/*
CURRENT CONCERNS
hmmm yeah
  actually having multiple triggers per parameters is bit of an issue, let alone how to handle two triggers back-to-back (so to speak)
  or how to handle change in timing of particular triggers, while still having the correct ani style
  so in other words, there has to be somekind of data structure which keeps track of triggers
  the boolean lock array once again comes to mind, however, thats not quite sufficient
  the problem is:
  for each trigger, only needs to have 1 menu associated with it
  while still being able to change the start/stop respectivly
  
so yeah, probably want to decouple dropdown from trigger
instead what if each parameter has 1 dropdown menu associated with it by default 
and then, in the easing tab, also have a button to add additional dropdown / triggers to the parameter timeline
still.. how do I differentiate between triggers, i.e. how to tell if two adjecent matrix cells are 1 trigger, or two?

 ouch, now its a real mess aaaaaaaand now only one ani plays at a time. . this is just great :/
  update method is erm.. wonky
 
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
    gif.TriggerArray();

    gui.cp5.get(Matrix.class, "Matrix").stop();
    if (play == true) {
      gui.cp5.get(Matrix.class, "Matrix").play();
    }
  }
}