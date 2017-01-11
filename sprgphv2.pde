/*
quick braindump
gear0 is default, i.e. present on matrix
beyond that, make variable selector, i.e. simply construct new matrix everytime variable is added or deleted

on play
  - save layerstates into json
  - construct trigger array
on pause/stop
  - clear trigger array

ALSO
 - first cell trigger doesnt work ~ welp this appears a bug with Matrix, even example sketch doesnt print 0 when stop/start is used
 - reset doesnt work when last cell active ~ this is a timing issue, i.e. ani is still accessing parameter when reset occurs quit and dirty solution is to substract x value from duration if cell = 7 or something like that
 - how to deselect buttonbar, i.e. is it actually usefull?
 - wouldnt it make more sense to use ani from? 
    

right, read/write from JSON files works
question now is, how to handle the layer states
basically, need a number of buttons to save different states into JSON files
than, write a function inside trigger class which figures out the different between 2 states
i.e. take initial value, take end value (based on how many intervals) and subtract

 
 
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