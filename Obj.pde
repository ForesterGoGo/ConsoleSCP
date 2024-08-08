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
  void AddRootSize(PVector rootSize) 
  {
    PVector size = new PVector();
    size.add(rootSize.copy());
    println("MARK - AddRootSize = rootSize: " + rootSize + " & size: " + size);
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
    element.AddRootPosition(position); //задаем смещение от родительского элемента
    element.AddRootSize(size); //задаем размер от родительского элемента
    elements.add(element); //добавляем элемент к родительскому массиву
  }
}
