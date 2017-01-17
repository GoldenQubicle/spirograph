/*
take time aspect out of matrix, i.e. only serves to trigger
 move duration ani into easing style tab, makes more sense anyway
 
 yeah okay, ani tab is nicely set up, still. . first priority is really getting two ani back-to-back
 
 
 
 
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
boolean play;
String JSON = "C:\\Users\\Erik\\Documents\\Processing\\sprgphv2\\data\\LayerState";

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
  ds.enableLazySave('i', ".png");
  gui = new GUI(this);
  gif = new Animation();
  //gifExport = new GifMaker(this, "export.gif");
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
      gui.cp5.get(Matrix.class, "Matrix").stop();
      if (play == true) {
        gui.cp5.get(Matrix.class, "Matrix").play();
      }
    }
  }