class GUI extends PApplet {   //<>//

  PApplet parent;
  ControlP5 cp5;
  int id;
  boolean layerlock = false;
  ColorWheel colorBackground, colorStroke, colorFill;
  Toggle stroke, fill, drawMode;
  ScrollableList layerSwitch, blendMode, fileSelect;
  String [] blendModes = {"Normal", "Add", "Subtract", "Darkest", "Lightest", "Exclusion", "Multiply", "Screen", "Replace"};
  Slider gifWidth, gifHeight, gifLength, gifInterval, lx, ly, sw, gear0z, gear1z, gear2z, gear3z, petals1, petals2, petals3, alphaFill, alphaStroke, G1r, G2r, G3r, density; 
  Button gifSettings, gifSave, Load, Save, layerNew, layerCopy, layerDelete;
  ArrayList <Button> menuGifLayer = new ArrayList<Button>();
  Slider2D gear0, gear1, gear2, gear3;
  RadioButton trigX, trigY, trigZ, trigX2, trigY2, densityRanges;
  ArrayList <RadioButton> trigSwitch = new ArrayList<RadioButton>();
  Textlabel trig;  
  Textfield fileName;
  // using int variables to strip decimals for gui aethetic
  int LX, LY, SW, GW, GH, ms, i, g0z, g1z, g2z, g3z, p1, p2, p3, as, af, g1r, g2r, g3r, d; 
  float densityRangeMin = 1;
  float densityRangeMax = 1000;

  // not yet in use, however, lots of stuff in animation depends on it so therefor not commented out
  ScrollableList Easing;
  //Button Copy, SaveAll, Save, Increase, Decrease;
  Matrix Ani;
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
    size(860, 980);
  } 

  public void setup() {
    id = 0;
    cp5 = new ControlP5(this);
    int rPanex = 630;
    int rPaneyMenu = 3;
    // gif & layer menu
    gifSettings = cp5.addButton("gifSettings").setPosition(rPanex+150, rPaneyMenu).setCaptionLabel("Settings").setId(0);
    Save = cp5.addButton("Save").setPosition(rPanex+150, rPaneyMenu+25).setCaptionLabel("Save").setId(1);
    Load = cp5.addButton("Load").setPosition(rPanex+150, rPaneyMenu+50).setCaptionLabel("Load").setId(2);
    cp5.addGroup("fs").setPosition(rPanex, 15).setSize(220, 135).setBackgroundColor(color(255)).setBarHeight(15).setCaptionLabel("Load File").disableCollapse().setBackgroundColor(0).hide();
    fileSelect = cp5.addScrollableList("fileSelect").setPosition(15, 15).setSize(180, 85).setGroup("fs");//.hide();
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
    // new gif menu
    cp5.addGroup("ng").setPosition(rPanex, 15).setSize(220, 135).setBackgroundColor(color(255)).setBarHeight(15).setCaptionLabel("GIF setting").disableCollapse().setBackgroundColor(0).hide();
    gifWidth = cp5.addSlider("GW").setPosition(10, 10).setRange(200, 1920).setGroup("ng").setCaptionLabel("Width");
    gifHeight = cp5.addSlider("GH").setPosition(10, 25).setRange(200, 1920).setGroup("ng").setCaptionLabel("Height");
    gifLength = cp5.addSlider("ms").setPosition(10, 40).setRange(1000, 10000).setGroup("ng").setCaptionLabel("Duration (ms)");
    gifInterval = cp5.addSlider("i").setPosition(10, 55).setRange(2, 20).setNumberOfTickMarks(19).snapToTickMarks(true).setGroup("ng").setCaptionLabel("Intervals");
    gifSave = cp5.addButton("gifSave").setPosition(90, 80).setGroup("ng").setCaptionLabel("Save").setId(3);
    fileName = cp5.addTextfield("fileName").setPosition(10, 80).setGroup("ng").setSize(75, 20).setText(controller.fileio.fileName);
    // layer controls
    layerNew = cp5.addButton("layerNew").setPosition(rPanex + 75, rPaneyMenu).setCaptionLabel("New Layer").setId(4);
    layerCopy = cp5.addButton("layerCopy").setPosition(rPanex + 75, rPaneyMenu+25).setCaptionLabel("Copy Layer").setId(5);
    layerDelete = cp5.addButton("layerDelete").setPosition(rPanex + 75, rPaneyMenu+50).setCaptionLabel("Delete Layer").setId(6);
    layerSwitch = cp5.addScrollableList("SwitchLayers").setPosition(rPanex+75, 80).setWidth(145).setType(ScrollableList.DROPDOWN).setCaptionLabel("Layers").setOpen(false);//.addItem(layers.get(id).name, layers.get(id));
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
    drawMode = cp5.addToggle("drawMode").setPosition(rPanex, 3).setSize(50, 20).setValue(false).setMode(ControlP5.SWITCH).setCaptionLabel("  3D           2D");
    colorBackground = cp5.addColorWheel("Background").setPosition(3, 3).setValue(128);
    colorStroke = cp5.addColorWheel("Stroke").setPosition(209, 3).setValue(128);
    colorFill = cp5.addColorWheel("Fill").setPosition(415, 3).setValue(128);
    alphaStroke = cp5.addSlider("as").setPosition(209, 220).setSize(200, 10).setRange(0, 255).setValue(255).setCaptionLabel("alpha");   
    alphaFill = cp5.addSlider("af").setPosition(415, 220).setSize(200, 10).setRange(0, 255).setValue(255).setCaptionLabel("alpha");   
    fill = cp5.addToggle("fill").setPosition(rPanex, 40).setSize(20, 20).setState(true);
    stroke = cp5.addToggle("stroke").setPosition(rPanex+30, 40).setSize(20, 20).setState(false);
    lx = cp5.addSlider("LX").setPosition(rPanex, 165).setSize(200, 10).setRange(0, 200).setCaptionLabel("Line Width");  
    ly = cp5.addSlider("LY").setPosition(rPanex, 180).setSize(200, 10).setRange(0, 200).setCaptionLabel("Line Height"); 
    sw = cp5.addSlider("SW").setPosition(rPanex, 195).setSize(200, 10).setRange(0, 200).setCaptionLabel("Stroke Weight");    
    blendMode = cp5.addScrollableList("blendMode").setPosition(rPanex, 80).setWidth(70).setType(ScrollableList.DROPDOWN).setCaptionLabel("blendMode").setOpen(false).addItems(blendModes);
    cp5.getController("as").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("af").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("LX").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("LY").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("SW").getCaptionLabel().align(CENTER, CENTER);
    // density  
    densityRanges = cp5.addRadioButton("density").setPosition(3, 425).setSize(60, 20).setItemsPerRow(10).addItem("1-10k", 1).addItem("10k-20k", 2).addItem("20k-30k", 3).addItem("30k-40k", 4)
      .addItem("40k-50k", 5).addItem("50k-60k", 6).addItem("60k-70k", 7).addItem("70k-80k", 8).addItem("80k-90k", 9).addItem("90k-100k", 10);//.addItem("10001-11000", 11).addItem("11001-12000", 12).addItem("12001-13000", 13)
    //.addItem("103001-14000", 14).addItem("14001-15000", 15).addItem("15001-16000", 16).addItem("16001-17000", 17).addItem("17001-18000", 18).addItem("18001-19000", 19).addItem("19001-20000", 20);
    for (int i =0; i < 10; i++) {
      densityRanges.getItem(i).getCaptionLabel().align(CENTER, CENTER);
    }
    density = cp5.addSlider("d").setPosition(3, 450).setSize(610, 20).setRange(densityRangeMin, densityRangeMax).setCaptionLabel("Density").setNumberOfTickMarks(101).showTickMarks(true).snapToTickMarks(true); 
    density.getCaptionLabel().align(CENTER, CENTER);

    // gears
    int size2d = 150;
    int posy = 240;
    int posx = 3;
    gear0 = cp5.addSlider2D("G0").setMinMax(-256, -256, 256, 256).setPosition(posx, posy).setCaptionLabel("Radius Gear 0").setSize(size2d, size2d);//.setValue(layers.get(id).gear0.RX, layers.get(id).gear0.RY);
    gear1 = cp5.addSlider2D("G1").setMinMax(-256, -256, 256, 256).setPosition(posx+155, posy).setCaptionLabel("Radius Gear 1").setSize(size2d, size2d);//.setValue(layers.get(id).gear1.RX, layers.get(id).gear1.RY);
    gear2 = cp5.addSlider2D("G2").setMinMax(-256, -256, 256, 256).setPosition(posx+(155*2), posy).setCaptionLabel("Radius Gear 2").setSize(size2d, size2d);//.setValue(layers.get(id).gear2.RX, layers.get(id).gear2.RY);
    gear3 = cp5.addSlider2D("G3").setMinMax(-256, -256, 256, 256).setPosition(posx+(155*3), posy).setCaptionLabel("Radius Gear 3").setSize(size2d, size2d);//.setValue(layers.get(id).gear3.RX, layers.get(id).gear3.RY);    
    gear0z = cp5.addSlider("G0z").setRange(-256, 256).setPosition(3, posy + size2d + 20).setSize(size2d, 10).setCaptionLabel("Gear 0 Z").hide();//.setValue(layers.get(id).gear0.RZ);
    gear1z = cp5.addSlider("G1z").setRange(-256, 256).setPosition(158, posy + size2d + 20).setSize(size2d, 10).setCaptionLabel("Gear 1 Z").hide(); //.setValue(layers.get(id).gear1.RZ);
    gear2z = cp5.addSlider("G2z").setRange(-256, 256).setPosition(313, posy + size2d + 20).setSize(size2d, 10).setCaptionLabel("Gear 2 Z").hide();//.setValue(layers.get(id).gear2.RZ);
    gear3z = cp5.addSlider("G3z").setRange(-256, 256).setPosition(468, posy + size2d + 20).setSize(size2d, 10).setCaptionLabel("Gear 3 Z").hide();//.setValue(layers.get(id).gear3.RZ);
    petals1 = cp5.addSlider("p1").setPosition(rPanex, posy).setSize(200, 10).setRange(0, 200).setCaptionLabel("Gear 1 Petals"); 
    petals2 = cp5.addSlider("p2").setPosition(rPanex, posy+15).setSize(200, 10).setRange(0, 200).setCaptionLabel("Gear 2 Petals");
    petals3 = cp5.addSlider("p3").setPosition(rPanex, posy+30).setSize(200, 10).setRange(0, 200).setCaptionLabel("Gear 3 Petals");        
    G1r = cp5.addSlider("g1r").setPosition(rPanex, posy+45).setSize(200, 10).setRange(-100, 100).setCaptionLabel("Gear 1 Rotate"); 
    G2r = cp5.addSlider("g2r").setPosition(rPanex, posy+60).setSize(200, 10).setRange(-100, 100).setCaptionLabel("Gear 2 Rotate"); 
    G3r = cp5.addSlider("g3r").setPosition(rPanex, posy+75).setSize(200, 10).setRange(-100, 100).setCaptionLabel("Gear 3 Rotate");
    cp5.getController("G0z").getCaptionLabel().align(CENTER, BOTTOM);  
    cp5.getController("G1z").getCaptionLabel().align(CENTER, BOTTOM);
    cp5.getController("G2z").getCaptionLabel().align(CENTER, BOTTOM);
    cp5.getController("G3z").getCaptionLabel().align(CENTER, BOTTOM);
    cp5.getController("p1").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("p2").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("p3").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("g1r").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("g2r").getCaptionLabel().align(CENTER, CENTER);
    cp5.getController("g3r").getCaptionLabel().align(CENTER, CENTER);
    // cos sin tan Switches    
    int poy = 0;
    int pox = 0;
    String [] trig = {"cos", "sin", "tan"};
    for (int i = 0; i < 4; i++) {
      trigX = cp5.addRadioButton("G" + i + "trigX").setPosition(rPanex, 352 + poy).setSize(40, 12).setItemsPerRow(3).addItem(trig[0]+" g"+i+"x", 0).addItem(trig[1]+" g"+i+"x", 1).addItem(trig[2]+" g"+i+"x", 2).activate(0);
      trigY = cp5.addRadioButton("G" + i + "trigY").setPosition(rPanex, 367  + poy).setSize(40, 12).setItemsPerRow(3).addItem(trig[0]+" g"+i+"y", 0).addItem(trig[1]+" g"+i+"y", 1).addItem(trig[2]+" g"+i+"y", 2).activate(1);
      trigZ = cp5.addRadioButton("G" + i + "trigZ").setPosition(3 + pox, 425).setSize(40, 12).setItemsPerRow(3).addItem(trig[0]+" g"+i+"z", 0).addItem(trig[1]+" g"+i+"z", 1).addItem(trig[2]+" g"+i+"z", 2).activate(0).hide();
      trigX2 = cp5.addRadioButton("G" + i + "trigX2").setPosition(3 + pox, 440).setSize(40, 12).setItemsPerRow(3).addItem(trig[0]+" g"+i+"x2", 0).addItem(trig[1]+" g"+i+"x2", 1).addItem(trig[2]+" g"+i+"x2", 2).activate(1).hide();
      trigY2 = cp5.addRadioButton("G" + i + "trigY2").setPosition(3 + pox, 455).setSize(40, 12).setItemsPerRow(3).addItem(trig[0]+" g"+i+"y2", 0).addItem(trig[1]+" g"+i+"y2", 1).addItem(trig[2]+" g"+i+"y2", 2).activate(1).hide();
      for (int c = 0; c < 3; c++) {
        trigX.getItem(c).getCaptionLabel().set(trig[c]).align(CENTER, CENTER); 
        trigY.getItem(c).getCaptionLabel().set(trig[c]).align(CENTER, CENTER);
        trigZ.getItem(c).getCaptionLabel().set(trig[c]).align(CENTER, CENTER);
        trigX2.getItem(c).getCaptionLabel().set(trig[c]).align(CENTER, CENTER); 
        trigY2.getItem(c).getCaptionLabel().set(trig[c]).align(CENTER, CENTER);
      }
      trigSwitch.add(cp5.get(RadioButton.class, "G" + i + "trigX"));
      trigSwitch.add(cp5.get(RadioButton.class, "G" + i + "trigY"));
      trigSwitch.add(cp5.get(RadioButton.class, "G" + i + "trigZ"));
      trigSwitch.add(cp5.get(RadioButton.class, "G" + i + "trigX2"));
      trigSwitch.add(cp5.get(RadioButton.class, "G" + i + "trigY2"));
      cp5.addTextlabel("g" + i + "x").setPosition(rPanex+128, 354  + poy).setText("Gear"+ i + " X");
      cp5.addTextlabel("g" + i + "y").setPosition(rPanex+128, 369 + poy).setText("Gear" + i +" Y");
      cp5.addTextlabel("g" + i + "z").setPosition(125 + pox, 426).setText("G" + i +" Z").hide();
      cp5.addTextlabel("g" + i + "x2").setPosition(125 + pox, 441).setText("G" + i +" X2").hide();
      cp5.addTextlabel("g" + i + "y2").setPosition(125 + pox, 456).setText("G" + i + "Y2").hide();
      poy = poy + 30;
      pox = pox + 155;
    }
  }

  void controlEvent(ControlEvent theEvent) {
    for (RadioButton R : trigSwitch) {
      if (theEvent.isFrom(R) && layerlock == false) {
        layers.get(id).trig.set(R.getName(), int(R.getValue()));
      }
    }
    if (theEvent.isFrom(densityRanges) && layerlock == false) {
      densityRangeMax = densityRanges.getValue()* 10000;
      densityRangeMin = densityRangeMax - 10000;
      density.setRange(densityRangeMin, densityRangeMax);
      density.getCaptionLabel().align(CENTER, CENTER);
      //println("checkiecheck");
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
    if (theEvent.getController().equals(gifInterval)) {
      gif.Interval = gifInterval.getValue();
    }
    if (theEvent.getController().equals(drawMode)) {
      layers.get(id).spheres3d = drawMode.getState();
      for (int i =0; i < 4; i++) {
        if (drawMode.getState() == true) {
          density.hide();
          densityRanges.hide();
          cp5.getController("G"+i+"z").show();
          cp5.get(RadioButton.class, "G" + i + "trigZ").show();
          cp5.get(RadioButton.class, "G" + i + "trigX2").show();
          cp5.get(RadioButton.class, "G" + i + "trigY2").show();
          cp5.getController("g" + i + "z").show();
          cp5.getController("g" + i + "x2").show();
          cp5.getController("g" + i + "y2").show();
        } else {
          density.show();
          densityRanges.show();
          cp5.getController("G"+i+"z").hide();
          cp5.get(RadioButton.class, "G" + i + "trigZ").hide();
          cp5.get(RadioButton.class, "G" + i + "trigX2").hide();
          cp5.get(RadioButton.class, "G" + i + "trigY2").hide();
          cp5.getController("g" + i + "z").hide();
          cp5.getController("g" + i + "x2").hide();
          cp5.getController("g" + i + "y2").hide();
        }
      }
    }
    if (theEvent.getController().equals(colorBackground)) {
      cBackground = colorBackground.getRGB();
    }
    if (layerlock == false) {
      if (theEvent.getController().equals(density)) {
        layers.get(id).density = density.getValue();
      }      
      if (theEvent.getController().equals(blendMode)) {
        layers.get(id).blendSelect = int(blendMode.getValue());
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
      if (theEvent.getController().equals(petals1)) {
        layers.get(id).gear1.P = petals1.getValue();
      }
      if (theEvent.getController().equals(petals2)) {
        layers.get(id).gear2.P = petals2.getValue();
      }
      if (theEvent.getController().equals(petals3)) {
        layers.get(id).gear3.P = petals3.getValue();
      }
      if (theEvent.getController().equals(G1r)) {
        //layers.get(id).gear1.speed = map(G1r.getValue(), -100, 100, -.0000025, .0000025);
        layers.get(id).gear1.rotate = map(G1r.getValue(), -100, 100, -TAU, TAU);
      }
      if (theEvent.getController().equals(G2r)) {
        //layers.get(id).gear2.speed = map(G2r.getValue(), -100, 100, -.0000025, .0000025);
        layers.get(id).gear2.rotate = map(G2r.getValue(), -100, 100, -TAU, TAU);
      }
      if (theEvent.getController().equals(G3r)) {
        //layers.get(id).gear3.speed = map(G3r.getValue(), -100, 100, -.0000025, .0000025);
        layers.get(id).gear3.rotate = map(G3r.getValue(), -100, 100, -TAU, TAU);
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
      if (theEvent.getController().equals(layerSwitch)) {
        int set = int(layerSwitch.getValue());
        println(set);
        layerlock = true;
        controller.updateLayerGUI(0, set);
      }
    }
  }

  //// LAYERSTATES START HERE
  //// Controller object
  //Layer = cp5.getProperties();
  //Layer.remove(CS).remove(Pause).remove(cp).remove(cw).remove(Ani).remove(Copy).remove(New).remove(SaveAll).remove(Save);
  //// saves JSON for each layerstate
  //for (int i=0; i < gif.LayerStates; i++) {
  //  Layer.setSnapshot("LayerState" + i);
  //  Layer.saveAs(JSON + i);
  //}

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
    blendMode(BLEND);
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
}