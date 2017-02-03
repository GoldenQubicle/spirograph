/* //<>//
BIG IDEA: TRY 3D!
 so yeah, deffo gonna do this =) 
 current thinking
 add z dimension to gear
 add z calculation to formulas
 since theta is based on circumference, gear0.C needs to be replaced with surface area sphere
 plot the outcome to translate
 
 also, prolly want to make a new class for this . .
 
 quick braindump with regard to myriad of fixes for 2d
 basically need to tackle it from multiple layer, because each layer will need 1) layerstates AND 2) it's own ani/easing settings
 i.e. all data need to be held per layer, and probably want to move functions for it into animation class
 
 ROADMAP GOING FORWARD 
 - ani easing / matrix tab as seperate controller property object
 - multiple layer support!
 - also, add blendmodes to layers?
 - full control implementation
 - save/load above & layerstates into one single JSON file
 - start renderer seperate from timing matrix
 
 TODO
 - sort saving colors
 adding color picker to layer properties result in nullpointer on load, even though it's saved in json
 however, doesnt matter because I want to save both fill & stroke color, i.e. two variables instead of one     
 - add callbacks to easing dropdown to bring to front, along with add/sub
 - be able to save the result of interacting ani to layerstate, grab the value from layer, write to cp5 and save json
 - textfields to enter gear radii
 - toggle to save forward for individual layer parameter
 - individual matrix trigger, ie .trigger(N), somekind of dial? i.e. selected trigger fires on spacebar 
 
 low prio
 cast toggle mode per individual gear / gear connector
 rework density with radiobutton for value ranges 
 
 */
import peasy.*;
import controlP5.*;
import dawesometoolkit.*;
import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;
//import gifAnimation.*;

//GifMaker gifExport;
PeasyCam cam;
Layer layer_1;
Layer3D layer3d_1;
ArrayList<Layer> layers;
//ArrayList<Layer3D> layers;
DawesomeToolkit ds;
color BG;
GUI gui;
Animation gif;
boolean play;
String JSON = "C:\\Users\\Erik\\Documents\\Processing\\sprgphv2\\data\\LayerState";

void settings() {
  size(512, 512, P3D);
  smooth(8);
}

void setup() {
  gif = new Animation();
  play = false;
  Ani.init(this);
  Ani.noAutostart();
  Ani.setDefaultTimeMode(Ani.SECONDS);
  BG = 128;  
  layers = new ArrayList();
  layer_1 = new Layer();
  layer3d_1 = new Layer3D();
  layers.add(layer_1);
  //layers.add(layer3d_1);
  ds = new DawesomeToolkit(this);
  ds.enableLazySave('i', ".png");
  gui = new GUI(this);
  blendMode(SCREEN);
  //gifExport = new GifMaker(this, "export.gif");
  //cam = new PeasyCam(this, 100);
  //cam = new PeasyCam(this, 100);
  //cam.setFreeRotationMode();
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