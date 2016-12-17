/*
BRAINDUMP with regard to animation ~  all things are ideally speaking ofc
 - set length of animation, e.g. 2 seconds
 - set x number of control points with 2 being the minimum, i.e. start / stop
 - being able to set different kind of transitions inbetween control points, that is:
 if simply do go from 0 - 60 over 60 frames, than each frame is a difference of 1, i.e. liniear transition
 - layer settings on each control point are automatically stored when tweaked
 - being able to loop between individual control points (i.e. not only over start/stop) and tweak settings in realtime
 - save/load animation scripts so I can work on and off 
 
 parameters per layer
 - 8 : 4 gears with x&ypos (reduced to 4 if using PVectors)
 - 3 : petal
 - 2 : color fill&stroke
 - 2 : toggle fill&stroke
 - 1 : outline, toggle active color in picker
 - 2 : line x&y
 - 2 : toggle line&dots
 - 3 : gears connect
 - 1 : strokeweight
 - 1 : Density
 
 SO, 25 parameters per layer
 HOWEVER, do I really need to, or want to, pass all of them into an 'animation' class, if the settings
 can be saved per layer / time point
 
 need to pass  2 layer objects to animation, i.e. start/stop to lerp over settings
 matrix toggles which parameter is iterated over
 
 instead of calling on the layer objects to draw continously, I need to write each 'lerp frame' to a pixel array / PIamge
 than itterate over that array for the animation
 layers are only on display for tweaking
 
 STRATEGY
 - top row of matrix will lock/unlock layer, i.e. be called on main loop or not
 - attach (multiple) layer object(s) to steps, i.e. when playing it toggles between the two
 - write current display into pixel array / PIMage

 
 
 CONSIDERATIONS
 - would be kinda nice if I could copy gear/petal settings from one layer to a new one (e.g. if press copy, grab settings from id-1).
 - finer controls, either by textfield input, or make a 2-staged control (for dotdensity, i.e. toggle ranges 0-1000, than slider per range). 
 - to combat the noticable lag with multiple taxing layers, maybe see if layer can be drawn once, than stored as PImage / pixel array or somehting
 
 */
//import gifAnimation.*;
import controlP5.*;
import dawesometoolkit.*;

//GifMaker gifExport;
Layer layer_1;
ArrayList<Layer> layers;
DawesomeToolkit ds;
color BG;
GUI gui;
Animation gif;

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
  gif = new Animation();
  //gifExport = new GifMaker(this, "export.gif");
}

void draw() {
  background(BG);
  
 // only valid when layers are unlocked 
  for (int i = 0; i < layers.size(); i++) {
    layers.get(i).display();
  }
  gui.Controls();

//println(frameRate);
}


void keyPressed() {

  if (key=='p') {
    if (gui.cp5.get(Matrix.class, "Matrix").isPlaying()) {
      gui.cp5.get(Matrix.class, "Matrix").pause();
    } else {
      gui.cp5.get(Matrix.class, "Matrix").play();
    }
  } else if (key=='0') {
    gui.cp5.get(Matrix.class, "Matrix").clear();
  }
}