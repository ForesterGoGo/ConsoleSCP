/*
Интерфейс
*/
int countButton = 0;
ArrayList<Button> buttonsList;
int countWindow = 0;
ArrayList<Window> windowsList;
int countPanel = 0;
ArrayList<Panel> panelsList;
int countLabel = 0;
ArrayList<Label> labelsList;

color borderColor       = color(255);
color titleColor        = color(255);
color textColor         = color(255);
color protocolTextColor = color(255,100,100);

color buttonEnColor   = color(0,200,0); //енаблед
color buttonDisColor  = color(100,0,0); //дисаблед
color buttonOnColor   = color(0,0,255); //под курсором
color buttonPushColor = color(200);     //нажат
color buttonTextColor = color(100);     //текст

interface TypeButton
{
  int
  CLICABLE  = 0, 
  FLAG      = 1, 
  GROUPFLAG = 2;
}
interface TypeStrip
{
  int
  VERTICAL = 0,
  HORIZONTAL = 1;
}
interface StatusButton
{
  int
  DISABLE = 0,
  ENABLE  = 1,
  MOUSEIN = 2,
  PUSH    = 3,
  CLICKED = 4;
}
interface TypeWindow
{
  int
  ERROR       = 0, 
  ATENTION    = 1,
  INFORMATION = 2, 
  SELECT      = 3, 
  LIST        = 4,
  CONTAINER   = 5;
}
interface TypeDeepPosWindow
{
  int
  IMPORTANT = 0,
  NOTICE    = 1,
  STANDART  = 2;
}
interface TypePanel //Пока не используется
{
  int
  DEFAULT   = 0,
  SCROLLBOX = 1;
}
class Window extends Container
{
  int id;
  int type;
  int deepPos;
  int titleIndent;
  String title;
  String uieventStart;
  boolean enabled = false;
  //ArrayList<Object> elements;
  Window(PVector Dposition, PVector Dsize, int Dtype, String Dtitle, int DdeepPos, String DuieventStart)
  {
    id = ++countWindow;
    position = Dposition;
    type = Dtype;
    deepPos = DdeepPos;
    uieventStart = DuieventStart;
    title = Dtitle;
    AddObjectList(this);
    AddWindowsList(this);
    size = Dsize;
    
    elements = new ArrayList<Object>();
  }
  String GetName()
  {
    return "basicWindowName";
  }
  void Draw()
  {
    if(!enabled) return;
    fill(200);
    stroke(255);
    rect(position.x,position.y,size.x,size.y);
    rect(position.x,position.y,size.x,titleIndent);
    switch(type)
    {
      case 0:
      break;
      case 1:
      break;
      case 2:
      break;
      case 3:
      break;
      case 4:
      break;
    }
    for(Object element : elements)
      element.Draw();
  }
  void Update()
  {
    enabled = false;
    for(String uievent : uievents) if(uievent.equals(uieventStart))
    {
      enabled = true;
    }
    for(Object element : elements)
      element.Update();
  }
  void Destruct()
  {
    windowsList.remove(this);
  }
}
Window protocolWindowGET(String name)
{
  Window temp;
  switch(name)
  {
    case "protocolWindow":
      temp = windowsList.get(2);
    break;
    default: 
      temp = null;
    break;
  }
  return temp;
}
void WindowsDraw()
{
  for(Window window: windowsList)
    if(window.deepPos == TypeDeepPosWindow.STANDART)
      window.Draw();
  for(Window window: windowsList)
    if(window.deepPos == TypeDeepPosWindow.NOTICE)
      window.Draw();
  for(Window window: windowsList)
    if(window.deepPos == TypeDeepPosWindow.IMPORTANT)
      window.Draw();
}
class Group extends Object
{
  int id;
  IntList EsID;
  Group()
  {
    EsID = new IntList();
  }
  String GetName()
  {
    return "name";
  }
}
class Button extends Object //Кнопка
{
  int id;
  int type = 0;
  int status = 0;
  String text;
  color colr;
  color colrPush;
  color colrMouseIn;
  color colrDisabled;
  boolean mouseIn = false;
  boolean push = false;
  boolean enabled = true;
  Button(PVector Dposition, PVector Dsize, int Dtype, String Dtext)
  {
    id = ++countButton;
    position = Dposition;
    size = Dsize;
    type = Dtype;
    text = Dtext;
    size.x = textWidth(text)+15;
    AddObjectList(this);
    AddButtonsList(this);
  };
  String GetName(){return null;}
  color getColor()
  {
    color temp = color(0);
    return temp;
  }
  void Draw()
  {
    switch(status)
    { 
       case StatusButton.CLICKED:
       //case StatusButton.PUSH:
       fill(buttonPushColor);
       break;
       case StatusButton.MOUSEIN:
       fill(buttonOnColor);
       break;
       case StatusButton.ENABLE:
       fill(buttonEnColor);
       break;
       case StatusButton.DISABLE:
       fill(buttonDisColor);
       break;
    }
    rect(position.x,position.y,size.x,size.y);
    fill(buttonTextColor);
    text(text,position.x+5,position.y+15);
    noFill();
  }
  void Update()
  {
    if(enabled) 
      if(mouse.x>position.x && mouse.y>position.y && mouse.x<size.x+position.x && mouse.y<size.y+position.y)
        if(flagMouseClicked || mousePressed) // flagMouseClicked НЕ РАБОТАЕТ, пока сделано через прессед, к PUSH не прикосаться!
            status = StatusButton.CLICKED;
          else if(mousePressed) status = StatusButton.PUSH;
        else status = StatusButton.MOUSEIN;
      else status = StatusButton.ENABLE;
    else status = StatusButton.DISABLE;
    
    if(status == StatusButton.CLICKED)
    {
      /*if(text == "Clear") gameGrid.ClearCell();
      if(text == "Lamp") mouseMode = "Lamp";
      if(text == "Connect") mouseMode = "Connect";
      if(text == "Pin") mouseMode = "Pin";
      if(text == "Simulate") flagSimulate = !flagSimulate;*/
    }
  }
}
class Label extends Object //Текстовая область
{
  int id;
  boolean enabled;
  String text;
  Viral component;
  Label(PVector Dposition, String Dtext, boolean Denabled)
  {
    id = countLabel++;
    position = Dposition;
    text = Dtext;
    enabled = Denabled;
  }
  Label(PVector Dposition, String Dtext, boolean Denabled, Viral Dcomponent)
  {
    id = countLabel++;
    position = Dposition;
    text = Dtext;
    enabled = Denabled;
    component = Dcomponent;
  }
  void Draw()
  {
    if(enabled)
    {
      stroke(255,0,0);
      fill(protocolTextColor);
      String temp = "";
      try{
        if(component.variable.length()>0) 
          temp = component.variable;
      }catch(NullPointerException e){ println("ERROR - component.variable undefiend or null data");}
      textFont(debugFont);
      text(text+temp,position.x,position.y);
      textFont(font);
    }
  }
}
class Panel extends Container //Группирует элементы интерфейса для их локального взаимодействия
{
  int id;
  boolean enabled;
  int type;
  int countButton;
  boolean flag;
  boolean enableScrollBar;
  //ArrayList<Object> elements;
  Panel(PVector Dposition,PVector Dsize,int Dtype)
  {
    id = countPanel++;
    position = Dposition;
    size = Dsize;
    type = Dtype;
    
    elements = new ArrayList<Object>();
    
    if(Dtype == TypePanel.SCROLLBOX) enableScrollBar = true;
    else enableScrollBar = false;
    enabled = false;
    AddObjectList(this);
    AddPanelsList(this);
  }
  String GetName(){return null;}
  void Draw()
  {
    if(!enabled) return;
    if(enableScrollBar)
    {
      fill(255,0,0);
      rect(position.x-15,position.y-15,10,10);
    }
    for(Object element : elements)
      element.Draw();
  }
  void Update()
  {
    for(Object element : elements)
      element.Update();
  }
  void ButtonTriggerEnabled(int enblID)
  {
    /*for(int i=0;i<4;i++)
      upPanel.buttonPanel[i].enabled = false;
    if(enblID >= 4) return;
    upPanel.buttonPanel[enblID].enabled = true;*/
  }
}

void AddWindowsList(Window temp)
{
  windowsList.add(temp);
  countWindow++;
}
void AddButtonsList(Button temp)
{
  buttonsList.add(temp);
  countButton++;
}
void AddPanelsList(Panel temp)
{
  panelsList.add(temp);
  countPanel++;
}
void AddLabelsList(Label temp)
{
  labelsList.add(temp);
  countLabel++;
}

void DrawGamePanel()
{
/*if(gamePanel.enabled)
{
  gamePanel.Draw();
  // облать игровой панели
  stroke(200);
  noFill();
  rect(0,height-40,width,40);
  noStroke();
}*/
}
void UpdatePanels()
{
/*if(gamePanel.enabled)
{
 for(int i=0;i<gamePanel.currentCountButton;i++)
  {
    if(gamePanel.buttonPanel[i].name == "ObjUp")
      if(countAllocate == 1) 
        gamePanel.buttonPanel[i].enabled = true;
      else 
        gamePanel.buttonPanel[i].enabled = false;
    
    if(gamePanel.buttonPanel[i].position.x < mouse.x && gamePanel.buttonPanel[i].position.y < mouse.y && 
      gamePanel.buttonPanel[i].position.x+40 > mouse.x && gamePanel.buttonPanel[i].position.y+40 > mouse.y &&
      gamePanel.buttonPanel[i].enabled)
      {
        gamePanel.buttonPanel[i].mouseIn = true;
        
        if(mousePressed)
        {
          mouseMode = gamePanel.buttonPanel[i].name;
          gamePanel.buttonPanel[i].push = true;
        }
        else gamePanel.buttonPanel[i].push = false;
      }
      else gamePanel.buttonPanel[i].mouseIn = false;
  }
}
if(upPanel.enabled)
{
  for(int i=0;i<upPanel.currentCountButton;i++)
  {
    if(upPanel.buttonPanel[i].enabled)
    {
      if(upPanel.buttonPanel[i].position.x < mouse.x && upPanel.buttonPanel[i].position.y < mouse.y && 
        upPanel.buttonPanel[i].position.x+40 > mouse.x && upPanel.buttonPanel[i].position.y+40 > mouse.y)
      {
          if(mousePressed)
          {
            mouseMode = upPanel.buttonPanel[i].name;
            upPanel.buttonPanel[i].push = true;
          }
          else upPanel.buttonPanel[i].push = false;
          
          upPanel.buttonPanel[i].mouseIn = true;
      }
      else upPanel.buttonPanel[i].mouseIn = false;
  }*/
}
