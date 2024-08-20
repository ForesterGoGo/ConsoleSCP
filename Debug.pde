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
      if(list.length > 1)
      {
        if(list.length < 3 && list[1].equals("-showall"))
        {
          StringList stringBindList = ShowBindList();
          consoleOutput.AddLn("Binds:");
          for(String text : stringBindList)
            consoleOutput.AddLn(text);
        }
        else
        {
          char keyChar = toChar(list[1]);
          String uievent = list[2];
          
          if(settingsXML.getChild("bind").getChild("key_"+keyChar) == null) //Если нет записаной в настройках кнопки, которую запрашивает перед созданием - выдайт ошибку NPE
            settingsXML.getChild("bind").getChild("key_"+keyChar).setContent(uievent);
    
          bindList.add(new Bind(keyChar,uievent,true));
          
          if(list.length == 4 && list[3].equals("-startup"))
          {
            if(settingsXML.getChild("startUpDebugInfo").getContent().equals("true")) //Debug info????
              settingsXML.getChild("startUpDebugInfo").setContent("false");
            else
              settingsXML.getChild("startUpDebugInfo").setContent("true");
          }
        }
      }
      else 
      {
        consoleOutput.AddLn("Неправильный ввод команды");
        consoleOutput.AddLn("Исспользуйте /Bind [клавиша] [эвент] [ключ]");
        consoleOutput.AddLn("Доступные ключи:");
        consoleOutput.AddLn("-startup [true/false] - сохранение бинда на следующих запусках");
        consoleOutput.AddLn("-showall - показать все существующие привязки");
      }
    break;
    case "debuginfo": 
      if(list.length>1)
      {
        if(list[1].equals("-startup"))  
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
            consoleOutput.AddLn("Доступные ключи: -startup [true/false] - открытие окна дебаг при запуске по умолчанию");
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
      consoleOutput.AddLn("Используйте комманды, чтобы упростить тестирование игры.");
      consoleOutput.AddLn("debuginfo - активировать плашку дебаг панели (КЛЮЧИ: -s - запуск при старте; -b - делает фон(не готов) )");
      consoleOutput.AddLn("settings - открыть окно настроек");
      consoleOutput.AddLn("bind - настройки привязки клавиш");
      
    break;
    default:
      consoleOutput.AddLn("Комманды \""+command+"\" не существует, для помощи по командам наберите >help");
    break;
  }
  lastCommand.append(command);
  if(lastCommand.size()>=6) lastCommand.remove(0);
}
