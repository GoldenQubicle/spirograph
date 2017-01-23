/*
 BUGS
 phewww. .. right, finally it pretty much is getting along just fine, though there a number of well weird bugs
 notably, half the time the ani tab seemingly just doesnt load - which is strange because everything happens in setup
 so.. probably it could be related to the toggle instead?
  - gear3xy addition doesnt quite work, probably because gif.Variables is one too many
  - AniEnd actually needs to be -1 somewhere, i.e. loads from one trigger ahead, also one trigger itself requires additional click, i.e. initial value is 0
 
 TODO
 - add callbacks to easing dropdown to bring to front, along with add/sub
 - add sub button, obviously
 - be able to save the result of interacting ani to layerstate, grab the value from layer, write to cp5 and save json
 - retain easing settings upon looping
 - have last first & layerstate sync 
 - have the option to load a complete layerstate on a trigger, so to switch between settings while retaining the same visual design
 
 TO CONSIDER
 actually reintroduce trigger class, i.e. 
   animation pulls in xy array from ani.get
   based on this array, pull in AniEnd
   calculate duration
   send x, y, end & duration to trigger class, with if statements in constructor to arrive at proper configuration
   trigger object has .ani() and .update() function
   the main thing here is this will allow to call .pause/.play on the trigger objects, thus potentially allowing for frame-by-frame rendering
 
 
 low prio
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
  gui.ColorFillStroke(); // temporary disabled because of intermittent NullPointers - still. .. aargghhhh >|
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