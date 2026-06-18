module {:extern "turtlecompopt"} TurtleCompilerOpt {

  ghost function simulateTurnSide(side: int, degs: int): (result: int)
    requires side in {0, 1} // 0 = left, 1 = right
    ensures 0 <= result < 360
  {
    if side == 0 then simulateTurn(-degs) else simulateTurn(degs)
  }

  ghost function simulateTurn(degs: int): (result: int)
    ensures 0 <= result < 360
    ensures result == degs % 360 // we need to add this to help Dafny 
    decreases if degs < 0 then (-degs + 359) / 360 else degs / 360 // steps of adding/removing 360 degrees until termination
  {
    // turn a full circle if the degrees is negative or greater than 360
    if degs < 0 then 
      simulateTurn(degs + 360) 
      else if degs >= 360 then 
      simulateTurn(degs - 360) 
      else degs
  }

  class TurtleTurnOpts {
    static method turn(side: int, degs: int) returns (degrees: int)
      requires side in {0, 1} // 0 = left, 1 = right
      ensures 0 <= degrees < 360
      ensures degrees == simulateTurnSide(side, degs)
    {
      if side == 0 {
        degrees := -degs % 360;
      } else {
        degrees := degs % 360;
      }
    }

  }
}