/* //<>//

soo, this upset below is nice and all, but actually not necesarry at the moment to start restructering and/or refactoring
that is to say, everything works as it should 
instead focus on more pressing issue, namely how to handle updating / interpolating keyFrames settings

User story
- when I have all frames selected active, a change to e.g. color is applied to all frames, regardless whether there's a change to trigger
- when I have selected frame 6 <= end changes made to e.g. radius gear 2 are applied to frame 7,8,9, etc

so, in terms of updating keyFrames there're 3 cases
1 changes made on all frames 
2 changes made on frame <= end
3 changes made to single frame

case 3 is basically how it's working now
so question is: how to propogate the changed parameter to the approriate keyFrames in case 1 & 2
that is: simply running the keyFrames through copyLayerSettings is obviously not going to work
so, is it possible to do a comparison of layer objects?


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

 BUGS
 controls freeze when toggling the gear trig completely off

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