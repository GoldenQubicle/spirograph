/*
CURRENT CONCERNS
 
 need to set/retrieve setting when switching layers!
 this sorta works for now tho few issues

   2) colors are not picked up between layer and that is because
   3) need to find a way to pick up fill/stroke color within individual layer
 
 
 delete layer
 toggle layer visibilty
 
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
  size(1024, 1024, P2D);
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