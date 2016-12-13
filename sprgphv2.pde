/*
CURRENT CONCERNS
 WTF DOES STROKEWEIGHT CAUSE SUCH HAVOC?! ok so it just massivly slow things down. . . :/ soo maybe only have this for ellipse layer
 
 ~~~~~how to structure multiple layers with different settings~~~~
 
 - button to add new layer
 - dropdown menu to select layer
 - hide/show selected
 - delete selected layer
 
 each layers needs to have gears,stroke,color, etc etc retained
 HOWEVER
 gui needs to be generalised to work on selected layers
 
 TODO
 - add textfield input to radi / petals / density
 - add MODE to layer
 
 */

import controlP5.*;
import dawesometoolkit.*;

Layer layer_1;
GUI gui;
DawesomeToolkit ds;
boolean lock;
color BG;

void settings() {
  size(1024, 1024, P2D);
  smooth(8);
}


void setup() {
  BG = 128;
  layer_1 = new Layer();
  gui = new GUI(this);
  ds = new DawesomeToolkit(this);
  ds.enableLazySave();
  lock = false;
}


void draw() {
  background(BG);

  // for (Layer myLayer : layers){
  layer_1.display();
  //}


  gui.Controls();


  //// below possible function for control points & drawing straight lines
  //for (float i = 0; i < layerS_1.gear1.P; i++) {
  //  float theta = TAU/(layerS_1.gear1.P) * i;
  //  float theta2 = TAU/(layerS_1.gear1.P) * (i+5); // this term here needs to be max =  petals -1
  //  float x = cos(theta) * (layerS_1.gear1.RX); 
  //  float y =  sin(theta) * (layerS_1.gear1.RY); 
  //  float x2 = cos(theta2) * (layerS_1.gear1.RX); 
  //  float y2 =  sin(theta2) * (layerS_1.gear1.RY); 
  //  //ellipse(width/2 + x, height/2 - y, 6, 6 );
  //  strokeCap(ROUND);
  //  strokeWeight(3);
  //  stroke(0, 255, 0);
  //  line(width/2 + x, height/2 - y, width/2 + x2, height/2 - y2);
  //}
}

//void keyPressed() {
//  if (key == 'l') {
//    if (lock == false) {
//      lock = true;
//      //println(lock);
//    }
//    //if (lock == true) {
//    //  lock = false;
//    //}
//  }
//}