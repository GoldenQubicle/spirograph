class GUI {

  ControlP5 cp5;
  ColorPicker cp;
  GUI(PApplet theApplet) {

    cp5 = new ControlP5(theApplet);
    // layer1    
    Group L_1 = cp5.addGroup("L_1")
      .setLabel("Layer 1")
      .setPosition(0, 0)
      .setSize(310, 400)
      .setBackgroundColor(color(255, 100));

    //cp5.addButton("Add")
    //  .setGroup(L_1)
    //  .setPosition(0, 0)  
    //  .setLabel("Add Gear")
    //  .setValue(layerS_1.Shift)
    //  ;
    //cp5.addButton("Delete")
    //  .setGroup(L_1)
    //  .setPosition(70, 0)  
    //  .setLabel("Remove Gear")
    //  .setValue(layerS_1.Shift)
    //  ;
    cp = cp5.addColorPicker("ColorPicker") 
      .setGroup(L_1)
      .setPosition(10, 10)
      .setWidth(140)
      .setColorValue(layerS_1.C)
      ;
    
    cp5.addSlider("Density").setGroup(L_1).setPosition(120, 365).setSize(140,15).setRange(0,100000).setValue(10000); 
      
    cp5.addSlider("LineX").setGroup(L_1).setPosition(10, 350).setRange(0, 250).setValue(2);
    cp5.addSlider("LineY").setGroup(L_1).setPosition(160, 350).setRange(0, 250).setValue(2);

    cp5.addToggle("Fill").setGroup(L_1).setPosition(10, 365).setSize(45, 15).setValue(true).setMode(ControlP5.SWITCH);
    cp5.addToggle("Stroke").setGroup(L_1).setPosition(65, 365).setSize(45, 15).setValue(true).setMode(ControlP5.SWITCH);

    // gear0
    Group G_0 = cp5.addGroup("G_0")
      .setLabel("Gear 0")
      .setGroup(L_1)
      .setPosition(10, 90)
      ;
    cp5.addSlider2D("Radius Gear0")  
      .setGroup(G_0)
      .setMinMax(-512, -512, 512, 512)
      .setValue(layerS_1.gear0.RX, layerS_1.gear0.RY);
    ;
    // gear1
    Group G_1 = cp5.addGroup("G_1")
      .setLabel("Gear 1")
      .setGroup(L_1)
      .setPosition(160, 90)
      ;
    cp5.addSlider2D("Radius Gear1")  
      .setGroup(G_1)
      .setMinMax(-150, -150, 150, 150)
      .setValue(layerS_1.gear1.RX, layerS_1.gear1.RY);
    ;
    cp5.addSlider("Petals_1")
      .setGroup(G_1)
      .setPosition(0, -20)
      .setRange(0, 50)
      .setValue(layerS_1.gear1.P)
      ;  

    // gear2
    Group G_2 = cp5.addGroup("G_2")
      .setLabel("Gear 2")
      .setGroup(L_1)
      .setPosition(10, 230)
      ;
    cp5.addSlider2D("Radius Gear2")  
      .setGroup(G_2)
      .setMinMax(-150, -150, 150, 150)
      .setValue(layerS_1.gear2.RX, layerS_1.gear2.RY);
    ;
    cp5.addSlider("Petals_2")
      .setGroup(G_2)
      .setPosition(0, -20)
      .setRange(0, 100)
      .setValue(layerS_1.gear2.P)
      ;

    // gear3
    Group G_3 = cp5.addGroup("G_3")
      .setLabel("Gear 3")
      .setGroup(L_1)
      .setPosition(160, 230)
      ;
    cp5.addSlider2D("Radius Gear3")  
      .setGroup(G_3)
      .setMinMax(-150, -150, 150, 150)
      .setValue(layerS_1.gear3.RX, layerS_1.gear3.RY);
    ;
    cp5.addSlider("Petals_3")
      .setGroup(G_3)
      .setPosition(0, -20)
      .setRange(0, 200)
      .setValue(layerS_1.gear3.P)
      ;
  }

  void Controls() {
    layerS_1.C = cp.getColorValue();

    Controller LineX = cp5.getController( "LineX");
    layerS_1.LX = LineX.getValue();
    Controller LineY = cp5.getController( "LineY");
    layerS_1.LY = LineY.getValue();
    
    Controller Density = cp5.getController("Density");
    layerS_1.PlotDots = Density.getValue();
    
    // gear 0
    Controller CG_0 = cp5.getController("Radius Gear0");
    layerS_1.gear0.RX = CG_0.getArrayValue(0);
    layerS_1.gear0.RY = CG_0.getArrayValue(1);
    if (lock == true) {
      layerS_1.gear0.RY = layerS_1.gear0.RX;
    }

    // gear 1
    Controller CG_1 = cp5.getController("Radius Gear1");
    layerS_1.gear1.RX = CG_1.getArrayValue(0); 
    layerS_1.gear1.RY = CG_1.getArrayValue(1);
    if (lock == true) {
      layerS_1.gear1.RY = layerS_1.gear1.RX;
    }
    Controller Gear1_P = cp5.getController("Petals_1");
    layerS_1.gear1.P = int(Gear1_P.getValue());

    // gear 2
    Controller CG_2 = cp5.getController("Radius Gear2");
    layerS_1.gear2.RX = CG_2.getArrayValue(0); 
    layerS_1.gear2.RY = CG_2.getArrayValue(1);
    if (lock == true) {
      layerS_1.gear2.RY = layerS_1.gear2.RX;
    }
    Controller Gear2_P = cp5.getController("Petals_2");
    layerS_1.gear2.P = int(Gear2_P.getValue());

    // gear 3
    Controller CG_3 = cp5.getController("Radius Gear3");
    layerS_1.gear3.RX = CG_3.getArrayValue(0); 
    layerS_1.gear3.RY = CG_3.getArrayValue(1);
    if (lock == true) {
      layerS_1.gear3.RY = layerS_1.gear3.RX;
    }
    Controller Gear3_P = cp5.getController("Petals_3");
    layerS_1.gear3.P = int(Gear3_P.getValue());
  }
}