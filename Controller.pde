class Controller {
  FileIO fileio = new FileIO();
  Layer dummy = new Layer(100);
  int kfOld; 

  Controller() {
    for (int l=0; l < gif.nLayers; l++) {
      for (int f=0; f < gif.keyFrames; f++) {
        Layer dummy = new Layer(0);
        dummy.name = layerActive.get(l).name;
        dummy.id = layerActive.get(l).id;
        dummy.kf = f; 
        layerKeyFrames.add(layerSettings(dummy, l));
        println(layerKeyFrames.size());
      }
    }
  }

  void menuGifLayer(int buttonID) {
    switch(buttonID) {
    case 0:
      // gif settings menu
      update = true;
      kfOld = gif.keyFrames;
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
      if (kfOld > gif.keyFrames) {
        updateKeyFrames(2);
      }
      if (kfOld < gif.keyFrames) {
        updateKeyFrames(3);
      }
      fileio.saveJSON();     
      updateAniMatrixGUI();
      break;
    case 4:
      // new layer
      Layer blank = new Layer(100);
      layerActive.add(blank);
      blank.id = layerActive.size();
      blank.name = "Layer " + layerActive.size();      
      updateKeyFrames(0);
      gui.layerSwitch.addItem(blank.name, blank);
      gif.nLayers+=1;
      break;
    case 5:
      // copy layer
      Layer copy = new Layer(100);
      int origin = int(gui.layerSwitch.getValue());      
      layerActive.add(layerSettings(copy, origin));
      copy.id =  layerActive.size(); 
      copy.name = ("Layer " + (layerActive.size()) + " - copy layer " + (int(gui.layerSwitch.getValue())+1));
      gui.layerSwitch.addItem(copy.name, copy);
      gif.nLayers+=1;
      updateKeyFrames(0);
      break;
    case 6:
      // delete layer
      int del = int(gui.layerSwitch.getValue());
      updateKeyFrames(1);     
      gui.layerSwitch.removeItem(layerActive.get(del).name);
      layerActive.remove(del);
      gif.nLayers-=1;
      break;
    case 7:
      // load actual json file selected
      gui.cp5.getGroup("fs").hide();
      //update = true;
      gui.layerlock = true;
      layerActive.clear();
      layerKeyFrames.clear();
      gui.layerSwitch.clear();
      gui.colorBackground.remove();      
      fileio.loadJSON(fileio.listOfFiles[int(gui.fileSelect.getValue())].getName());
      gui.colorBackground = gui.cp5.addColorWheel("Background").setPosition(3, 3).setRGB(fileio.global.getInt("colorBackground"));
      gui.fileName.setText(controller.fileio.fileName);
      for (int l =0; l < gif.nLayers; l++) {
        int frame = l*gif.keyFrames;
        layerActive.add(layerKeyFrames.get(frame));
        gui.layerSwitch.addItem(layerKeyFrames.get(frame).name, layerKeyFrames.get(frame));
      }
      updateAniMatrixGUI();
      updateLayerGUI(0);
      gui.layerlock = false;
      break;
    }
  }

  void updateKeyFrames(int action) {
    switch(action) {
    case 0:
      // add new & copied layer
      for (int f =0; f < gif.keyFrames; f++) {
        layerKeyFrames.add(layerSettings(layerActive.get(layerActive.size()-1), layerActive.size()-1));
      }
      break;
    case 1:
      // delete layer
      int del = int(gui.layerSwitch.getValue());
      int index = gif.keyFrames*(del+1)-1;
      for (int f = index; f > (gif.keyFrames*del)-1; f--) {  
        layerKeyFrames.remove(f);
      }
    case 2:
      // trim keyFrames
      int rangeDel = kfOld - gif.keyFrames;
      for (int rangeEnd = layerKeyFrames.size()-1; rangeEnd > 0; rangeEnd-=kfOld) {
        for (int r = 0; r < rangeDel; r++) { 
          layerKeyFrames.remove(rangeEnd-r);
        }
      }
      break;
    case 3:
      // add keyFrames
      int rangeAdd = gif.keyFrames - kfOld;
      int layerAdd = rangeAdd * gif.nLayers;
      int sizeOld = layerKeyFrames.size();
      int rep = 1;
      for (int i = 0; i < layerAdd; i++) {
        Layer dummy = new Layer(0);
        layerKeyFrames.add(dummy);
        println(layerKeyFrames.size());
      }
      for (int rangeStart = kfOld; rangeStart <= sizeOld; rangeStart+= kfOld) {
        for (int layer = 0; layer < kfOld; layer++) {
          int kfGet = rangeStart + layer;      
          int kfSet = kfGet + rangeAdd;     
          if (kfSet > layerKeyFrames.size()) {
            continue;
          }
          layerKeyFrames.set(kfSet-1, layerKeyFrames.get(kfGet));
          println(rangeAdd, rangeStart, kfGet, kfSet);
        }
        int getN = rangeStart - 1;
        for (int n =0; n < (gif.keyFrames - kfOld); n++) {
          int setN = rangeStart + n; 
          layerKeyFrames.set(setN, layerKeyFrames.get(getN));
          println(getN, setN, rep, (gif.keyFrames - kfOld));
        }
        rep+=1;
        rangeAdd+=rangeAdd;
      }
    }
  }

  void updateAniMatrixGUI() {
    gui.keyFrames.remove();   
    gui.keyFrames =  gui.cp5.addRadioButton("kf").setPosition(3, 500).setSize((610/gif.keyFrames), 20).setItemsPerRow(gif.keyFrames);
    for (int i = 0; i < gif.keyFrames; i++) {       
      gui.keyFrames.addItem("KF" + (i+1), i);
      gui.keyFrames.getItem(i).getCaptionLabel().set("KF" + (i+1)).align(CENTER, CENTER);
    }
    gui.keyFrames.activate(0);
    gui.gifKeyFrames.setValue(gif.keyFrames);
    gui.gifLength.setValue(gif.totalTime);
  }

  void updateLayerGUI(int get) {
    if (gui.layerlock == true) {
      gui.gear0.remove();
      gui.gear1.remove();
      gui.gear2.remove();
      gui.gear3.remove();
      gui.colorFill.remove();
      gui.colorStroke.remove();
      gui.gear0 = gui.cp5.addSlider2D("G0").setMinMax(-256, -256, 256, 256).setPosition(3, 240).setCaptionLabel("Radius Gear 0").setSize(150, 150).setValue(layerActive.get(get).gear0.RX, layerActive.get(get).gear0.RY);
      gui.gear1 = gui.cp5.addSlider2D("G1").setMinMax(-256, -256, 256, 256).setPosition(158, 240).setCaptionLabel("Radius Gear 1").setSize(150, 150).setValue(layerActive.get(get).gear1.RX, layerActive.get(get).gear1.RY);
      gui.gear2 = gui.cp5.addSlider2D("G2").setMinMax(-256, -256, 256, 256).setPosition(313, 240).setCaptionLabel("Radius Gear 2").setSize(150, 150).setValue(layerActive.get(get).gear2.RX, layerActive.get(get).gear2.RY);
      gui.gear3 = gui.cp5.addSlider2D("G3").setMinMax(-256, -256, 256, 256).setPosition(468, 240).setCaptionLabel("Radius Gear 3").setSize(150, 150).setValue(layerActive.get(get).gear3.RX, layerActive.get(get).gear3.RY);   
      gui.colorFill = gui.cp5.addColorWheel("Fill").setPosition(415, 3).setRGB(layerActive.get(get).cFill);
      gui.alphaFill.setValue(alpha(layerActive.get(get).cFill));
      gui.colorStroke = gui.cp5.addColorWheel("Stroke").setPosition(209, 3).setRGB(layerActive.get(get).cStroke);
      gui.alphaStroke.setValue(alpha(layerActive.get(get).cStroke));
      gui.blendMode.setValue(layerActive.get(get).blendSelect); 
      gui.fill.setState(layerActive.get(get).fill);
      gui.stroke.setState(layerActive.get(get).stroke);
      gui.lx.setValue(layerActive.get(get).lx);
      gui.ly.setValue(layerActive.get(get).ly);
      gui.sw.setValue(layerActive.get(get).sw);
      gui.petals1.setValue(layerActive.get(get).gear1.P);
      gui.petals2.setValue(layerActive.get(get).gear2.P);
      gui.petals3.setValue(layerActive.get(get).gear3.P);
      gui.G1r.setValue(layerActive.get(get).gear1.rotate);
      gui.G2r.setValue(layerActive.get(get).gear2.rotate);
      gui.G3r.setValue(layerActive.get(get).gear3.rotate);
      for (int r = 0; r < gui.trigSwitch.size(); r++) {
        gui.trigSwitch.get(r).activate(layerActive.get(get).trig.get(gui.trigSwitch.get(r).getName()));
      }
      gui.layerID = get;
      gui.layerlock = false;
    }
  }

  Layer layerSettings(Layer layer, int get) {
    layer.name = layerActive.get(get).name;
    layer.id = layerActive.get(get).id;
    for (int i = 0; i < 4; i++) {
      layer.gears[i].RX = layerActive.get(get).gears[i].RX;  
      layer.gears[i].RY = layerActive.get(get).gears[i].RY;   
      layer.gears[i].RZ = layerActive.get(get).gears[i].RZ;
      layer.gears[i].P = layerActive.get(get).gears[i].P;
      layer.gears[i].rotate = layerActive.get(get).gears[i].rotate;
    }
    layer.cFill = layerActive.get(get).cFill;
    layer.cStroke = layerActive.get(get).cStroke;
    layer.fill = layerActive.get(get).fill;
    layer.stroke = layerActive.get(get).stroke;
    layer.lx = layerActive.get(get).lx;
    layer.ly = layerActive.get(get).ly;
    layer.sw = layerActive.get(get).sw;
    for (int r=0; r < gui.trigSwitch.size(); r++) {
      layer.trig.set(gui.trigSwitch.get(r).getName(), layerActive.get(get).trig.get(gui.trigSwitch.get(r).getName()));
    }
    return layer;
  }
}