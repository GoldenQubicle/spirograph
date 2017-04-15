class GUI extends PApplet { //<>//
  PApplet parent;
  ControlP5 cp5;
  int layerID;
  boolean layerlock = false;
  Matrix Ani;
  ColorWheel colorBackground, colorStroke, colorFill;
  Toggle stroke, fill, drawMode, keyFrameAll, keyFrameFWD;
  ScrollableList layerSwitch, blendMode, fileSelect, Easing;
  Slider2D gear0, gear1, gear2, gear3;
  Slider gifWidth, gifHeight, gifLength, gifKeyFrames, lx, ly, sw, gear0z, gear1z, gear2z, gear3z, petals0, petals1, petals2, petals3, alphaFill, alphaStroke, G0r, G1r, G2r, G3r, density, g0c, g1c, g2c, g3c; 
  Button gifSettings, gifSave, Load, Save, layerNew, layerCopy, layerDelete, Increase, Decrease, saveFWD;
  ArrayList <Button> menuGifLayer = new ArrayList<Button>();
  RadioButton trigX, trigY, densityRanges, keyFrames;
  ArrayList <RadioButton> trigSwitch = new ArrayList<RadioButton>();

  // using int variables to strip decimals for gui aethetic
  int LX, LY, SW, GW, GH, ms, i, p0, p1, p2, p3, as, af, g0r, g1r, g2r, g3r, d, g0C, g1C, g2C, g3C; 
  float densityRangeMin = 1;
  float densityRangeMax = 1000;
  Textfield fileName, g0x, g0y;
  Textlabel trig, Label;
  Textarea renderMessage;
  String [] labelsAniMatrix = {"Gear 0 X", "Gear 0 Y", "Gear 0 Petals", "Gear 0 Rotate", 
    "Gear 1 X", "Gear 1 Y", "Gear 1 Petals", "Gear 1 Rotate", 
    "Gear 2 X", "Gear 2 Y", "Gear 2 Petals", "Gear 2 Rotate", 
    "Gear 3 X", "Gear 3 Y", "Gear 3 Petals", "Gear 3 Rotate", 
    "line X", "line Y", "StrokeWeight", "color Fill", "color Stroke"};
  String[] EasingNames = {"LINEAR", "QUAD_IN", "QUAD_OUT", "QUAD_IN_OUT", "CUBIC_IN", "CUBIC_IN_OUT", "CUBIC_OUT", "QUART_IN", "QUART_OUT", "QUART_IN_OUT", "QUINT_IN", "QUINT_OUT", "QUINT_IN_OUT", "SINE_IN", "SINE_OUT", "SINE_IN_OUT", "CIRC_IN", "CIRC_OUT", "CIRC_IN_OUT", "EXPO_IN", "EXPO_OUT", "EXPO_IN_OUT", "BACK_IN", "BACK_OUT", "BACK_IN_OUT", "BOUNCE_IN", "BOUNCE_OUT", "BOUNCE_IN_OUT", "ELASTIC_IN", "ELASTIC_OUT", "ELASTIC_IN_OUT"};
  String [] blendModes = {"Normal", "Add", "Subtract", "Darkest", "Lightest", "Exclusion", "Multiply", "Screen", "Replace"};

  public GUI(PApplet theApplet) {
    super();
    parent = theApplet;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(860, 980);
  } 

  public void setup() {
    layerID = 0;
    cp5 = new ControlP5(this);
    int rPanex = 630;
    int rPaneyMenu = 3;
    // gif & layer menu
    gifSettings = cp5.addButton("gifSettings").setPosition(rPanex+150, rPaneyMenu).setCaptionLabel("Settings").setId(0).moveTo("global");
    Save = cp5.addButton("Save").setPosition(rPanex+150, rPaneyMenu+25).setCaptionLabel("Save").setId(1).moveTo("global");
    Load = cp5.addButton("Load").setPosition(rPanex+150, rPaneyMenu+50).setCaptionLabel("Load").setId(2).moveTo("global");
    cp5.addGroup("fs").setPosition(rPanex, 15).setSize(220, 135).setBackgroundColor(color(255)).setBarHeight(15).setCaptionLabel("Load File").disableCollapse().setBackgroundColor(0).hide().moveTo("global");
    fileSelect = cp5.addScrollableList("fileSelect").setPosition(15, 15).setSize(180, 85).setGroup("fs");
    fileSelect.addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent theEvent) {
        if (theEvent.getAction()==ControlP5.ACTION_CLICK) {
          controller.menuGifLayer(7);
          fileSelect.hide();
          fileSelect.clear();
        }
      }
    }
    );
    //settings menu
    cp5.addGroup("ng").setPosition(rPanex, 15).setSize(220, 135).setBackgroundColor(color(255)).setBarHeight(15).setCaptionLabel("GIF setting").disableCollapse().setBackgroundColor(0).hide().moveTo("global");
    gifWidth = cp5.addSlider("GW").setPosition(10, 10).setRange(200, 1920).setGroup("ng").setCaptionLabel("Width");
    gifHeight = cp5.addSlider("GH").setPosition(10, 25).setRange(200, 1920).setGroup("ng").setCaptionLabel("Height");
    gifLength = cp5.addSlider("ms").setPosition(10, 40).setRange(1000, 10000).setGroup("ng").setCaptionLabel("Duration (ms)");
    gifKeyFrames = cp5.addSlider("i").setPosition(10, 55).setRange(2, 20).setNumberOfTickMarks(19).snapToTickMarks(true).setGroup("ng").setCaptionLabel("Key Frames");
    gifSave = cp5.addButton("gifSave").setPosition(90, 80).setGroup("ng").setCaptionLabel("Save").setId(3);
    fileName = cp5.addTextfield("fileName").setPosition(10, 80).setGroup("ng").setSize(75, 20).setText(controller.fileio.fileName);
    // layer controls
    layerNew = cp5.addButton("layerNew").setPosition(rPanex + 75, rPaneyMenu).setCaptionLabel("New Layer").setId(4).moveTo("global");
    layerCopy = cp5.addButton("layerCopy").setPosition(rPanex + 75, rPaneyMenu+25).setCaptionLabel("Copy Layer").setId(5).moveTo("global");
    layerDelete = cp5.addButton("layerDelete").setPosition(rPanex + 75, rPaneyMenu+50).setCaptionLabel("Delete Layer").setId(6).moveTo("global");
    layerSwitch = cp5.addScrollableList("SwitchLayers").setPosition(rPanex+75, 80).setWidth(145).setType(ScrollableList.DROPDOWN).setCaptionLabel("Layers").setOpen(false).moveTo("global");
    for (int i =0; i < gif.nLayers; i++) {
      layerSwitch.addItem(layerActive.get(i).name, layerActive.get(i));
    }
    layerSwitch.addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent theEvent) {
        if (theEvent.getAction()==ControlP5.ACTIVE) {
          layerSwitch.bringToFront();
        }
      }
    }
    );
    // add callbacks
    menuGifLayer.add(cp5.get(Button.class, "gifSettings"));
    menuGifLayer.add(cp5.get(Button.class, "Save"));
    menuGifLayer.add(cp5.get(Button.class, "Load"));
    menuGifLayer.add(cp5.get(Button.class, "gifSave"));
    menuGifLayer.add(cp5.get(Button.class, "layerNew"));
    menuGifLayer.add(cp5.get(Button.class, "layerCopy"));
    menuGifLayer.add(cp5.get(Button.class, "layerDelete"));
    for (int i =0; i < menuGifLayer.size(); i++) {
      menuGifLayer.get(i).addCallback(new CallbackListener() {
        public void controlEvent(CallbackEvent theEvent) { 
          if (theEvent.getAction()==ControlP5.ACTION_CLICK) {
            controller.menuGifLayer(theEvent.getController().getId());
          }
        }
      }
      );
    }
    // colors, line & stroke
    drawMode = cp5.addToggle("drawMode").setPosition(rPanex, 3).setSize(50, 20).setValue(false).setMode(ControlP5.SWITCH).setCaptionLabel("lines   spiro").moveTo("global");
    colorBackground = cp5.addColorWheel("Background").setPosition(3, 3).setValue(128).moveTo("global");
    colorStroke = cp5.addColorWheel("Stroke").setPosition(209, 3).setValue(128).moveTo("global");
    colorFill = cp5.addColorWheel("Fill").setPosition(415, 3).setValue(128).moveTo("global");
    alphaStroke = cp5.addSlider("as").setPosition(209, 220).setSize(200, 10).setRange(0, 255).setValue(255).setCaptionLabel("alpha").moveTo("global");   
    alphaFill = cp5.addSlider("af").setPosition(415, 220).setSize(200, 10).setRange(0, 255).setValue(255).setCaptionLabel("alpha").moveTo("global");   
    fill = cp5.addToggle("fill").setPosition(rPanex, 40).setSize(20, 20).setState(true).moveTo("global");
    stroke = cp5.addToggle("stroke").setPosition(rPanex+30, 40).setSize(20, 20).setState(false).moveTo("global").moveTo("global");
    lx = cp5.addSlider("LX").setPosition(rPanex, 100).setSize(200, 10).setRange(0, 200).setCaptionLabel("Line Width").moveTo("global");  
    ly = cp5.addSlider("LY").setPosition(rPanex, 115).setSize(200, 10).setRange(0, 200).setCaptionLabel("Line Height").moveTo("global"); 
    sw = cp5.addSlider("SW").setPosition(rPanex, 130).setSize(200, 10).setRange(0, 200).setCaptionLabel("Stroke Weight").moveTo("global");    
    blendMode = cp5.addScrollableList("blendMode").setPosition(rPanex, 80).setWidth(70).setType(ScrollableList.DROPDOWN).setCaptionLabel("blendMode").setOpen(false).addItems(blendModes).moveTo("global");
    cp5.getController("as").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("af").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("LX").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("LY").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("SW").getCaptionLabel().align(CENTER, CENTER);
    // density  
    densityRanges = cp5.addRadioButton("density").setPosition(3, 425).setSize(61, 20).setItemsPerRow(10).addItem("1-10k", 1).addItem("10k-20k", 2).addItem("20k-30k", 3).addItem("30k-40k", 4)
      .addItem("40k-50k", 5).addItem("50k-60k", 6).addItem("60k-70k", 7).addItem("70k-80k", 8).addItem("80k-90k", 9).addItem("90k-100k", 10).moveTo("global");
    for (int i =0; i < 10; i++) {
      densityRanges.getItem(i).getCaptionLabel().align(CENTER, CENTER);
    }
    density = cp5.addSlider("d").setPosition(3, 450).setSize(615, 20).setRange(densityRangeMin, densityRangeMax).setCaptionLabel("Density").setNumberOfTickMarks(101).showTickMarks(true).snapToTickMarks(true).moveTo("global"); 
    density.getCaptionLabel().align(CENTER, CENTER);

    // gears
    int size2d = 150;
    int posy = 240;
    int posx = 3;
    gear0 = cp5.addSlider2D("G0").setMinMax(-256, -256, 256, 256).setPosition(posx, posy).setCaptionLabel("Radius Gear 0").setSize(size2d, size2d).moveTo("global");//.setValue(layers.get(id).gear0.RX, layers.get(id).gear0.RY);
    gear1 = cp5.addSlider2D("G1").setMinMax(-256, -256, 256, 256).setPosition(posx+155, posy).setCaptionLabel("Radius Gear 1").setSize(size2d, size2d).moveTo("global");//.setValue(layers.get(id).gear1.RX, layers.get(id).gear1.RY);
    gear2 = cp5.addSlider2D("G2").setMinMax(-256, -256, 256, 256).setPosition(posx+(155*2), posy).setCaptionLabel("Radius Gear 2").setSize(size2d, size2d).moveTo("global");//.setValue(layers.get(id).gear2.RX, layers.get(id).gear2.RY);
    gear3 = cp5.addSlider2D("G3").setMinMax(-256, -256, 256, 256).setPosition(posx+(155*3), posy).setCaptionLabel("Radius Gear 3").setSize(size2d, size2d).moveTo("global");//.setValue(layers.get(id).gear3.RX, layers.get(id).gear3.RY);    

    g0x = cp5.addTextfield("G0x").setPosition(posx, posy+165).setSize(60, 15).setText(str(gear0.getArrayValue(0))).moveTo("global");
    g0y = cp5.addTextfield("G0y").setPosition(posx+70, posy+165).setSize(60, 15).setText(str(gear0.getArrayValue(1))).moveTo("global");

    petals0 = cp5.addSlider("p0").setPosition(rPanex, posy-15).setSize(200, 10).setRange(0, 200).setCaptionLabel("Gear 0 Petals").moveTo("global"); 
    petals1 = cp5.addSlider("p1").setPosition(rPanex, posy).setSize(200, 10).setRange(0, 200).setCaptionLabel("Gear 1 Petals").moveTo("global"); 
    petals2 = cp5.addSlider("p2").setPosition(rPanex, posy+15).setSize(200, 10).setRange(0, 200).setCaptionLabel("Gear 2 Petals").moveTo("global");
    petals3 = cp5.addSlider("p3").setPosition(rPanex, posy+30).setSize(200, 10).setRange(0, 200).setCaptionLabel("Gear 3 Petals").moveTo("global"); 
    g0c = cp5.addSlider("g0C").setPosition(rPanex, posy-75).setSize(200, 10).setRange(0, 200).setCaptionLabel("Gear 0 Connect").moveTo("global"); 
    g1c = cp5.addSlider("g1C").setPosition(rPanex, posy-60).setSize(200, 10).setRange(0, 200).setCaptionLabel("Gear 1 Connect").moveTo("global"); 
    g2c = cp5.addSlider("g2C").setPosition(rPanex, posy-45).setSize(200, 10).setRange(0, 200).setCaptionLabel("Gear 2 Connect").moveTo("global"); 
    g3c = cp5.addSlider("g3C").setPosition(rPanex, posy-30).setSize(200, 10).setRange(0, 200).setCaptionLabel("Gear 3 Connect").moveTo("global"); 
    G0r = cp5.addSlider("g0r").setPosition(rPanex, posy+45).setSize(200, 10).setRange(-TAU, TAU).setNumberOfTickMarks(9).snapToTickMarks(true).setCaptionLabel("Gear 0 Rotate").moveTo("global"); 
    G1r = cp5.addSlider("g1r").setPosition(rPanex, posy+60).setSize(200, 10).setRange(-TAU, TAU).setNumberOfTickMarks(9).snapToTickMarks(true).setCaptionLabel("Gear 1 Rotate").moveTo("global"); 
    G2r = cp5.addSlider("g2r").setPosition(rPanex, posy+75).setSize(200, 10).setRange(-TAU, TAU).setNumberOfTickMarks(9).snapToTickMarks(true).setCaptionLabel("Gear 2 Rotate").moveTo("global");
    G3r = cp5.addSlider("g3r").setPosition(rPanex, posy+90).setSize(200, 10).setRange(-TAU, TAU).setNumberOfTickMarks(9).snapToTickMarks(true).setCaptionLabel("Gear 3 Rotate").moveTo("global"); 
    cp5.getController("p0").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("p1").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("p2").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("p3").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("g0r").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("g1r").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("g2r").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("g3r").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("g0C").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("g1C").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("g2C").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("g3C").getCaptionLabel().align(CENTER, CENTER);

    // cos sin tan Switches    
    int poy = 0;
    int pox = 0;
    String [] trig = {"cos", "sin", "tan"};
    for (int i = 0; i < 4; i++) {
      trigX = cp5.addRadioButton("G" + i + "trigX").setPosition(rPanex, 352 + poy).setSize(40, 12).setItemsPerRow(3).addItem(trig[0]+" g"+i+"x", 0).addItem(trig[1]+" g"+i+"x", 1).addItem(trig[2]+" g"+i+"x", 2).activate(0).moveTo("global");
      trigY = cp5.addRadioButton("G" + i + "trigY").setPosition(rPanex, 367  + poy).setSize(40, 12).setItemsPerRow(3).addItem(trig[0]+" g"+i+"y", 0).addItem(trig[1]+" g"+i+"y", 1).addItem(trig[2]+" g"+i+"y", 2).activate(1).moveTo("global");
      for (int c = 0; c < 3; c++) {
        trigX.getItem(c).getCaptionLabel().set(trig[c]).align(CENTER, CENTER); 
        trigY.getItem(c).getCaptionLabel().set(trig[c]).align(CENTER, CENTER);
      }
      trigSwitch.add(cp5.get(RadioButton.class, "G" + i + "trigX"));
      trigSwitch.add(cp5.get(RadioButton.class, "G" + i + "trigY"));
      cp5.addTextlabel("g" + i + "x").setPosition(rPanex+128, 354  + poy).setText("Gear"+ i + " X").moveTo("global");
      cp5.addTextlabel("g" + i + "y").setPosition(rPanex+128, 369 + poy).setText("Gear" + i +" Y").moveTo("global");
      poy = poy + 30;
      pox = pox + 155;
    }
    //radio button bar to toggle keyFrames
    keyFrames = cp5.addRadioButton("kf").setPosition(3, 500).setSize((gif.matrixWidth/gif.keyFrames), 20).setItemsPerRow(gif.keyFrames).moveTo("global");
    for (int i = 0; i < gif.keyFrames; i++) {       
      keyFrames.addItem("KF" + (i+1), i);
      keyFrames.getItem(i).getCaptionLabel().set("KF" + (i+1)).align(CENTER, CENTER);
    }
    keyFrames.activate(0);
    saveFWD = cp5.addButton("saveFWD").setPosition(199, 480).setSize(50, 16).moveTo("global");
    keyFrameFWD = cp5.addToggle("KFfwd").setPosition(95, 480).setSize(50, 16).moveTo("global");
    keyFrameAll = cp5.addToggle("KFall").setPosition(147, 480).setSize(50, 16).moveTo("global");
    cp5.getController("KFfwd").getCaptionLabel().align(CENTER, CENTER);  
    cp5.getController("KFall").getCaptionLabel().align(CENTER, CENTER);  

    // ANIMATRIX TABS START HERE
    // make tabs
    cp5.getTab("default").setCaptionLabel("Matrix").setId(1);
    cp5.getTab("default").activateEvent(true);
    cp5.addTab("Ani Easing");
    cp5.getTab("Ani Easing").activateEvent(true).setId(2);
    cp5.getWindow().setPositionOfTabs(10, 480);
    //  labels
    for (int i = 0; i < labelsAniMatrix.length; i++) {
      Label =  cp5.addTextlabel("Label" + i).setPosition(gif.matrixWidth + 10, 530 + (gif.cellHeight*i)).setText(labelsAniMatrix[i]).moveTo("global");
    }
    // actual matrix    
    Ani = cp5.addMatrix("Matrix").setPosition(3, 525).setSize(gif.matrixWidth, gif.matrixHeight).setGap(2, 2).setMode(ControlP5.MULTIPLES)
      .setInterval(gif.aniMatrixTiming).setGrid(gif.keyFrames, gif.layerVars).stop(); 
    Ani.addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent theEvent) { 
        if (theEvent.getAction()==ControlP5.ACTION_CLICK) {
          for (int f = 0; f < gif.keyFrames; f++) {
            for (int v = 0; v < gif.layerVars; v++) {
              if (Ani.get(f, v) == true && layerlock == false) {
                gif.layerAniStart.get(int(layerSwitch.getValue()))[f][v] = true;
              } else {
                gif.layerAniStart.get(int(layerSwitch.getValue()))[f][v] = false;
              }
            }
          }
        }
      }
    }
    );
    //easing tab
    for (int x = 0; x< gif.keyFrames; x++) {
      for (int y = 0; y < gif.layerVars; y++) {
        Easing = cp5.addScrollableList("Easing"+"0"+x+"0"+y).setPosition(10 + (x*gif.cellWidth), 525 + (y*gif.cellHeight)).setWidth(gif.cellWidth).setHeight(100).setBarHeight(gif.cellHeight).setType(ScrollableList.DROPDOWN).close(); 
        Easing.addItems(EasingNames);
        cp5.getController("Easing"+"0"+x+"0"+y).setVisible(false);
        cp5.getController("Easing"+"0"+x+"0"+y).moveTo("Ani Easing");
        Increase = cp5.addButton("add"+"0"+x+"0"+y).setPosition((10+gif.cellWidth) + (x*gif.cellWidth), 525 + (y*gif.cellHeight)).setWidth(15).setCaptionLabel("+").setId(x);
        Decrease = cp5.addButton("minus"+"0"+x+"0"+y).setPosition((x*gif.cellWidth)-5, 525 + (y*gif.cellHeight)).setWidth(15).setCaptionLabel("-").setId(x);
        cp5.getController("minus"+"0"+x+"0"+y).setVisible(false);
        cp5.getController("minus"+"0"+x+"0"+y).moveTo("Ani Easing");
        cp5.getController("add"+"0"+x+"0"+y).setVisible(false);
        cp5.getController("add"+"0"+x+"0"+y).moveTo("Ani Easing");
      }
    }
    renderMessage = cp5.addTextarea("message").setPosition(600, 480).setSize(200, 20).setText("");
  }

  void controlEvent(ControlEvent theEvent) {
    if (theEvent.isTab()) {
      gif.tabToggle();
    }
    for (RadioButton R : trigSwitch) {
      if (theEvent.isFrom(R) && layerlock == false) {
        layerActive.get(layerID).trig.set(R.getName(), int(R.getValue()));
      }
    }
    if (theEvent.isFrom(densityRanges) && layerlock == false) {
      densityRangeMax = densityRanges.getValue()* 10000;
      densityRangeMin = densityRangeMax - 10000;
      density.setRange(densityRangeMin, densityRangeMax);
      density.getCaptionLabel().align(CENTER, CENTER);
    }
    if (theEvent.isFrom(keyFrames)) {  
      int frame = int(keyFrames.getValue());
      controller.toggleKeyFrames(frame);
    }
    if (theEvent.getController().equals(saveFWD)) {
      int frame = int(keyFrames.getValue());
      for (int f = frame; f < (gif.keyFrames); f++) {
        int keyFrame = f + (int(gui.layerSwitch.getValue())*gif.keyFrames);
        Layer New = new Layer(10);
        layerKeyFrames.set(keyFrame, controller.copyLayerSettings(New, 1, frame+(int(layerSwitch.getValue())*gif.keyFrames)));
      }
    }
    for (int x = 0; x < gif.keyFrames; x++) {
      for (int y = 0; y < gif.layerVars; y++) {
        if (theEvent.getController().getName().equals("Easing"+"0"+x+"0"+y)) {
          gif.layerAniEasing.get(int(layerSwitch.getValue()))[x][y] = int(theEvent.getController().getValue());
        }
        if (theEvent.getController().getName().equals("add"+"0"+x+"0"+y)) {   
          gif.layerAniEnd.get(int(layerSwitch.getValue()))[x][y] += int(theEvent.getController().getValue());
          int interval =   gif.layerAniEnd.get(int(layerSwitch.getValue()))[x][y]  - x; 
          gif.layerAniInt.get(int(layerSwitch.getValue()))[x][y] = interval;
          cp5.getController("Easing"+"0"+x+"0"+y).setWidth(gif.cellWidth + interval*gif.cellWidth);
          theEvent.getController().setPosition( ((10+gif.cellWidth) + (x*gif.cellWidth) + ((interval)*gif.cellWidth)), 525 + (y*gif.cellHeight));
        }
        if (theEvent.getController().getName().equals("minus"+"0"+x+"0"+y)) {
          gif.layerAniEnd.get(int(layerSwitch.getValue()))[x][y] -= int(theEvent.getController().getValue());
          int interval =   gif.layerAniEnd.get(int(layerSwitch.getValue()))[x][y] - x;   
          gif.layerAniInt.get(int(layerSwitch.getValue()))[x][y]= interval;
          cp5.getController("Easing"+"0"+x+"0"+y).setWidth(gif.cellWidth + interval*gif.cellWidth);
          int tempx = int(cp5.getController("add"+"0"+x+"0"+y).getPosition()[0]);
          cp5.getController("add"+"0"+x+"0"+y).setPosition( (tempx - gif.cellWidth), 525 + (y*gif.cellHeight));
        }
      }
    }
    if (theEvent.getController().equals(gifWidth)) {
      Width = int(gifWidth.getValue());
    }
    if (theEvent.getController().equals(gifHeight)) {
      Height = int(gifHeight.getValue());
    }
    if (theEvent.getController().equals(gifLength)) {
      gif.totalTime = gifLength.getValue();
    }
    if (theEvent.getController().equals(gifKeyFrames)) {
      gif.keyFrames = int(gifKeyFrames.getValue());
    }
    if (theEvent.getController().equals(colorBackground)) {
      cBackground = colorBackground.getRGB();
    }

    // layer controls start here
    if (layerlock == false) {
      // set selection of keyFrames worked upon
      float range = 0; 
      float start = 0;
      if (keyFrameFWD.getState() == true) {
        range = gif.keyFrames - keyFrames.getValue();
        start = keyFrames.getValue()+((layerSwitch.getValue())*gif.keyFrames);
      }
      if (keyFrameAll.getState() == true) {
        range = gif.keyFrames;
        start = layerSwitch.getValue()*gif.keyFrames;
      } 


      // new gear controllers to be integrated
      g0x.setText(str(layerActive.get(layerID).gears[0].rX));
      g0y.setText(str(layerActive.get(layerID).gears[0].rY));

      if (theEvent.getController().equals(g0x)) {
        layerActive.get(layerID).gears[0].rX = float(g0x.getStringValue());
        layerlock = true;
        controller.updateLayerGUI(0, layerID);
      }
      
        // gear controllers
        for (int g = 0; g < 4; g++) {
          if (theEvent.getController().getName().equals("G" + g)) {
            layerActive.get(layerID).gears[g].rX = theEvent.getController().getArrayValue(0);
            layerActive.get(layerID).gears[g].rY = theEvent.getController().getArrayValue(1);
            if (keyFrameFWD.getState() == true || keyFrameAll.getState() == true) {
              for (int i = 0; i < range; i++) {         
                layerKeyFrames.get(int(start+i)).gears[g].rX = theEvent.getController().getArrayValue(0);
                layerKeyFrames.get(int(start+i)).gears[g].rY = theEvent.getController().getArrayValue(1);
              }
            }
          }
          if (theEvent.getController().getName().equals("p" + g)) {
            layerActive.get(layerID).gears[g].petals = int(theEvent.getController().getValue());
            if (keyFrameFWD.getState() == true || keyFrameAll.getState() == true) {
              for (int i = 0; i < range; i++) {  
                layerKeyFrames.get(int(start+i)).gears[g].petals = int(theEvent.getController().getValue());
              }
            }
          }
          if (theEvent.getController().getName().equals("g" + g + "C")) {
            layerActive.get(layerID).gears[g].connect = theEvent.getController().getValue();
            if (keyFrameFWD.getState() == true || keyFrameAll.getState() == true) {
              for (int i = 0; i < range; i++) {  
                layerKeyFrames.get(int(start+i)).gears[g].connect = int(theEvent.getController().getValue());
              }
            }
          }
          if (theEvent.getController().getName().equals("g" + g + "r")) {
            layerActive.get(layerID).gears[g].rotate = theEvent.getController().getValue();   
            if (keyFrameFWD.getState() == true || keyFrameAll.getState() == true) {
              for (int i = 0; i < range; i++) {                
                layerKeyFrames.get(int(start+i)).gears[g].rotate  = theEvent.getController().getValue();
              }
            }
          }
          if (theEvent.getController().getName().equals("G"+g+"z")) {
            layerActive.get(layerID).gears[g].rZ = theEvent.getController().getValue();
            if (keyFrameFWD.getState() == true || keyFrameAll.getState() == true) {
              for (int i = 0; i < range; i++) {  
                layerKeyFrames.get(int(start+i)).gears[g].rZ  = theEvent.getController().getValue();
              }
            }
          }
        }
        if (theEvent.getController().equals(density)) {
          layerActive.get(layerID).density = int(density.getValue());
          if (keyFrameFWD.getState() == true || keyFrameAll.getState() == true) {
            for (int i = 0; i < range; i++) {  
              layerKeyFrames.get(int(start+i)).density  = int(density.getValue());
            }
          }
        }
        if (theEvent.getController().equals(blendMode)) {
          layerActive.get(layerID).blendSelect = int(blendMode.getValue());
          if (keyFrameFWD.getState() == true || keyFrameAll.getState() == true) {
            for (int i = 0; i < range; i++) {  
              layerKeyFrames.get(int(start+i)).blendSelect  = int(theEvent.getController().getValue());
            }
          }
        }
        if (theEvent.getController().equals(colorStroke)  || theEvent.getController().equals(alphaStroke)) {
          layerActive.get(layerID).strokeR = colorStroke.r();
          layerActive.get(layerID).strokeG = colorStroke.g();
          layerActive.get(layerID).strokeB = colorStroke.b();
          layerActive.get(layerID).strokeA = alphaStroke.getValue();
          layerActive.get(layerID).cStroke = color(layerActive.get(layerID).strokeR, layerActive.get(layerID).strokeG, layerActive.get(layerID).strokeB, layerActive.get(layerID).strokeA);
          if (keyFrameFWD.getState() == true || keyFrameAll.getState() == true) {
            for (int i = 0; i < range; i++) {  
              layerKeyFrames.get(int(start+i)).strokeR = colorStroke.r();
              layerKeyFrames.get(int(start+i)).strokeG = colorStroke.g();
              layerKeyFrames.get(int(start+i)).strokeB = colorStroke.b();
              layerKeyFrames.get(int(start+i)).strokeA = alphaStroke.getValue();
            }
          }
        }
        if (theEvent.getController().equals(colorFill) || theEvent.getController().equals(alphaFill)) {
          layerActive.get(layerID).fillR = colorFill.r();
          layerActive.get(layerID).fillG = colorFill.g();
          layerActive.get(layerID).fillB = colorFill.b();
          layerActive.get(layerID).fillA = alphaFill.getValue();
          layerActive.get(layerID).cFill = color(layerActive.get(layerID).fillR, layerActive.get(layerID).fillG, layerActive.get(layerID).fillB, layerActive.get(layerID).fillA);
          if (keyFrameFWD.getState() == true || keyFrameAll.getState() == true) {
            for (int i = 0; i < range; i++) { 
              layerKeyFrames.get(int(start+i)).fillR = colorFill.r();
              layerKeyFrames.get(int(start+i)).fillG = colorFill.g();
              layerKeyFrames.get(int(start+i)).fillB = colorFill.b();
              layerKeyFrames.get(int(start+i)).fillA = alphaFill.getValue();
            }
          }
        }
        if (theEvent.getController().equals(stroke)) {
          layerActive.get(layerID).stroke = stroke.getState();
          if (keyFrameFWD.getState() == true || keyFrameAll.getState() == true) {
            for (int i = 0; i < range; i++) {  
              layerKeyFrames.get(int(start+i)).stroke  = stroke.getState();
            }
          }
        }
        if (theEvent.getController().equals(fill)) {
          layerActive.get(layerID).fill = fill.getState();
          if (keyFrameFWD.getState() == true || keyFrameAll.getState() == true) {
            for (int i = 0; i < range; i++) {  
              layerKeyFrames.get(int(start+i)).fill  = fill.getState();
            }
          }
        }
        if (theEvent.getController().equals(lx)) {
          layerActive.get(layerID).lx = lx.getValue();
          if (keyFrameFWD.getState() == true || keyFrameAll.getState() == true) {
            for (int i = 0; i < range; i++) {  
              layerKeyFrames.get(int(start+i)).lx  = lx.getValue();
            }
          }
        }
        if (theEvent.getController().equals(ly)) {
          layerActive.get(layerID).ly = ly.getValue();
          if (keyFrameFWD.getState() == true || keyFrameAll.getState() == true) {
            for (int i = 0; i < range; i++) {  
              layerKeyFrames.get(int(start+i)).ly  = ly.getValue();
            }
          }
        }
        if (theEvent.getController().equals(sw)) {
          layerActive.get(layerID).sw = sw.getValue();
          if (keyFrameFWD.getState() == true || keyFrameAll.getState() == true) {
            for (int i = 0; i < range; i++) {  
              layerKeyFrames.get(int(start+i)).sw  = sw.getValue();
            }
          }
        }
        if (theEvent.getController().equals(drawMode)) {  
          layerActive.get(layerID).lines = drawMode.getState();
        }
        if (theEvent.getController().equals(layerSwitch)) {
          int set = int(layerSwitch.getValue());
          layerlock = true;
          controller.updateMatrixLayerGUI(set);
          controller.updateLayerGUI(0, set);
          controller.updateAniGUI(2, set);
          gif.tabToggle();
        }
      }
    }

    void draw() {
      blendMode(BLEND);
      background(190);
    }

    void keyPressed() {
      if (key==' ') {     
        if (play == false) {
          cp5.get(Matrix.class, "Matrix").play();
          cp5.get(Matrix.class, "Matrix").trigger(0);
          play = true;
        } else {
          cp5.get(Matrix.class, "Matrix").pause();
          play = false;
        }
      }
      if (key == 'q') { 
        gif.triggerArray();
        cp5.get(Matrix.class, "Matrix").stop();
        if (play == true) {
          gif.triggerArray();
          cp5.get(Matrix.class, "Matrix").play();
        }
      }
      if (key == 'r') {
        play = true;
        render = true;
        gif.renderStart = millis();
        gif.aniStart(0);
      }
      if (key == 'k') {
        play = true;
        renderKeyFrames = true;
        gif.renderStart = millis();
        gif.aniStart(0);
      }
      if (key == 'p') {
        if (playback == true) {
          playback = false;
        } else {
          playback = true;
        }
        gif.renderStart = millis();
      }
    }

    void Matrix(int theX, int theY) { 
      gif.aniStart(theX);
    }
  } 