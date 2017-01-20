/*
 phewww. .. right, finally it pretty much is getting along just fine, though there a number of well weird bugs
 notably, half the time the ani tab seemingly just doesnt load - which is strange because everything happens in setup
 so.. probably it could be related to the toggle instead?
 
 also, gear3xy addition doesnt quite work, probably because gif.Variables is one too many
 
 AND, the AniEnd actually needs to be -1 somewhere, i.e. loads from one trigger ahead
 
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
  gif = new Animation();
  play = false;
  Ani.init(this);
  //Ani.noAutostart();
  BG = 128;  
  layers = new ArrayList();
  layer_1 = new Layer();
  layers.add(layer_1);
  ds = new DawesomeToolkit(this);
  ds.enableLazySave('i', ".png");
  gui = new GUI(this);

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
      //gui.cp5.get(Matrix.class, "Matrix").trigger(0);
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