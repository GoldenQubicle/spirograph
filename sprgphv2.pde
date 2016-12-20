/*
 CURRENT THINKIN with regard to animation 
 OKAY - unless I find a way to get indiviual layers to act as keyframes, as initially proposed, i.e. pass theX of matrix between the two windows, thats not happening 
 make a trigger object class, which holds an id, in addition to variable values for ani, the ani themselves and which layer its associated with
 then in the animation class, set up for loop which constructs the triggers based on keyframes
 the big issue is, how to handle tweaking, i.e. store and load settings of triggers
 
     strategy 
       - cp5 snapshots, possible for layerstates?
       - if yes, cp5 properties save/load as json - including matrix et al
       - and custom json for triggerstates (composed of trigger objects)
 
 trigger object
  : layer.id
  : trigger.state
  : array numeric values for layer parameters (possibly read from cp5 snapshots?)
  : array ani objects for layer parameters ! gui gives acces to these
          
        
       
 CONSIDERATIONS 
 - finer controls, either by textfield input, or make a 2-staged control (for dotdensity, i.e. toggle ranges 0-1000, than slider per range). 
 - if its becoming laggy with multiple taxing layers, maybe see if layer can be drawn once, than stored as PImage / pixel array or somehting
 - for possible release, make a welcome screen where to choose mode (drawing or animation) and set size (and length & #triggers if applicable)
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


void settings() {
  size(512, 512, P2D);
  smooth(8);
}

void setup() {
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
  ds.enableLazySave();
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
  gui.ColorFillStroke();
}




void keyPressed() {
  if (key=='p') {
    if (gui.cp5.get(Matrix.class, "Matrix").isPlaying()) {
      gui.cp5.get(Matrix.class, "Matrix").pause();
    } else {
      gui.cp5.get(Matrix.class, "Matrix").play();
    }
  }
}