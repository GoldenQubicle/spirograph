class Controller {


  Controller() {
  }

  void menuGifLayer(int id) {
    switch(id) {
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
      Layer New = new Layer();
      layers.add(New);
      gui.LayerList.addItem("Layer" + layers.size(), New);
      break;
    case 5:
      // copy layer
      Layer newC = new Layer();
      layerCopy(newC);
      layers.add(newC);
      gui.LayerList.addItem("copy off" + int(gui.LayerList.getValue()+1), newC);
      break;
    case 6:
      // delete layer
      break;
    }
  }

  void layerSwitch(int set) {
    if (gui.layerlock == true) {
      gui.gear0.remove();
      gui.gear1.remove();
      gui.gear2.remove();
      gui.gear3.remove();
      gui.colorFill.remove();
      gui.colorStroke.remove();
      gui.gear0 = gui.cp5.addSlider2D("G0").setMinMax(-256, -256, 256, 256).setPosition(3, 240).setCaptionLabel("Radius Gear 0").setSize(150, 150).setValue(layers.get(set).gear0.RX, layers.get(set).gear0.RY);
      gui.gear1 = gui.cp5.addSlider2D("G1").setMinMax(-256, -256, 256, 256).setPosition(158, 240).setCaptionLabel("Radius Gear 1").setSize(150, 150).setValue(layers.get(set).gear1.RX, layers.get(set).gear1.RY);
      gui.gear2 = gui.cp5.addSlider2D("G2").setMinMax(-256, -256, 256, 256).setPosition(313, 240).setCaptionLabel("Radius Gear 2").setSize(150, 150).setValue(layers.get(set).gear2.RX, layers.get(set).gear2.RY);
      gui.gear3 = gui.cp5.addSlider2D("G3").setMinMax(-256, -256, 256, 256).setPosition(468, 240).setCaptionLabel("Radius Gear 3").setSize(150, 150).setValue(layers.get(set).gear3.RX, layers.get(set).gear3.RY);   
      gui.colorFill = gui.cp5.addColorWheel("Fill").setPosition(415, 3).setRGB(layers.get(set).cFill);
      gui.alphaFill.setValue(alpha(layers.get(set).cFill));
      gui.colorStroke = gui.cp5.addColorWheel("Stroke").setPosition(209, 3).setRGB(layers.get(set).cStroke);
      gui.alphaStroke.setValue(alpha(layers.get(set).cStroke));
      gui.fill.setState(layers.get(set).fill);
      gui.stroke.setState(layers.get(set).stroke);
      gui.lx.setValue(layers.get(set).lx);
      gui.ly.setValue(layers.get(set).ly);
      gui.sw.setValue(layers.get(set).sw);
      gui.petals1.setValue(layers.get(set).gear1.P);
      gui.petals2.setValue(layers.get(set).gear2.P);
      gui.petals3.setValue(layers.get(set).gear3.P);
      gui.G1r.setValue(layers.get(set).gear1.move);
      gui.G2r.setValue(layers.get(set).gear2.move);
      gui.G3r.setValue(layers.get(set).gear3.move);

      gui.id = set;
      gui.layerlock = false;
    }
  }

  void layerCopy(Layer Copy) {
    for (int i = 0; i < 4; i++) {
      Copy.gears[i].RX = layers.get(int(gui.LayerList.getValue())).gears[i].RX;  
      Copy.gears[i].RY = layers.get(int(gui.LayerList.getValue())).gears[i].RY;   
      Copy.gears[i].RZ = layers.get(int(gui.LayerList.getValue())).gears[i].RZ;
    }
    for (int i = 0; i < 3; i++) {
      Copy.gears[i].P = layers.get(int(gui.LayerList.getValue())).gears[i].P;
      Copy.gears[i].move = layers.get(int(gui.LayerList.getValue())).gears[i].move;
    }
    Copy.cFill = layers.get(int(gui.LayerList.getValue())).cFill;
    Copy.cStroke = layers.get(int(gui.LayerList.getValue())).cStroke;
    Copy.fill = layers.get(int(gui.LayerList.getValue())).fill;
    Copy.stroke = layers.get(int(gui.LayerList.getValue())).stroke;
    Copy.lx = layers.get(int(gui.LayerList.getValue())).lx;
    Copy.ly = layers.get(int(gui.LayerList.getValue())).ly;
    Copy.sw = layers.get(int(gui.LayerList.getValue())).sw;
    Copy.trig = layers.get(int(gui.LayerList.getValue())).trig;
  }
}