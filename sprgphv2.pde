/* //<>//
factor the core funtionality out to gear class
 
 i.e. cos(Theta/gear1.Ratio())*gear1.RX
 
 so a function which returns x,y,z values which are either cos / sin / tan
 
 
 redesign gui - 3 colorwheels on top (left is background, middle stroke, right fill)
 strokeweight, lineX/Y & fill stroke toggle together, top right, next to colorwheels
 4 gears below (0,1,2,3 left to right obviously)
 density settings rework into radio button & range
 new gif settings in dropdown group  
 
 */


import peasy.*;
import controlP5.*;
import dawesometoolkit.*;
import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;
//import gifAnimation.*;

//GifMaker gifExport;
PeasyCam cam;
DawesomeToolkit ds;
GUI gui;
Animation gif;
Layer layer_1;
ArrayList<Layer> layers;
String JSON = "C:\\Users\\Erik\\Documents\\Processing\\sprgphv2\\data\\LayerState";
boolean play, update;
int Width = 512;
int Height = 512;
color BG;

void settings() {
  size(Width, Height, P3D);
  smooth(8);
}

void setup() {
  surface.setResizable(true);
  surface.setTitle("Preview");
  cam = new PeasyCam(this, 512);
  cam.setFreeRotationMode();
  ds = new DawesomeToolkit(this);
  ds.enableLazySave('i', ".png");
  Ani.init(this);
  Ani.noAutostart();
  Ani.setDefaultTimeMode(Ani.FRAMES);
  gui = new GUI(this);
  gif = new Animation();
  layers = new ArrayList();
  layer_1 = new Layer();
  layers.add(layer_1);
  BG = 120;
  play = false;
  //blendMode(DIFFERENCE);
  //gifExport = new GifMaker(this, "export.gif");
  update = true;
}

void draw() {
  surface.setSize(Width, Height);
  background(BG);  

  //translate(Width/2, Height/2);
 

  for (int i = 0; i < layers.size(); i++) {
    layers.get(i).display();
  }


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