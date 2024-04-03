/*
  Система эвентов
  Каждый эвент является строкой, содержащей название эвента. 
  Когда эвент активен - он храниться в списке uievents
*/
/* МЫСЛИ
  Можно сделать обработчик эвентов, чтоб вследходящие эвенты обрабатывались в одном кадре. Для этого эвенты должны разделяться на обработаные и нет. Или же скорее всего это не для эвентов, а чего-то другого.
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
