class GUI extends PApplet {    //<>//

  int id, set, bg, trigger;
  float duration;
  boolean layerlock;
  PApplet parent;
  ControlP5 cp5;
  Slider2D G0, G1, G2, G3;
  Slider P1, P2, P3, LX, LY, SW, D, G1c, G2c, G3c;
  Toggle Fill, Stroke, Lines, Dots, CS, Cast, Pause;
  ColorPicker cp;
  ScrollableList LayerList, Easing;
  Button New, Copy;
  Matrix Ani;
  Ani Trigger;
  public GUI(PApplet theApplet) {
    super();
    parent = theApplet;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(512, 768);
  } 

  public void setup() {
    id = 0;
    set = 0;
    cp5 = new ControlP5(this);
    // color
    cp5.addColorWheel("BackGround").setPosition(302, 10).setValue(128).plugTo(this, "BG");
    cp = cp5.addColorPicker("ColorPicker").setPosition(10, 10).setColorValue(layers.get(id).Fill);
    CS = cp5.addToggle("Switch").setPosition(270, 10).setSize(25, 25).setState(false);
    // gear0
    G0 = cp5.addSlider2D("Radius Gear 0").setMinMax(-512, -512, 512, 512).setPosition(10, 90).setCaptionLabel("Radius Gear 0").plugTo(this, "Controls").setValue(layers.get(id).gear0.RX, layers.get(id).gear0.RY);
    //// gear1
    G1 = cp5.addSlider2D("Radius Gear1").setMinMax(-150, -150, 150, 150).setPosition(160, 90).setCaptionLabel("Radius Gear 1").plugTo(this, "Controls").setValue(layers.get(id).gear1.RX, layers.get(id).gear1.RY);
    P1 = cp5.addSlider("Petals_1").setRange(0, 50).setPosition(160, 80).setCaptionLabel("Petals").plugTo(this, "Controls").setValue(layers.get(id).gear1.P);
    // gear2
    G2 = cp5.addSlider2D("Radius Gear2").setMinMax(-150, -150, 150, 150).setPosition(10, 230).setCaptionLabel("Radius Gear 2").plugTo(this, "Controls").setValue(layers.get(id).gear2.RX, layers.get(id).gear2.RY);
    P2 = cp5.addSlider("Petals_2").setRange(0, 100).setPosition(10, 220).setCaptionLabel("Petals").plugTo(this, "Controls").setValue(layers.get(id).gear2.P);
    //// gear3
    G3 = cp5.addSlider2D("Radius Gear3").setMinMax(-150, -150, 150, 150).setPosition(160, 230).setCaptionLabel("Radius Gear 3").plugTo(this, "Controls").setValue(layers.get(id).gear3.RX, layers.get(id).gear3.RY);
    P3 = cp5.addSlider("Petals_3").setRange(0, 200).setPosition(160, 220).setCaptionLabel("Petals").plugTo(this, "Controls").setValue(layers.get(id).gear3.P);
    // fill stroke width for all modes
    Fill = cp5.addToggle("Fill").setPosition(10, 370).setSize(45, 15).setMode(ControlP5.SWITCH).setState(true).plugTo(this, "Controls");
    Stroke = cp5.addToggle("Stroke").setPosition(65, 370).setSize(45, 15).setMode(ControlP5.SWITCH).setState(false).plugTo(this, "Controls");
    LX = cp5.addSlider("LineX").setPosition(10, 350).setRange(0, 250).plugTo(this, "Controls").setValue(layers.get(id).LX);
    LY = cp5.addSlider("LineY").setPosition(160, 350).setRange(0, 250).plugTo(this, "Controls").setValue(layers.get(id).LY);
    SW = cp5.addSlider("StrokeWeight").setPosition(310, 330).setRange(0, 250).setValue(2).plugTo(this, "Controls").setValue(layers.get(id).Sw);    
    Lines = cp5.addToggle("Lines").setPosition(310, 290).setSize(20, 20).setState(false).plugTo(this, "Controls");  
    Dots = cp5.addToggle("Dots").setPosition(340, 290).setSize(20, 20).setState(false).plugTo(this, "Controls");
    Cast = cp5.addToggle("Cast").setPosition(370, 290).setSize(20, 20).setState(false).plugTo(this, "Controls");
    // line density for spiro mode
    D = cp5.addSlider("Density").setPosition(10, 490).setSize(450, 15).setRange(0, 100000).plugTo(this, "Controls").setValue(layers.get(id).PlotDots);
    // gear connectors for line & dot mode
    G1c = cp5.addSlider("Connect G1").setPosition(310, 230).setRange(0, 100).plugTo(this, "Controls");
    G2c = cp5.addSlider("Connect G2").setPosition(310, 250).setRange(0, 100).plugTo(this, "Controls");
    G3c = cp5.addSlider("Connect G3").setPosition(310, 270).setRange(0, 100).plugTo(this, "Controls");
    // layers control
    LayerList = cp5.addScrollableList("SwitchLayers").setPosition(310, 390).setType(ScrollableList.DROPDOWN).setCaptionLabel("Layers");
    for (int i = 0; i<layers.size(); i++) {
      LayerList.addItem("Layer" + (i+1), layers.get(i));
    }
    New = cp5.addButton("New Layer").setPosition(310, 350).setSize(60, 15);
    Copy = cp5.addButton("Copy Layer").setPosition(380, 350).setSize(60, 15);
    // animation matrix
    Pause = cp5.addToggle("Play/Pause").setPosition(10, 520).setSize(30, 15).setState(play);
    Ani = cp5.addMatrix("Matrix").setPosition(10, 550).setSize(400, 100).setGap(10, 20).setMode(ControlP5.MULTIPLES)
      .setInterval(gif.Interval).setGrid(gif.Triggers, gif.Variables).stop();// .set(0, 0, true);
    //Easing = cp5.addScrollableList("Easing Styles").setPosition(50, 580).setType(ScrollableList.DROPDOWN).addItem("test 1", gif.test1).addItem("test 2", gif.test2);
  }

  void draw() {
    background(190);
  }


  void Matrix(int theX, int theY) {

    // for each theX, need to check to left and right
    // whether neighbors are active
    // the number of consequetive active cells need to funneled to ani
    // so first of all need to calculate number of cells to left & right of current theX
    // than feed those numbers into for loop which checks

    // if and only if there's at least one! active cell in the first column
    // this will perform check on the entire matrix
    // and could thus be used to update the triggers

    // checks which cells in matrix are activated
    for (int x = 0; x < gif.Triggers; x++) {
      for (int y = 0; y < gif.Variables; y++) {
        println(Ani.get(x, y), x, y);
      }
    }

    if (theX == 0) {
      //println("hard start");
    }
    //if (theX == gif.Triggers-1){
    // println("hard stop"); 
    //}
    if (theX > 0) {
      int forward = (gif.Triggers-1) - theX;
      if (forward == 0) {
        //println("hard stop");
      }
      for (int i = 0; i<=forward; i++) {
        if (Ani.get((theX + i), theY) == true) {
          duration = i * gif.ms; 
          //println(theX +  i + " are active");
        }
      }

      int backward = (gif.Triggers-1) - forward;
      //println(backward);
    }



    //if (Ani.get((theX+1), theY) == true) {
    //  //println(gif.Triggers - theX); 
    //  } else {
    //    println("false " + (theX+1));
    //  };


    // at the end here I want to pass int start,int end & int theY to gif class to construct trigger 
      gif.triggerState(theX, theY, duration);
    //  //gif.layerState(theX);
  }



  void controlEvent(CallbackEvent theEvent) {
    if (theEvent.getController().equals(Ani)) {
      //println((Ani.get(theX,theY)));
    }


    if (theEvent.getController().equals(Copy)) {
      if (theEvent.getAction() == ControlP5.ACTION_PRESS) {
        Layer New = new Layer();
        New.gear0.RX = layers.get(id).gear0.RX;
        New.gear0.RY = layers.get(id).gear0.RY;
        New.gear1.RX = layers.get(id).gear1.RX;
        New.gear1.RY = layers.get(id).gear1.RY;
        New.gear2.RX = layers.get(id).gear2.RX;
        New.gear2.RY = layers.get(id).gear2.RY;
        New.gear3.RX = layers.get(id).gear3.RX;
        New.gear3.RY = layers.get(id).gear3.RY;
        New.gear1.P = layers.get(id).gear1.P;
        New.gear2.P = layers.get(id).gear2.P;
        New.gear3.P = layers.get(id).gear3.P;
        New.LX = layers.get(id).LX;
        New.LY = layers.get(id).LY;
        New.Fill = layers.get(id).Fill;
        New.Stroke = layers.get(id).Stroke;
        New.lines = layers.get(id).lines;
        New.dots = layers.get(id).dots;
        New.PlotDots = layers.get(id).PlotDots;
        New.gear1.Connect = layers.get(id).gear1.Connect;
        New.gear2.Connect = layers.get(id).gear2.Connect;
        New.gear3.Connect = layers.get(id).gear3.Connect;
        layers.add(New);
        LayerList.addItem("Copy " + (id+1), New);
      }
    }
    if (theEvent.getController().equals(New)) {
      if (theEvent.getAction() == ControlP5.ACTION_PRESS) {
        Layer New = new Layer();
        layers.add(New);
        LayerList.addItem("Layer " + layers.size(), New);
      }
    }
    if (theEvent.getController().equals(CS)) {
      if (theEvent.getAction() == ControlP5.ACTION_PRESS) {
        if (CS.getState() == false) {
          cp.setColorValue(layers.get(id).Fill);
        }          
        if (CS.getState() == true) {
          cp.setColorValue(layers.get(id).Stroke);
        }
      }
    }
  }

  void ColorFillStroke() {
    if (layerlock == false) {
      if (CS.getState() == false) {
        layers.get(id).Fill =  cp.getColorValue() ;
      }
      if (CS.getState() == true) {
        layers.get(id).Stroke =  cp.getColorValue();
      }
    }
  }

  void SwitchLayers() {
    if (id != int(LayerList.getValue())) {
      layerlock = true;
      set = int(LayerList.getValue());
      G0.remove();
      G1.remove();
      G2.remove();
      G3.remove();
      G0 = cp5.addSlider2D("Radius Gear0").setMinMax(-512, -512, 512, 512).setPosition(10, 90).setCaptionLabel("Radius Gear 0").plugTo(this, "Controls").setValue(layers.get(set).gear0.RX, layers.get(set).gear0.RY);
      G1 = cp5.addSlider2D("Radius Gear1").setMinMax(-150, -150, 150, 150).setPosition(160, 90).setCaptionLabel("Radius Gear 1").plugTo(this, "Controls").setValue(layers.get(set).gear1.RX, layers.get(set).gear1.RY);
      G2 = cp5.addSlider2D("Radius Gear2").setMinMax(-150, -150, 150, 150).setPosition(10, 230).setCaptionLabel("Radius Gear 2").plugTo(this, "Controls").setValue(layers.get(set).gear2.RX, layers.get(set).gear2.RY);
      G3 = cp5.addSlider2D("Radius Gear3").setMinMax(-150, -150, 150, 150).setPosition(160, 230).setCaptionLabel("Radius Gear 3").plugTo(this, "Controls").setValue(layers.get(set).gear3.RX, layers.get(set).gear3.RY);
      P1.setValue(layers.get(set).gear1.P);
      P2.setValue(layers.get(set).gear2.P);
      P3.setValue(layers.get(set).gear3.P);
      LX.setValue(layers.get(set).LX);
      LY.setValue(layers.get(set).LY);
      Fill.setState(layers.get(set).fill);
      Stroke.setState(layers.get(set).stroke);
      SW.setValue(layers.get(set).Sw);
      Lines.setState(layers.get(set).lines);
      Dots.setState(layers.get(set).dots);
      D.setValue(layers.get(set).PlotDots);
      G1c.setValue(layers.get(set).gear1.Connect);
      G2c.setValue(layers.get(set).gear2.Connect);
      G3c.setValue(layers.get(set).gear3.Connect);
      if (CS.getState() == false) {
        cp.setColorValue(layers.get(set).Fill);
      }
      if (CS.getState() == true) {
        cp.setColorValue(layers.get(set).Stroke);
      }
      layerlock = false;
      id = int(LayerList.getValue());
    }
  }

  void Controls() {
    if (layerlock == false) {
      layers.get(id).gear0.RX = G0.getArrayValue(0);
      layers.get(id).gear0.RY = G0.getArrayValue(1);
      layers.get(id).gear1.RX = G1.getArrayValue(0);
      layers.get(id).gear1.RY = G1.getArrayValue(1);
      layers.get(id).gear2.RX = G2.getArrayValue(0);
      layers.get(id).gear2.RY = G2.getArrayValue(1);
      layers.get(id).gear3.RX = G3.getArrayValue(0);
      layers.get(id).gear3.RY = G3.getArrayValue(1);
      if (Cast.getState() == false) {
        layers.get(id).gear1.P = int(P1.getValue()); 
        layers.get(id).gear2.P = int(P2.getValue());
        layers.get(id).gear3.P = int(P3.getValue());
      }
      //if (Cast.getState() == true) {
      //  layers.get(id).gear1.P = P1.getValue(); 
      //  layers.get(id).gear2.P = P2.getValue();
      //  layers.get(id).gear3.P = P3.getValue();
      //}
      layers.get(id).LX = LX.getValue();
      layers.get(id).LY = LY.getValue();
      layers.get(id).fill = Fill.getState();
      layers.get(id).stroke = Stroke.getState();
      layers.get(id).Sw = SW.getValue();
      layers.get(id).lines = Lines.getState();
      layers.get(id).dots = Dots.getState();
      layers.get(id).PlotDots = D.getValue();
      if (Cast.getState() == false) {
        layers.get(id).gear1.Connect = int(G1c.getValue());
        layers.get(id).gear2.Connect = int(G2c.getValue());
        layers.get(id).gear3.Connect = int(G3c.getValue());
      }
      if (Cast.getState() == true) {
        layers.get(id).gear1.Connect = (G1c.getValue());
        layers.get(id).gear2.Connect = (G2c.getValue());
        layers.get(id).gear3.Connect = (G3c.getValue());
      }
    }
  }

  void BG(color bg) {
    BG = bg;
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
    if (key == 'r') {
      gui.cp5.get(Matrix.class, "Matrix").stop();
      if (play == true) {
        gui.cp5.get(Matrix.class, "Matrix").play();
      }
    }
  }
}