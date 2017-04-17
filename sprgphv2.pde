import peasy.*; //<>//
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
Layer layer_1;
ArrayList<Layer> layerActive =  new ArrayList();
ArrayList<Layer> layerKeyFrames = new ArrayList();
ArrayList<Layer> layerAnimate =  new ArrayList();
boolean play, update, render, renderKeyFrames, playback, next;
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
      preview.display(layerActive.get(i));
    }
  }
  if (play == true  && playback == false) {
    for (int i = 0; i < layerAnimate.size(); i++) {
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
    if (gif.fTemp == gif.aniTotalFrames-1) {
      playback = false;
      gif.fTemp = 0;
    }
    next = false;
  }
}