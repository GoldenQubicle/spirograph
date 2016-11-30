
class GUI {
  ControlP5 cp5;

  GUI(PApplet theApplet) {

    cp5 = new ControlP5(theApplet);
    Group g0 = cp5.addGroup("go").setPosition(250, 100).setLabel("Gear 0");
    cp5.addSlider("RadiusX")
      .setPosition(0, 0)
      .setGroup(g0)
      .setMin(-width/2)
      .setMax(width/2)
      .setValue(layerS_1.RadiusX)
      .setId(1)
      ;

    cp5.addSlider("RadiusY")
      .setPosition(0, 10)
      .setMin(-width/2)
      .setMax(width/2)
      .setValue(layerS_1.RadiusY)
      .setGroup(g0)
      .setId(2)
      ;
    Group g1 = cp5.addGroup("g1").setPosition(250, 130).setLabel("Gear 1");
    cp5.addSlider("RadiusX2")
      .setPosition(0, 0)
      .setGroup(g1)
      .setMin(-width/2)
      .setMax(width/2)
      .setValue(layerS_1.RadiusX2)
      .setId(1)
      ;

    cp5.addSlider("RadiusY2")
      .setPosition(0, 10)
      .setMin(-width/2)
      .setMax(width/2)
      .setValue(layerS_1.RadiusY2)
      .setGroup(g1)
      .setId(2)
      ;
  }


  void Controls() {
    Controller Gear0_RY = cp5.getController("RadiusX");
    layerS_1.RadiusX = Gear0_RY.getValue();
    Controller Gear0_RX = cp5.getController("RadiusY");
    layerS_1.RadiusY = Gear0_RX.getValue();
    Controller Gear0_RY2 = cp5.getController("RadiusX2");
    layerS_1.RadiusX2 = Gear0_RY2.getValue();
    Controller Gear0_RX2 = cp5.getController("RadiusY2");
    layerS_1.RadiusY2 = Gear0_RX2.getValue();
  }
}