/*
CURRENT CONCERNS
 rrrrriiight
 I know how to venture forward and make a complete layer, however, its gonna be messy. . 
 still better than nothing I guess but honestly, there should deffo be a better method, i.e.
 with dynamic controls per gear change. . ah well itll do for now
 SO, here's a thought, maybe put the controls into a seperate window?! like how I did with the TTG 
 OR - take a hard look at cp5 example control inside class, this is pretty much what I wanted to do with gear class
 ALSO check out control frame example!!!
 
 TODO - ADD CONTROLS FOR ONE! LAYER
 - toggle between gears with switch cases
 - per Gear: RadiusX, RadiusY, Petals
 - per Layer: line width, color
 
 
 ADDED VALUE
 - scale & rotate layer
 - the for loop with TAU/ARG*i & subsequent theta is at the heart of operations, maybe isolate it in single function?
 - geometric layer
 - dare I say online implementation?
 */

import controlP5.*;
import dawesometoolkit.*;

LayerS layerS_1;
GUI gui;
DawesomeToolkit ds;


void setup() {
  size(1000, 1000, P2D);
  smooth(8);
  layerS_1 = new LayerS();
  gui = new GUI(this);
  ds = new DawesomeToolkit(this);
  ds.enableLazySave();
}


void draw() {
  background(128);

  layerS_1.display();
  gui.Controls();

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

void Add() {
  if (layerS_1.Shift < 3) {
    layerS_1.Shift = layerS_1.Shift + 1;
  }
}
void Delete() {
  if (layerS_1.Shift > 0) {
    layerS_1.Shift = layerS_1.Shift - 1;
  }
}


void ColorPicker() {
  //int r = int(gui.cp5.getController("ColorPicker").getArrayValue(0));
  //int g = int(gui.cp5.getController("ColorPicker").getArrayValue(1));
  //int b = int(gui.cp5.getController("ColorPicker").getArrayValue(2));
  //int a = int(gui.cp5.getController("ColorPicker").getArrayValue(3));
  //layerS_1.C = gui.cp.getColorValue();
  println("check");
}

//public void controlEvent(ControlEvent c) {
//    int r = int(c.getArrayValue(0));
//    int g = int(c.getArrayValue(1));
//    int b = int(c.getArrayValue(2));
//    int a = int(c.getArrayValue(3));
//    layerS_1.C = color(r,g,b,a);

//}


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