class GUI {

  ControlP5 cp5;

  GUI(PApplet theApplet) {

    cp5 = new ControlP5(theApplet);
// layer1    
    Group L_1 = cp5.addGroup("L_1")
      .setLabel("Layer 1")
      .setPosition(250, 100)
      .setSize(150, 100)
      .setBackgroundColor(color(255, 100));
      
    cp5.addButton("Add")
    .setGroup(L_1)
    .setPosition(10,60)  
    .setLabel("Add Gear")
    .setValue(layerS_1.Shift)
    ;
    cp5.addButton("Delete")
    .setGroup(L_1)
    .setPosition(80,60)  
    .setLabel("Remove Gear")
    .setValue(layerS_1.Shift)
     ;
     
// gear0
    Group G_0 = cp5.addGroup("G_0")
      .setLabel("Gear 0")
      .setGroup(L_1)
      .setPosition(10, 10)
      ;
    cp5.addSlider("RadiusX")
      .setPosition(0, 0)
      .setGroup(G_0)
      .setMin(-width/2)
      .setMax(width/2)
      .setValue(layerS_1.gear0.RX)
      .setId(1)
      ;
    cp5.addSlider("RadiusY")
      .setGroup(G_0)
      .setPosition(0, 10)
      .setMin(-width/2)
      .setMax(width/2)
      .setValue(layerS_1.gear0.RY)
      .setId(2)
      ;
// gear1
    Group G_1 = cp5.addGroup("G_1")
      .setLabel("Gear 1")
      .setGroup(L_1)
      .setPosition(10, 40)
      ;
    cp5.addSlider("RadiusX2")
      .setPosition(0, 0)
      .setGroup(G_1)
      .setMin(-width/2)
      .setMax(width/2)
      .setValue(layerS_1.gear1.RX)
      .setId(3)
      ;
    cp5.addSlider("RadiusY2")
      .setGroup(G_1)
      .setPosition(0, 10)
      .setMin(-width/2)
      .setMax(width/2)
      .setValue(layerS_1.gear1.RY)
      .setId(4)
      ;
    //cp5.addSlider("lineX")
    //  .setPosition(0, 20)
    //  .setGroup(G_0)
    //  .setMin(1)
    //  .setMax(50)
    //  .setValue(layerS_1.Gear_0.get("lineX"))
    //  .setId(3)
    //  ;
    //cp5.addSlider("lineY")
    //  .setPosition(0, 30)
    //  .setMin(1)
    //  .setMax(50)
    //  .setValue(layerS_1.Gear_0.get("lineY"))
    //  .setGroup(G_0)
    //  .setId(4)
    //  ;
  }

 


  void Controls() {

    Controller Gear0_RX = cp5.getController("RadiusX");
    layerS_1.gear0.RX = Gear0_RX.getValue();

    Controller Gear0_RY = cp5.getController("RadiusY");
    layerS_1.gear0.RY = Gear0_RY.getValue();

    Controller Gear0_RY2 = cp5.getController("RadiusX2");
    layerS_1.gear1.RX = Gear0_RY2.getValue();
    
    Controller Gear0_RX2 = cp5.getController("RadiusY2");
    layerS_1.gear1.RY = Gear0_RX2.getValue();     

  }
  

}