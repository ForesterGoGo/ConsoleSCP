PImage img;
PFont font, debugFont, defaultFont;
int fps;
//*****************************************************************
/*
Последнее обновление 24.03.24 0:57
Список проблем: 
1. Съехал текст из-за убраного offset`a, потому что он нахуй не нужен. [РЕШЕНО]
2. Текст не помещается в правый край окна. Захардкожена грань, по поиску в тексте "002200".
3. При выборе другого протокола из списка, сначала обновляется текст протокола, потом обновляется состояние окна.
4. Текст отрисовывается на окне, а не внутри него.
*/
//*****************************************************************
void setup()
{
  size(1024, 720, P2D);
  background(100);
  //---------------------------
  bindList = new ArrayList<Bind>();
  uievents = new StringList();
  lines = new ArrayList<Line>();
  objectList = new ArrayList<Object>();
  protocols = new ArrayList<Protocol>();
  
  windowsList = new ArrayList<Window>();
  buttonsList = new ArrayList<Button>();
  panelsList  = new ArrayList<Panel>();
  labelsList  = new ArrayList<Label>();
  
  savetxt = new Viral();
  debugInfoOutput = new Viral();
  consoleOutput = new Viral();
  protocolOutput = new Viral();
  commandPromt = new Viral();
  
  masKey = new Key[255];
  //---------------------------
  background(150);
  font = createFont("Data/PsyForce.ttf",20);
  defaultFont = createFont("Arial Bold", 14);
  debugFont = createFont("Data/PsyForce.ttf", 20);
  
  for(int i = 0;i<masKey.length;i++)
    masKey[i] = new Key(char(i));
    
  mouse = new Mouse();
  flagMouseInWhite = false;
  flagMouseClicked = false;
  //monitor = "";//RectMonitor(33,16);
  //monitor = sendMessage(monitor,33,19,color(255,0,0),"ERROR");
  flagDrawCentrLine = false;
  
  //------CREATE ELEMENTS--------
  mails = new ArrayList<Mail>();
  conditions = new ArrayList<Condition>();
  protocols = new ArrayList<Protocol>();
  elements = new ArrayList<Element>();
  
  //------CREATE SETTINGS WINDOW--------
  Window settingsWindow = new Window(new PVector(width/4,height/4),new PVector(width/2,height/2),TypeWindow.CONTAINER,"SETTINGS",TypeDeepPosWindow.STANDART,"EnabledSettingsWindow");
  settingsWindow.SetElement(new Button(new PVector(20,20),new PVector(20,20),TypeButton.CLICABLE,"кнопачка"));
  
  Window debugInfoWindow = new Window(new PVector(20,20),new PVector(400,100),TypeWindow.CONTAINER,"SETTINGS",TypeDeepPosWindow.IMPORTANT,"EnabledDebugInfo");  
  debugInfoWindow.SetElement(new Label(new PVector(5,-5),"",true,debugInfoOutput));
  
  Window protocolWindow = new Window(new PVector(width/5,height/5),new PVector(width-width/5-100,height-height/5-100),TypeWindow.CONTAINER,"PROTOCOL",TypeDeepPosWindow.STANDART,"EnabledProtocolWindow"); //<>//
  Panel protocolPanel = new Panel(new PVector(0,0),new PVector(0,0),TypePanel.SCROLLBOX);
  Label protocolLabel = new Label(new PVector(10,15),"",true,protocolOutput);
  protocolWindow.SetElement(protocolPanel);
  protocolPanel.SetElement(protocolLabel);
  protocolPanel.enabled = true;
  
  
  Window consoleWindow = new Window(new PVector(0,0),new PVector(width,height/2),TypeWindow.CONTAINER,"DEBUG",TypeDeepPosWindow.IMPORTANT,"EnabledconsoleWindow");
  consoleWindow.SetElement(new Label(new PVector(10,15),"console v.0.3a \n",true,consoleOutput));
  consoleWindow.SetElement(new Label(new PVector(10,height/2-10),">",true,commandPromt));
  //-----------------------------
  loadXMLe();
  //-----------------------------
  /*for(String font :PFont.list())
    println(font);*/
    prepareExitHandler();
    //printStructure();
    
  textFont(font); 
  colorMode(RGB);
}

void draw() 
{
  mouse.Update();
  DebugInfoController();
  for(Window window: windowsList)
    window.Update();
  for(Bind bind: bindList)
    bind.Update();
  background(0);
  //----------------------------------------
  textLeading(40);
  background(0);
  
  stroke(255);
  strokeWeight(4);
  noFill();
  rect(10,10,width-20,height-20);
  strokeWeight(1);
  
  fill(0);
  stroke(0);
  rect(40,5,100,10);
  
  //------ Draw Objects
  flagMouseInWhite = false;
  noStroke();
  for(int i=0;i<protocols.size();i++)
  {
    fill(
      protocols.get(i).clas==0?0:255,
      protocols.get(i).clas==2?0:255,
      protocols.get(i).clas==0||protocols.get(i).clas==1||protocols.get(i).clas==2?0:255
    );
    rect(35,55+20*i,10,10);
    fill(255);
    
    if(mouse.x>=50&&mouse.x<width-20&&mouse.y>=50+20*i&&mouse.y<20+50+20*i)
    {
      fill(255);
      rect(35,50+20*i,width-50,20);
      fill(0);
      if(flagMouseClicked) 
      {
        protocolOutput.Clean();
        protocolOutput.Set(protocols.get(i).textBlocks,width-200);    //protocolWindow.elements.get ... 002200
        UIEventSwitch("EnabledProtocolWindow"); // При повторном клике закрывает окно
      }
    }
    else fill(255);
    text("SCP-"+protocols.get(i).number+" - "+protocols.get(i).title,50,50+20*i,width-20,height);
  }
  WindowsDraw();

  flagMouseClicked = false;
  mouse.Draw();
  //-----------Prepare for next frame
  UpdateLastMasKey();
}
