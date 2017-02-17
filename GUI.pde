class GUI extends PApplet {     //<>//
  int id, set;
  boolean layerlock;
  PApplet parent;
  ControlP5 cp5;
  Slider2D G0, G1, G2, G3;
  Slider P1, P2, P3, LX, LY, SW, D, G1c, G2c, G3c, Duration, G0X, G0Y, G0Z, GifWidth, GifHeight, GifLength, GifInterval;
  Toggle Fill, Stroke, Lines, Dots, CS, Spheres, Pause;
  ColorPicker cp;
  ColorWheel cw;
  ScrollableList LayerList, Easing;
  Button New, Copy, SaveAll, Save, Increase, Decrease, OK;
  Matrix Ani;
  ControllerProperties Layer;
  ButtonBar LayerState;
  Textlabel Label;
  String [] Labels = {"", "Gear 0 X", "Gear 0 Y", "Gear 1 Petals", "Gear 1 X", "Gear 1 Y", "Gear 2 Petals", "Gear 2 X", "Gear 2 Y", "Gear 3 Petals", "Gear 3 X", "Gear 3 Y", "Line X", "Line Y", "StrokeWeight", "Connect G1", "Connect G2", "Connect G3", "Density"}; 
  String[] EasingNames = {"LINEAR", "QUAD_IN", "QUAD_OUT", "QUAD_IN_OUT", "CUBIC_IN", "CUBIC_IN_OUT", "CUBIC_OUT", "QUART_IN", "QUART_OUT", "QUART_IN_OUT", "QUINT_IN", "QUINT_OUT", "QUINT_IN_OUT", "SINE_IN", "SINE_OUT", "SINE_IN_OUT", "CIRC_IN", "CIRC_OUT", "CIRC_IN_OUT", "EXPO_IN", "EXPO_OUT", "EXPO_IN_OUT", "BACK_IN", "BACK_OUT", "BACK_IN_OUT", "BOUNCE_IN", "BOUNCE_OUT", "BOUNCE_IN_OUT", "ELASTIC_IN", "ELASTIC_OUT", "ELASTIC_IN_OUT"};

  public GUI(PApplet theApplet) {
    super();
    parent = theApplet;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(680, 980);
  } 

  public void setup() {
    id = 0;
    set = 0;
    cp5 = new ControlP5(this);
    cw = cp5.addColorWheel("BackGround").setPosition(302, 10).setValue(128).plugTo(this, "Controls").moveTo("global");
    
    // gif dimensions, lenght & interval 
    GifWidth = cp5.addSlider("Width").setPosition(510, 45).setRange(200, 1920).setValue(gifWidth).moveTo("global");
    GifHeight = cp5.addSlider("Height").setPosition(510, 60).setRange(200, 1920).setValue(gifHeight).moveTo("global");
    GifLength = cp5.addSlider("TimeLength").setPosition(510, 75).setRange(1000, 10000).setValue(gif.TotalTime).moveTo("global");
    GifInterval = cp5.addSlider("Intervals").setPosition(510, 90).setRange(2, 20).setValue(gif.LayerStates).setNumberOfTickMarks(19).snapToTickMarks(true).moveTo("global");
    OK = cp5.addButton("OK").setPosition(510, 115).setVisible(true);
    OK.addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent theEvent) {
        if (theEvent.getAction() == ControlP5.ACTION_PRESS) {
          //println("check");
          gifWidth = int(GifWidth.getValue());
          gifHeight = int(GifHeight.getValue());
          gif.TotalTime = GifLength.getValue();
          gif.LayerStates = int(GifInterval.getValue());
          gif.Update();
        }
      }
    }
    );
    // not functional button, i.e. just visual indicator 
    Pause = cp5.addToggle("Play/Pause").setPosition(10, 400).setSize(30, 15).setState(play).moveTo("global");
   
    // LAYER CONTROLS START HERE
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
    G0 = cp5.addSlider2D("Radius Gear 0").setMinMax(0, 0, 512, 512).setPosition(10, 90).setCaptionLabel("Radius Gear 0").plugTo(this, "Controls").setValue(160, 160).moveTo("global");
    // gear1
    G1 = cp5.addSlider2D("Radius Gear 1").setMinMax(0, 0, 256, 256).setPosition(160, 90).setCaptionLabel("Radius Gear 1").plugTo(this, "Controls").setValue(190, 190).moveTo("global");
    P1 = cp5.addSlider("Petals_1").setRange(0, 50).setPosition(160, 80).setCaptionLabel("Petals").plugTo(this, "Controls").setValue(6).moveTo("global");
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
    SW = cp5.addSlider("StrokeWeight").setPosition(310, 330).setRange(0, 250).setValue(2).plugTo(this, "Controls").setValue(layers.get(id).SW).moveTo("global");
    Lines = cp5.addToggle("Lines").setPosition(310, 290).setSize(20, 20).setState(false).plugTo(this, "Controls").moveTo("global");
    Dots = cp5.addToggle("Dots").setPosition(340, 290).setSize(20, 20).setState(false).plugTo(this, "Controls").moveTo("global");
    Spheres = cp5.addToggle("3D").setPosition(370, 290).setSize(20, 20).setState(false).plugTo(this, "Controls").moveTo("global");
    // line density for spiro mode
    D = cp5.addSlider("Density").setPosition(10, 430).setSize(450, 15).setRange(0, 100000).plugTo(this, "Controls").setValue(layers.get(id).PlotDots).moveTo("global");
    // gear connectors for line & dot mode
    G1c = cp5.addSlider("Connect G1").setPosition(310, 230).setRange(0, 100).plugTo(this, "Controls").moveTo("global");
    G2c = cp5.addSlider("Connect G2").setPosition(310, 250).setRange(0, 100).plugTo(this, "Controls").moveTo("global");
    G3c = cp5.addSlider("Connect G3").setPosition(310, 270).setRange(0, 100).plugTo(this, "Controls").moveTo("global");

    // new, copy, switch
    LayerList = cp5.addScrollableList("SwitchLayers").setPosition(310, 390).setType(ScrollableList.DROPDOWN).setCaptionLabel("Layers").moveTo("global").setOpen(false);
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
          New.gear0.RZ = layers.get(id).gear0.RZ;
          New.gear1.RX = layers.get(id).gear1.RX;
          New.gear1.RY = layers.get(id).gear1.RY;
          New.gear1.RZ = layers.get(id).gear1.RZ;
          New.gear2.RX = layers.get(id).gear2.RX;
          New.gear2.RY = layers.get(id).gear2.RY;
          New.gear2.RZ = layers.get(id).gear2.RZ;
          New.gear3.RX = layers.get(id).gear3.RX;
          New.gear3.RY = layers.get(id).gear3.RY;
          New.gear3.RZ = layers.get(id).gear3.RZ;
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
          New.spheres3d = layers.get(id).spheres3d;
          layers.add(New);
          LayerList.addItem("Copy " + (id+1), New);
        }
      }
    }
    );
    
    // LAYERSTATES START HERE
    // Controller object
    Layer = cp5.getProperties();
    Layer.remove(CS).remove(Pause).remove(cp).remove(cw).remove(Ani).remove(Copy).remove(New).remove(SaveAll).remove(Save);
    // saves JSON for each layerstate
    for (int i=0; i < gif.LayerStates; i++) {
      Layer.setSnapshot("LayerState" + i);
      Layer.saveAs(JSON + i);
    }
    // save functions
    SaveAll = cp5.addButton("Save FWD").setPosition(120, 400).setSize(60, 15).moveTo("global");
    SaveAll.addCallback(new CallbackListener() {
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
    Save = cp5.addButton("Save").setPosition(50, 400).setSize(60, 15).moveTo("global");
    Save.addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent theEvent) {
        if (theEvent.getAction() == ControlP5.ACTION_PRESS) {
          int LS = int(LayerState.getValue());
          Layer.setSnapshot("LayerState" + LS);
          Layer.saveAs(JSON + LS);
          //LayerStateArray.set(LS, layers.get(0));
        }
      }
    }
    );
    //button bar to toggle layerstates
    LayerState = cp5.addButtonBar("ls").setPosition(10, 475).setSize(gif.MatrixWidth, gif.CellHeight);
    String [] buttonL;
    buttonL = new String[gif.LayerStates];
    for (int i = 0; i < gif.LayerStates; i++) {       
      buttonL[i] = "LS" + (i+1);
    }
    LayerState.addItems(buttonL);
    cp5.getController("ls").moveTo("global");
    LayerState.addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent theEvent) {
        if (theEvent.getAction() == ControlP5.ACTION_CLICK) {
          int LS = int(LayerState.getValue());
          Layer.load(JSON + LS);
          //gif.LoadLayerState(ls);
          //set = int(LayerState.getValue());
          //SwitchLayers();
        }
      }
    }
    );
    
    // ANIMATRIX TABS START HERE
    // make tabs
    cp5.getTab("default").setCaptionLabel("Matrix").setId(1);
    cp5.addTab("Ani Easing");
    cp5.getTab("Ani Easing").activateEvent(true).setId(2);
    cp5.getTab("default").activateEvent(true);
    cp5.getTab("Ani Easing");
    cp5.getWindow().setPositionOfTabs(10, 450);
    // ani easing tab
    for (int x = 00; x< gif.LayerStates; x++) {
      for (int y = 1; y < gif.Variables; y++) {
        //println(x, y);
        Easing = cp5.addScrollableList("Easing"+"0"+x+"0"+y).setPosition(10 + (x*gif.CellWidth), 500 + (y*gif.CellHeight)).setWidth(gif.CellWidth).setHeight(100).setBarHeight(gif.CellHeight).setType(ScrollableList.DROPDOWN).close(); 
        Easing.addItems(EasingNames);
        cp5.getController("Easing"+"0"+x+"0"+y).setVisible(false);
        cp5.getController("Easing"+"0"+x+"0"+y).moveTo("Ani Easing");

        Increase = cp5.addButton("add"+"0"+x+"0"+y).setPosition((10+gif.CellWidth) + (x*gif.CellWidth), 500 + (y*gif.CellHeight)).setWidth(15).setCaptionLabel("+").setId(x);
        cp5.getController("add"+"0"+x+"0"+y).addCallback(new CallbackListener() {
          public void controlEvent(CallbackEvent theEvent) { 
            if (theEvent.getAction()==ControlP5.ACTION_CLICK) {        
              int x = theEvent.getController().getId();
              int y = (int(theEvent.getController().getPosition()[1]) - 500)/gif.CellHeight;        
              gif.AniEnd[x][y] = gif.AniEnd[x][y] + int(theEvent.getController().getValue());
              int interval = gif.AniEnd[x][y] - x; 
              //gif.AniInt[x][y] = interval;
              cp5.getController("Easing"+"0"+x+"0"+y).setWidth(gif.CellWidth + interval*gif.CellWidth);
              theEvent.getController().setPosition( ((10+gif.CellWidth) + (x*gif.CellWidth) + ((interval)*gif.CellWidth)), 500 + (y*gif.CellHeight));
              //println(gif.AniEnd[x][y],interval);
            }
          }
        }
        );
        Decrease = cp5.addButton("minus"+"0"+x+"0"+y).setPosition((x*gif.CellWidth)-5, 500 + (y*gif.CellHeight)).setWidth(15).setCaptionLabel("-").setId(x);
        cp5.getController("minus"+"0"+x+"0"+y).addCallback(new CallbackListener() {
          public void controlEvent(CallbackEvent theEvent) { 
            if (theEvent.getAction()==ControlP5.ACTION_CLICK) {        
              int x = theEvent.getController().getId();
              int y = (int(theEvent.getController().getPosition()[1]) - 500)/gif.CellHeight;        
              gif.AniEnd[x][y] = gif.AniEnd[x][y] - int(theEvent.getController().getValue());
              int interval = gif.AniEnd[x][y] - x;   
              //gif.AniInt[x][y] = interval;
              cp5.getController("Easing"+"0"+x+"0"+y).setWidth(gif.CellWidth + interval*gif.CellWidth);
              int tempx = int(cp5.getController("add"+"0"+x+"0"+y).getPosition()[0]);
              cp5.getController("add"+"0"+x+"0"+y).setPosition( (tempx - gif.CellWidth), 500 + (y*gif.CellHeight));
              //println(x, y,  gif.AniEnd[x][y],interval);
            }
          }
        }
        );
        cp5.getController("minus"+"0"+x+"0"+y).setVisible(false);
        cp5.getController("minus"+"0"+x+"0"+y).moveTo("Ani Easing");
        cp5.getController("add"+"0"+x+"0"+y).setVisible(false);
        cp5.getController("add"+"0"+x+"0"+y).moveTo("Ani Easing");
        Layer.remove(Increase, "add"+"0"+x+"0"+y); 
        Layer.remove(Decrease, "minus"+"0"+x+"0"+y);
        //Layer.remove(Easing, "Easing"+"0"+x+"0"+y);
      }
    }
    // actual matrix
    Ani = cp5.addMatrix("Matrix").setPosition(10, 500).setSize(gif.MatrixWidth, gif.MatrixHeight). setGap(5, 5).setMode(ControlP5.MULTIPLES)
      .setInterval(gif.Interval).setGrid(gif.LayerStates, gif.Variables).set(0, 0, true).stop();
    // aaand some labels
    for (int i = 0; i < Labels.length; i++) {
      Label =  cp5.addTextlabel("Label" + i).setPosition(gif.MatrixWidth + 10, 505 + (gif.CellHeight*i)).setText(Labels[i]).moveTo("global");
      Layer.remove(Label, "Label" + i);
    }
  }

  void draw() {
    background(190);
  }

  void keyPressed() {
    if (key==' ') {     
      if (play == false) {
        gif.triggerArray();
        cp5.get(Matrix.class, "Matrix").play();
        cp5.get(Matrix.class, "Matrix").trigger(0);
        play = true;
      } else {
        cp5.get(Matrix.class, "Matrix").pause();
        play = false;
      }
      gui.cp5.get(Toggle.class, "Play/Pause").setState(play);
    }
    if (key == 'q') { 
      Layer.load(JSON+0);
      gif.triggerArray();
      cp5.get(Matrix.class, "Matrix").stop();
      if (play == true) {
        gif.triggerArray();
        cp5.get(Matrix.class, "Matrix").play();
      }
    }
  }

  void Matrix(int theX, int theY) {
    gif.aniStart(theX, theY);
    if (theX == 0) {
      Layer.load(JSON+0);
    }
  }

  void controlEvent(ControlEvent theControlEvent) {
    if (theControlEvent.isTab()) {
      gif.tabToggle();
    }
  }

  //void ColorFillStroke() {
  //  if (layerlock == false) {
  //    if (CS.getState() == false) {
  //      //layers.get(id).Fill =  cp.getColorValue() ;
  //        //layers.get(id).Fill =  cw.getPickingColor();

  //    }
  //    if (CS.getState() == true) {
  //      layers.get(id).Stroke =  cp.getColorValue();
  //    }
  //  }
  //}

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
      SW.setValue(layers.get(set).SW);
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
layers.get(id).Fill =  cw.getRGB();

      //3D controls
      if (Spheres.getState() == true) {
        layers.get(id).gear0.RZ = SW.getValue();
        layers.get(id).gear1.RZ = G1c.getValue();
        layers.get(id).gear2.RZ = G2c.getValue();
        layers.get(id).gear3.RZ = G3c.getValue();
      }

      layers.get(id).gear0.RX = map(G0.getArrayValue(0), 0, 512, -256, 256);
      layers.get(id).gear0.RY = map(G0.getArrayValue(1), 0, 512, -256, 256);
      layers.get(id).gear1.RX = map(G1.getArrayValue(0), 0, 256, -128, 128);
      layers.get(id).gear1.RY = map(G1.getArrayValue(1), 0, 256, -128, 128);
      layers.get(id).gear2.RX = map(G2.getArrayValue(0), 0, 256, -128, 128);
      layers.get(id).gear2.RY = map(G2.getArrayValue(1), 0, 256, -128, 128);
      layers.get(id).gear3.RX = map(G3.getArrayValue(0), 0, 256, -128, 128);
      layers.get(id).gear3.RY = map(G3.getArrayValue(1), 0, 256, -128, 128);
      layers.get(id).gear1.P = int(P1.getValue()); 
      layers.get(id).gear2.P = int(P2.getValue());
      layers.get(id).gear3.P = int(P3.getValue());
      layers.get(id).LX = LX.getValue();
      layers.get(id).LY = LY.getValue();
      layers.get(id).fill = Fill.getState();
      layers.get(id).stroke = Stroke.getState();
      layers.get(id).spheres3d = Spheres.getState();
      layers.get(id).SW = SW.getValue();
      layers.get(id).lines = Lines.getState();
      layers.get(id).dots = Dots.getState();
      layers.get(id).PlotDots = D.getValue();
      layers.get(id).gear1.Connect = int(G1c.getValue());
      layers.get(id).gear2.Connect = int(G2c.getValue());
      layers.get(id).gear3.Connect = int(G3c.getValue());
    }
  }

  void BG(color bg) {
    BG = bg;
  }
}