/*  //<>//
RREAALLLY need to sort out the funky offset business on update / load - maybe preempt it by loading a default in setup?!

going forward, be able to
- save json with size, length, intervals & background color - DONE!
- load said json - AND DONE!!
- add layer variables almost done
- add mutliple layer support
- reintroduce matrix

 couple more random ideas 
 - used spheres while in '2d' and apply rotate over x and y, probably pretty cool
 - speaking of, look into how I could possibly set up material / lighting
 - be able to move layers to the front or back, relative to each other
 
 Controller Class
- handles program logic, i.e. middle man gui and layer / animation / rendering / saveNLoad
- gifSaveAs -> text inputfield, and add preview button?
- gifSave -> 'current file' string as parameter?
- loadGif -> select file from dropdown menu?

  SaveNLoad Class
  - saves gui settings not related to layer, i.e. background color
  - saves layers as json objects 
  - loads layers
  
  Some thoughs to entertain
  - should SaveNLoad return layer objects? Or, should it write to dummy layer object in controller?
  - and in general, should keyframes be treated as layer objects, or read/write from json directly? or possibly ACT as json?
  - guess what Im asking, how and where do I translate between layer and json?
  
 todo
 add a 'reset to middle' button to gears
 add a 'lock radii' button to gears
  
 density toggle / reset between 2d&3d 
  
 */

import peasy.*;
import controlP5.*;
import dawesometoolkit.*;
import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;
//import gifAnimation.*;

//GifMaker gifExport;
PeasyCam cam;
DawesomeToolkit ds;
Controller controller;
GUI gui;
Animation gif;
Layer layer_1;
ArrayList<Layer> layers;
ArrayList<Layer> layerFrames;
boolean play, update;
int Width = 512;
int Height = 512;
color cBackground;

void settings() {
  size(Width, Height, P3D);
  smooth(8);
}

void setup() {
  colorMode(RGB);
  surface.setTitle("Preview");
  surface.setResizable(true);
  cam = new PeasyCam(this, 512);
  cam.setFreeRotationMode();
  ds = new DawesomeToolkit(this);
  ds.enableLazySave('i', ".png");
  Ani.init(this);
  Ani.noAutostart();
  Ani.setDefaultTimeMode(Ani.FRAMES);
  controller = new Controller();
  gui = new GUI(this);
  gif = new Animation();
  layers = new ArrayList();
  //layer_1 = new Layer();
  //layers.add(layer_1);
  cBackground = 120;
  play = false;
  //gifExport = new GifMaker(this, "export.gif");
  update = false;
}

void draw() {
  background(cBackground);   
 
  if (update == true) { 
     surface.setSize(Width, Height);
    translate(Width/2, Height/2);
  }
  for (int i = 0; i < layers.size(); i++) {
    layers.get(i).display();
  }
}

void keyPressed() {
  if (key==' ') {     
    if (play == false) {
      gui.cp5.get(Matrix.class, "Matrix").play();
      play = true;
    } else {
      gui.cp5.get(Matrix.class, "Matrix").pause();
      play = false;
    }
    gui.cp5.get(Toggle.class, "Play/Pause").setState(play);
  }
  if (key == 'q') {
    gui.cp5.get(Matrix.class, "Matrix").stop();
    if (play == true) {
      gui.cp5.get(Matrix.class, "Matrix").play();
    }
  }
}