class GUI extends PApplet {
  int w, h;
  PApplet parent;
  ControlP5 cp5;
  ColorPicker cp;

  public GUI(PApplet theApplet) {
    super();
    parent = theApplet;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(510, 512);
  } 

  public void setup() {

    cp5 = new ControlP5(this);
    cp = cp5.addColorPicker("ColorPicker").setPosition(10, 10).setColorValue(layerS_1.C);
    cp5.addToggle("Outline").setPosition(270, 10).setSize(20, 15).setValue(true).setState(false);

    cp5.addSlider("Density").setPosition(10, 400).setSize(260, 15).setRange(0, 100000).setValue(layerS_1.PlotDots); 
    cp5.addSlider("LineX").setPosition(10, 350).setRange(0, 250).setValue(layerS_1.LX);
    cp5.addSlider("LineY").setPosition(160, 350).setRange(0, 250).setValue(layerS_1.LY);
    cp5.addToggle("Fill").setPosition(10, 370).setSize(45, 15).setValue(true).setMode(ControlP5.SWITCH).setState(true);
    cp5.addToggle("Stroke").setPosition(65, 370).setSize(45, 15).setValue(true).setMode(ControlP5.SWITCH).setState(false);

    // gear0
    Group G_0 = cp5.addGroup("G_0").setLabel("Gear 0").setPosition(10, 90);
    cp5.addSlider2D("Radius Gear0")  
      .setGroup(G_0)
      .setMinMax(-512, -512, 512, 512)
      .setValue(layerS_1.gear0.RX, layerS_1.gear0.RY);
    ;
    //// gear1
    Group G_1 = cp5.addGroup("G_1").setLabel("Gear 1").setPosition(160, 90);
    cp5.addSlider2D("Radius Gear1").setGroup(G_1).setMinMax(-150, -150, 150, 150).setValue(layerS_1.gear1.RX, layerS_1.gear1.RY);
    cp5.addSlider("Petals_1").setGroup(G_1).setPosition(0, -20).setRange(0, 50).setValue(layerS_1.gear1.P);  

    //// gear2
    Group G_2 = cp5.addGroup("G_2").setLabel("Gear 2").setPosition(10, 230);
    cp5.addSlider2D("Radius Gear2").setGroup(G_2).setMinMax(-150, -150, 150, 150).setValue(layerS_1.gear2.RX, layerS_1.gear2.RY);
    cp5.addSlider("Petals_2").setGroup(G_2).setPosition(0, -20).setRange(0, 100).setValue(layerS_1.gear2.P);

    //// gear3
    Group G_3 = cp5.addGroup("G_3").setLabel("Gear 3").setPosition(160, 230);
    cp5.addSlider2D("Radius Gear3").setGroup(G_3).setMinMax(-150, -150, 150, 150).setValue(layerS_1.gear3.RX, layerS_1.gear3.RY);
    cp5.addSlider("Petals_3").setGroup(G_3).setPosition(0, -20).setRange(0, 200).setValue(layerS_1.gear3.P);
  }

  void draw() {
    background(190);
  }
  
  void Controls() {
    if (cp5.getController("Outline").getValue() == 1) {
      layerS_1.Cs = cp.getColorValue();
    }
    if (cp5.getController("Outline").getValue() == 0) {
      layerS_1.C = cp.getColorValue();
    }

    layerS_1.LX = cp5.getController( "LineX").getValue();
    layerS_1.LY = cp5.getController( "LineY").getValue();
    layerS_1.PlotDots = cp5.getController("Density").getValue();


    // gear 0
    layerS_1.gear0.RX = cp5.getController("Radius Gear0").getArrayValue(0);
    layerS_1.gear0.RY = cp5.getController("Radius Gear0").getArrayValue(1);

    //if (lock == true) {
    //  layerS_1.gear0.RY = layerS_1.gear0.RX;
    //}

    //// gear 1
    layerS_1.gear1.RX = cp5.getController("Radius Gear1").getArrayValue(0); 
    layerS_1.gear1.RY = cp5.getController("Radius Gear1").getArrayValue(1);
    layerS_1.gear1.P = int(cp5.getController("Petals_1").getValue());

    //if (lock == true) {
    //  layerS_1.gear1.RY = layerS_1.gear1.RX;
    //}

    // gear 2
    layerS_1.gear2.RX = cp5.getController("Radius Gear2").getArrayValue(0); 
    layerS_1.gear2.RY = cp5.getController("Radius Gear2").getArrayValue(1);
    layerS_1.gear2.P = int(cp5.getController("Petals_2").getValue());

    //if (lock == true) {
    //  layerS_1.gear2.RY = layerS_1.gear2.RX;
    //}

    //// gear 3
    layerS_1.gear3.RX = cp5.getController("Radius Gear3").getArrayValue(0); 
    layerS_1.gear3.RY = cp5.getController("Radius Gear3").getArrayValue(1);
     layerS_1.gear3.P = int(cp5.getController("Petals_3").getValue()
    
    //if (lock == true) {
    //  layerS_1.gear3.RY = layerS_1.gear3.RX;
    //}
 
   );
  }
}