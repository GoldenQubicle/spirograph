/* //<>//
Controller
  - receives input and executes commands
  - updates GUI  

CurrenState 
  - add/remove keyframes
  - add/remove time
  - resize surface
  - add/copy/delete layer
  - update triggerAra
  
Animation
  - move setupArrays & updateAniMatrixTiming to CurrenState
  - flexible renderLoop, i.e. checks for new/changed triggers (would this check be performed in contoller, and then triggerArray in CurrentState?) 
  - interpolate keyFrames
  - playback over PImage[]

fileIO
  - save/load JSON
  - save PNG

  
to speed things up I want not rebuild the whole trigger array everytime, rather check first if there're any changes
if so: remove, add or update triggers (so this is rud soo probably in controller class?)
and then only re-render and replace the appriate PImages frames in the array



sort out the controller logic with regard to renderer for easier debuggin of said renderer

so basically, want to have somekind of 'lock' to indicate wheter changes made apply to all frames, only affect going forward or the single keyframe worked upon

rework gui while sorting that logic out

 renderer needs to be intergrated into gui / controller logic
 beforehand, move some layer settings (density / color) into sort of global
 or rather more often than not, when I adjust those, I want it to apply over all keyframes
 also, when copying layer, Id expect all keyframes to be copied as well
 
 theres a weird bug when toggling the gear trig completely off
 camera / offset not correct in 3d

 */

import peasy.*;
import controlP5.*;
import dawesometoolkit.*;
import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

PeasyCam cam;
DawesomeToolkit ds;
Controller controller;
GUI gui;
Animation gif;
Layer layer_1, layer_2;
ArrayList<Layer> layerActive =  new ArrayList();
ArrayList<Layer> layerKeyFrames = new ArrayList();
ArrayList<Layer> layerAnimate =  new ArrayList();
boolean play, update, spheres3d, render;
int Width = 512;
int Height = 512;
color cBackground;
float delay;

void settings() {
  size(Width, Height, P3D);
  smooth(8);
}

void setup() {
  colorMode(RGB);

  layer_1 = new Layer(75);
  layer_1.name = "Layer 1";
  layer_1.id = 1;
  layerActive.add(layer_1);
  //layer_2 = new Layer(150);
  //layer_2.name = "Layer 2";
  //layer_2.id = 2;
  //layerActive.add(layer_2);  
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
  update = false;
  spheres3d = false;
  render = false;
}

void draw() {
  background(cBackground);   
  //println(frameRate);
  if (update == true && Width != 512 || Height != 512) { 
    surface.setSize(Width, Height);
    translate(Width/2, Height/2);
  }

  if (play == false) { //<>//
    for (int i = 0; i < layerActive.size(); i++) {
      layerActive.get(i).display();
    }
  }
  if (play == true) {
    for (int i = 0; i < layerAnimate.size(); i++) {
      layerAnimate.get(i).display();
    }
  }
  if (render == true) { //<>//
    gif.renderLoop();
  }
}

// keep this timer for now, could be usefull later for playback over PImage[]
//void timer(float ms) {
//  if (ms > delay) {
//    render = false;
//  }
//  if (render == false) {
//    delay += 500;
//    gif.renderFrame+=1;    
//    gif.renderOnTimer(gif.renderFrame);  
//  }
//}

void keyPressed() {
  if (key==' ') {     
    if (play == false) {
      gui.cp5.get(Matrix.class, "Matrix").play();
      play = true;
    } else {
      gui.cp5.get(Matrix.class, "Matrix").pause();
      play = false;
    }
  }
  if (key == 'q') {
    gui.cp5.get(Matrix.class, "Matrix").stop();
    if (play == true) {
      gui.cp5.get(Matrix.class, "Matrix").play();
    }
  }
}