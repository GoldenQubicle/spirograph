class GUI {

  ControlP5 cp5;

  GUI(PApplet theApplet) {

    cp5 = new ControlP5(theApplet);
    Group L_1 = cp5.addGroup("L_1")
      .setLabel("Layer 1")
      .setPosition(250, 100)
      .setSize(150, 100)
      .setBackgroundColor(color(255, 100))
      ;
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
      .setValue(layerS_1.RadiusX)
      .setId(1)
      ;
    cp5.addSlider("RadiusY")
      .setGroup(G_0)
      .setPosition(0, 10)
      .setMin(-width/2)
      .setMax(width/2)
      .setValue(layerS_1.RadiusY)
      .setId(2)
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
    layerS_1.RadiusX = Gear0_RX.getValue();

    Controller Gear0_RY = cp5.getController("RadiusY");
    layerS_1.RadiusY = Gear0_RY.getValue();

    //  Controller Gear0_LX = cp5.getController("lineX");
    //  layerS_1.Gear_0.set("lineX", Gear0_LX.getValue());

    //  Controller Gear0_LY = cp5.getController("lineY");
    //  layerS_1.Gear_0.set("lineY", Gear0_LY.getValue());

    //  //Controller Gear0_RY2 = cp5.getController("RadiusX2");
    //  //layerS_1.RadiusX2 = Gear0_RY2.getValue();
    //  //Controller Gear0_RX2 = cp5.getController("RadiusY2");
    //  //layerS_1.RadiusY2 = Gear0_RX2.getValue();
  }
}