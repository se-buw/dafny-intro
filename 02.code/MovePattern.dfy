// api methods in the turtle simulator
method {:extern} move(d: int) 
  requires d >= 0
  
method {:extern} turn(deg: int)
  requires 0 <= deg < 360



method regPolyMove(n : int, s : int) 
  requires s >= 0
  requires n > 2
{
  for i := 0 to n-1 {
    move(s);
    turn(360/n);
  }  
}

method Main() {
  regPolyMove(3, 10); // triangle
  regPolyMove(4, 10); // square
  regPolyMove(5, 10); // pentagon
}