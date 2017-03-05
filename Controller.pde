class Controller {

  Layer dummy = new Layer();
  FileIO fileio;


  Controller() {
    fileio = new FileIO();
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
      update = true;
      fileio.loadGif();
      loadGlobals();
      break;
    case 3:
      // create new gif  
        fileio.saveAs();
      break;
    case 4:
      // new layer
      Layer blank = new Layer();
      blank.name = "Layer " + (layers.size()+1);
      layers.add(blank);
      gui.layerSwitch.addItem(blank.name, blank);
      break;
    case 5:
      // copy layer
      Layer copy = new Layer();
      copy.name = ("Layer " + (layers.size()+1) + " - copy layer " + (int(gui.layerSwitch.getValue())+1));
      int origin = int(gui.layerSwitch.getValue());
      layers.add(layerGetSettings(copy, origin, 0));
      gui.layerSwitch.addItem(copy.name, copy);
      break;
    case 6:
      // delete layer
      int del = int(gui.layerSwitch.getValue());
      gui.layerSwitch.removeItem(layers.get(del).name);
      layers.remove(del);
      break;
    }
  }

  void loadGlobals() {
    Width = fileio.currentFile.getInt("gifWidth");
    Height = fileio.currentFile.getInt("gifHeight");
    gif.totalTime = fileio.currentFile.getFloat("gifLength");
    gif.Interval = fileio.currentFile.getFloat("gifInterval");
    gui.colorBackground.remove();
    gui.colorBackground = gui.cp5.addColorWheel("Background").setPosition(3, 3).setRGB(fileio.currentFile.getInt("colorBackground"));    
    cBackground = fileio.currentFile.getInt("colorBackground");
  }

  void updateLayerGUI(int select, int get) {
    if (gui.layerlock == true) {
      gui.gear0.remove();
      gui.gear1.remove();
      gui.gear2.remove();
      gui.gear3.remove();
      gui.colorFill.remove();
      gui.colorStroke.remove();
      gui.gear0 = gui.cp5.addSlider2D("G0").setMinMax(-256, -256, 256, 256).setPosition(3, 240).setCaptionLabel("Radius Gear 0").setSize(150, 150).setValue(layerSelect(select, get).gear0.RX, layerSelect(select, get).gear0.RY);
      gui.gear1 = gui.cp5.addSlider2D("G1").setMinMax(-256, -256, 256, 256).setPosition(158, 240).setCaptionLabel("Radius Gear 1").setSize(150, 150).setValue(layerSelect(select, get).gear1.RX, layerSelect(select, get).gear1.RY);
      gui.gear2 = gui.cp5.addSlider2D("G2").setMinMax(-256, -256, 256, 256).setPosition(313, 240).setCaptionLabel("Radius Gear 2").setSize(150, 150).setValue(layerSelect(select, get).gear2.RX, layerSelect(select, get).gear2.RY);
      gui.gear3 = gui.cp5.addSlider2D("G3").setMinMax(-256, -256, 256, 256).setPosition(468, 240).setCaptionLabel("Radius Gear 3").setSize(150, 150).setValue(layerSelect(select, get).gear3.RX, layerSelect(select, get).gear3.RY);   
      gui.colorFill = gui.cp5.addColorWheel("Fill").setPosition(415, 3).setRGB(layerSelect(select, get).cFill);
      gui.alphaFill.setValue(alpha(layerSelect(select, get).cFill));
      gui.colorStroke = gui.cp5.addColorWheel("Stroke").setPosition(209, 3).setRGB(layerSelect(select, get).cStroke);
      gui.alphaStroke.setValue(alpha(layerSelect(select, get).cStroke));
      gui.blendMode.setValue(layerSelect(select, get).select); 
      gui.fill.setState(layerSelect(select, get).fill);
      gui.stroke.setState(layerSelect(select, get).stroke);
      gui.lx.setValue(layerSelect(select, get).lx);
      gui.ly.setValue(layerSelect(select, get).ly);
      gui.sw.setValue(layerSelect(select, get).sw);
      gui.petals1.setValue(layerSelect(select, get).gear1.P);
      gui.petals2.setValue(layerSelect(select, get).gear2.P);
      gui.petals3.setValue(layerSelect(select, get).gear3.P);
      gui.G1r.setValue(layerSelect(select, get).gear1.move);
      gui.G2r.setValue(layerSelect(select, get).gear2.move);
      gui.G3r.setValue(layerSelect(select, get).gear3.move);
      for (int r = 0; r < gui.trigSwitch.size(); r++) {
        gui.trigSwitch.get(r).activate(layerSelect(select, get).trig.get(gui.trigSwitch.get(r).getName()));
      }
      gui.id = get;
      gui.layerlock = false;
    }
  }

  Layer layerSelect(int select, int getlayer) {  
    if (select == 0) {
      dummy = layers.get(getlayer);
    }
    if (select == 1 ) {
      dummy = layerFrames.get(getlayer);
    }
    return dummy;
  }

  Layer layerGetSettings(Layer layer, int get, int select) {
    for (int i = 0; i < 4; i++) {
      layer.gears[i].RX = layerSelect(select, get).gears[i].RX;  
      layer.gears[i].RY = layerSelect(select, get).gears[i].RY;   
      layer.gears[i].RZ = layerSelect(select, get).gears[i].RZ;
    }
    for (int i = 0; i < 3; i++) {
      layer.gears[i].P = layerSelect(select, get).gears[i].P;
      layer.gears[i].move = layerSelect(select, get).gears[i].move;
    }
    layer.cFill = layerSelect(select, get).cFill;
    layer.cStroke = layerSelect(select, get).cStroke;
    layer.fill = layerSelect(select, get).fill;
    layer.stroke = layerSelect(select, get).stroke;
    layer.lx = layerSelect(select, get).lx;
    layer.ly = layerSelect(select, get).ly;
    layer.sw = layerSelect(select, get).sw;
    for (int r=0; r < gui.trigSwitch.size(); r++) {
      layer.trig.set(gui.trigSwitch.get(r).getName(), layerSelect(select, get).trig.get(gui.trigSwitch.get(r).getName()));
    }
    return layer;
  }
}