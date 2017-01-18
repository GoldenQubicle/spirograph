/*
take time aspect out of matrix, i.e. only serves to trigger
 move duration ani into easing style tab, makes more sense anyway
 
 yeah okay, ani tab is nicely set up, still. . first priority is really getting two ani back-to-back
 okay so per active matrix cell, make a group which contains length & style for ani
 NOPE
 what if instead ani dropdown menu on cell toggle, than add a + in ani tab to set the length
 i.e. default length of ani is 1 interval, when + is pressed it increases to the next layerstate
 visually this is represented by increasing width of dropdown menu
 this means than ani could potentially overlap in duration, which could be done by puttin them inside a parameter group?
 at any rate, also means each matrix cell has a dropdown menu associated with it, i.e. can be setup beforehand
 
 todo
 remap gear values!
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

  play = false;
  Ani.init(this);
  BG = 128;  
  layers = new ArrayList();
  layer_1 = new Layer();
  layers.add(layer_1);
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