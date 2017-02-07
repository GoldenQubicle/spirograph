/* //<>//
so yeah, not sure where this project is going. Like, I would ideally like to have a 3d version yes, and a custom renderer which writes out
elaborate animations at 60fps. . thats not what I meant. 
What I mean is, not sure what exaclty the next thing I should be working on is gonna be
like, being able to write/write animations would be pretty awesome, however, thats gonna require some sort of refactoring
both in terms of layerstate treatment and gui
moreover, 3d mode would be pretty awesome as well, yes, though yet again will require some work in terms of gui
SO
maybe I should abstract gui, e.g. slider2d provides 2d array of values within a certain range, i.e. its not bound to any specific object
in yet another words, perhaps the actual controls need become methods of layer objects, and which specific visual element they affect 
is determined by the layer mode - which can be spirograph, lines, dots, 3d, whatever
 
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
int Mode;
void settings() {
  size(640, 640, P3D);
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
  //blendMode(SCREEN);
  //gifExport = new GifMaker(this, "export.gif");
  cam = new PeasyCam(this, 100);
  cam = new PeasyCam(this, 100);
  cam.setFreeRotationMode();
}

void draw() {
  background(BG);
  //println(frameRate);

  if (Mode == 1 || Mode == 2) {
    for (int i = 0; i < layers.size(); i++) {
      layers.get(i).display();
    }
  } else {
    layer3d_1.display();
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