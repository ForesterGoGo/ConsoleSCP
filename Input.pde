/*
  Средства ввода и управления
*/
ArrayList<Bind> bindList;
int countBind = 0;
class Bind
{
  char c;
  String uievent;
  boolean save;
  Bind(char Dc,String e, boolean s)
  {
    c = Dc;
    uievent = e;
    save = s;
    AddBindList(this);
  }
  Bind(char Dc,String e)
  {
    c = Dc;
    uievent = e;
    save = true;
    AddBindList(this);
  }
  void Update()
  {
    if(masKey[c-32].push != masKey[c-32].last && masKey[c-32].push == true)
    {
      UIEventSwitch(uievent);
    }
    //println(int(c)+" - "+int('q')+" - "+int('w')+" - "+int('e')+" - "+ uievent);
  }
}

void AddBindList(Bind temp)
{
  bindList.add(temp);
  countBind++;
}

StringList ShowBindList()
{
  StringList list = new StringList();
  for(Bind bind : bindList)
    list.append("[ "+bind.c+" ] - "+bind.uievent);
  return list;
}

void mousePressed()
{
  lines.add(new Line(mouseX,0,mouseX,height));
}

char toChar(String txt)
{
  return txt.charAt(0);
}
