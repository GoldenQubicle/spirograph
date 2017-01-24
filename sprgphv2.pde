/*
 TODO
 - add callbacks to easing dropdown to bring to front, along with add/sub
 - be able to save the result of interacting ani to layerstate, grab the value from layer, write to cp5 and save json
 - have last first & layerstate sync 
 - have the option to load a complete layerstate on a trigger, so to switch between settings while retaining the same visual design
       come to think of this, could put this on 1st row of matrix, and ALWAYS set 1st cell, so that it acts as reset on loop?
       however, think that's gonne be tricky with regards to timing ani, i.e. first need to load the json into layer, only THEN ani can acces layer
 - new controller property object for easing styles, because now when I switch layerstates it loads easing from those
     i.e. probably need to have 1 json for the matrix / ani easing which serves as script of sorts 
 
 low prio
 cast toggle mode per individual gear / gear connector
 rework density with radiobutton for value ranges 
 
 */
 
import controlP5.*;
import dawesometoolkit.*;
import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;
//import gifAnimation.*;

//GifMaker gifExport;
Layer layer_1;
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
  gif = new Animation();
  play = false;
  Ani.init(this);
  Ani.noAutostart();
  BG = 128;  
  layers = new ArrayList();
  layer_1 = new Layer();
  layers.add(layer_1);
  ds = new DawesomeToolkit(this);
  ds.enableLazySave('i', ".png");
  gui = new GUI(this);

  //gifExport = new GifMaker(this, "export.gif");
}

void draw() {
  background(BG);
  //println(frameRate);

  for (int i = 0; i < layers.size(); i++) {
    layers.get(i).display();
  }

  gui.BG(BG);  
  gui.ColorFillStroke(); // temporary disabled because of intermittent NullPointers - still. .. aargghhhh >|
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