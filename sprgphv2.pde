/* //<>//
roadmap - in order of severity
 - additional gear controls : lockXY, resetTo0, castFloat - data & logic & gui
 - fix color transitions - data & logic
 - implement multiple layer key editting - logic
 - check-check-double-check multiple layer ani x consequetive ani - logic 
 - add line & dot mode back in - logic & gui
 - add radial color toggle - gui
 - finalise gui - gui
 
 possibly add background color to aniMatrix
 possibly figure out how to put toggles (e.g. stroke, fill) to use with keyframes
 possibly add density to aniMatrix
 
 known bugs
 - controls freeze when toggling the gear trigs completely off
 - aniInterval gui not correct,  off by one error somewhere
 - in compiled app controls freeze upon new file save
 
 -------------------------------------------------------------------------------------------------------------------------- 
 ok so couple of long term goals
 when/if Im gonna refactor as outlined below, CurrentState (i.e. Model class) must have a robust update function, i.e.
 have logic functions which work out changes for keyFrames, timing AND Triggers
 - with regard keyFrames, atm storing these in one array, which is really annoying to work with. Moreover, data is already stored in JSON
 so it should be possible to represent keyFrames by simply read/write data directly from JSON, instead of representing it as seperate Layer objects
 - with regard triggers, atm its storing way more data than necessary, i.e. only need active Matrix cells & end values of ani
 
 Obviously, the various render functions in Animation should be consolidated into oneother as the only difference is the value for aniSeek
 Even more obvious: multiple layer support is still not properly implemented . . 
 
 Controller
 - receives input and executes commands
 - updates GUI  
 
 CurrentState 
 - add/remove keyframes
 - add/remove time
 - resize surface
 - add/copy/delete layer
 - update triggerArrat
 
 Animation
 - move setupArrays & updateAniMatrixTiming to CurrenState
 - flexible renderLoop, i.e. checks for new/changed triggers (would this check be performed in contoller, and then triggerArray in CurrentState?) 
 - interpolate keyFrames
 - playback over PImage[]
 
 fileIO
 - save/load JSON
 - save PNG

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
Display preview;
Layer layer_1, layer_2;
ArrayList<Layer> layerActive =  new ArrayList();
ArrayList<Layer> layerKeyFrames = new ArrayList();
ArrayList<Layer> layerAnimate =  new ArrayList();
boolean play, update, spheres3d, render, renderKeyFrames, playback, next;
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
  preview = new Display();
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
  renderKeyFrames = false;
  playback = false;
}

void draw() {
  background(cBackground);   

  if (update == true && Width != 512 || Height != 512) { 
    surface.setSize(Width, Height);
    translate(Width/2, Height/2);
  }

  if (play == false && playback == false) {
    for (int i = 0; i < layerActive.size(); i++) {
      //layerActive.get(i).display();
      preview.display(layerActive.get(i));
    }
  }
  if (play == true  && playback == false) {
    for (int i = 0; i < layerAnimate.size(); i++) {
      //layerAnimate.get(i).display();
      preview.display(layerAnimate.get(i));
    }
  }
  if (render == true) {
    gif.renderLoop();
  }
  if (renderKeyFrames == true) {
    gif.renderKeyFrames();
  }

  if (playback == true) {
    blendMode(BLEND);
    gif.playback(gif.fTemp);
    timer(millis());
  }
}


void timer(float ms) {
  if (ms > (gif.renderStart + delay)) {
    next = true;
  }
  if (next == true) {
    delay += 16;
    gif.fTemp+=1;
    if (gif.fTemp == gif.aniTotalFrames) {
      playback = false;
      gif.fTemp = 0;
    }
    next = false;
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
  }
  if (key == 'q') {
    gui.cp5.get(Matrix.class, "Matrix").stop();
    if (play == true) {
      gui.cp5.get(Matrix.class, "Matrix").play();
    }
  }
}