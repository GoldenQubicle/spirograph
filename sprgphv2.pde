/* //<>//
factor the core funtionality out to gear class

  i.e. cos(Theta/gear1.Ratio())*gear1.RX
  
so a function which returns x,y,z values which are either cos / sin / tan

 
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
int gifWidth = 512;
int gifHeight = 512;

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
  //gui.ColorFillStroke(); // intermittent NullPointers - still. .. aargghhhh >|
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