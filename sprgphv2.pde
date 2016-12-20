/*
 CURRENT THINKIN with regard to animation 
 make a trigger object class, which holds an id, in addition to variable values for ani, the ani themselves and additional info like toggles and which layers its associated with
 then in the animation class, set up for loop which constructs the triggers based on keyframes
 the big issue is, how to handle tweaking, i.e. store and load settings of triggers
 
 CONSIDERATIONS 
 - save/load animation scripts so I can work on and off 
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