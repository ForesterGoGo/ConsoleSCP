int lastX,lastZ;
StringList lastCommand = new StringList();
int lastCommandFocus = 0;
void DebugInfoController()
{
  if (frameCount % 10 == 0) fps=int(frameRate);
  //textFont(debugFont);
  debugInfoOutput.Clean();
  debugInfoOutput.AddLn(""+fps);
  debugInfoOutput.AddLn("Push "+keyCode);
  debugInfoOutput.AddLn("flagMouseInWhite: "+flagMouseInWhite);
  debugInfoOutput.AddLn("flagMouseClicked: "+flagMouseClicked);
  debugInfoOutput.AddLn("settings: "+windowsList.get(0).enabled);
  debugInfoOutput.AddLn("Push:"+masKey['w'-32].push+" Last:"+masKey['w'-32].last);
  debugInfoOutput.AddLn(""+uievents);
  //textFont(font);
}
void DebudConsoleController(String command)
{
  String list[] = split(command.toLowerCase(),' ');
  switch(list[0])
  {
    case "bind":
      if(list.length>1)
      {
              
        bindList.add(new Bind(toChar(list[1]),list[2],true));
        
        if(list[3].equals("-s"))
        {
          if(settingsXML.getChild("startUpDebugInfo").getContent().equals("true"))
            settingsXML.getChild("startUpDebugInfo").setContent("false");
          else
            settingsXML.getChild("startUpDebugInfo").setContent("true");
        }
      }
      else 
      {
        consoleOutput.AddLn("Неправильный ввод команды");
        consoleOutput.AddLn("Исспользуйте /Bind [клавиша] [эвент] [ключ]");
        consoleOutput.AddLn("Доступные ключи: -s - сохранение бинда на следующих запусках");
      }
    break;
    case "debuginfo": 
      if(list.length>1)
      {
        if(list[1].equals("-s"))  
        {
          if(list.length>2)
          {
            if(list[2].equals("true")) //Определение постоянного показывания дебага при старте
              settingsXML.getChild("startUpDebugInfo").setContent("true");
            else
              settingsXML.getChild("startUpDebugInfo").setContent("false");
            consoleOutput.AddLn("Выполнено.");
          } 
          else 
          {
            consoleOutput.AddLn("Неправильный ввод команды");
            consoleOutput.AddLn("Исспользуйте [эвент] [ключ] [значение]");
            consoleOutput.AddLn("Пример: debuginfo -s true");
          }
          println("SAVE - startUpDebugInfo");
        }
        if(list[1].equals("-b"))
        {
          //делает фон
        }
      }
      else UIEventSwitch("EnabledDebugInfo");
    break;
    case "echo":
      for(TextBlock block: protocols.get(0).textBlocks) consoleOutput.AddLn(block.text);
    break;
    case "f":
      for(TextBlock block: protocols.get(0).textBlocks) consoleOutput.AddLn(block.text);
    break;
    case "settings":
      UIEventSwitch("EnabledSettingsWindow");
    break;
    case "cls":
      consoleOutput.Clean();
    break;
    case "help":
    case "":
      consoleOutput.AddLn("Используйте комманды, чтобы упрощать тестирование игры.");
      consoleOutput.AddLn("debuginfo - активировать плашку дебаг панели (КЛЮЧИ: -s - запуск при старте; -b - делает фон(не готов) )");
    break;
    default:
      consoleOutput.AddLn("Комманды "+command+" не существует, для помощи по командам наберите >help");
    break;
  }
  lastCommand.append(command);
  if(lastCommand.size()>=6) lastCommand.remove(0);
}
