/*
BRAINDUMP with regard to animation ~  all things are ideally speaking ofc
- set length of animation, e.g. 2 seconds
- set x number of control points with 2 being the minimum, i.e. start / stop
- being able to set different kind of transitions inbetween control points, that is:
  if simply do go from 0 - 60 over 60 frames, than each frame is a difference of 1, i.e. liniear transition
- layer settings on each control point are automatically stored when tweaked
- being able to loop between individual control points (i.e. not only over start/stop) and tweak settings in realtime
- save/load animation scripts so I can work on and off 

 
CONSIDERATIONS
 - would be kinda nice if I could copy gear/petal settings from one layer to a new one (e.g. if press copy, grab settings from id-1).
 - finer controls, either by textfield input, or make a 2-staged control (for dotdensity, i.e. toggle ranges 0-1000, than slider per range). 
 - to combat the noticable lag with multiple taxing layers, maybe see if layer can be drawn once, than stored as PImage / pixel array or somehting
 
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