/*
CURRENT CONCERNS
 
the ffing color picker cannot be cast into the general control event
SO - either find a workaround for the color picker (make it part of layer?) 
OR - find a way to make the new layers work without the need for the control event business, which I dont know is needed anyway

ALSO! 

need to set/retrieve setting when switching layers! 
 
 TODO
- fine grain controlls, either by textfield input, or make a 2-staged control (for dotdensity, i.e. toggle ranges 0-1000, than slider per range). 
 
 */

import controlP5.*;
import dawesometoolkit.*;

Layer layer_1;
ArrayList<Layer> layers;
String[] Layers;
GUI gui;
DawesomeToolkit ds;
color BG;


void settings() {
  size(1024, 1024, P2D);
  smooth(8);
}

void setup() {
  BG = 128;  
  layers = new ArrayList();
  layer_1 = new Layer();
  layers.add(layer_1);
  Layers = new String[1];
  Layers[0] = "Layer " + layer_1.ID;  
  gui = new GUI(this);
  ds = new DawesomeToolkit(this);
  ds.enableLazySave();

}


void draw() {
  background(BG);

  for(int i = 0; i < layers.size(); i++){
    layers.get(i).display(); 
  }
  
  gui.Controls();
}