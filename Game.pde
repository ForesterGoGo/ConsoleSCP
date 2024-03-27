ArrayList<Mail> mails;
ArrayList<Condition> conditions;
ArrayList<Protocol> protocols;
ArrayList<Element> elements;

class Element
{
  int id;
}
void AddElementList(Element temp)
{
  elements.add(temp);
}

//----------------------------------------------------------
class Game
{
  int clearanceLevel; //Уровень допуска (0..5)
  int gameImmersion; //Игровое погружение (0..5)
  int time; //Внутриигровое время/энергия (0..1000)
  
  ArrayList<GameEvent> gameEvents;
  Game(){}
  void Update()
  {
    for(Condition condition: conditions)
      condition.Update();
  }
}

//----------------------------------------------------------
interface TypeCondition 
{
  int
  FALSE = 0, 
  TRUE  = 1;
}
class Condition //Условие после выполнения перестает быть активным, если его не активирует эффект другого условия
{
  int id;
  int type;
  String contentName,elementType,elementParametr,conditionTypeChar;
  String valueStr;
  int valueInt;
  Boolean valueBool;
  float valueFl;
  int elementId;
  ArrayList<Effect> effects;
  Condition(int t, String contentN, String elemType, int elemId, String elemParam, String sign, String val, ArrayList<Effect> e)
  {
    type              = t;
    contentName       = contentN;
    elementType       = elemType;
    elementId         = elemId;
    elementParametr   = elemParam;
    conditionTypeChar = sign;
    valueStr          = val;
    effects           = e;
  }
  Condition(int t, String contentN, String elemType, int elemId, String elemParam, String sign, int val, ArrayList<Effect> e)
  {
    type              = t;
    contentName       = contentN;
    elementType       = elemType;
    elementId         = elemId;
    elementParametr   = elemParam;
    conditionTypeChar = sign;
    valueInt          = val;
    effects           = e;
  }
  Condition(int t, String contentN, String elemType, int elemId, String elemParam, String sign, boolean val, ArrayList<Effect> e)
  {
    type              = t;
    contentName       = contentN;
    elementType       = elemType;
    elementId         = elemId;
    elementParametr   = elemParam;
    conditionTypeChar = sign;
    valueBool          = val;
    effects           = e;
  }
  Condition(int t, String contentN, String elemType, int elemId, String elemParam, String sign, float val, ArrayList<Effect> e)
  {
    type              = t;
    contentName       = contentN;
    elementType       = elemType;
    elementId         = elemId;
    elementParametr   = elemParam;
    conditionTypeChar = sign;
    valueFl         = val;
    effects           = e;
  }
  void Update() //на сколько я представляю, здесь будет очень большой и томный код
  {
    
  }
}
//----------------------------------------------------------
class Effect //Эфект применяется только один раз, когда условие является выполненым.
{
  String type;
  String valueStr;
  int valueInt;
  float valueFl;
  boolean valueBool;
  
  String elementType;
  String elementParametr;
  int elementId;
  Effect(String val, String elemType, int elemId, String elemParam)
  {
    type = "string";
    valueStr = val;
    elementType       = elemType;
    elementId         = elemId;
    elementParametr   = elemParam;
  }
  Effect(int val, String elemType, int elemId, String elemParam)
  {
    type = "string";
    valueInt = val;
    elementType       = elemType;
    elementId         = elemId;
    elementParametr   = elemParam;
  }
  Effect(Boolean val, String elemType, int elemId, String elemParam)
  {
    type = "string";
    valueBool = val;
    elementType       = elemType;
    elementId         = elemId;
    elementParametr   = elemParam;
  }
  Effect(float val, String elemType, int elemId, String elemParam)
  {
    type = "string";
    valueFl = val;
    elementType       = elemType;
    elementId         = elemId;
    elementParametr   = elemParam;
  }
}
//----------------------------------------------------------
interface TypeGameEvent 
{
  int
  DISABLED = 0, 
  ENABLED  = 1, 
  PASSED   = 2,
  SKIPED   = 3;
}

class GameEvent //То что будет указываться игроку, что-то типо глав книги, только более динамичнее с возможностью паралели нескольких Эвентов. Эвенты будут разделять игру до и после, но не точно.
{
  String name;
  int status;
  
  GameEvent(String n, int s)
  {
    name = n;
    status = s;
  }
}
//----------------------------------------------------------
class Mail
{
  String topic;
  String text;
  int status; //0.недоступно 1.пришло 2.просмотренно
  //В последующем в письме почты будут храниться блоки, по заданию которых нужно вставлять в нужный протокол объекта (впринципе это основной геимплей)
  Mail(String t, String te, int s)
  {
    topic = t;
    text = te;
    status = s;
  }
}
class TextBlock
{
  int id;
  String text;
  boolean nline;
  color clr;
  
  TextBlock(int i, String t, boolean nln, color c)
  {
    id = i;
    text = t;
    nline = nln;
    clr = c;
  }
}
class Protocol extends Element
{
  int id;
  int number;
  String type;
  String name;
  String sNumber;
  String title;
  String proced;
  int clas;
  ArrayList<TextBlock> textBlocks;
  
  Protocol(int i, String t, int n, int c, String tit, ArrayList<TextBlock> tBlocks)
  {
    id = i;
    type = t;
    number = n;
    clas = c;
    title = tit;
    textBlocks = tBlocks;
    
    name = "p"+number;
    AddElementList(this);
  }
  String GetName(){return null;}
  void Draw()
  {
  }
}
