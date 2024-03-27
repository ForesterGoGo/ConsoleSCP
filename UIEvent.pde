/*
  Система эвентов
  Каждый эвент является строкой, содержащей название эвента. 
  Когда эвент активен - он храниться в списке uievents
*/
StringList uievents;

//Проверка на наличие евента в запущенных
boolean UIEventOn(String temp)
{
  boolean flag = false;
  for(String uievent : uievents) if(uievent.equals(temp)) flag = true;
  return flag;
}

//Запуск эвента
boolean UIEventStart(String temp)
{
  boolean flag = true;
  for(String uievent : uievents) if(uievent.equals(temp)) flag = false;
  if(flag) uievents.append(temp);
  println("START - "+temp);
  return flag;
}

//Остановка эвента
boolean UIEventStop(String temp)
{
  boolean flag = true;
  for(int i=0;i<uievents.size();i++) if(uievents.get(i).equals(temp)) 
  {
    flag = false;
    uievents.remove(i);
  }
  println(temp+" - STOP");
  return flag;
}

//Смена состояния эвента
void UIEventSwitch(String temp)
{
  if(UIEventOn(temp)) UIEventStop(temp);
  else UIEventStart(temp);
}
