boolean flagDrawCentrLine;
ArrayList<Line> lines;
class Line extends Object
{
  PVector position;
  PVector size;
  Line(int p1, int p2, int s1, int s2)
  {
    position = new PVector(p1,p2);
    size = new PVector(s1,s2);
    AddObjectList(this);
  }
  void Draw()
  {
    line(position.x,position.y,size.x,size.y);
  }
}
void DrawLine()
{
  if(flagDrawCentrLine)
  {
    line(width/2,0,width/2,height);
    line(0,height/2,width,height/2);
  }
  for (Line line : lines) line.Draw();
  line(mouseX,0,mouseX,height);
}
