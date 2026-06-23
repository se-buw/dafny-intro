#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

const fileArg = process.argv[2];
if (!fileArg) {
  console.error('Usage: node scripts/patch-dafny-runtime.cjs <generated-js-file>');
  process.exit(1);
}

const targetPath = path.resolve(process.cwd(), fileArg);
if (!fs.existsSync(targetPath)) {
  console.error(`Generated file not found: ${targetPath}`);
  process.exit(1);
}

const source = fs.readFileSync(targetPath, 'utf8');
const marker = '})(); // end of module _module';
if (!source.includes(marker)) {
  console.error('Unexpected Dafny JS layout: marker not found.');
  process.exit(1);
}

if (source.includes('module.exports = GameEngine;')) {
  // Idempotent: keep existing export block.
  process.exit(0);
}

const exportBlock = [
  '',
  '// Export GameEngine for CommonJS/ESM interop (used by Vite).',
  "if (typeof module !== 'undefined' && module.exports) {",
  '  module.exports = GameEngine;',
  '  module.exports.default = GameEngine;',
  '}',
  ''
].join('\n');

fs.writeFileSync(targetPath, source + exportBlock, 'utf8');
