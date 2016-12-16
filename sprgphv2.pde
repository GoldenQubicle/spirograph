/*
CURRENT CONCERNS

actually hide layer may be superfluos as well since its simply fill&stroke off. . hehehe
 
 TODO
 - finer controls, either by textfield input, or make a 2-staged control (for dotdensity, i.e. toggle ranges 0-1000, than slider per range). 
 
 */

import controlP5.*;
import dawesometoolkit.*;

Layer layer_1;
ArrayList<Layer> layers;
DawesomeToolkit ds;
color BG;
GUI gui;

void settings() {
  size(512, 512, P2D);
  smooth(8);
}

void setup() {

  BG = 128;  
  layers = new ArrayList();
  layer_1 = new Layer();
  layers.add(layer_1);
  ds = new DawesomeToolkit(this);
  ds.enableLazySave();
  gui = new GUI(this);
}


void draw() {
  background(BG);

  for (int i = 0; i < layers.size(); i++) {
    layers.get(i).display();
  }

  gui.Controls();
}