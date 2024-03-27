ArrayList<Object> objectList;

class Object
{
  String name;
  int id;
  PVector position;
  PVector size;
  void Draw(){}
  void Update(){}
  void AddRootPosition(PVector rootPos) 
  {
    position.add(rootPos.copy());
    println("MARK - AddRootPosition = rootPos: " + rootPos + " & position: " + position);
  }
}

void AddObjectList(Object temp)
{
  objectList.add(temp);
}


class Container extends Object
{
  ArrayList<Object> elements;
  void SetElement(Object element)
  {
    element.AddRootPosition(position); //задаем смещение от родительского окна
    elements.add(element); //добавляем элемент к родительскому массиву
  }
}
