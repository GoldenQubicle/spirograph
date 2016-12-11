/*

possibly extract gears from spirograph layer so the gui controls gears, and the layers are responsible for handling fill/color etc and which shapes to draw 
i.e. lines, circles
OR better yet, make a gui toggle so to switch between modes (eg lines mode, spiralmode, etc), so it becomes a property of layer (i.e. mode), long color, fill, etc

TODO
 - timing and scripting events, possibly with ani library and cp5 matrix controls
 - before than 
 1) add geometry later and corresponding controls
 2) load/save control properties 
 
 4) proper gif export
 
 ADDED VALUE
 d00d, transitioning gifs!
 basically make a function which describes point in a circle for min/max xy per gear, and feed that into the xy gear parameters
 or, pick random values at start, 
 , pcik another set of random values to lerp to - LERP between different controller properties settings over set amount of time
 also random generator
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
  layer_1 = new Layer();
  gui = new GUI(this);
  ds = new DawesomeToolkit(this);
  ds.enableLazySave();
  lock = false;
  BG = 128;
}


void draw() {
  background(BG);

  layer_1.display();
  
  
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