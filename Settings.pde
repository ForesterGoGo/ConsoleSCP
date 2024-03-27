import java.lang.reflect.Method;
import java.lang.reflect.Field;
import java.util.Collections;

/*String loadSettings(String field)
{
  return ; 
}*/

void printStructure() 
{
  /*println("\n***** PAPPLET METHODS: *****");
  printMethods(getClass().getMethods());*/
  
  println("\n***** USER CLASS FIELDS: *****");
  for (Class c : getClass().getDeclaredClasses()) printFields(c.getDeclaredFields(),c.getName());
}

String clean(String str) 
{
  str = str.substring(str.lastIndexOf('.') + 1);
  if (str.contains("$")) str = str.substring(str.indexOf('$') + 1); // get rid of the sketch class name and keep only the child class name
  return str.replaceAll("[^\\w]", "");
}
void printFields(Field[] list, String nameClass) 
{
  println("\n-----CLASS " + clean(nameClass)+"-----");
  ArrayList<String> result = new ArrayList();

  for (Field f : list) {
    String name = clean(f.getName());
    String type = clean(f.getType().toString());    
    if(type.equals("classConsoleSCP")) continue;

    result.add(type + " " + name);
  }
  Collections.sort(result);
  for (String s : result) println(s);
  println("--------------------------");
}
