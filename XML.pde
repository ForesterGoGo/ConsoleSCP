XML settingsXML;
XML contentXML;
Viral blocks[] = {
  savetxt
};
void loadXMLe()
{
  settingsXML = loadXML("settings.xml"); 
  contentXML = loadXML("content.xml"); 
  
  if(settingsXML.getChild("startUpDebugInfo").getContent().equals("true")) UIEventStart("EnabledDebugInfo"); //Чек на эвент
  
  Bind current; //НЕ обращать внимания на варнинг, все работает хорошо, не стоит сука трогать!!!
  try{
    for(String element : GetXMLElements(settingsXML.getChild("bind").listChildren()))
    {
      String uievent = settingsXML.getChild("bind").getChild(element).getContent();
      current = new Bind(split(element,"_")[1].charAt(0),uievent);
    }
  } catch (NullPointerException e) {println("ERROR - bind_GetXMLElements");}
  //------------------------------------------------------------------------------
  //Перевод с XML в Объекты - потоколы/события/системы безопасности
  ArrayList<Effect> complectEffects = new ArrayList<Effect>();
  try{
    for(XML element : contentXML.getChild("conditions").getChildren("condition"))
    {
      for(XML effectLink : element.getChildren("effectLink"))
        for(XML effect : contentXML.getChild("effects").getChildren("effect"))
          if(effect.getInt("id") == effectLink.getInt("effectId"))
          {
            if(effect.getString("typeVal")=="int")
              complectEffects.add(new Effect(effect.getInt("value"), effect.getString("elemTyp"),effect.getInt("elemId"),effect.getString("elemParam")));
            if(effect.getString("typeVal")=="string")
              complectEffects.add(new Effect(effect.getString("value"), effect.getString("elemTyp"),effect.getInt("elemId"),effect.getString("elemParam")));
            if(effect.getString("typeVal")=="boolean")
              complectEffects.add(new Effect(boolean(effect.getInt("value")), effect.getString("elemTyp"),effect.getInt("elemId"),effect.getString("elemParam")));
            if(effect.getString("typeVal")=="float")
              complectEffects.add(new Effect(effect.getFloat("value"), effect.getString("elemTyp"),effect.getInt("elemId"),effect.getString("elemParam")));
          }
      if(Type(element.getString("typeVal"))=="int")
        conditions.add(new Condition(TypeCondition.FALSE, contentXML.getName(),element.getString("elemTyp"),element.getInt("elemId"),element.getString("elemParam"),element.getString("sign"),element.getInt("value"),complectEffects)); 
      if(Type(element.getString("typeVal"))=="string")
        conditions.add(new Condition(TypeCondition.FALSE, contentXML.getName(),element.getString("elemTyp"),element.getInt("elemId"),element.getString("elemParam"),element.getString("sign"),element.getString("value"),complectEffects)); 
    }//Condition(String elemParam, String sign, String val, ArrayList<Effect> e)
  } catch (NullPointerException e) {println("ERROR - conditions_GetXMLElements");}
  
  //------------------------------------------------------------------------------
  
  ArrayList<TextBlock> protocolTextBlocks = new ArrayList<TextBlock>(); //обновляем список блоков для первого протокола
  try{
    for(XML element : contentXML.getChild("protocols").getChildren("protocol"))
    {
      protocolTextBlocks = new ArrayList<TextBlock>(); //обновляем список блоков для следующего протокола
      for(XML block : element.getChildren("textBlock"))
        protocolTextBlocks.add(new TextBlock(block.getInt("id"),block.getContent(),block.hasAttribute("nline"),color(255)));
      protocols.add(new Protocol(element.getInt("id"),element.getString("type"),element.getInt("number"),element.getInt("clas"),element.getString("title"),protocolTextBlocks)); 
    }
  } catch (NullPointerException e) {println("ERROR - conditions_GetXMLElements");}
  
  //------------------------------------------------------------------------------
}

String[] GetXMLElements(String[] temp)
{
  String[] result = new String[(int)temp.length/2];
  for(int i=0,j=0;i<temp.length;i++)
      if(!temp[i].equals("#text"))result[j++]=temp[i];
  return result;
}

void saveXMLe()
{
  //settingsXML.getChild("windowSizeWidth");
  //settingsXML.getChild("windowSizeHeight");
  //saveXML(settingsXML,"settings.xml");
  /*String[] savelist = {"Enabled"};
  for(String temp : savelist)
    try {
      println(settingsXML.getChild(temp).toString());
    } catch (NullPointerException e) {
      println("No find "+temp+"-setting: Create "+temp+" with parametrs - "+width);
      settingsXML.addChild(temp).setContent(""+width);
    }*/
  
  //settingsXML.getChild
  
  saveXML(settingsXML,"settings.xml");
}

private void prepareExitHandler() 
{
  Runtime.getRuntime().addShutdownHook(new Thread(new Runnable(){ public void run () 
    {
      System.out.println("-------------------------------------------------\nSHUTDOWN HOOK");
      saveXMLe();
    }
  }
  ));
}
