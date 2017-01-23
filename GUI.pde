class GUI extends PApplet {    //<>//
  int id, set;
  boolean layerlock;
  PApplet parent;
  ControlP5 cp5;
  Slider2D G0, G1, G2, G3;
  Slider P1, P2, P3, LX, LY, SW, D, G1c, G2c, G3c, Duration;
  Toggle Fill, Stroke, Lines, Dots, CS, Cast, Pause;
  ColorPicker cp;
  ColorWheel cw;
  ScrollableList LayerList, Easing;
  Button New, Copy, Save, Increase, Decrease;
  Matrix Ani;
  ControllerProperties Layer;
  ButtonBar LayerState, TriggerState;
  Textlabel Label;
  String [] Labels = {"", "Gear 0 X", "Gear 0 Y", "Gear 1 Petals", "Gear 1 X", "Gear 1 Y", "Gear 2 Petals", "Gear 2 X", "Gear 2 Y", "Gear 3 Petals", "Gear 3 X", "Gear 3 Y"}; 
  String[] EasingNames = {"LINEAR", "QUAD_IN", "QUAD_OUT", "QUAD_IN_OUT", "CUBIC_IN", "CUBIC_IN_OUT", "CUBIC_OUT", "QUART_IN", "QUART_OUT", "QUART_IN_OUT", "QUINT_IN", "QUINT_OUT", "QUINT_IN_OUT", "SINE_IN", "SINE_OUT", "SINE_IN_OUT", "CIRC_IN", "CIRC_OUT", "CIRC_IN_OUT", "EXPO_IN", "EXPO_OUT", "EXPO_IN_OUT", "BACK_IN", "BACK_OUT", "BACK_IN_OUT", "BOUNCE_IN", "BOUNCE_OUT", "BOUNCE_IN_OUT", "ELASTIC_IN", "ELASTIC_OUT", "ELASTIC_IN_OUT"};

  public GUI(PApplet theApplet) {
    super();
    parent = theApplet;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(768, 1024);
  } 

  public void setup() {
    id = 0;
    set = 0;
    cp5 = new ControlP5(this);

    // color
    cw = cp5.addColorWheel("BackGround").setPosition(302, 10).setValue(128).plugTo(this, "BG").moveTo("global");
    cp = cp5.addColorPicker("ColorPicker").setPosition(10, 10).setColorValue(layers.get(id).Fill).moveTo("global");
    CS = cp5.addToggle("Switch").setPosition(270, 10).setSize(25, 25).setState(false).moveTo("global");
    CS.addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent theEvent) {
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
    );

    // gear 0
    G0 = cp5.addSlider2D("Radius Gear 0").setMinMax(0, 0, 512, 512).setPosition(10, 90).setCaptionLabel("Radius Gear 0").plugTo(this, "Controls").setValue(128, 128).moveTo("global");
    // gear1
    G1 = cp5.addSlider2D("Radius Gear 1").setMinMax(0, 0, 256, 256).setPosition(160, 90).setCaptionLabel("Radius Gear 1").plugTo(this, "Controls").setValue(128, 128).moveTo("global");
    P1 = cp5.addSlider("Petals_1").setRange(0, 50).setPosition(160, 80).setCaptionLabel("Petals").plugTo(this, "Controls").setValue(layers.get(id).gear1.P).moveTo("global");
    // gear2
    G2 = cp5.addSlider2D("Radius Gear 2").setMinMax(0, 0, 256, 256).setPosition(10, 230).setCaptionLabel("Radius Gear 2").plugTo(this, "Controls").setValue(128, 128).moveTo("global");
    P2 = cp5.addSlider("Petals_2").setRange(0, 100).setPosition(10, 220).setCaptionLabel("Petals").plugTo(this, "Controls").setValue(layers.get(id).gear2.P).moveTo("global");
    //// gear3
    G3 = cp5.addSlider2D("Radius Gear 3").setMinMax(0, 0, 256, 256).setPosition(160, 230).setCaptionLabel("Radius Gear 3").plugTo(this, "Controls").setValue(128, 128).moveTo("global");
    P3 = cp5.addSlider("Petals_3").setRange(0, 200).setPosition(160, 220).setCaptionLabel("Petals").plugTo(this, "Controls").setValue(layers.get(id).gear3.P).moveTo("global");
    // fill stroke width for all modes
    Fill = cp5.addToggle("Fill").setPosition(10, 370).setSize(45, 15).setMode(ControlP5.SWITCH).setState(true).plugTo(this, "Controls").moveTo("global");
    Stroke = cp5.addToggle("Stroke").setPosition(65, 370).setSize(45, 15).setMode(ControlP5.SWITCH).setState(false).plugTo(this, "Controls").moveTo("global");
    LX = cp5.addSlider("LineX").setPosition(10, 350).setRange(0, 250).plugTo(this, "Controls").setValue(layers.get(id).LX).moveTo("global");
    LY = cp5.addSlider("LineY").setPosition(160, 350).setRange(0, 250).plugTo(this, "Controls").setValue(layers.get(id).LY).moveTo("global");
    SW = cp5.addSlider("StrokeWeight").setPosition(310, 330).setRange(0, 250).setValue(2).plugTo(this, "Controls").setValue(layers.get(id).Sw).moveTo("global");
    Lines = cp5.addToggle("Lines").setPosition(310, 290).setSize(20, 20).setState(false).plugTo(this, "Controls").moveTo("global");
    Dots = cp5.addToggle("Dots").setPosition(340, 290).setSize(20, 20).setState(false).plugTo(this, "Controls").moveTo("global");
    Cast = cp5.addToggle("Cast").setPosition(370, 290).setSize(20, 20).setState(false).plugTo(this, "Controls").moveTo("global");

    // line density for spiro mode ~ !!!! temporary disabled, need to be reworked with range buttons
    D = cp5.addSlider("Density").setPosition(10, 430).setSize(450, 15).setRange(0, 100000).plugTo(this, "Controls").setValue(layers.get(id).PlotDots).moveTo("global");
    // gear connectors for line & dot mode
    G1c = cp5.addSlider("Connect G1").setPosition(310, 230).setRange(0, 100).plugTo(this, "Controls").moveTo("global");
    G2c = cp5.addSlider("Connect G2").setPosition(310, 250).setRange(0, 100).plugTo(this, "Controls").moveTo("global");
    G3c = cp5.addSlider("Connect G3").setPosition(310, 270).setRange(0, 100).plugTo(this, "Controls").moveTo("global");

    // layers control
    LayerList = cp5.addScrollableList("SwitchLayers").setPosition(310, 390).setType(ScrollableList.DROPDOWN).setCaptionLabel("Layers").moveTo("global");
    for (int i = 0; i<layers.size(); i++) {
      LayerList.addItem("Layer" + (i+1), layers.get(i));
    }
    New = cp5.addButton("New Layer").setPosition(310, 350).setSize(60, 15).moveTo("global");
    New.addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent theEvent) {
        if (theEvent.getAction() == ControlP5.ACTION_PRESS) {
          Layer New = new Layer();
          layers.add(New);
          LayerList.addItem("Layer" + layers.size(), New);
        }
      }
    }
    );
    Copy = cp5.addButton("Copy Layer").setPosition(380, 350).setSize(60, 15).moveTo("global");
    Copy.addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent theEvent) {
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
    }
    );

    Pause = cp5.addToggle("Play/Pause").setPosition(10, 400).setSize(30, 15).setState(play).moveTo("global");
    Save = cp5.addButton("Save").setPosition(50, 400).setSize(60, 15).moveTo("global");
    Save.addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent theEvent) {
        if (theEvent.getAction() == ControlP5.ACTION_PRESS) {
          int LS = int(LayerState.getValue());
          for (int i = LS; i < gif.LayerStates; i++) {
            Layer.setSnapshot("LayerState" + i);
            Layer.saveAs(JSON + i);
          }
        }
      }
    }
    );

    // setup tabs for animation ui
    cp5.getTab("default").setCaptionLabel("Matrix");
    cp5.addTab("Ani Easing");
    cp5.getTab("Ani Easing").activateEvent(true);
    cp5.getTab("default").activateEvent(true);
    cp5.getTab("Ani Easing");
    cp5.getWindow().setPositionOfTabs(10, 450);

    //button bar layerstates
    LayerState = cp5.addButtonBar("ls").setPosition(10, 498).setSize(gif.MatrixWidth, gif.CellHeight);
    String [] buttonL;
    buttonL = new String[gif.LayerStates];
    for (int i = 0; i < gif.LayerStates; i++) {       
      buttonL[i] = "LS" + (i+1);
    }
    LayerState.addItems(buttonL);
    LayerState.addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent theEvent) {
        if (theEvent.getAction() == ControlP5.ACTION_CLICK) {
          int i = int(LayerState.getValue());
          Layer.load(JSON + i);
        }
      }
    }
    );
    cp5.getController("ls").moveTo("global");

    // Controller for layerstates, temporary stripping 
    Layer = cp5.getProperties();
    Layer.remove(LX);
    Layer.remove(LY);
    Layer.remove(SW);
    Layer.remove(D);
    Layer.remove(G1c);
    Layer.remove(G2c);
    Layer.remove(G3c);
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

    // actual matrix
    Ani = cp5.addMatrix("Matrix").setPosition(10, 500).setSize(gif.MatrixWidth, gif.MatrixHeight). setGap(5, 5).setMode(ControlP5.MULTIPLES)
      .setInterval(gif.Interval).setGrid(gif.LayerStates, gif.Variables).stop();
    for (int i = 0; i < gif.LayerStates; i++) {
      Ani.set(i, 0, true);
    }

    for (int i = 0; i < Labels.length; i++) {
      Label =  cp5.addTextlabel("Label" + i).setPosition(gif.MatrixWidth + 10, 505 + (gif.CellHeight*i)).setText(Labels[i]).moveTo("global");
      Layer.remove(Label, "Label" + i);
    }

    // easing tab
    for (int x = 0; x< gif.LayerStates; x++) {
      for (int y = 1; y < gif.Variables; y++) {

        Easing = cp5.addScrollableList("Easing" + x + y).setPosition(10 + (x*gif.CellWidth), 500 + (y*gif.CellHeight)).setWidth(gif.CellWidth).setHeight(100).setBarHeight(gif.CellHeight).setType(ScrollableList.DROPDOWN).close(); 
        Easing.addItems(EasingNames);
        cp5.getController("Easing" + x + y).setVisible(false);
        cp5.getController("Easing" + x + y).moveTo("Ani Easing");

        Increase = cp5.addButton("add" + x + y).setPosition((10+gif.CellWidth) + (x*gif.CellWidth), 500 + (y*gif.CellHeight)).setWidth(15).setCaptionLabel("+");
        cp5.getController("add" + x + y).addCallback(new CallbackListener() {
          public void controlEvent(CallbackEvent theEvent) {
            if (theEvent.getAction()==ControlP5.ACTION_CLICK) {
              int x = int(theEvent.getController().toString().substring(3, 4));
              int y = int(theEvent.getController().toString().substring(4, 5));
              gif.AniEnd[x][y] = gif.AniEnd[x][y] + int(theEvent.getController().getValue());
              int i = gif.AniEnd[x][y]-x;
              cp5.getController("Easing" + x + y).setWidth(i*gif.CellWidth);
              theEvent.getController().setPosition( ((10+gif.CellWidth) + (x*gif.CellWidth) + ((i-1)*gif.CellWidth)), 500 + (y*gif.CellHeight));
              println(x, y, gif.AniEnd[x][y], i);
            }
          }
        }
        );
        cp5.getController("add" + x + y).setVisible(false);
        cp5.getController("add" + x + y).moveTo("Ani Easing");
        //Layer.remove(Easing, "Easing" + x + y);
        Layer.remove(Easing, "add" + x + y);
      }
    }
  }

  void draw() {
    background(190);
  }

  void keyPressed() {
    if (key==' ') {     
      if (play == false) {
        //gui.cp5.get(Matrix.class, "Matrix").trigger(0);
        //gif.Trigger = 0;
        cp5.get(Matrix.class, "Matrix").play();
        play = true;
      } else {
        cp5.get(Matrix.class, "Matrix").pause();
        play = false;
      }
      gui.cp5.get(Toggle.class, "Play/Pause").setState(play);
    }
    if (key == 'q') {
      println(gif.AniEnd[3][1]);
      Layer.load(JSON+0);
      cp5.get(Matrix.class, "Matrix").stop();
      if (play == true) {
        cp5.get(Matrix.class, "Matrix").play();
      }
    }
  }

  void Matrix(int theX, int theY) {
    // so when playing, this here passes along theX to the triggers & layerstate reset on loop
    gif.AniStart(theX, theY);
    gif.LoadLayerValue(theX, theY);
    // reset layerstate on loop
    if (theX == 0) {
      Layer.load(JSON+0);
    }
  }

  void controlEvent(ControlEvent theControlEvent) {
    if (theControlEvent.isTab()) {
      println("checktab");
      gif.toggle();
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
      G0 = cp5.addSlider2D("Radius Gear 0").setMinMax(0, 0, 512, 512).setPosition(10, 90).setCaptionLabel("Radius Gear 0").plugTo(this, "Controls").setValue(map(layers.get(set).gear0.RX, -256, 256, 0, 512), map(layers.get(set).gear0.RY, -256, 256, 0, 512));
      cp5.getController("Radius Gear 0").moveTo("global");
      G1 = cp5.addSlider2D("Radius Gear1").setMinMax(0, 0, 256, 256).setPosition(160, 90).setCaptionLabel("Radius Gear 1").plugTo(this, "Controls").setValue(map(layers.get(set).gear1.RX, -128, 128, 0, 256), map(layers.get(set).gear1.RY, -128, 128, 0, 256));
      cp5.getController("Radius Gear1").moveTo("global");
      G2 = cp5.addSlider2D("Radius Gear2").setMinMax(0, 0, 256, 256).setPosition(10, 230).setCaptionLabel("Radius Gear 2").plugTo(this, "Controls").setValue(map(layers.get(set).gear2.RX, -128, 128, 0, 256), map(layers.get(set).gear2.RY, -128, 128, 0, 256));
      cp5.getController("Radius Gear2").moveTo("global");
      G3 = cp5.addSlider2D("Radius Gear3").setMinMax(0, 0, 256, 256).setPosition(160, 230).setCaptionLabel("Radius Gear 3").plugTo(this, "Controls").setValue(map(layers.get(set).gear3.RX, -128, 128, 0, 256), map(layers.get(set).gear3.RY, -128, 128, 0, 256));
      cp5.getController("Radius Gear3").moveTo("global");
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
      layers.get(id).gear0.RX = map(G0.getArrayValue(0), 0, 512, -256, 256);
      layers.get(id).gear0.RY = map(G0.getArrayValue(1), 0, 512, -256, 256);
      layers.get(id).gear1.RX = map(G1.getArrayValue(0), 0, 256, -128, 128);
      layers.get(id).gear1.RY = map(G1.getArrayValue(1), 0, 256, -128, 128);
      layers.get(id).gear2.RX = map(G2.getArrayValue(0), 0, 256, -128, 128);
      layers.get(id).gear2.RY = map(G2.getArrayValue(1), 0, 256, -128, 128);
      layers.get(id).gear3.RX = map(G3.getArrayValue(0), 0, 256, -128, 128);
      layers.get(id).gear3.RY = map(G3.getArrayValue(1), 0, 256, -128, 128);
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