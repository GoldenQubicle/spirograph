/* //<>//

 hmmm. . . petals is read as float in trigger atm
 also animation z axis not working. .  
 
 load/safe animations as json
 - make color work, i.e. add color to json layerstates
 - make multiple layers work, i.e. layerstate json AND associated ani matrix per layer in one json
 - add camera per animation json
 
 
 make function which grabs camera position & rotations and than sets it as render point for 3d so I can play around with material / lighting for nice image =)
 also, can I ani between different camera positions?!
 funtion which calculated the different layerstates inbetween ani, i.e. LS1 = 0, LS3 = 60 than LS2 = 30 automatically
 
 bit of braindump with regard to saving
 first off, I want one single json, however, can cp5 load sections from within the serve as layerstate - OK so it cannot becauase it takes a string as filename
 
 so, need to approach this the other way around, i.e. design structure for json, and make load/save functions in animation, to be placed inside callbacks
 aaand come to think of it, the loading a layerstate is pretty much the same function as switching layers themselves
 so might write a controller class function which handles this (and saving) rather than having it split across gui and animation 
 soooo wouldnt it then make more sense to store the laterstate AS layer objects as well, i.e. inside an array and only use json for actual saving as 'script'
 and then saving a layertstate would be as simple as writing the actual layer into the layerstate array
 
 so all things considered, maybe first make a front end menu where I can set the length and #layerstates and compile an aplha, then refactor everything
 
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
ArrayList<Layer> layers;
ArrayList<Layer> LayerStateArray;
DawesomeToolkit ds;
color BG;
GUI gui;
Animation gif;
boolean play, update;
String JSON = "C:\\Users\\Erik\\Documents\\Processing\\sprgphv2\\data\\LayerState";
int gifWidth = 400;
int gifHeight = 400;

void settings() {
  size(gifWidth, gifHeight, P3D);
  smooth(8);
}

void setup() {
  surface.setResizable(true);
  surface.setTitle("Preview");
  gif = new Animation();
  play = false;
  Ani.init(this);
  Ani.noAutostart();
  Ani.setDefaultTimeMode(Ani.SECONDS);
  BG = 120;
  layers = new ArrayList();
  layer_1 = new Layer();
  layers.add(layer_1);
  LayerStateArray = new ArrayList();
  for (int i = 0; i < gif.LayerStates; i++) {
    LayerStateArray.add(layers.get(0));
  }
  ds = new DawesomeToolkit(this);
  ds.enableLazySave('i', ".png");
  gui = new GUI(this);
  blendMode(DIFFERENCE);
  //gifExport = new GifMaker(this, "export.gif");
  cam = new PeasyCam(this, 300);
  cam.setFreeRotationMode();
}

void draw() {
  background(BG);
  surface.setSize(gifWidth,gifHeight);
  if(update == true){translate(gifWidth/2,gifHeight/2);}
  
  for (int i = 0; i < layers.size(); i++) {
    layers.get(i).display();
  }

  gui.BG(BG);  
  gui.ColorFillStroke(); // intermittent NullPointers - still. .. aargghhhh >|
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