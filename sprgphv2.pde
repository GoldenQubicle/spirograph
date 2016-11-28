/*
TODO
 - start using GUI library!
 - adjustabele Radius, thickness & color
 - add secondary logic, which can be toggled, with switch cases?  
 
 */

Logic Outer;
GUI gui;
void setup() {

  size(640, 640, P2D);
  smooth(8);
  Outer = new Logic();
  gui = new GUI();
}


void draw() {
  background(128);
  Outer.display();
  //gui.display();
}

//void keyPressed() {
//  if (key == 's') {
//    String image = "image" + 1 + ".png";
//    save(image);
//  }
//}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  Outer.RadiusX = Outer.RadiusX-e;
}