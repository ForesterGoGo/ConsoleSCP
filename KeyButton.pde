Key[] masKey;
class Key
{
  char symbole;
  boolean push;
  boolean last;
  Key(char Dsymbole)
  {
    push = false;
    last = false;
    symbole = Dsymbole;
  }
  boolean handle()
  {
    boolean flag;
    if(push != last) flag = true;
    else flag = false;
    return flag;
  }
}
void UpdateLastMasKey()
{
  for(Key temp : masKey)
  {
    temp.last = temp.push;
  }
}
void keyPressed()
{
  masKey[keyCode].push = true;
  if(!UIEventOn("EnabledconsoleWindow")) 
    switch(keyCode)
    {
      case 96:
        UIEventSwitch("EnabledconsoleWindow");
      break;
    }
  else //Если мы находимся в консоли
  {
    if(keyCode != 96) 
      if(keyCode != 10)
      {
        if(keyCode != 8 && keyCode != 16 && keyCode != 17) commandPromt.Add(key+"");
        else commandPromt.Del();
      }
      else 
      {
        DebudConsoleController(commandPromt.variable);
        commandPromt.Clean();
      }
    else UIEventSwitch("EnabledconsoleWindow");
  }
}
void keyReleased()
{
  masKey[keyCode].push = false;
}
