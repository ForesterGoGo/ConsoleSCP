Mouse mouse;
boolean flagMouseInWhite;
boolean flagMouseClicked;
class Mouse extends Object
{
  int x;
  int y;
  Mouse()
  {   
    AddObjectList(this);
  }
  String GetName(){return null;}
  void Update()
  {
    x = int((float(mouseX)/float(width ))*float(width ));
    y = int((float(mouseY)/float(height))*float(height));
  }
  void Draw()
  {
    if(mouse.y>0) noCursor();
    else cursor(ARROW);
    noStroke();
    if(get(x+2,y+2) == color(255)||get(x-2,y-2) == color(255)||get(x-2,y+2) == color(255)||get(x+2,y-2) == color(255)){flagMouseInWhite = true;}
    else {flagMouseInWhite = false;}
    if(mousePressed)
    {
      if(flagMouseInWhite) fill(255);
      else fill(0);
    }
    else
    {
      if(flagMouseInWhite) fill(0);
      else fill(255);
    }
    rect(x-5,y-5,10,10);
  }
}
void mouseClicked()
{
  flagMouseClicked = true;
}
