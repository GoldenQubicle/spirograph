/* //<>//
add a 'reset to middle' button to gears
add a 'lock radii' button to gears
make the rotation of gears slider into actual control over said rotation, rather than its speed

maybe move additional z controls over to beneath the existing cos/sin/tan

- also wtf does the rotation sometimes just stop?!


add layer support
density toggle / reset between 2d&3d

start on custom save & load
 
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