/*
CURRENT CONCERNS
How the f do I pass values along, surely not from a bunch of global vars? 
Especially not given RadiusY value is actually been read. . need to figure out how to access it. . 
also moveable menu would be nice

TODO
 - per Gear set: RadiusX, RadiusY, LineX, LineY, Petals, Color
 - be able to rotate & scale individual layers
 - save function without worry about naming, i.e. contineous numbering scheme
 
ADDED VALUE
- the for loop with TAU/ARG*i & subsequent theta is at the heart of operations, maybe isolate it in single function?
- geometric layer
- dare I say online implementation? 
 */
 
import controlP5.*;
ControlP5 cp5;
LayerS layerS_1;
GUI gui;

float wut;

void setup() {
  cp5 = new ControlP5(this);
  size(640, 640, P2D);
  smooth(8);
  layerS_1 = new LayerS();
  gui = new GUI();
  
  wut = 150;

}


void draw() {
  background(128);
  layerS_1.display();
  //gui.display();
  
  // below possible function for control points & drawing straight lines
  for (float i = 0; i < layerS_1.Petals; i++) {
    float theta = TAU/(layerS_1.Petals) * i;
    float theta2 = TAU/(layerS_1.Petals) * (i+5); // this term here needs to be max =  petals -1
    float x = cos(theta) * (layerS_1.RadiusX+75); 
    float y =  sin(theta) * (layerS_1.RadiusY+75); 
    float x2 = cos(theta2) * (layerS_1.RadiusX+75); 
    float y2 =  sin(theta2) * (layerS_1.RadiusY+75); 
    //ellipse(width/2 + x, height/2 - y, 6, 6 );
    strokeCap(ROUND);
    strokeWeight(3);
    stroke(0,255,0);
    line(width/2 + x, height/2 - y, width/2 + x2, height/2 - y2);
  }
}

//void keyPressed() {
//  if (key == 's') {
//    String image = "image" + 1 + ".png";
//    save(image);
//  }
//}

//void mouseWheel(MouseEvent event) {
//  float e = event.getCount();
//  Outer.RadiusX = Outer.RadiusX-e;
//}