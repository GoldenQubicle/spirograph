class Controller {


  Controller() {
  }

  void menuGifLayer(int buttonID) {
    switch(buttonID) {
    case 0:
      // gif settings
      update = true;
      break;
    case 1:
      // save gif
      break;
    case 2:
      // load gif
      break;
    case 3:
      // create new gif  
      break;
    case 4:
      // new layer
      Layer blank = new Layer();
      layers.add(blank);
      gui.layerSwitch.addItem("Layer " + layers.size(), blank);
      break;
    case 5:
      // copy layer
      Layer copy = new Layer();
      layerGetSettings(copy);
      layers.add(copy);
      gui.layerSwitch.addItem("Layer " + layers.size() + " - copy layer " + int(gui.layerSwitch.getValue()+1), copy);
      break;
    case 6:
      // delete layer
      break;
    }
  }

  void updateGUI(int select, int set) {
    if (gui.layerlock == true) {
      gui.gear0.remove();
      gui.gear1.remove();
      gui.gear2.remove();
      gui.gear3.remove();
      gui.colorFill.remove();
      gui.colorStroke.remove();
      gui.gear0 = gui.cp5.addSlider2D("G0").setMinMax(-256, -256, 256, 256).setPosition(3, 240).setCaptionLabel("Radius Gear 0").setSize(150, 150).setValue(layerSelect(select, set).gear0.RX, layerSelect(select, set).gear0.RY);
      gui.gear1 = gui.cp5.addSlider2D("G1").setMinMax(-256, -256, 256, 256).setPosition(158, 240).setCaptionLabel("Radius Gear 1").setSize(150, 150).setValue(layerSelect(select, set).gear1.RX, layerSelect(select, set).gear1.RY);
      gui.gear2 = gui.cp5.addSlider2D("G2").setMinMax(-256, -256, 256, 256).setPosition(313, 240).setCaptionLabel("Radius Gear 2").setSize(150, 150).setValue(layerSelect(select, set).gear2.RX, layerSelect(select, set).gear2.RY);
      gui.gear3 = gui.cp5.addSlider2D("G3").setMinMax(-256, -256, 256, 256).setPosition(468, 240).setCaptionLabel("Radius Gear 3").setSize(150, 150).setValue(layerSelect(select, set).gear3.RX, layerSelect(select, set).gear3.RY);   
      gui.colorFill = gui.cp5.addColorWheel("Fill").setPosition(415, 3).setRGB(layerSelect(select, set).cFill);
      gui.alphaFill.setValue(alpha(layerSelect(select, set).cFill));
      gui.colorStroke = gui.cp5.addColorWheel("Stroke").setPosition(209, 3).setRGB(layerSelect(select, set).cStroke);
      gui.alphaStroke.setValue(alpha(layerSelect(select, set).cStroke));
      gui.fill.setState(layerSelect(select, set).fill);
      gui.stroke.setState(layerSelect(select, set).stroke);
      gui.lx.setValue(layerSelect(select, set).lx);
      gui.ly.setValue(layerSelect(select, set).ly);
      gui.sw.setValue(layerSelect(select, set).sw);
      gui.petals1.setValue(layerSelect(select, set).gear1.P);
      gui.petals2.setValue(layerSelect(select, set).gear2.P);
      gui.petals3.setValue(layerSelect(select, set).gear3.P);
      gui.G1r.setValue(layerSelect(select, set).gear1.move);
      gui.G2r.setValue(layerSelect(select, set).gear2.move);
      gui.G3r.setValue(layerSelect(select, set).gear3.move);
      for (int r = 0; r < gui.trigSwitch.size(); r++) {
        
          gui.trigSwitch.get(r).activate(layerSelect(select, set).trig.get(gui.trigSwitch.get(r).getName()));
      
         }

      gui.id = set;
      gui.layerlock = false;
    }
  }

  Layer layerSelect(int select, int set) {
    Layer dummy = new Layer();
    if (select == 0) {
      dummy = layers.get(set);
    }
    if (select == 1 ) {
      dummy = layerFrames.get(set);
    }
    return dummy;
  }

  void layerGetSettings(Layer Copy) {
    for (int i = 0; i < 4; i++) {
      Copy.gears[i].RX = layers.get(int(gui.layerSwitch.getValue())).gears[i].RX;  
      Copy.gears[i].RY = layers.get(int(gui.layerSwitch.getValue())).gears[i].RY;   
      Copy.gears[i].RZ = layers.get(int(gui.layerSwitch.getValue())).gears[i].RZ;
    }
    for (int i = 0; i < 3; i++) {
      Copy.gears[i].P = layers.get(int(gui.layerSwitch.getValue())).gears[i].P;
      Copy.gears[i].move = layers.get(int(gui.layerSwitch.getValue())).gears[i].move;
    }
    Copy.cFill = layers.get(int(gui.layerSwitch.getValue())).cFill;
    Copy.cStroke = layers.get(int(gui.layerSwitch.getValue())).cStroke;
    Copy.fill = layers.get(int(gui.layerSwitch.getValue())).fill;
    Copy.stroke = layers.get(int(gui.layerSwitch.getValue())).stroke;
    Copy.lx = layers.get(int(gui.layerSwitch.getValue())).lx;
    Copy.ly = layers.get(int(gui.layerSwitch.getValue())).ly;
    Copy.sw = layers.get(int(gui.layerSwitch.getValue())).sw;
    Copy.trig = layers.get(int(gui.layerSwitch.getValue())).trig;
  }
}