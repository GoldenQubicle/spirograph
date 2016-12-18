class GUI extends PApplet {   //<>// //<>// //<>//
  int w, h, id, set, lp;
  PApplet parent;
  ControlP5 cp5;
  ColorPicker cp;
  color dummy;

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
    lp = 1;
    cp5 = new ControlP5(this);
    cp = cp5.addColorPicker("ColorPicker").setPosition(10, 10).setColorValue(layers.get(id).Fill);
    cp5.addColorWheel("BackGround").setPosition(302, 10).setValue(128);
    cp5.addToggle("Lines").setPosition(310, 290).setSize(20, 20).setState(false);  
    cp5.addToggle("Dots").setPosition(340, 290).setSize(20, 20).setState(false);
    cp5.addSlider("StrokeWeight").setPosition(310, 330).setRange(0, 250);//.setValue(layer_1.Sw);
    cp5.addSlider("Connect G1").setPosition(310, 230).setRange(0, 100);//.setValue(layers.get(id).gear1.Connect);
    cp5.addSlider("Connect G2").setPosition(310, 250).setRange(0, 100);//.setValue(layers.get(id).gear2.Connect);
    cp5.addSlider("Connect G3").setPosition(310, 270).setRange(0, 100);//.setValue(layers.get(id).gear3.Connect);

    //cp5.addRadioButton("Switch").setPosition(270,10).setSize(25,25).addItem("CFill", 0).addItem("CStroke", 1);
    cp5.addToggle("Switch").setPosition(270, 10).setSize(25, 25);

    cp5.addSlider("Density").setPosition(10, 490).setSize(450, 15).setRange(0, 100000);//.setValue(layers.get(id).PlotDots); 
    cp5.addSlider("LineX").setPosition(10, 350).setRange(0, 250);//.setValue(layers.get(id).LX);
    cp5.addSlider("LineY").setPosition(160, 350).setRange(0, 250);//.setValue(layers.get(id).LY);
    cp5.addToggle("Fill").setPosition(10, 370).setSize(45, 15).setMode(ControlP5.SWITCH).setState(true);//.setValue(layers.get(id).fill);
    cp5.addToggle("Stroke").setPosition(65, 370).setSize(45, 15).setMode(ControlP5.SWITCH).setState(false);//.setValue(layers.get(id).stroke);

    // gear0
    cp5.addSlider2D("Radius Gear0").setMinMax(-512, -512, 512, 512).setPosition(10, 90).setCaptionLabel("Radius Gear 0");//.setValue(layers.get(id).gear1.RX, layers.get(id).gear1.RY);
    //// gear1
    cp5.addSlider2D("Radius Gear1").setMinMax(-150, -150, 150, 150).setPosition(160, 90).setCaptionLabel("Radius Gear 1");
    ;//.setValue(layers.get(id).gear1.RX, layers.get(id).gear1.RY)
    cp5.addSlider("Petals_1").setRange(0, 50).setPosition(160, 80).setCaptionLabel("Petals"); 
    ;//.setValue(layers.get(id).gear1.P) 
    //// gear2
    cp5.addSlider2D("Radius Gear2").setMinMax(-150, -150, 150, 150).setPosition(10, 230).setCaptionLabel("Radius Gear 2");
    ;//.setValue(layers.get(id).gear2.RX, layers.get(id).gear2.RY)
    cp5.addSlider("Petals_2").setRange(0, 100).setPosition(10, 220).setCaptionLabel("Petals");
    ;//.setValue(layers.get(id).gear2.P)
    //// gear3
    cp5.addSlider2D("Radius Gear3").setMinMax(-150, -150, 150, 150).setPosition(160, 230).setCaptionLabel("Radius Gear 3");//.setValue(layers.get(id).gear3.RX, layers.get(id).gear3.RY);
    cp5.addSlider("Petals_3").setRange(0, 200).setPosition(160, 220).setCaptionLabel("Petals");//.setValue(layers.get(id).gear3.P);

    // layers control
    cp5.addScrollableList("layers").setPosition(310, 390).setType(ScrollableList.DROPDOWN);//.addItem("Layer 1", layer_1).addItem("Layer 2", layer_2).addItem("Layer 3", layer_3);   
    cp5.addButton("New Layer").setPosition(310, 350).setSize(60, 15);
    cp5.addButton("Hide Layer").setPosition(380, 350).setSize(60, 15);

    //cp5.addButton("Load").setPosition(380, 370).setSize(60, 15);

    // animation matrix
    cp5.addMatrix("Matrix").setPosition(10, 550).setSize(400, 100).setGrid(gif.keyFrames, lp).setInterval(gif.Interval).setMode(ControlP5.MULTIPLES).stop().setGap(10, 0)
      .set(0, 0, false).isPlaying();

    cp5.addButton("Add").setPosition(10, 525).setSize(60, 15);
  }

  void draw() {
    background(190);
  }

  //void Matrix() {     
  //  // here we check button toggle, i.e. active parameters per layer
  //  // soooo always needs to have 1 button on to read data from it
  //  if (cp5.get(Matrix.class, "Matrix").get(3, 0) == true) {
  //    //println("check");
  //  } 

  //  if (cp5.get(Matrix.class, "Matrix").get(3, 0) == false) {
  //    //println("really?!");
  //  }
  //}


  void Add() {  
    for (int i = 1; i <= gif.keyFrames; i++) {
      gui.cp5.get(ScrollableList.class, "layers").addItem("Key Frame " + i, layers.get(i));
    }
  }

  void NewLayer() {
    if (cp5.getController("New Layer").isMousePressed() == true) {
      Layer New = new Layer();
      New.ID =  layers.size() + 1;
      layers.add(New);
      cp5.get(ScrollableList.class, "layers").addItem("Layer" + New.ID, New);
    }
  }

  void HideLayer() {
    if (cp5.getController("Hide Layer").isMousePressed() == true) {
      cp5.getController("Fill").setValue(0);
      cp5.getController("Stroke").setValue(0);
    }
  }

  void SwitchLayer() {
    if (id != int(cp5.get(ScrollableList.class, "layers").getValue())) {
      set = int(cp5.get(ScrollableList.class, "layers").getValue());
      if (layers.get(set).lines == false) {
        cp5.getController("Lines").setValue(0);
      }
      if (layers.get(set).lines == true) {
        cp5.getController("Lines").setValue(1);
      }
      if (layers.get(set).dots == false) {
        cp5.getController("Dots").setValue(0);
      }
      if (layers.get(set).dots == true) {
        cp5.getController("Dots").setValue(1);
      }
      if (layers.get(set).fill == false) {
        cp5.getController("Fill").setValue(0);
      }
      if (layers.get(set).fill == true) {
        cp5.getController("Fill").setValue(1);
      }
      if (layers.get(set).stroke == false) {
        cp5.getController("Stroke").setValue(0);
      }
      if (layers.get(set).stroke == true) {
        cp5.getController("Stroke").setValue(1);
      }

      if (layers.get(set).outline == false) {
        cp.setColorValue( layers.get(set).Fill);
        cp5.getController("Switch").setValue(0);
      }
      if (layers.get(set).outline == true) {
        cp.setColorValue( layers.get(set).Stroke);
        cp5.getController("Switch").setValue(1);
      }

      cp5.getController("LineX").setValue(layers.get(set).LX);
      cp5.getController("LineY").setValue(layers.get(set).LY);
      cp5.getController("Density").setValue(layers.get(set).PlotDots);

      cp5.getController("StrokeWeight").setValue(layers.get(set).Sw);
      cp5.getController("Connect G1").setValue(layers.get(set).gear1.Connect);
      cp5.getController("Connect G2").setValue(layers.get(set).gear2.Connect);
      cp5.getController("Connect G3").setValue(layers.get(set).gear3.Connect);

      cp5.getController("Radius Gear0").remove();
      cp5.getController("Radius Gear1").remove();
      cp5.getController("Radius Gear2").remove();
      cp5.getController("Radius Gear3").remove();

      cp5.addSlider2D("Radius Gear0").setMinMax(-512, -512, 512, 512).setValue(layers.get(set).gear0.RX, layers.get(set).gear0.RY).setPosition(10, 90).setCaptionLabel("Radius Gear 0");
      cp5.addSlider2D("Radius Gear1").setMinMax(-512, -512, 512, 512).setValue(layers.get(set).gear1.RX, layers.get(set).gear1.RY).setPosition(160, 90).setCaptionLabel("Radius Gear 1");
      cp5.addSlider2D("Radius Gear2").setMinMax(-512, -512, 512, 512).setValue(layers.get(set).gear2.RX, layers.get(set).gear2.RY).setPosition(10, 230).setCaptionLabel("Radius Gear 2");
      cp5.addSlider2D("Radius Gear3").setMinMax(-512, -512, 512, 512).setValue(layers.get(set).gear3.RX, layers.get(set).gear3.RY).setPosition(160, 230).setCaptionLabel("Radius Gear 3");

      cp5.getController("Petals_1").setValue(layers.get(set).gear1.P);
      cp5.getController("Petals_2").setValue(layers.get(set).gear2.P);
      cp5.getController("Petals_3").setValue(layers.get(set).gear3.P);
    }
  }

  void SwitchColors() {
    if (cp5.getController("Switch").isMousePressed() == true && cp5.getController("Switch").getValue() == 0) {
      cp.setColorValue(layers.get(id).Fill);
    };
    if (cp5.getController("Switch").isMousePressed() == true && cp5.getController("Switch").getValue() == 1) {
      cp.setColorValue(layers.get(id).Stroke);
    };
  }

  void Controls() {
    if (cp5.getController("Switch").isMousePressed() == true) {
      SwitchColors();
    }
    NewLayer();
    HideLayer();
    //SaveLayer();
    SwitchLayer();

    // background color        
    BG = int(cp5.getController("BackGround").getValue());

    // first get layer id from the dropdownmenu
    id = int(cp5.get(ScrollableList.class, "layers").getValue());

    // ~~~~ below are controls for individual layers ~~~
    // switch draw modes
    if (cp5.getController("Lines").getValue() == 0) {    
      layers.get(id).lines = false;
    }
    if (cp5.getController("Lines").getValue() == 1) {    
      layers.get(id).lines = true;
    }
    if (cp5.getController("Dots").getValue() == 0) {    
      layers.get(id).dots = false;
    }
    if (cp5.getController("Dots").getValue() == 1) {    
      layers.get(id).dots = true;
    }

    // set colors for fill & stroke 
    if (cp5.getController("Switch").getValue() == 0) {
      layers.get(id).Fill = int(cp.getValue());
      layers.get(id).outline = false;
    }
    if ( cp5.getController("Switch").getValue() == 1) {
      layers.get(id).Stroke = int(cp.getValue());
      layers.get(id).outline = true;
    }

    // toggle fill & stroke
    if (cp5.getController("Fill").getValue() == 0) {
      layers.get(id).fill = false;
    }
    if (cp5.getController("Fill").getValue() == 1) {
      layers.get(id).fill = true;
    }
    if (cp5.getController("Stroke").getValue() == 0) {
      layers.get(id).stroke = false;
    }
    if (cp5.getController("Stroke").getValue() == 1) {
      layers.get(id).stroke = true;
    }

    // controls for spiro & dot mode
    layers.get(id).LX = cp5.getController("LineX").getValue();
    layers.get(id).LY = cp5.getController("LineY").getValue();
    layers.get(id).PlotDots = cp5.getController("Density").getValue();

    // controls for dot & line mode
    layers.get(id).Sw = cp5.getController("StrokeWeight").getValue();
    layers.get(id).gear1.Connect = int(cp5.getController("Connect G1").getValue());
    layers.get(id).gear2.Connect = int(cp5.getController("Connect G2").getValue());
    layers.get(id).gear3.Connect = int(cp5.getController("Connect G3").getValue());

    // controls for gears below - lock currently not used but should be re-instated  
    // gear 0
    //layers.get(id).gear0.RX = cp5.getGroup("G_0").getController("X Radius").getValue();
    layers.get(id).gear0.RX = cp5.getController("Radius Gear0").getArrayValue(0);
    layers.get(id).gear0.RY = cp5.getController("Radius Gear0").getArrayValue(1);
    //if (lock == true) {
    //  layerS_1.gear0.RY = layerS_1.gear0.RX;
    //}

    //// gear 1
    layers.get(id).gear1.RX = cp5.getController("Radius Gear1").getArrayValue(0); 
    layers.get(id).gear1.RY = cp5.getController("Radius Gear1").getArrayValue(1);
    layers.get(id).gear1.P = int(cp5.getController("Petals_1").getValue());
    //if (lock == true) {
    //  layerS_1.gear1.RY = layerS_1.gear1.RX;
    //}

    // gear 2
    layers.get(id).gear2.RX = cp5.getController("Radius Gear2").getArrayValue(0); 
    layers.get(id).gear2.RY = cp5.getController("Radius Gear2").getArrayValue(1);
    layers.get(id).gear2.P = int(cp5.getController("Petals_2").getValue());
    //if (lock == true) {
    //  layerS_1.gear2.RY = layerS_1.gear2.RX;
    //}

    //// gear 3
    layers.get(id).gear3.RX = cp5.getController("Radius Gear3").getArrayValue(0); 
    layers.get(id).gear3.RY = cp5.getController("Radius Gear3").getArrayValue(1);
    layers.get(id).gear3.P = int(cp5.getController("Petals_3").getValue());
    //if (lock == true) {
    //  layerS_1.gear3.RY = layerS_1.gear3.RX;
    //}
  }
}