import { useState, useMemo } from 'react';
import GameEngine from './gameEngine';

export default function App() {
  // Lazy initialize the game engine
  const engine = useMemo(() => {
    const e = new GameEngine.TicTacToe();
    e.__ctor();
    return e;
  }, []);

  const [gameState, setGameState] = useState(0);
  const winner = useMemo(() => {
    // Check both players after each move
    if (engine.CheckWin(1)) return 1;
    if (engine.CheckWin(2)) return 2;
    return null;
  }, [gameState, engine]);

  const gridArray = useMemo(() => 
    Array.from(engine.grid, (val: any) => val.toNumber?.() ?? val),
    [gameState, engine]
  );

  const handleCellClick = (index: number) => {
    if (gridArray[index] === 0 && !winner) {
      engine.Play(index);
      setGameState(s => s + 1); // Trigger re-render
    }
  };

  const currentPlayer = engine.currentPlayer.toNumber?.() ?? engine.currentPlayer;
  const playerSymbol = (p: number) => p === 1 ? '❌' : '⭕';

  return (
    <div style={{ textAlign: 'center', fontFamily: 'sans-serif', padding: '24px' }}>
      <h1>Verified Tic-Tac-Toe</h1>
      {winner ? (
        <p style={{ fontSize: '20px', fontWeight: 'bold', color: '#2ecc71' }}>
          Player {playerSymbol(winner)} wins! 🎉
        </p>
      ) : (
        <p style={{ fontSize: '18px' }}>Current Turn: {playerSymbol(currentPlayer)}</p>
      )}
      
      <div style={{ 
        display: 'grid', 
        gridTemplateColumns: 'repeat(3, 100px)', 
        gap: '8px', 
        justifyContent: 'center',
        margin: '24px 0'
      }}>
        {gridArray.map((cell, index) => (
          <button
            key={index}
            onClick={() => handleCellClick(index)}
            disabled={cell !== 0 || !!winner}
            style={{
              width: '100px',
              height: '100px',
              fontSize: '32px',
              cursor: cell === 0 && !winner ? 'pointer' : 'not-allowed',
              borderRadius: '8px',
              border: '2px solid #333',
              backgroundColor: cell !== 0 ? '#e8f5e9' : '#f5f5f5',
              fontWeight: 'bold',
              transition: 'all 0.2s'
            }}
          >
            {cell === 1 ? '❌' : cell === 2 ? '⭕' : ''}
          </button>
        ))}
      </div>

      <button 
        onClick={() => window.location.reload()} 
        style={{ 
          padding: '10px 20px', 
          fontSize: '16px', 
          cursor: 'pointer',
          borderRadius: '4px',
          border: 'none',
          backgroundColor: '#007bff',
          color: 'white',
          fontWeight: 'bold'
        }}
      >
        Reset Board
      </button>
    </div>
  );
}