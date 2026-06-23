# React + TypeScript + Vite

## Verified Tic-Tac-Toe Workflow (Dafny -> JS -> React)

This project is set up so that Dafny code generation happens automatically.

### Where to work

- Edit game logic in `src/GameEngine.dfy`.
- Run npm scripts from this folder: `02.tictactoe/tictactoe`.

### Commands

- Development: `npm run dev`
- Production build: `npm run build`

Both commands automatically run `dafny:build` first, which:

1. Verifies and compiles `src/GameEngine.dfy` to `src/dafny-runtime.js`
2. Applies a small export patch for JS module interop
3. Copies runtime output to `public/dafny.js`

### Notes

- Do not manually edit `src/dafny-runtime.js`; it is generated each build.
- Keep wrapper code minimal in `src/gameEngine.ts` (re-export only).
- If you run commands at repository root, you may see `Missing script: dev`.
