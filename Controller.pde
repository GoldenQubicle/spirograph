class Controller {
  FileIO fileio = new FileIO();
  Layer dummy = new Layer();

  Controller() {
    for (int i = 0; i < gif.keyFrames; i++) {
      Layer kf = new Layer();
      kf.id = i;
      kf.name =  "keyFrame "+ i;
      layerFrames.add(layerSettings(kf, 0, 0));
    }
  }

  void menuGifLayer(int buttonID) {
    switch(buttonID) {
    case 0:
      // gif settings menu
      update = true;
      gui.cp5.getGroup("ng").show();
      gui.cp5.getGroup("ng").bringToFront();
      gui.cp5.getController("GW").setValue(Width);
      gui.cp5.getController("GH").setValue(Height);
      break;
    case 1:
      // save all as json 
      fileio.saveJSON();
      break;
    case 2:
      // load json menu   
      gui.cp5.getGroup("fs").show();
      gui.cp5.getGroup("fs").bringToFront();
      gui.fileSelect.setOpen(true).show();
      for (File file : fileio.getFiles()) {
        gui.fileSelect.addItem(file.getName(), file);
      }
      break;
    case 3:
      // save gif settings  
      gui.cp5.getGroup("ng").hide();
      controller.fileio.fileName = gui.fileName.getText();
      fileio.saveJSON();     
      updateAniMatrixGUI();
      break;
    case 4:
      // new layer
      Layer blank = new Layer();
      layers.add(blank);
      blank.id = layers.size();
      blank.name = "Layer " + layers.size();     
      gui.layerSwitch.addItem(blank.name, blank);
      break;
    case 5:
      // copy layer
      Layer copy = new Layer();
      int origin = int(gui.layerSwitch.getValue());      
      layers.add(layerSettings(copy, origin, 0));
      copy.id =  layers.size(); 
      copy.name = ("Layer " + (layers.size()) + " - copy layer " + (int(gui.layerSwitch.getValue())+1));
      gui.layerSwitch.addItem(copy.name, copy);
      break;
    case 6:
      // delete layer
      int del = int(gui.layerSwitch.getValue());
      gui.layerSwitch.removeItem(layers.get(del).name);
      layers.remove(del);
      break;
    case 7:
      // load actual json file selected
      gui.cp5.getGroup("fs").hide();
      update = true;
      gui.layerlock = true;
      layers.clear();
      gui.layerSwitch.clear();
      gui.colorBackground.remove();      
      fileio.loadJSON(fileio.listOfFiles[int(gui.fileSelect.getValue())].getName());
      gui.colorBackground = gui.cp5.addColorWheel("Background").setPosition(3, 3).setRGB(fileio.global.getInt("colorBackground"));
      gui.fileName.setText(controller.fileio.fileName);
      for (Layer myLayer : layers) {
        gui.layerSwitch.addItem(myLayer.name, myLayer);
      }
      updateAniMatrixGUI();
      updateLayerGUI(0, 0);
      gui.layerlock = false;
      break;
    }
  }

  Layer layerSelect(int select, int getlayer) {  
    Layer dummy = new Layer();
    if (select == 0) {
      dummy = layers.get(getlayer);
    }
    if (select == 1 ) {
      dummy = layerFrames.get(getlayer);
    }
    return dummy;
  }

  void  updateAniMatrixGUI() {
    gui.keyFrames.remove();   
    gui.keyFrames =  gui.cp5.addRadioButton("kf").setPosition(3, 500).setSize((610/gif.keyFrames), 20).setItemsPerRow(gif.keyFrames);
    for (int i = 0; i < gif.keyFrames; i++) {       
      gui.keyFrames.addItem("KF" + (i+1), i);
      gui.keyFrames.getItem(i).getCaptionLabel().set("KF" + (i+1)).align(CENTER, CENTER);
    }
    gui.keyFrames.activate(0);
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
      gui.blendMode.setValue(layerSelect(select, get).blendSelect); 
      gui.fill.setState(layerSelect(select, get).fill);
      gui.stroke.setState(layerSelect(select, get).stroke);
      gui.lx.setValue(layerSelect(select, get).lx);
      gui.ly.setValue(layerSelect(select, get).ly);
      gui.sw.setValue(layerSelect(select, get).sw);
      gui.petals1.setValue(layerSelect(select, get).gear1.P);
      gui.petals2.setValue(layerSelect(select, get).gear2.P);
      gui.petals3.setValue(layerSelect(select, get).gear3.P);
      gui.G1r.setValue(layerSelect(select, get).gear1.rotate);
      gui.G2r.setValue(layerSelect(select, get).gear2.rotate);
      gui.G3r.setValue(layerSelect(select, get).gear3.rotate);
      for (int r = 0; r < gui.trigSwitch.size(); r++) {
        gui.trigSwitch.get(r).activate(layerSelect(select, get).trig.get(gui.trigSwitch.get(r).getName()));
      }
      gui.layerID = get;
      gui.layerlock = false;
    }
  }

  Layer layerSettings(Layer layer, int get, int select) {
    for (int i = 0; i < 4; i++) {
      layer.gears[i].RX = layerSelect(select, get).gears[i].RX;  
      layer.gears[i].RY = layerSelect(select, get).gears[i].RY;   
      layer.gears[i].RZ = layerSelect(select, get).gears[i].RZ;
      layer.gears[i].P = layerSelect(select, get).gears[i].P;
      layer.gears[i].rotate = layerSelect(select, get).gears[i].rotate;
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