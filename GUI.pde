class GUI extends PApplet {     //<>//
  PApplet parent;
  ControlP5 cp5;
  Button gifNew, gifNewOK;
  ColorWheel colorBackground, colorStroke, colorFill;
  Toggle stroke, fill, drawMode;
  Slider gifWidth, gifHeight, gifLength, gifInterval, lx, ly, sw, gear0z, gear1z, gear2z, gear3z, petals1, petals2, petals3, alphaFill, alphaStroke;
  Slider2D gear0, gear1, gear2, gear3;
  ButtonBar trigX, trigY, trigZ;
  Textlabel trig;


  Toggle Lines, Dots, CS, Spheres, Pause;
  ScrollableList LayerList, Easing;
  Button New, Copy, SaveAll, Save, Increase, Decrease, OK;
  Matrix Ani;
  ButtonBar LayerState;
  Textlabel Label;
  String [] Labels = {"", "Gear 0 X", "Gear 0 Y", "Gear 1 Petals", "Gear 1 X", "Gear 1 Y", "Gear 2 Petals", "Gear 2 X", "Gear 2 Y", "Gear 3 Petals", "Gear 3 X", "Gear 3 Y", "Line X", "Line Y", "StrokeWeight", "Connect G1", "Connect G2", "Connect G3", "Density"}; 
  String[] EasingNames = {"LINEAR", "QUAD_IN", "QUAD_OUT", "QUAD_IN_OUT", "CUBIC_IN", "CUBIC_IN_OUT", "CUBIC_OUT", "QUART_IN", "QUART_OUT", "QUART_IN_OUT", "QUINT_IN", "QUINT_OUT", "QUINT_IN_OUT", "SINE_IN", "SINE_OUT", "SINE_IN_OUT", "CIRC_IN", "CIRC_OUT", "CIRC_IN_OUT", "EXPO_IN", "EXPO_OUT", "EXPO_IN_OUT", "BACK_IN", "BACK_OUT", "BACK_IN_OUT", "BOUNCE_IN", "BOUNCE_OUT", "BOUNCE_IN_OUT", "ELASTIC_IN", "ELASTIC_OUT", "ELASTIC_IN_OUT"};
  int id, set;
  boolean layerlock;

  int LX, LY, SW, GW, GH, ms, i, g0z, g1z, g2z, g3z, p1, p2, p3, as, af ; // using int to strip decimals for better ui aethetic, might come back to bite me in the arse . . =) 

  public GUI(PApplet theApplet) {
    super();
    parent = theApplet;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(860, 980);
  } 

  public void setup() {
    id = 0;
    set = 0;
    cp5 = new ControlP5(this);

    // new gif menu
    gifNew = cp5.addButton("gifNew").setPosition(780, 3).setCaptionLabel("New");
    cp5.addGroup("ng").setPosition(300, 500).setSize(175, 110).setBackgroundColor(color(255, 50)).setCaptionLabel("set animation").disableCollapse().hide();
    gifWidth = cp5.addSlider("GW").setPosition(10, 10).setRange(200, 1920).setGroup("ng").setCaptionLabel("Width");
    gifHeight = cp5.addSlider("GH").setPosition(10, 25).setRange(200, 1920).setGroup("ng").setCaptionLabel("Height");
    gifLength = cp5.addSlider("ms").setPosition(10, 40).setRange(1000, 10000).setGroup("ng").setCaptionLabel("Duration (ms)");
    gifInterval = cp5.addSlider("i").setPosition(10, 55).setRange(2, 20).setNumberOfTickMarks(19).snapToTickMarks(true).setGroup("ng").setCaptionLabel("Intervals");
    gifNewOK = cp5.addButton("Create").setPosition(50, 80).setGroup("ng");
    drawMode = cp5.addToggle("drawMode").setPosition(623, 3).setSize(50, 20).setValue(true).setMode(ControlP5.SWITCH).setCaptionLabel("  3D           2D");

    // colors, line & stroke
    colorBackground = cp5.addColorWheel("Background").setPosition(3, 3).setValue(128);
    colorStroke = cp5.addColorWheel("Stroke").setPosition(209, 3).setValue(128);
    colorFill = cp5.addColorWheel("Fill").setPosition(415, 3).setValue(128);
    alphaStroke = cp5.addSlider("as").setPosition(209, 220).setSize(200, 10).setRange(0, 255).setValue(255).setCaptionLabel("alpha");   
    alphaFill = cp5.addSlider("af").setPosition(415, 220).setSize(200, 10).setRange(0, 255).setValue(255).setCaptionLabel("alpha");   
    fill = cp5.addToggle("fill").setPosition(623, 60).setSize(20, 20).setState(true);
    stroke = cp5.addToggle("stroke").setPosition(653, 60).setSize(20, 20).setState(false);
    lx = cp5.addSlider("LX").setPosition(623, 120).setSize(200, 10).setRange(0, 200).setCaptionLabel("Line Width");  
    ly = cp5.addSlider("LY").setPosition(623, 140).setSize(200, 10).setRange(0, 200).setCaptionLabel("Line Height"); 
    sw = cp5.addSlider("SW").setPosition(623, 160).setSize(200, 10).setRange(0, 200).setCaptionLabel("Stroke Weight");    
    cp5.getController("as").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("af").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("LX").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("LY").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("SW").getCaptionLabel().align(CENTER, CENTER);

    // gears
    int size2d = 150;
    int posy = 240;
    gear0 = cp5.addSlider2D("G0").setMinMax(-256, -256, 256, 256).setPosition(3, posy).setCaptionLabel("Radius Gear 0").setSize(size2d, size2d);
    gear1 = cp5.addSlider2D("G1").setMinMax(-256, -256, 256, 256).setPosition(158, posy).setCaptionLabel("Radius Gear 1").setSize(size2d, size2d);
    gear2 = cp5.addSlider2D("G2").setMinMax(-256, -256, 256, 256).setPosition(313, posy).setCaptionLabel("Radius Gear 2").setSize(size2d, size2d);
    gear3 = cp5.addSlider2D("G3").setMinMax(-256, -256, 256, 256).setPosition(468, posy).setCaptionLabel("Radius Gear 3").setSize(size2d, size2d);    
    gear0z = cp5.addSlider("G0z").setRange(-256, 256).setPosition(3, posy + size2d + 20).setSize(size2d, 10).setCaptionLabel("Gear 0 Z").show(); 
    gear1z = cp5.addSlider("G1z").setRange(-256, 256).setPosition(158, posy + size2d + 20).setSize(size2d, 10).setCaptionLabel("Gear 1 Z").show(); 
    gear2z = cp5.addSlider("G2z").setRange(-256, 256).setPosition(313, posy + size2d + 20).setSize(size2d, 10).setCaptionLabel("Gear 2 Z").show(); 
    gear3z = cp5.addSlider("G3z").setRange(-256, 256).setPosition(468, posy + size2d + 20).setSize(size2d, 10).setCaptionLabel("Gear 3 Z").show(); 
    petals1 = cp5.addSlider("p1").setPosition(623, posy).setSize(200, 10).setRange(0, 200).setCaptionLabel("Petals Gear 1"); 
    petals2 = cp5.addSlider("p2").setPosition(623, posy+15).setSize(200, 10).setRange(0, 200).setCaptionLabel("Petals Gear 2");
    petals3 = cp5.addSlider("p3").setPosition(623, posy+30).setSize(200, 10).setRange(0, 200).setCaptionLabel("Petals Gear 3");
    cp5.getController("G0z").getCaptionLabel().align(CENTER, BOTTOM);  
    cp5.getController("G1z").getCaptionLabel().align(CENTER, BOTTOM);
    cp5.getController("G2z").getCaptionLabel().align(CENTER, BOTTOM);
    cp5.getController("G3z").getCaptionLabel().align(CENTER, BOTTOM);
    cp5.getController("p1").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("p2").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("p3").getCaptionLabel().align(CENTER, CENTER);
    int poy = 0;
    int pox = 0;
    String [] trig = {"cos", "sin", "tan"};
    for (int i = 0; i < 4; i++) {
      trigX = cp5.addButtonBar("G" + i + "trigX").setPosition(623, 285 + poy).addItems(trig).setSize(120, 12);
      cp5.getController("G" + i + "trigX").addCallback(new CallbackListener() {
        public void controlEvent(CallbackEvent theEvent) { 
          if (theEvent.getAction()==ControlP5.ACTION_CLICK) {
            layers.get(id).trig.set(theEvent.getController().getName(), int(theEvent.getController().getValue()));
          }
        }
      }
      );
      trigY = cp5.addButtonBar("G" + i + "trigY").setPosition(623, 300  + poy).addItems(trig).setSize(120, 12);
      cp5.getController("G" + i + "trigY").addCallback(new CallbackListener() {
        public void controlEvent(CallbackEvent theEvent) { 
          if (theEvent.getAction()==ControlP5.ACTION_CLICK) {
            layers.get(id).trig.set(theEvent.getController().getName(), int(theEvent.getController().getValue()));
          }
        }
      }
      );

      trigZ = cp5.addButtonBar("G" + i + "trigZ").setPosition(3 + pox, 425).addItems(trig).setSize(120, 12);
      cp5.getController("G" + i + "trigZ").addCallback(new CallbackListener() {
        public void controlEvent(CallbackEvent theEvent) { 
          if (theEvent.getAction()==ControlP5.ACTION_CLICK) {
            layers.get(id).trig.set(theEvent.getController().getName(), int(theEvent.getController().getValue()));
          }
        }
      }
      );
      cp5.addTextlabel("g" + i + "x").setPosition(750, 287  + poy).setText("Gear"+ i + " X");
      cp5.addTextlabel("g" + i + "y").setPosition(750, 302 + poy).setText("Gear" + i +" Y");
      cp5.addTextlabel("g" + i + "z").setPosition(125 + pox, 426).setText("G" + i +" Z");
      poy = poy + 30;
      pox = pox + 155;
    }
  }

  void controlEvent(ControlEvent theEvent) {
    if (theEvent.getController().equals(gifNew)) {
      cp5.getGroup("ng").show();
    }
    if (theEvent.getController().equals(gifWidth)) {
      Width = int(gifWidth.getValue());
    }
    if (theEvent.getController().equals(gifHeight)) {
      Height = int(gifHeight.getValue());
    }
    if (theEvent.getController().equals(gifNewOK)) {
      cp5.getGroup("ng").hide();
    }
    if (theEvent.getController().equals(drawMode)) {
      layers.get(id).spheres3d = drawMode.getState();
      if (drawMode.getState() == true) {
        gear0z.show(); 
        gear1z.show(); 
        gear2z.show(); 
        gear3z.show();
      } else {
        gear0z.hide(); 
        gear1z.hide(); 
        gear2z.hide(); 
        gear3z.hide();
      }
    }    
    if (theEvent.getController().equals(colorBackground)) {
      BG = colorBackground.getRGB();
    }
    if (theEvent.getController().equals(colorStroke)  || theEvent.getController().equals(alphaStroke)) {
      layers.get(id).cStroke = color(colorStroke.r(), colorStroke.g(), colorStroke.b(), int(alphaStroke.getValue()));
    }
    if (theEvent.getController().equals(colorFill) || theEvent.getController().equals(alphaFill)) {
      layers.get(id).cFill = color(colorFill.r(), colorFill.g(), colorFill.b(), int(alphaFill.getValue()));
    }
    if (theEvent.getController().equals(stroke)) {
      layers.get(id).stroke = stroke.getState();
    }
    if (theEvent.getController().equals(fill)) {
      layers.get(id).fill = fill.getState();
    }
    if (theEvent.getController().equals(lx)) {
      layers.get(id).lx = lx.getValue();
    }
    if (theEvent.getController().equals(ly)) {
      layers.get(id).ly = ly.getValue();
    }
    if (theEvent.getController().equals(sw)) {
      layers.get(id).sw = sw.getValue();
    }
    if (theEvent.getController().equals(gear0)) {
      layers.get(id).gear0.RX = gear0.getArrayValue(0);
      layers.get(id).gear0.RY = gear0.getArrayValue(1);
    }
    if (theEvent.getController().equals(gear1)) {
      layers.get(id).gear1.RX = gear1.getArrayValue(0);
      layers.get(id).gear1.RY = gear1.getArrayValue(1);
    }
    if (theEvent.getController().equals(gear2)) {
      layers.get(id).gear2.RX = gear2.getArrayValue(0);
      layers.get(id).gear2.RY = gear2.getArrayValue(1);
    }
    if (theEvent.getController().equals(gear3)) {
      layers.get(id).gear3.RX = gear3.getArrayValue(0);
      layers.get(id).gear3.RY = gear3.getArrayValue(1);
    }
    if (theEvent.getController().equals(gear0z)) {
      layers.get(id).gear0.RZ = gear0z.getValue();
    }
    if (theEvent.getController().equals(gear1z)) {
      layers.get(id).gear1.RZ = gear1z.getValue();
    }
    if (theEvent.getController().equals(gear2z)) {
      layers.get(id).gear2.RZ = gear2z.getValue();
    }
    if (theEvent.getController().equals(gear3z)) {
      layers.get(id).gear3.RZ = gear3z.getValue();
    }
    if (theEvent.getController().equals(petals1)) {
      layers.get(id).gear1.P = petals1.getValue();
    }
    if (theEvent.getController().equals(petals2)) {
      layers.get(id).gear2.P = petals2.getValue();
    }
    if (theEvent.getController().equals(petals3)) {
      layers.get(id).gear3.P = petals3.getValue();
    }
  }

  //// new, copy, switch
  //LayerList = cp5.addScrollableList("SwitchLayers").setPosition(310, 390).setType(ScrollableList.DROPDOWN).setCaptionLabel("Layers").moveTo("global").setOpen(false);
  //for (int i = 0; i<layers.size(); i++) {
  //  LayerList.addItem("Layer" + (i+1), layers.get(i));
  //}
  //New = cp5.addButton("New Layer").setPosition(310, 350).setSize(60, 15).moveTo("global");
  //New.addCallback(new CallbackListener() {
  //  public void controlEvent(CallbackEvent theEvent) {
  //    if (theEvent.getAction() == ControlP5.ACTION_PRESS) {
  //      Layer New = new Layer();
  //      layers.add(New);
  //      LayerList.addItem("Layer" + layers.size(), New);
  //    }
  //  }
  //}
  //);
  //Copy = cp5.addButton("Copy Layer").setPosition(380, 350).setSize(60, 15).moveTo("global");
  //Copy.addCallback(new CallbackListener() {
  //  public void controlEvent(CallbackEvent theEvent) {
  //    if (theEvent.getAction() == ControlP5.ACTION_PRESS) {
  //      Layer New = new Layer();
  //      New.gear0.RX = layers.get(id).gear0.RX;
  //      New.gear0.RY = layers.get(id).gear0.RY;
  //      New.gear0.RZ = layers.get(id).gear0.RZ;
  //      New.gear1.RX = layers.get(id).gear1.RX;
  //      New.gear1.RY = layers.get(id).gear1.RY;
  //      New.gear1.RZ = layers.get(id).gear1.RZ;
  //      New.gear2.RX = layers.get(id).gear2.RX;
  //      New.gear2.RY = layers.get(id).gear2.RY;
  //      New.gear2.RZ = layers.get(id).gear2.RZ;
  //      New.gear3.RX = layers.get(id).gear3.RX;
  //      New.gear3.RY = layers.get(id).gear3.RY;
  //      New.gear3.RZ = layers.get(id).gear3.RZ;
  //      New.gear1.P = layers.get(id).gear1.P;
  //      New.gear2.P = layers.get(id).gear2.P;
  //      New.gear3.P = layers.get(id).gear3.P;
  //      New.LX = layers.get(id).LX;
  //      New.LY = layers.get(id).LY;
  //      New.Fill = layers.get(id).Fill;
  //      New.Stroke = layers.get(id).Stroke;
  //      New.lines = layers.get(id).lines;
  //      New.dots = layers.get(id).dots;
  //      New.PlotDots = layers.get(id).PlotDots;
  //      New.gear1.Connect = layers.get(id).gear1.Connect;
  //      New.gear2.Connect = layers.get(id).gear2.Connect;
  //      New.gear3.Connect = layers.get(id).gear3.Connect;
  //      New.spheres3d = layers.get(id).spheres3d;
  //      layers.add(New);
  //      LayerList.addItem("Copy " + (id+1), New);
  //    }
  //  }
  //}
  //);

  //// LAYERSTATES START HERE
  //// Controller object
  //Layer = cp5.getProperties();
  //Layer.remove(CS).remove(Pause).remove(cp).remove(cw).remove(Ani).remove(Copy).remove(New).remove(SaveAll).remove(Save);
  //// saves JSON for each layerstate
  //for (int i=0; i < gif.LayerStates; i++) {
  //  Layer.setSnapshot("LayerState" + i);
  //  Layer.saveAs(JSON + i);
  //}
  //// save functions
  //SaveAll = cp5.addButton("Save FWD").setPosition(120, 400).setSize(60, 15).moveTo("global");
  //SaveAll.addCallback(new CallbackListener() {
  //  public void controlEvent(CallbackEvent theEvent) {
  //    if (theEvent.getAction() == ControlP5.ACTION_PRESS) {
  //      int LS = int(LayerState.getValue());
  //      for (int i = LS; i < gif.LayerStates; i++) {
  //        Layer.setSnapshot("LayerState" + i);
  //        Layer.saveAs(JSON + i);
  //      }
  //    }
  //  }
  //}
  //);
  //Save = cp5.addButton("Save").setPosition(50, 400).setSize(60, 15).moveTo("global");
  //Save.addCallback(new CallbackListener() {
  //  public void controlEvent(CallbackEvent theEvent) {
  //    if (theEvent.getAction() == ControlP5.ACTION_PRESS) {
  //      int LS = int(LayerState.getValue());
  //      Layer.setSnapshot("LayerState" + LS);
  //      Layer.saveAs(JSON + LS);
  //      //LayerStateArray.set(LS, layers.get(0));
  //    }
  //  }
  //}
  //);
  ////button bar to toggle layerstates
  //LayerState = cp5.addButtonBar("ls").setPosition(10, 475).setSize(gif.MatrixWidth, gif.CellHeight);
  //String [] buttonL;
  //buttonL = new String[gif.LayerStates];
  //for (int i = 0; i < gif.LayerStates; i++) {       
  //  buttonL[i] = "LS" + (i+1);
  //}
  //LayerState.addItems(buttonL);
  //cp5.getController("ls").moveTo("global");
  //LayerState.addCallback(new CallbackListener() {
  //  public void controlEvent(CallbackEvent theEvent) {
  //    if (theEvent.getAction() == ControlP5.ACTION_CLICK) {
  //      int LS = int(LayerState.getValue());
  //      Layer.load(JSON + LS);
  //      //gif.LoadLayerState(ls);
  //      //set = int(LayerState.getValue());
  //      //SwitchLayers();
  //    }
  //  }
  //}
  //);

  //// ANIMATRIX TABS START HERE
  //// make tabs
  //cp5.getTab("default").setCaptionLabel("Matrix").setId(1);
  //cp5.addTab("Ani Easing");
  //cp5.getTab("Ani Easing").activateEvent(true).setId(2);
  //cp5.getTab("default").activateEvent(true);
  //cp5.getTab("Ani Easing");
  //cp5.getWindow().setPositionOfTabs(10, 450);
  //// ani easing tab
  //for (int x = 00; x< gif.LayerStates; x++) {
  //  for (int y = 1; y < gif.Variables; y++) {
  //    //println(x, y);
  //    Easing = cp5.addScrollableList("Easing"+"0"+x+"0"+y).setPosition(10 + (x*gif.CellWidth), 500 + (y*gif.CellHeight)).setWidth(gif.CellWidth).setHeight(100).setBarHeight(gif.CellHeight).setType(ScrollableList.DROPDOWN).close(); 
  //    Easing.addItems(EasingNames);
  //    cp5.getController("Easing"+"0"+x+"0"+y).setVisible(false);
  //    cp5.getController("Easing"+"0"+x+"0"+y).moveTo("Ani Easing");

  //    Increase = cp5.addButton("add"+"0"+x+"0"+y).setPosition((10+gif.CellWidth) + (x*gif.CellWidth), 500 + (y*gif.CellHeight)).setWidth(15).setCaptionLabel("+").setId(x);
  //    cp5.getController("add"+"0"+x+"0"+y).addCallback(new CallbackListener() {
  //      public void controlEvent(CallbackEvent theEvent) { 
  //        if (theEvent.getAction()==ControlP5.ACTION_CLICK) {        
  //          int x = theEvent.getController().getId();
  //          int y = (int(theEvent.getController().getPosition()[1]) - 500)/gif.CellHeight;        
  //          gif.AniEnd[x][y] = gif.AniEnd[x][y] + int(theEvent.getController().getValue());
  //          int interval = gif.AniEnd[x][y] - x; 
  //          //gif.AniInt[x][y] = interval;
  //          cp5.getController("Easing"+"0"+x+"0"+y).setWidth(gif.CellWidth + interval*gif.CellWidth);
  //          theEvent.getController().setPosition( ((10+gif.CellWidth) + (x*gif.CellWidth) + ((interval)*gif.CellWidth)), 500 + (y*gif.CellHeight));
  //          //println(gif.AniEnd[x][y],interval);
  //        }
  //      }
  //    }
  //    );
  //    Decrease = cp5.addButton("minus"+"0"+x+"0"+y).setPosition((x*gif.CellWidth)-5, 500 + (y*gif.CellHeight)).setWidth(15).setCaptionLabel("-").setId(x);
  //    cp5.getController("minus"+"0"+x+"0"+y).addCallback(new CallbackListener() {
  //      public void controlEvent(CallbackEvent theEvent) { 
  //        if (theEvent.getAction()==ControlP5.ACTION_CLICK) {        
  //          int x = theEvent.getController().getId();
  //          int y = (int(theEvent.getController().getPosition()[1]) - 500)/gif.CellHeight;        
  //          gif.AniEnd[x][y] = gif.AniEnd[x][y] - int(theEvent.getController().getValue());
  //          int interval = gif.AniEnd[x][y] - x;   
  //          //gif.AniInt[x][y] = interval;
  //          cp5.getController("Easing"+"0"+x+"0"+y).setWidth(gif.CellWidth + interval*gif.CellWidth);
  //          int tempx = int(cp5.getController("add"+"0"+x+"0"+y).getPosition()[0]);
  //          cp5.getController("add"+"0"+x+"0"+y).setPosition( (tempx - gif.CellWidth), 500 + (y*gif.CellHeight));
  //          //println(x, y,  gif.AniEnd[x][y],interval);
  //        }
  //      }
  //    }
  //    );
  //    cp5.getController("minus"+"0"+x+"0"+y).setVisible(false);
  //    cp5.getController("minus"+"0"+x+"0"+y).moveTo("Ani Easing");
  //    cp5.getController("add"+"0"+x+"0"+y).setVisible(false);
  //    cp5.getController("add"+"0"+x+"0"+y).moveTo("Ani Easing");
  //    Layer.remove(Increase, "add"+"0"+x+"0"+y); 
  //    Layer.remove(Decrease, "minus"+"0"+x+"0"+y);
  //    //Layer.remove(Easing, "Easing"+"0"+x+"0"+y);
  //  }
  //}
  //// actual matrix
  //Ani = cp5.addMatrix("Matrix").setPosition(10, 500).setSize(gif.MatrixWidth, gif.MatrixHeight). setGap(5, 5).setMode(ControlP5.MULTIPLES)
  //  .setInterval(gif.Interval).setGrid(gif.LayerStates, gif.Variables).set(0, 0, true).stop();
  //// aaand some labels
  //for (int i = 0; i < Labels.length; i++) {
  //  Label =  cp5.addTextlabel("Label" + i).setPosition(gif.MatrixWidth + 10, 505 + (gif.CellHeight*i)).setText(Labels[i]).moveTo("global");
  //  Layer.remove(Label, "Label" + i);
  //}
  //}

  void draw() {
    background(190);
  }

  //void keyPressed() {
  //  if (key==' ') {     
  //    if (play == false) {
  //      gif.triggerArray();
  //      cp5.get(Matrix.class, "Matrix").play();
  //      cp5.get(Matrix.class, "Matrix").trigger(0);
  //      play = true;
  //    } else {
  //      cp5.get(Matrix.class, "Matrix").pause();
  //      play = false;
  //    }
  //    gui.cp5.get(Toggle.class, "Play/Pause").setState(play);
  //  }
  //  if (key == 'q') { 
  //    Layer.load(JSON+0);
  //    gif.triggerArray();
  //    cp5.get(Matrix.class, "Matrix").stop();
  //    if (play == true) {
  //      gif.triggerArray();
  //      cp5.get(Matrix.class, "Matrix").play();
  //    }
  //  }
  //}

  //void Matrix(int theX, int theY) {
  //  gif.aniStart(theX, theY);
  //  if (theX == 0) {
  //    Layer.load(JSON+0);
  //  }
  //}

  //void controlEvent(ControlEvent theControlEvent) {
  //  if (theControlEvent.isTab()) {
  //    gif.tabToggle();
  //  }
  //}


  //void SwitchLayers() {
  //  if (id != int(LayerList.getValue())) {
  //    layerlock = true;
  //    set = int(LayerList.getValue());
  //    G0.remove();
  //    G1.remove();
  //    G2.remove();
  //    G3.remove();
  //    G0 = cp5.addSlider2D("Radius Gear 0").setMinMax(0, 0, 512, 512).setPosition(10, 90).setCaptionLabel("Radius Gear 0").plugTo(this, "Controls").setValue(map(layers.get(set).gear0.RX, -256, 256, 0, 512), map(layers.get(set).gear0.RY, -256, 256, 0, 512));
  //    cp5.getController("Radius Gear 0").moveTo("global");
  //    G1 = cp5.addSlider2D("Radius Gear1").setMinMax(0, 0, 256, 256).setPosition(160, 90).setCaptionLabel("Radius Gear 1").plugTo(this, "Controls").setValue(map(layers.get(set).gear1.RX, -128, 128, 0, 256), map(layers.get(set).gear1.RY, -128, 128, 0, 256));
  //    cp5.getController("Radius Gear1").moveTo("global");
  //    G2 = cp5.addSlider2D("Radius Gear2").setMinMax(0, 0, 256, 256).setPosition(10, 230).setCaptionLabel("Radius Gear 2").plugTo(this, "Controls").setValue(map(layers.get(set).gear2.RX, -128, 128, 0, 256), map(layers.get(set).gear2.RY, -128, 128, 0, 256));
  //    cp5.getController("Radius Gear2").moveTo("global");
  //    G3 = cp5.addSlider2D("Radius Gear3").setMinMax(0, 0, 256, 256).setPosition(160, 230).setCaptionLabel("Radius Gear 3").plugTo(this, "Controls").setValue(map(layers.get(set).gear3.RX, -128, 128, 0, 256), map(layers.get(set).gear3.RY, -128, 128, 0, 256));
  //    cp5.getController("Radius Gear3").moveTo("global");   
  //    P1.setValue(layers.get(set).gear1.P);
  //    P2.setValue(layers.get(set).gear2.P);
  //    P3.setValue(layers.get(set).gear3.P);
  //    LX.setValue(layers.get(set).LX);
  //    LY.setValue(layers.get(set).LY);
  //    Fill.setState(layers.get(set).fill);
  //    Stroke.setState(layers.get(set).stroke);
  //    SW.setValue(layers.get(set).SW);
  //    Lines.setState(layers.get(set).lines);
  //    Dots.setState(layers.get(set).dots);
  //    D.setValue(layers.get(set).PlotDots);
  //    G1c.setValue(layers.get(set).gear1.Connect);
  //    G2c.setValue(layers.get(set).gear2.Connect);
  //    G3c.setValue(layers.get(set).gear3.Connect);
  //    if (CS.getState() == false) {
  //      cp.setColorValue(layers.get(set).Fill);
  //    }
  //    if (CS.getState() == true) {
  //      cp.setColorValue(layers.get(set).Stroke);
  //    }
  //    layerlock = false;
  //    id = int(LayerList.getValue());
  //  }
  //}
}