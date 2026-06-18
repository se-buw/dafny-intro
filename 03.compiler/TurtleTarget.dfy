module TurtleTarget {

  datatype Command =
    | Move(distance: int)
    | Turn(degrees: int)

  datatype State = TurtleState(heading: int, disp: map<int, int>)

  predicate ValidHeading(h: int) {
    0 <= h < 360
  }

  predicate ValidCommand(c: Command) {
    match c
    case Move(d) => true
    case Turn(deg) => 0 <= deg < 360
  }

  predicate SameProgram(p1: seq<Command>, p2: seq<Command>) 
      requires forall i :: 0 <= i < |p1| ==> ValidCommand(p1[i])
      requires forall i :: 0 <= i < |p2| ==> ValidCommand(p2[i])
  {
    execProgram(initState(), p1) == execProgram(initState(), p2)
  }

  function addDisp(m: map<int, int>, h: int, d: int): map<int, int>
    requires ValidHeading(h)
  {
    m[h := (if h in m then m[h] else 0) + d]
  }

  function initState(): State {
    TurtleState(0, map[])
  }

  function execCommand(s: State, c: Command): State
    requires ValidHeading(s.heading)
    requires ValidCommand(c)
    ensures ValidHeading(execCommand(s, c).heading)
  {
    match c
    case Move(d) =>
      if d >= 0 then
        TurtleState(s.heading, addDisp(s.disp, s.heading, d))
      else
        TurtleState(s.heading, addDisp(s.disp, (s.heading + 180) % 360, -d))
    case Turn(deg) =>
      TurtleState((s.heading + deg) % 360, s.disp)
  }

  function execProgram(s: State, p: seq<Command>): State
    requires ValidHeading(s.heading)
    requires forall i :: 0 <= i < |p| ==> ValidCommand(p[i])
    ensures ValidHeading(execProgram(s, p).heading)
    decreases |p|
  {
    if |p| == 0 then
      s
    else
      execProgram(execCommand(s, p[0]), p[1..])
  }

}
