ArrayList<Object> objectList;

class Object
{
  String name;
  int id;
  int idObjectList;
  int parentId;
  PVector position;
  PVector size;
  void Draw(PVector parentPos){};
  void Update(PVector parentPos){};
  
  Object GetParent()
  {
    return objectList.get(parentId);
  }
}

int AddObjectList(Object temp)
{
  objectList.add(temp);
  return objectList.size()-1;
}

class Container extends Object
{
  ArrayList<Object> elements;
  void SetElement(Object element)
  {
    elements.add(element); //добавляем элемент к родительскому массиву
    element.parentId = idObjectList; //даем элементу id родительского элемента
  }
}
