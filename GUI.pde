class GUI extends PApplet { //<>//
  int w, h, id;
  PApplet parent;
  ControlP5 cp5;
  ColorPicker cp;

  public GUI(PApplet theApplet) {
    super();
    parent = theApplet;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(512, 512);
  } 

  public void setup() {

    cp5 = new ControlP5(this);
    //cp = cp5.addColorPicker("ColorPicker").setPosition(10, 10).setColorValue(layer_1.Fill);
    cp5.addColorWheel("BackGround").setPosition(302, 10).setValue(128);

    cp5.addToggle("Lines").setPosition(310, 290).setSize(20, 20).setValue(false);  
    cp5.addToggle("Dots").setPosition(340, 290).setSize(20, 20).setValue(false);
    cp5.addSlider("StrokeWeight").setPosition(310, 330).setRange(0, 250).setValue(layer_1.Sw);
    cp5.addSlider("Connect G1").setPosition(310, 230).setRange(0, 100).setValue(layer_1.gear1.Connect);
    cp5.addSlider("Connect G2").setPosition(310, 250).setRange(0, 100).setValue(layer_1.gear2.Connect);
    cp5.addSlider("Connect G3").setPosition(310, 270).setRange(0, 100).setValue(layer_1.gear3.Connect);

    cp5.addToggle("Outline").setPosition(270, 10).setSize(20, 15).setValue(false).setState(false);
    cp5.addButton("Set").setPosition(270, 40).setSize(20, 15);
    cp5.addSlider("Density").setPosition(10, 490).setSize(450, 15).setRange(0, 100000).setValue(layer_1.PlotDots); 
    cp5.addSlider("LineX").setPosition(10, 350).setRange(0, 250).setValue(layer_1.LX);
    cp5.addSlider("LineY").setPosition(160, 350).setRange(0, 250).setValue(layer_1.LY);
    cp5.addToggle("Fill").setPosition(10, 370).setSize(45, 15).setMode(ControlP5.SWITCH).setValue(layer_1.fill);
    cp5.addToggle("Stroke").setPosition(65, 370).setSize(45, 15).setMode(ControlP5.SWITCH).setValue(layer_1.stroke);

    // gear0
    Group G_0 = cp5.addGroup("G_0").setLabel("Gear 0").setPosition(10, 90);
    cp5.addSlider2D("Radius Gear0").setGroup(G_0).setMinMax(-512, -512, 512, 512) .setValue(layer_1.gear0.RX, layer_1.gear0.RY);
    //// gear1
    Group G_1 = cp5.addGroup("G_1").setLabel("Gear 1").setPosition(160, 90);
    cp5.addSlider2D("Radius Gear1").setGroup(G_1).setMinMax(-150, -150, 150, 150).setValue(layer_1.gear1.RX, layer_1.gear1.RY);
    cp5.addSlider("Petals_1").setGroup(G_1).setPosition(0, -20).setRange(0, 50).setValue(layer_1.gear1.P);  
    //// gear2
    Group G_2 = cp5.addGroup("G_2").setLabel("Gear 2").setPosition(10, 230);
    cp5.addSlider2D("Radius Gear2").setGroup(G_2).setMinMax(-150, -150, 150, 150).setValue(layer_1.gear2.RX, layer_1.gear2.RY);
    cp5.addSlider("Petals_2").setGroup(G_2).setPosition(0, -20).setRange(0, 100).setValue(layer_1.gear2.P);
    //// gear3
    Group G_3 = cp5.addGroup("G_3").setLabel("Gear 3").setPosition(160, 230);
    cp5.addSlider2D("Radius Gear3").setGroup(G_3).setMinMax(-150, -150, 150, 150).setValue(layer_1.gear3.RX, layer_1.gear3.RY);
    cp5.addSlider("Petals_3").setGroup(G_3).setPosition(0, -20).setRange(0, 200).setValue(layer_1.gear3.P);

    cp5.addScrollableList("layers").setPosition(310, 370).setType(ScrollableList.DROPDOWN).addItem("Layer 1", layer_1);   
    cp5.addButton("New Layer").setPosition(310, 350);
  }

  void draw() {
    background(190);
  }


  void controlEvent(ControlEvent theEvent) {
    if (theEvent.getController().getName() == "New Layer") {
      Layer New = new Layer();
      New.ID =  layers.size() + 1;
      layers.add(New);
      cp5.get(ScrollableList.class, "layers").addItem("Layer" + New.ID, New);
    }
  }

  void Controls() {
    BG = int(cp5.getController("BackGround").getValue());

    id = int(cp5.get(ScrollableList.class, "layers").getValue());

    // pass layer number into here in order to retrieve active from array
    // so, have a seperate dummy layer object for controls?

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
    //if (cp5.getController("Outline").getValue() == 0) {
    //  layer_1.Fill = int(cp.getValue());
    //}
    //if (cp5.getController("Outline").getValue() == 1) {
    //  layer_1.Stroke = int(cp.getValue());
    //}
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

    layers.get(id).LX = cp5.getController("LineX").getValue();
    layers.get(id).LY = cp5.getController("LineY").getValue();
    layers.get(id).PlotDots = cp5.getController("Density").getValue();

    layers.get(id).Sw = cp5.getController("StrokeWeight").getValue();
    layers.get(id).gear1.Connect = int(cp5.getController("Connect G1").getValue());
    layers.get(id).gear2.Connect = int(cp5.getController("Connect G2").getValue());
    layers.get(id).gear3.Connect = int(cp5.getController("Connect G3").getValue());

    // gear 0
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