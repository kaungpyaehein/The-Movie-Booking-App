abstract class Shape {
  void draw();
}

class Circle extends Shape {
  @override
  void draw() {
    print("draw a circle");
  }
}

class Square extends Shape {
  @override
  void draw() {
    print("draw a square");
  }
}

void main() {

  //polymorphism
  Shape circle = Circle();
  Shape square = Square();
  circle.draw();
  square.draw();
}


