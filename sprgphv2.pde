/* //<>// //<>//
 

- trig switches pose bit of a problem for layer switching, hehehehe
  yeah so actually rather annoying, the buttunbar does not update visually and there doesbt seem to be a way to toggle active cells. . . :/

- use space underneath gears in 2d mode for density controls, i.e. density for 3d will be hardcoded, or maybe some slider but it doesnt need to be as finegraines as for 2d 

 couple more random ideas 
 - used spheres while in '2d' and apply rotate over x and y, probably pretty cool
 - speaking of, look into how I could possibly set up material / lighting
 - add blend mode to layer, next to layer switch
 - be able to move layers to the front or back, relative to each other
 
 Controller Class
 - handles saving and loading of all settings - whether by cp5 json or custom function
 - handles rendering
 
 
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
String JSON = "C:\\Users\\Erik\\Documents\\Processing\\sprgphv2\\data\\LayerState";
boolean play, update;
int Width = 512;
int Height = 512;
color BG;

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
  layer_1 = new Layer();
  layers.add(layer_1);
  BG = 120;
  play = false;
  //blendMode(DIFFERENCE);
  //gifExport = new GifMaker(this, "export.gif");
  update = false;
}

void draw() {
  background(BG);  

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