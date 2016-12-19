/*
CURRENT CONCERNS

 
 
 BRAINDUMP with regard to animation ~  all things are ideally speaking ofc
 - set length of animation, e.g. 2 seconds
 - set x number of control points with 2 being the minimum, i.e. start / stop
 - being able to set different kind of transitions inbetween control points, that is:
 if simply do go from 0 - 60 over 60 frames, than each frame is a difference of 1, i.e. liniear transition
 - layer settings on each control point are automatically stored when tweaked
 - being able to loop between individual control points (i.e. not only over start/stop) and tweak settings in realtime
 - save/load animation scripts so I can work on and off 

 
 need to pass  2 layer objects to animation, i.e. start/stop to lerp over settings
 matrix toggles which parameter is iterated over
 
 instead of calling on the layer objects to draw continously, I need to write each 'lerp frame' to a pixel array / PIamge
 than itterate over that array for the animation
 layers are only on display for tweaking
 
 STRATEGY
 - attach (multiple) layer object(s) to steps, i.e. when playing it toggles between the two
 - write current display into pixel array / PIMage
 
 
 
 CONSIDERATIONS
 - unique stokeweight for lines and dots
 - !!would be kinda nice if I could copy gear/petal settings from one layer to a new one (e.g. if press copy, grab settings from id-1).
 - finer controls, either by textfield input, or make a 2-staged control (for dotdensity, i.e. toggle ranges 0-1000, than slider per range). 
 - to combat the noticable lag with multiple taxing layers, maybe see if layer can be drawn once, than stored as PImage / pixel array or somehting
 
 */
//import gifAnimation.*;
import controlP5.*;
import dawesometoolkit.*;

//GifMaker gifExport;
Layer layer_1, layer_2, layer_3;
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
  //layer_2 = new Layer();
  //layer_3 = new Layer();
  layers.add(layer_1);
  //layers.add(layer_2);
  //layers.add(layer_3);
  ds = new DawesomeToolkit(this);
  ds.enableLazySave();
  gui = new GUI(this);
  //gif = new Animation();
  //gifExport = new GifMaker(this, "export.gif");
}

void draw() {
  background(BG);
  
//println(frameRate);
for (int i = 0; i < layers.size();i++){
  layers.get(i).display();
 
}
 
  gui.BG(BG);  
 gui.ColorFillStroke();

}