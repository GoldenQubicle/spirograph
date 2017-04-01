/* //<>//
okay there is some really funky bug in the way intervals are handled 
 
 why in the name of jesus titty fucking christ doesnt it animate in 3d?!
 
 aaaand theres a weird bug when toggling the gear trig completely off
 
 honestly . . I should refactor . . 
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
  //Ani.setDefaultTimeMode(Ani.FRAMES);
  Ani.setDefaultTimeMode(Ani.SECONDS);
  gif = new Animation();  
  gui = new GUI(this);
  controller = new Controller();
  cBackground = color(128, 128, 128);
  play = false;
  update = false;
  spheres3d = false;
  render = false;
  //gifExport = new GifMaker(this, "export.gif");
}

void draw() {
  background(cBackground);   
  //println(frameRate);
  if (update == true && Width != 512 || Height != 512) { 
    surface.setSize(Width, Height);
    translate(Width/2, Height/2);
  }

  if (play == false) {
    for (int i = 0; i < layerActive.size(); i++) {
      layerActive.get(i).display();
    }
  }
  if (play == true) { //<>//
    for (int i = 0; i < layerAnimate.size(); i++) {
      layerAnimate.get(i).display();
    }
  }

  if (render == true) {
    gif.renderLoop();
  }
}

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
    //gui.cp5.get(Toggle.class, "Play/Pause").setState(play);
  }
  if (key == 'q') {
    gui.cp5.get(Matrix.class, "Matrix").stop();
    if (play == true) {
      gui.cp5.get(Matrix.class, "Matrix").play();
    }
  }
}