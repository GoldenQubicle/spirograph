/*
CURRENT CONCERNS
- really need restructering
- one core loop in which to pass the parameters of the different layers, e.g. for LayerS myLayer: Layers, do stuff
- be able to add / remove gears in realtime, i.e. pass additional arguments XY into object, i.e. add function (part of core?) 
- also, need to be able to select layers, i.e. layer need to have its own menu, which brings forth the optionals 
 
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

LayerS layerS_1;
GUI gui;

void setup() {
  size(640, 640, P2D);
  smooth(8);
  layerS_1 = new LayerS();
  gui = new GUI(this);
}


void draw() {
  background(128);
  layerS_1.display();
  gui.Controls();
  // below possible function for control points & drawing straight lines
  for (float i = 0; i < layerS_1.Petals; i++) {
    float theta = TAU/(layerS_1.Petals) * i;
    float theta2 = TAU/(layerS_1.Petals) * (i+5); // this term here needs to be max =  petals -1
    float x = cos(theta) * (layerS_1.RadiusX); 
    float y =  sin(theta) * (layerS_1.RadiusY); 
    float x2 = cos(theta2) * (layerS_1.RadiusX); 
    float y2 =  sin(theta2) * (layerS_1.RadiusY); 
    //ellipse(width/2 + x, height/2 - y, 6, 6 );
    strokeCap(ROUND);
    strokeWeight(3);
    stroke(0, 255, 0);
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