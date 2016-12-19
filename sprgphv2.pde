/*
RIGHT
  so the ani works
  current thinking is to use to matrix the trigger the ani with length of interval
  also, when 'lock' is active (e.g. top row) than settings are funneled to respective ani
 ALSO
 tie start/stop ani to matrix
 also repeat
 
 BRAINDUMP with regard to animation ~  all things are ideally speaking ofc
 - set length of animation, e.g. 2 seconds
 - set x number of control points with 2 being the minimum, i.e. start / stop
 - being able to set different kind of transitions inbetween control points, that is:
 if simply do go from 0 - 60 over 60 frames, than each frame is a difference of 1, i.e. liniear transition
 - layer settings on each control point are automatically stored when tweaked
 - being able to loop between individual control points (i.e. not only over start/stop) and tweak settings in realtime
 - save/load animation scripts so I can work on and off 
 
 
 CONSIDERATIONS 
 - finer controls, either by textfield input, or make a 2-staged control (for dotdensity, i.e. toggle ranges 0-1000, than slider per range). 
 - to combat the noticable lag with multiple taxing layers, maybe see if layer can be drawn once, than stored as PImage / pixel array or somehting
  */
import controlP5.*;
import dawesometoolkit.*;
import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;
//import gifAnimation.*;

//GifMaker gifExport;
Layer layer_1, layer_2, layer_3;
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
  Ani.init(this);
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
  gif = new Animation();
  //gifExport = new GifMaker(this, "export.gif");
  
}

void draw() {
  background(BG);
 //println(frameRate);

  for (int i = 0; i < layers.size(); i++) {
    layers.get(i).display();
  }
  gui.BG(BG);  
  gui.ColorFillStroke();
}

void keyPressed() {
  if (key=='p') {
    if (gui.cp5.get(Matrix.class, "Matrix").isPlaying()) {
      gui.cp5.get(Matrix.class, "Matrix").pause();
    } else {
      gui.cp5.get(Matrix.class, "Matrix").play();
    }
  }
}