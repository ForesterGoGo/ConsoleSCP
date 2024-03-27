Viral commandPromt;
Viral consoleOutput;
Viral protocolOutput;
Viral debugInfoOutput;
Viral savetxt;

class Viral
{
  String type = "";
  String variable = "";
  Viral(){}
  void Add(String temp)
  {
    variable+=temp;
  }
  void Del()
  {
    if(variable.length() != 0)variable = variable.substring(0,variable.length()-1); 
  }
  void Clean()
  {
    variable = "";
  }
  void AddLn(String temp)
  {
    variable += "\n"+temp; 
  }
  boolean CheckInBoxSize(int size)
  {
    boolean flag = false;
    if(textWidth(variable)<size) flag = true;
    return flag;
  }
  void Set(ArrayList<TextBlock> textBlocks, int windowWidth)//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!СОЗДАНИЕ ЛОГИКИ ТЕКСТОВОГО ПРОЦЕССОРА НА ОСНОВЕЕ ЗАКОМЕНЧЕНОГО КОДА!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  {
    int currentPos = 0; //Позиция каретки смещения нового текста
    for(int current=0;current<textBlocks.size();current++)
    {
      TextBlock block = textBlocks.get(current);
      //String currentText = block.text; //Берем текущий текст 
      String currentText = "";
      //--------------------перевод пробела в подчеркивание-------------
      /*for(int i=0;i<block.text.length();i++) 
        if(block.text.charAt(i) == ' ') currentText += '_';
        else currentText += block.text.charAt(i);*/
      //------------------------------ИЛИ-------------------------------
        currentText += block.text;
      //----------------------------------------------------------------
      
      String result = ""; //Результат 
      int spaceOfset = 0;
      int window = int(windowWidth/10.5); //Окошко, в котором располагается текст
      int gate = window - currentPos; //Доступное количество свободного пространства на текущей строке
      int lengthText = currentText.length();

      while(lengthText > gate) //Если больше рамок
      {
        //Ищем символ препинания или пробел, на котором можем обрезать строку
        for(int i = gate;i > 0 && currentText.charAt(i)!= ' ' && currentText.charAt(i)!= '.' && currentText.charAt(i)!= ',' && currentText.charAt(i)!= ':' && currentText.charAt(i)!= ';';i--) 
          gate--;
        if(currentText.charAt(gate)== ' ' || currentText.charAt(gate)== '.' || currentText.charAt(gate)== ',' || currentText.charAt(gate)== ':' || currentText.charAt(gate)== ';')
        {
          if(currentText.charAt(gate)== ' ') 
            currentText = currentText.substring(0,gate)+currentText.substring(gate+1);
          else
            gate++;
        }
        result += currentText.substring(0,gate)+"\n"; //Вставляем первый отрезок с "\n"
        currentText = currentText.substring(gate); //Подготавливаем оставшуюся строку к следующему циклу отрезания
        lengthText = currentText.length();
        
        if(lengthText > gate) currentPos = 0; //Если следующая строка войдёт во всю ширину окна, то убираем смещение
        gate = window - currentPos; //Вычисляем новые рамки
      }
      
      
      result += currentText; 
      
      if(textBlocks.size()>current+1 && !textBlocks.get(current+1).nline) result += ' ';// Добавляем пробел, соединяя блоки, если следующий блок начинается не с новой строки
      
      currentPos = lengthText;
                 
      //Если есть XML "\n"
      if(block.nline)
      {
        protocolOutput.AddLn(result);
        //currentPosition = 0;
      }
      else 
      {
        protocolOutput.Add(result);
      }
    }
    // int size = (int)protocolWindowGET("protocolWindow").size.x;
    //if(!protocolOutput.CheckInBoxSize(size)) protocolOutput.ReSize(size);
  }
  /*void ReSize(int size) // нерабочий вариант, нужно учитывать точки, запятые и слова. В общем гиганский текстовый процессор.
  {
    String result = "";
    String temp = variable; 
    float numberChar = textWidth(temp)/10-size;
    while(numberChar>1)
    {
      println("-------------------------\nreLnRect(): ("+temp+")-"+textWidth(temp)+">"+size);
      println("float numberChar("+(textWidth(temp)/10-size)+") = textWidth(temp)("+textWidth(temp)+")/10-size("+size+");");
      numberChar = textWidth(temp)/10-size;
      result += temp.substring(0,(int)numberChar)+"\n";
      temp = temp.substring((int)numberChar);
    }
    variable = result;
  }*/
}
String reLnRect(String temp, int maxPos) 
{
  print("->reLnRect():\n");
  String result = "";
  while(temp.length()>maxPos) 
  {
    println("while("+temp.length()+">"+maxPos+") = true;" );
    float numberChar = temp.length()-maxPos;//Делим на ширину символа чтобы получить номер символа где нужно вставить "\n"
    result += temp.substring(0,(int)numberChar)+"\n";
    temp = temp.substring((int)numberChar);
  }
  println("while("+temp.length()+">"+maxPos+") = false;" );
  result+=temp;
  println("return ='"+result+"'");
  return result;
}
String Type(int temp)
{
  return "int";
}
String Type(String temp)
{
  return "String";
}
String Type(float temp)
{
  return "float";
}
String Type(boolean temp)
{
  return "boolean";
}
