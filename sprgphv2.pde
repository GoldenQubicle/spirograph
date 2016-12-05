/*
CURRENT CONCERNS
uhghghghg total deadlock atm - cant even pass simple gear0 values to layer - WTF?!
contemplating going naive approach because either Im just blindsighted atm or more likely, trying something too complicated for my current skilllevel
at least with naive approach I know roughly how to set it up again and how know, maybe itll start to make sense along the way
SO navaive approach
  - write out all gears with a hard limit on 5
  - put those in a number of switch cases
  - tie those switches into the UI toggle button
  - write controls for all 5 gear sets, and a put those inside a layer group
 
 TODO - ADD CONTROLS FOR ONE! LAYER
 - toggle between Gear0 and Gear1
 - per Gear set: RadiusX, RadiusY, LineX, LineY, Petals
 - be able to set color and rotate & scale
 - save function without worry about naming, i.e. contineous numbering scheme
 
 ADDED VALUE
 - the for loop with TAU/ARG*i & subsequent theta is at the heart of operations, maybe isolate it in single function?
 - geometric layer
 - dare I say online implementation?
 */

import controlP5.*;

GUI gui;
LayerS Layer1;



void setup() {
  size(640, 640, P2D);
  smooth(8);
  Layer1 = new LayerS(this);
  gui = new GUI(this);
}


void draw() {
  background(128);


 Layer1.display();


  // below possible function for control points & drawing straight lines
  //for (float i = 0; i < layerS_1.Petals; i++) {
  //  float theta = TAU/(layerS_1.Petals) * i;
  //  float theta2 = TAU/(layerS_1.Petals) * (i+5); // this term here needs to be max =  petals -1
  //  float x = cos(theta) * (layerS_1.RadiusX); 
  //  float y =  sin(theta) * (layerS_1.RadiusY); 
  //  float x2 = cos(theta2) * (layerS_1.RadiusX); 
  //  float y2 =  sin(theta2) * (layerS_1.RadiusY); 
  //  //ellipse(width/2 + x, height/2 - y, 6, 6 );
  //  strokeCap(ROUND);
  //  strokeWeight(3);
  //  stroke(0, 255, 0);
  //  line(width/2 + x, height/2 - y, width/2 + x2, height/2 - y2);
  //}
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