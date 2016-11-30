
class GUI {


  GUI() {
    Group g0 = cp5.addGroup("go")
      .setPosition(250, 100)
      //.setWidth(100)
      //.activateEvent(true)
      //.setBackgroundColor(color(255, 80))
      //.setBackgroundHeight(100)
      .setLabel("Gear 0")
      ;
    cp5.addSlider("wut")
      .setPosition(0, 0)
      .setGroup(g0)
      .setMin(-width/2)
      .setMax(width/2)
      .setValue(layerS_1.RadiusX)
      ;

    cp5.addSlider("layerS_1.RadiusY")
      .setPosition(0, 10)
      .setMin(-width/2)
      .setMax(width/2)
      .setValue(layerS_1.RadiusY)
      .setGroup(g0)
      ;
  }


  void display() {
  }
}