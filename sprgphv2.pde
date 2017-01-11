/*
so lets seee. . 
however convoluted, it seems like reading/writing JSON files to act as layerstates is working
HOWEVER
atm if I continue in current structure Id end up with 4x the more-or-less the same code for loading the JSON values, namely in
  - gif setLayerState
  - gif LayerState
  - gui keyPressed
  - trigger value
MOREOVER
Id also want the controls to update between layerstates, so Id have to made another function similar to switchlayers, which would be another duplicate



    
 todo
 cast toggle mode per individual gear / gear connector
 
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
int trigger;
boolean play;


void settings() {
  size(512, 512, P2D);
  smooth(8);
}

void setup() {

  play = false;
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
  ds.enableLazySave('i',".png");
  gui = new GUI(this);
  gif = new Animation();
  //gifExport = new GifMaker(this, "export.gif");
  trigger = 0;
}

void draw() {
  background(BG);
  //println(frameRate);


  for (int i = 0; i < layers.size(); i++) {
    layers.get(i).display();
  }

  gui.BG(BG);  
  //gui.ColorFillStroke(); // temporary disabled because of intermittent NullPointers - still. .. aargghhhh >|
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
    gif.TriggerArray();

    gui.cp5.get(Matrix.class, "Matrix").stop();
    if (play == true) {
      gui.cp5.get(Matrix.class, "Matrix").play();
    }
  }
}