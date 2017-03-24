/* //<>//
  
  controller.switchKeyFrame(int layer, int setKeyFrame, int getKeyFrame){
    saveKeyFrame(setKeyFrame) 
    // write settings of active layer into JSON layerKeyFrame array
    // retrieve settings from JSON layerKeyFrame array and write into active layer
    // update the layerGUI
  }
  
  switchLayer.switchLayer(int keyFrame, int setLayer, int getLayer){
    
  }
  
  add watermark / logo to display?!
  
  need to work out render menu / program logic  
  1) want to call renderLoop to interpolate keyFrames
  2) want to render into PImage array and playback over it
  3) want to actually save frames out as png
  
   loading bug with ani easing gui not updated properly 
   actually seems more than just gui issue, not being able to save over when reloaded - for some reason

  
  hrmm. . possible performance improvement by ditching layerKeyFrames in favor on read/write directly from json
  about performance, wouldnt it be possible the playback is so slow now because its using the frame time mode?
  i.e. its now being forced to display all frames, and hence no longer in sync with actual timing - hrm nope, seems to just be slow =)
  so what if I switch back to default timing, since the renderer uses the seek function anyway, the notion of frames is bit obsolete
  and possibly implement actual auto save on timer 
  
  
  use the aniSeek & renderloop to update interpolated keyFrames
  
  have a 'frame 0', which is display when none of the keyframes are toggled, and will act as the layer to act on for ani starts on 0
  so the number of layers is keyFrames + 1
  
 add tickmarks to petal sliders 
 
 Perhaps consider splitting aniMatrix into shape (i.e. gears) and aesthetic (i.e. color, line, etc) collapsable menus, e.g. accordion  
 carefully trace layerlock, somewhere its not being set to false it seems
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
ArrayList<Layer> layerActive =  new ArrayList();
//ArrayList<Layer> layerKeyFrames = new ArrayList();
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
    //Ani.setDefaultTimeMode(Ani.SECONDS);
  gui = new GUI(this);
  controller = new Controller();
    gif = new Animation();  

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
  if (play == true) {
    for (int i = 0; i < layerAnimate.size(); i++) {
      layerAnimate.get(i).display();
    }
  }
  
  if (render == true) {
    gif.renderLoop();
  }
  //println(render);
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