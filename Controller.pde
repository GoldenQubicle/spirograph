class Controller {
  FileIO fileio = new FileIO();
  Layer dummy = new Layer(100);
  int kfOld; 

  Controller() {
    for (int l=0; l < gif.nLayers; l++) {
      for (int f=0; f < gif.keyFrames; f++) {
        Layer dummy = new Layer(10);
        dummy.name = layerActive.get(l).name;
        dummy.id = layerActive.get(l).id;
        dummy.kf = f; 
        layerKeyFrames.add(copyLayerSettings(dummy, 0, l));
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
      layerActive.add(copyLayerSettings(copy, 0, origin));
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
      updateLayerGUI(0, 0);
      gui.layerlock = false;
      break;
    }
  }

  void updateKeyFrames(int action) {
    switch(action) {
    case 0:
      // add new & copied layer
      for (int f =0; f < gif.keyFrames; f++) {
        Layer kfBLank = new Layer(0);
        layerKeyFrames.add(copyLayerSettings(kfBLank, 0, layerActive.size()-1));
        layerKeyFrames.get(layerKeyFrames.size()-1).kf = f;
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
      int range = gif.keyFrames - kfOld;
      int layerAdd = range * gif.nLayers;
      int sizeOld = layerKeyFrames.size();

      for (int i = 0; i < layerAdd; i++) {
        Layer dummy = new Layer(0);
        layerKeyFrames.add(dummy);
      }
      int setLayer = 0;
      int getLayer = 0;
      int rangeAdd = range*gif.nLayers;
      for (int indexStart = sizeOld-1; indexStart > 0; indexStart-=kfOld) {
        rangeAdd-=range;
        for (int i = 0; i < kfOld; i++) {    
          getLayer = indexStart - i;
          setLayer = getLayer + rangeAdd;  
          layerKeyFrames.set(setLayer, layerKeyFrames.get(getLayer));
        }
        setLayer = setLayer + kfOld-1;
        for (int c = 0; c < range; c++) {          
          int copyLayer = setLayer+c+1;
          Layer kfNew = new Layer(0);
          layerKeyFrames.set(copyLayer, copyLayerSettings(kfNew, 1, setLayer));
          layerKeyFrames.get(copyLayer).kf = kfOld + c;
        }
      }
    }
  }

  Layer arraySelect(int select, int getlayer) {  
    Layer dummy = new Layer(0);
    if (select == 0) {
      dummy = layerActive.get(getlayer);
    }
    if (select == 1 ) {
      dummy = layerKeyFrames.get(getlayer);
    }
    return dummy;
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

  void updateLayerGUI(int array, int get) {
    if (gui.layerlock == true) {
      gui.gear0.remove();
      gui.gear1.remove();
      gui.gear2.remove();
      gui.gear3.remove();
      gui.colorFill.remove();
      gui.colorStroke.remove();
      gui.gear0 = gui.cp5.addSlider2D("G0").setMinMax(-256, -256, 256, 256).setPosition(3, 240).setCaptionLabel("Radius Gear 0").setSize(150, 150).setValue(arraySelect(array, get).gear0.RX, arraySelect(array, get).gear0.RY);
      gui.gear1 = gui.cp5.addSlider2D("G1").setMinMax(-256, -256, 256, 256).setPosition(158, 240).setCaptionLabel("Radius Gear 1").setSize(150, 150).setValue(arraySelect(array, get).gear1.RX, arraySelect(array, get).gear1.RY);
      gui.gear2 = gui.cp5.addSlider2D("G2").setMinMax(-256, -256, 256, 256).setPosition(313, 240).setCaptionLabel("Radius Gear 2").setSize(150, 150).setValue(arraySelect(array, get).gear2.RX, arraySelect(array, get).gear2.RY);
      gui.gear3 = gui.cp5.addSlider2D("G3").setMinMax(-256, -256, 256, 256).setPosition(468, 240).setCaptionLabel("Radius Gear 3").setSize(150, 150).setValue(arraySelect(array, get).gear3.RX, arraySelect(array, get).gear3.RY);   
      gui.colorFill = gui.cp5.addColorWheel("Fill").setPosition(415, 3).setRGB(arraySelect(array, get).cFill);
      gui.alphaFill.setValue(alpha(arraySelect(array, get).cFill));
      gui.colorStroke = gui.cp5.addColorWheel("Stroke").setPosition(209, 3).setRGB(arraySelect(array, get).cStroke);
      gui.alphaStroke.setValue(alpha(arraySelect(array, get).cStroke));
      gui.blendMode.setValue(arraySelect(array, get).blendSelect); 
      gui.fill.setState(arraySelect(array, get).fill);
      gui.stroke.setState(arraySelect(array, get).stroke);
      gui.lx.setValue(arraySelect(array, get).lx);
      gui.ly.setValue(arraySelect(array, get).ly);
      gui.sw.setValue(arraySelect(array, get).sw);
      gui.petals1.setValue(arraySelect(array, get).gear1.P);
      gui.petals2.setValue(arraySelect(array, get).gear2.P);
      gui.petals3.setValue(arraySelect(array, get).gear3.P);
      gui.G1r.setValue(arraySelect(array, get).gear1.rotate);
      gui.G2r.setValue(arraySelect(array, get).gear2.rotate);
      gui.G3r.setValue(arraySelect(array, get).gear3.rotate);
      for (int r = 0; r < gui.trigSwitch.size(); r++) {
        gui.trigSwitch.get(r).activate(arraySelect(array, get).trig.get(gui.trigSwitch.get(r).getName()));
      }
      gui.layerID = get;
      gui.layerlock = false;
    }
  }

  Layer copyLayerSettings(Layer layer, int array, int get) {
    layer.name = arraySelect(array, get).name;
    layer.id = arraySelect(array, get).id;
    //layer.kf =  arraySelect(array, get).kf;
    for (int i = 0; i < 4; i++) {
      layer.gears[i].RX = arraySelect(array, get).gears[i].RX;  
      layer.gears[i].RY = arraySelect(array, get).gears[i].RY;   
      layer.gears[i].RZ = arraySelect(array, get).gears[i].RZ;
      layer.gears[i].P = arraySelect(array, get).gears[i].P;
      layer.gears[i].rotate = arraySelect(array, get).gears[i].rotate;
    }
    layer.cFill = arraySelect(array, get).cFill;
    layer.cStroke = arraySelect(array, get).cStroke;
    layer.fill = arraySelect(array, get).fill;
    layer.stroke = arraySelect(array, get).stroke;
    layer.lx = arraySelect(array, get).lx;
    layer.ly = arraySelect(array, get).ly;
    layer.sw = arraySelect(array, get).sw;
    for (int r=0; r < gui.trigSwitch.size(); r++) {
      layer.trig.set(gui.trigSwitch.get(r).getName(), arraySelect(array, get).trig.get(gui.trigSwitch.get(r).getName()));
    }
    return layer;
  }

  void toggleKeyFrames(int frame) {
     println(layerActive.size(), layerKeyFrames.size());
    layerActive.clear();
    for (int f = frame; f < layerKeyFrames.size(); f+= gif.keyFrames) {
            layerActive.add(layerKeyFrames.get(f));
      }
      println(layerActive.size(), layerKeyFrames.size());
       gui.layerlock = true;
       updateLayerGUI(0, int(gui.layerSwitch.getValue()));
    }
   
  }