/* //<>//

cant load 3d file properly, 3d toggle is not yet hooked up it seemd, tho shouldnt that be a global anyway?!
move Scrollable list blend mode & layerswitch to near aniMatrix, in addition to stroke/fill, line x&y and sw



 couple more random ideas 
 - used spheres while in '2d' and apply rotate over x and y, probably pretty cool
 - speaking of, look into how I could possibly set up material / lighting
 - be able to move layers to the front or back, relative to each other
  
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
Layer layer_1, layer_2;
ArrayList<Layer> layerActive;
ArrayList<Layer> layerKeyFrames = new ArrayList();
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
  layerActive = new ArrayList();
  layer_1 = new Layer(75);
  layer_1.name = "Layer 1";
  layer_1.id = 1;
  layerActive.add(layer_1);
  layer_2 = new Layer(150);
  layer_2.name = "Layer 2";
  layer_2.id = 2;
  layerActive.add(layer_2);
  surface.setTitle("Preview");
  surface.setResizable(true);
  cam = new PeasyCam(this, 512);
  cam.setFreeRotationMode();
  ds = new DawesomeToolkit(this);
  ds.enableLazySave('i', ".png");
  Ani.init(this);
  Ani.noAutostart();
  Ani.setDefaultTimeMode(Ani.FRAMES);
  gif = new Animation();  
  gui = new GUI(this);
  controller = new Controller();
  cBackground = color(128, 128, 128);
  play = false;
  //gifExport = new GifMaker(this, "export.gif");
  update = false;
}

void draw() {
  background(cBackground);   

  if (update == true && Width != 512 || Height != 512) { 
    surface.setSize(Width, Height);
    translate(Width/2, Height/2);
  }
  for (int i = 0; i < layerActive.size(); i++) {
    layerActive.get(i).display();
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
    //gui.cp5.get(Toggle.class, "Play/Pause").setState(play);
  }
  if (key == 'q') {
    gui.cp5.get(Matrix.class, "Matrix").stop();
    if (play == true) {
      gui.cp5.get(Matrix.class, "Matrix").play();
    }
  }
}