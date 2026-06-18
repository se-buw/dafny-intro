include "TurtleTarget.dfy"

module {:extern "turtlemoveopt"} TurtleMoveOpt {
  import opened TurtleTarget

  class TurtleMoveOpts {
    static method move(direction: int, distance: int) returns (program: seq<Command>)
      requires direction in {0, 1} // 0 = forward, 1 = backward
      requires distance > 0
      ensures forall i :: 0 <= i < |program| ==> ValidCommand(program[i])
      ensures SameProgram(program, [Move(if direction == 0 then distance else -distance)])
    {
      if direction == 0 {
        program := [Move(distance)];
      } else {
        program := [Turn(180), Move(distance), Turn(180)];
        ghost var s := initState();
        ghost var s1 := execCommand(s, Turn(180));
        ghost var s2 := execCommand(s1, Move(distance));
        ghost var s3 := execCommand(s2, Turn(180));
        assert execProgram(s2, [Turn(180)]) == s3;
        assert s3.heading == s.heading;
        assert s3 == execCommand(s, Move(-distance));
      }
    }
  }
}
