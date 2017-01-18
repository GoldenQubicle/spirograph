class GUI extends PApplet {    //<>//
  int id, set, mWidth, mHeight;
  boolean layerlock;
  PApplet parent;
  ControlP5 cp5;
  Slider2D G0, G1, G2, G3;
  Slider P1, P2, P3, LX, LY, SW, D, G1c, G2c, G3c, Duration;
  Toggle Fill, Stroke, Lines, Dots, CS, Cast, Pause;
  ColorPicker cp;
  ColorWheel cw;
  ScrollableList LayerList, Easing;
  Button New, Copy, Save;
  Matrix Ani;
  ControllerProperties Layer;
  ButtonBar LayerState;
  Textlabel Label;
  String [] Labels = {"", "Gear 0 X", "Gear 0 Y", "Gear 1 Petals", "Gear 1 X", "Gear 1 Y", "Gear 2 Petals", "Gear 2 X", "Gear 2 Y", "Gear 3 Petals", "Gear 3 X", "Gear 3 Y"}; 

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
    cw = cp5.addColorWheel("BackGround").setPosition(302, 10).setValue(128).plugTo(this, "BG");
    cp5.getController("BackGround").moveTo("global");
    cp = cp5.addColorPicker("ColorPicker").setPosition(10, 10).setColorValue(layers.get(id).Fill);
    cp5.get(ColorPicker.class, "ColorPicker").moveTo("global");
    CS = cp5.addToggle("Switch").setPosition(270, 10).setSize(25, 25).setState(false);
    cp5.getController("Switch").moveTo("global");
    // gear0
    G0 = cp5.addSlider2D("Radius Gear 0").setMinMax(0, 0, 1024, 1024).setPosition(10, 90).setCaptionLabel("Radius Gear 0").plugTo(this, "Controls").setValue(layers.get(id).gear0.RX, layers.get(id).gear0.RY);
    cp5.getController("Radius Gear 0").moveTo("global");
    //// gear1
    G1 = cp5.addSlider2D("Radius Gear1").setMinMax(-150, -150, 150, 150).setPosition(160, 90).setCaptionLabel("Radius Gear 1").plugTo(this, "Controls").setValue(layers.get(id).gear1.RX, layers.get(id).gear1.RY);
    cp5.getController("Radius Gear1").moveTo("global");
    P1 = cp5.addSlider("Petals_1").setRange(0, 50).setPosition(160, 80).setCaptionLabel("Petals").plugTo(this, "Controls").setValue(layers.get(id).gear1.P);
    cp5.getController("Petals_1").moveTo("global");
    // gear2
    G2 = cp5.addSlider2D("Radius Gear2").setMinMax(-150, -150, 150, 150).setPosition(10, 230).setCaptionLabel("Radius Gear 2").plugTo(this, "Controls").setValue(layers.get(id).gear2.RX, layers.get(id).gear2.RY);
    cp5.getController("Radius Gear2").moveTo("global");
    P2 = cp5.addSlider("Petals_2").setRange(0, 100).setPosition(10, 220).setCaptionLabel("Petals").plugTo(this, "Controls").setValue(layers.get(id).gear2.P);
    cp5.getController("Petals_2").moveTo("global");
    //// gear3
    G3 = cp5.addSlider2D("Radius Gear3").setMinMax(-150, -150, 150, 150).setPosition(160, 230).setCaptionLabel("Radius Gear 3").plugTo(this, "Controls").setValue(layers.get(id).gear3.RX, layers.get(id).gear3.RY);
    cp5.getController("Radius Gear3").moveTo("global");
    P3 = cp5.addSlider("Petals_3").setRange(0, 200).setPosition(160, 220).setCaptionLabel("Petals").plugTo(this, "Controls").setValue(layers.get(id).gear3.P);
    cp5.getController("Petals_3").moveTo("global");
    // fill stroke width for all modes
    Fill = cp5.addToggle("Fill").setPosition(10, 370).setSize(45, 15).setMode(ControlP5.SWITCH).setState(true).plugTo(this, "Controls");
    cp5.getController("Fill").moveTo("global");
    Stroke = cp5.addToggle("Stroke").setPosition(65, 370).setSize(45, 15).setMode(ControlP5.SWITCH).setState(false).plugTo(this, "Controls");
    cp5.getController("Stroke").moveTo("global");
    LX = cp5.addSlider("LineX").setPosition(10, 350).setRange(0, 250).plugTo(this, "Controls").setValue(layers.get(id).LX);
    cp5.getController("LineX").moveTo("global");
    LY = cp5.addSlider("LineY").setPosition(160, 350).setRange(0, 250).plugTo(this, "Controls").setValue(layers.get(id).LY);
    cp5.getController("LineY").moveTo("global");
    SW = cp5.addSlider("StrokeWeight").setPosition(310, 330).setRange(0, 250).setValue(2).plugTo(this, "Controls").setValue(layers.get(id).Sw);
    cp5.getController("StrokeWeight").moveTo("global");
    Lines = cp5.addToggle("Lines").setPosition(310, 290).setSize(20, 20).setState(false).plugTo(this, "Controls");
    cp5.getController("Lines").moveTo("global");
    Dots = cp5.addToggle("Dots").setPosition(340, 290).setSize(20, 20).setState(false).plugTo(this, "Controls");
    cp5.getController("Dots").moveTo("global");
    Cast = cp5.addToggle("Cast").setPosition(370, 290).setSize(20, 20).setState(false).plugTo(this, "Controls");
    cp5.getController("Cast").moveTo("global");
    // line density for spiro mode ~ !!!! temporary disabled, need to be reworked with range buttons
    D = cp5.addSlider("Density").setPosition(10, 430).setSize(450, 15).setRange(0, 100000).plugTo(this, "Controls").setValue(layers.get(id).PlotDots);
    cp5.getController("Density").moveTo("global");
    // gear connectors for line & dot mode
    G1c = cp5.addSlider("Connect G1").setPosition(310, 230).setRange(0, 100).plugTo(this, "Controls");
    cp5.getController("Connect G1").moveTo("global");
    G2c = cp5.addSlider("Connect G2").setPosition(310, 250).setRange(0, 100).plugTo(this, "Controls");
    cp5.getController("Connect G2").moveTo("global");
    G3c = cp5.addSlider("Connect G3").setPosition(310, 270).setRange(0, 100).plugTo(this, "Controls");
    cp5.getController("Connect G3").moveTo("global");
    // layers control
    LayerList = cp5.addScrollableList("SwitchLayers").setPosition(310, 390).setType(ScrollableList.DROPDOWN).setCaptionLabel("Layers");
    for (int i = 0; i<layers.size(); i++) {
      LayerList.addItem("Layer" + (i+1), layers.get(i));
    }
    cp5.getController("SwitchLayers").moveTo("global");
    New = cp5.addButton("New Layer").setPosition(310, 350).setSize(60, 15);
    cp5.getController("New Layer").moveTo("global");
    Copy = cp5.addButton("Copy Layer").setPosition(380, 350).setSize(60, 15);
    cp5.getController("Copy Layer").moveTo("global");
    Pause = cp5.addToggle("Play/Pause").setPosition(10, 400).setSize(30, 15).setState(play);
    cp5.getController("Play/Pause").moveTo("global");
    Save = cp5.addButton("Save").setPosition(50, 400).setSize(60, 15);
    cp5.getController("Save").moveTo("global");

    // setup tabs for animation ui
    cp5.getTab("default").setCaptionLabel("Matrix");
    cp5.addTab("Ani Easing");
    cp5.getTab("Ani Easing").activateEvent(true);
    cp5.getWindow().setPositionOfTabs(10, 450);
    //button bar layerstates
    LayerState = cp5.addButtonBar("ls").setPosition(10, 475).setSize(400, 20);
    String [] button;
    button = new String[gif.LayerStates];
    for (int i = 0; i < gif.LayerStates; i++) {       
      button[i] = "LS" + (i+1);
    }
    LayerState.addItems(button);
    cp5.getController("ls").moveTo("default");
    // actual matrix
    mWidth = 400;
    mHeight = 240;
    Ani = cp5.addMatrix("Matrix").setPosition(10, 500).setSize(mWidth, mHeight).setGap(5, 5).setMode(ControlP5.MULTIPLES)
      .setInterval(gif.Interval).setGrid(gif.LayerStates, gif.Variables).stop();
    for (int i = 0; i < gif.LayerStates; i++) {
      Ani.set(i, 0, true);
    }
    // labels
    int lHeight = 20; 
    for (int i = 0; i < Labels.length; i++) {
      Label =  cp5.addTextlabel("Label" + i).setPosition(420, 505 + (lHeight*i)).setText(Labels[i]);
      cp5.getController("Label" + i).moveTo("global");
      //cp5.getController("Label" + i).moveTo("default");
    }

    for (int i = 1; i < gif.Variables; i++) {
      Duration = cp5.addSlider(Labels[i]).setPosition(10, 505+(lHeight*i)).setSize(50, 20);
      cp5.getController(Labels[i]).setVisible(false);
      cp5.getController(Labels[i]).moveTo("Ani Easing");
    }

    //Easing = cp5.addScrollableList("Easing").setPosition(10, 600).setWidth(200).setHeight(140).close(); 
    //Easing.addItems(easingsVariableNames);
    //gui.cp5.getController("Easing").moveTo("Easing Styles");

    // Controller for layerstates, temporary stripping 
    Layer = cp5.getProperties();
    Layer.remove(LX);
    Layer.remove(LY);
    Layer.remove(SW);
    Layer.remove(D);
    Layer.remove(G1c);
    Layer.remove(G2c);
    Layer.remove(G3c);
    //Fill, Stroke, Lines, Dots, CS, Cast, Pause;
    Layer.remove(Fill);
    Layer.remove(Stroke);
    Layer.remove(Lines);
    Layer.remove(Dots);
    Layer.remove(CS);
    Layer.remove(Cast);
    Layer.remove(Pause);
    Layer.remove(cp);
    Layer.remove(cw);
    Layer.remove(Ani);
    Layer.remove(LayerList);
    Layer.remove(Copy);
    Layer.remove(New);
    Layer.remove(LayerState);
    Layer.remove(Save);

    // saves JSON for each layerstate
    for (int i=0; i < gif.LayerStates; i++) {
      Layer.setSnapshot("LayerState" + i);
      Layer.saveAs(JSON + i);
    }
    //println(Layer.getSnapshotIndices());
  }

  void draw() {
    background(190);
  }

  void keyPressed() {
    if (key==' ') {     
      if (play == false) {
        cp5.get(Matrix.class, "Matrix").play();
        play = true;
      } else {
        cp5.get(Matrix.class, "Matrix").pause();
        play = false;
      }
      gui.cp5.get(Toggle.class, "Play/Pause").setState(play);
    }
    if (key == 'q') {
      cp5.get(Matrix.class, "Matrix").stop();
      if (play == true) {
        cp5.get(Matrix.class, "Matrix").play();
      }
    }
  }

  void Matrix(int theX, int theY) {
    // so when playing, this here passes along theX to the triggers & layerstate reset on loop
    gif.AniStart(theX, theY);
  }

  void controlEvent(ControlEvent theControlEvent) {
    if (theControlEvent.isTab()) {
      gif.toggle();
    }
  }

  void controlEvent(CallbackEvent theEvent) {
    if (theEvent.getController().equals(Save)) {
      if (theEvent.getAction() == ControlP5.ACTION_PRESS) {
        int i = int(LayerState.getValue());
        Layer.setSnapshot("LayerState" + i);
        Layer.saveAs(JSON + i);
      }
    }
    if (theEvent.getController().equals(LayerState)) {
      if (theEvent.getAction() == ControlP5.ACTION_CLICK) {
        int i = int(LayerState.getValue());
        Layer.load(JSON + i);
      }
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
        LayerList.addItem("Layer" + layers.size(), New);
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
      layers.get(id).gear0.RX = map(G0.getArrayValue(0), 0, 1024, -512, 512);
      layers.get(id).gear0.RY = map(G0.getArrayValue(1), 0, 1024, -512, 512);
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
      //if (Cast.getState() == true) {
      //  layers.get(id).gear1.Connect = (G1c.getValue());
      //  layers.get(id).gear2.Connect = (G2c.getValue());
      //  layers.get(id).gear3.Connect = (G3c.getValue());
      //}
    }
  }

  void BG(color bg) {
    BG = bg;
  }
}