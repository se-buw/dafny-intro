module GameEngine {
  class TicTacToe {
    var grid: seq<int>
    var currentPlayer: int // 1 for Player X, 2 for Player O

    // The formal specification representing a valid state
    ghost predicate Valid()
      reads this
    {
      |grid| == 9 &&
      (currentPlayer == 1 || currentPlayer == 2) &&
      forall i :: 0 <= i < |grid| ==> (grid[i] == 0 || grid[i] == 1 || grid[i] == 2)
    }

    constructor()
      ensures Valid()
    {
      grid := [0, 0, 0, 0, 0, 0, 0, 0, 0];
      currentPlayer := 1; 
    }

    // A verified mutation method to register a move
    method Play(index: int)
      requires Valid()
      requires 0 <= index < 9
      requires grid[index] == 0 // Precondition: Must be empty
      modifies this
      ensures Valid()
    {
      grid := grid[index := currentPlayer];
      currentPlayer := if currentPlayer == 1 then 2 else 1;
    }

    // Check if a player has won
    method CheckWin(player: int) returns (won: bool)
      requires Valid()
      requires player == 1 || player == 2
    {
      // Check all 8 winning combinations
      var row1 := grid[0] == player && grid[1] == player && grid[2] == player;
      var row2 := grid[3] == player && grid[4] == player && grid[5] == player;
      var row3 := grid[6] == player && grid[7] == player && grid[8] == player;
      
      var col1 := grid[0] == player && grid[3] == player && grid[6] == player;
      var col2 := grid[1] == player && grid[4] == player && grid[7] == player;
      var col3 := grid[2] == player && grid[5] == player && grid[8] == player;
      
      var diag1 := grid[0] == player && grid[4] == player && grid[8] == player;
      var diag2 := grid[2] == player && grid[4] == player && grid[6] == player;
      
      won := row1 || row2 || row3 || col1 || col2 || col3 || diag1 || diag2;
    }
  }
}