/*
CURRENT CONCERNS

 
 TODO
 toggle Fill / noFill
 toggle noStroke / stroke (and add strokeWeight & strokeColor!)
 
 
 ADDED VALUE
 d00d, transitioning gifs!
 basically make a function which describes point in a circle for min/max xy per gear, and feed that into the xy gear parameters
 or, pick random values at start, 
 , pcik another set of random values to lerp to
 also random generator
 
 - geometric layer
 
 */

import controlP5.*;
import dawesometoolkit.*;

LayerS layerS_1;
GUI gui;
DawesomeToolkit ds;
boolean lock;

void setup() {
  size(1024, 1024, P2D);
  smooth(8);
  layerS_1 = new LayerS();
  gui = new GUI(this);
  ds = new DawesomeToolkit(this);
  ds.enableLazySave();
  lock = false;
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

//void Add() {
//  if (layerS_1.Shift < 3) {
//    layerS_1.Shift = layerS_1.Shift + 1;
//  }
//}
//void Delete() {
//  if (layerS_1.Shift > 0) {
//    layerS_1.Shift = layerS_1.Shift - 1;
//  }
//}

void keyPressed() {
  if (key == 'l') {
    if (lock == false) {
      lock = true;
      //println(lock);
    }
    //if (lock == true) {
    //  lock = false;
    //}
  }
}

//void mouseWheel(MouseEvent event) {
//  float e = event.getCount();
//  Outer.RadiusX = Outer.RadiusX-e;
//}