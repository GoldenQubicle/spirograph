class Controller {


  Controller() {
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
    //

    //P1.setValue(layers.get(set).gear1.P);
    //P2.setValue(layers.get(set).gear2.P);
    //P3.setValue(layers.get(set).gear3.P);
    //LX.setValue(layers.get(set).LX);
    //LY.setValue(layers.get(set).LY);
    //Fill.setState(layers.get(set).fill);
    //Stroke.setState(layers.get(set).stroke);
    //SW.setValue(layers.get(set).SW);
    //Lines.setState(layers.get(set).lines);
    //Dots.setState(layers.get(set).dots);
    //D.setValue(layers.get(set).PlotDots);
    //G1c.setValue(layers.get(set).gear1.Connect);
    //G2c.setValue(layers.get(set).gear2.Connect);
    //G3c.setValue(layers.get(set).gear3.Connect);
    //gui.layerlock = false;
  }

  void layerCopy() {

    int id = int(gui.LayerList.getValue());
    //int set = id +1; 
    //  if (id != int(LayerList.getValue())) {
    //    layerlock = true;
    //    set = int(LayerList.getValue());
    //    G0.remove();
    //    G1.remove();
    //    G2.remove();
    //    G3.remove();    


    Layer Copy = new Layer();
    layers.add(Copy);
    Copy.id = gui.id+1;

    layers.set(set, layers.get(id));
    gui.LayerList.addItem("Copy" + (int(gui.LayerList.getValue())+1), Copy);

    //  Copy.gear0.RX = layers.get(int(gui.LayerList.getValue())).gear0.RX;
    //  Copy.gear0.RY = layers.get(int(gui.LayerList.getValue())).gear0.RY;
    //  Copy.gear0.RZ = layers.get(int(gui.LayerList.getValue())).gear0.RZ;
    //  Copy.gear1.RX = layers.get(int(gui.LayerList.getValue())).gear1.RX;
    //  Copy.gear1.RY = layers.get(int(gui.LayerList.getValue())).gear1.RY;
    //  Copy.gear1.RZ = layers.get(int(gui.LayerList.getValue())).gear1.RZ;
    //  Copy.gear2.RX = layers.get(int(gui.LayerList.getValue())).gear2.RX;
    //  Copy.gear2.RY = layers.get(int(gui.LayerList.getValue())).gear2.RY;
    //  Copy.gear2.RZ = layers.get(int(gui.LayerList.getValue())).gear2.RZ;
    //  Copy.gear3.RX = layers.get(int(gui.LayerList.getValue())).gear3.RX;
    //  Copy.gear3.RY = layers.get(int(gui.LayerList.getValue())).gear3.RY;
    //  Copy.gear3.RZ = layers.get(int(gui.LayerList.getValue())).gear3.RZ;
    //  Copy.gear1.P = layers.get(int(gui.LayerList.getValue())).gear1.P;
    //  Copy.gear2.P = layers.get(int(gui.LayerList.getValue())).gear2.P;
    //  Copy.gear3.P = layers.get(int(gui.LayerList.getValue())).gear3.P;
    //  Copy.lx = layers.get(int(gui.LayerList.getValue())).lx;
    //  Copy.ly = layers.get(int(gui.LayerList.getValue())).ly;
    //  Copy.cFill = layers.get(int(gui.LayerList.getValue())).cFill;
    //  Copy.cStroke = layers.get(int(gui.LayerList.getValue())).cStroke;
    //  Copy.lines = layers.get(int(gui.LayerList.getValue())).lines;
    //  Copy.dots = layers.get(int(gui.LayerList.getValue())).dots;
    //  Copy.density = layers.get(int(gui.LayerList.getValue())).density;
    //  Copy.gear1.Connect = layers.get(int(gui.LayerList.getValue())).gear1.Connect;
    //  Copy.gear2.Connect = layers.get(int(gui.LayerList.getValue())).gear2.Connect;
    //  Copy.gear3.Connect = layers.get(int(gui.LayerList.getValue())).gear3.Connect;
    //  Copy.spheres3d = layers.get(int(gui.LayerList.getValue())).spheres3d;
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
      // new layer
      Layer New = new Layer();
      layers.add(New);
      gui.LayerList.addItem("Layer" + layers.size(), New);
      break;
    case 4:
      // copy layer
      layerCopy();


      break;
    case 5:
      // delete layer
      break;
    case 6:
      // create new gif  
      break;
    }
  }
}