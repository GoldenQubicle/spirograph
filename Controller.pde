class Controller {
  FileIO fileio = new FileIO();
  Layer dummy = new Layer(100);
  int kfOld;   
  Boolean [][] aniStartNew;
  int [][] aniIntNew;
  int [][] aniEndNew;

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
      gif.updateAniMatrixTiming();
      gui.cp5.getGroup("ng").hide();
      controller.fileio.fileName = gui.fileName.getText();
      if (kfOld > gif.keyFrames) {
        updateKeyFrames(2);
        updateAniGUI(0);
      }
      if (kfOld < gif.keyFrames) {
        updateKeyFrames(3);
        updateAniGUI(1);
      }
      fileio.saveJSON();  
      updateMatrixGUI();    
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
      update = true;
      gui.layerlock = true;
      layerActive.clear();
      layerKeyFrames.clear();
      gui.layerSwitch.clear();
      gui.colorBackground.remove();      
      fileio.loadJSON(fileio.listOfFiles[int(gui.fileSelect.getValue())].getName());
      gui.fileName.setText(controller.fileio.fileName);
      gui.colorBackground = gui.cp5.addColorWheel("Background").setPosition(3, 3).setRGB(fileio.global.getInt("colorBackground"));
      for (int l =0; l < gif.nLayers; l++) {
        int frame = l*gif.keyFrames;
        layerActive.add(layerKeyFrames.get(frame));
        gui.layerSwitch.addItem(layerKeyFrames.get(frame).name, layerKeyFrames.get(frame));
      }
      updateMatrixGUI();
      updateLayerGUI(0, 0);
      gui.layerlock = false;
      break;
    }
  }

  void updateKeyFrames(int action) {
    switch(action) {
    case 0:  // add new & copied layer
      // update keyFrame array
      for (int f =0; f < gif.keyFrames; f++) {
        Layer kfBLank = new Layer(10);
        layerKeyFrames.add(copyLayerSettings(kfBLank, 0, layerActive.size()-1));
        layerKeyFrames.get(layerKeyFrames.size()-1).kf = f;
      }
      // add new ani arrays
      gif.aniStart = new Boolean [gif.keyFrames][gif.layerVars];
      gif.aniInt = new int[gif.keyFrames][gif.layerVars]; 
      gif.aniEnd = new int[gif.keyFrames][gif.layerVars]; 
      for (int f = 0; f < gif.keyFrames; f++) {
        for (int v = 0; v < gif.layerVars; v++) {
          gif.aniStart[f][v] = false;
          gif.aniInt[f][v] = 1;
          gif.aniEnd[f][v] = f;
        }
      }
      gif.layerAniStart.add(gif.aniStart);
      gif.layerAniInt.add(gif.aniInt);
      gif.layerAniEnd.add(gif.aniEnd);
      break;
    case 1:
      // delete layer     
      int del = int(gui.layerSwitch.getValue());
      int index = gif.keyFrames*(del+1)-1;
      for (int f = index; f > (gif.keyFrames*del)-1; f--) {
        layerKeyFrames.remove(f);
      }
      gif.layerAniStart.remove(del);
      gif.layerAniInt.remove(del);
      gif.layerAniEnd.remove(del);
      break;
    case 2: // trim keyFrames      
      int rangeDel = kfOld - gif.keyFrames;
      // update keyFrame array
      for (int rangeEnd = layerKeyFrames.size()-1; rangeEnd > 0; rangeEnd-=kfOld) {
        for (int r = 0; r < rangeDel; r++) { 
          layerKeyFrames.remove(rangeEnd-r);
        }
      }      
      // update boolean arrays
      for (int l =0; l < gif.nLayers; l++) {
        aniStartNew = new Boolean [gif.keyFrames][gif.layerVars];
        aniIntNew = new int[gif.keyFrames][gif.layerVars]; 
        aniEndNew = new int[gif.keyFrames][gif.layerVars]; 
        for (int f =0; f < gif.keyFrames; f++) {
          for (int v = 0; v < gif.layerVars; v++) {
            aniStartNew[f][v] = gif.layerAniStart.get(l)[f][v];
            aniIntNew [f][v] = gif.layerAniInt.get(l)[f][v];
            aniEndNew[f][v] = gif.layerAniEnd.get(l)[f][v];
          }
        }
        gif.layerAniStart.set(l, aniStartNew);
        gif.layerAniInt.set(l, aniIntNew);
        gif.layerAniEnd.set(l, aniEndNew);
      }
      break;
    case 3: // add keyFrames 
      int range = gif.keyFrames - kfOld;
      int layerAdd = range * gif.nLayers;
      int sizeOld = layerKeyFrames.size();
      // add dummies to set proper size of array
      for (int i = 0; i < layerAdd; i++) {
        Layer dummy = new Layer(0);
        layerKeyFrames.add(dummy);
      }
      // updating ani arrays
      for (int l =0; l < gif.nLayers; l++) {
        aniStartNew = new Boolean [gif.keyFrames][gif.layerVars];
        aniIntNew = new int[gif.keyFrames][gif.layerVars]; 
        aniEndNew = new int[gif.keyFrames][gif.layerVars]; 
        for (int f = 0; f < kfOld; f++) {
          for (int v = 0; v < gif.layerVars; v++) {
            aniStartNew[f][v] = gif.layerAniStart.get(l)[f][v];
            aniIntNew [f][v] = gif.layerAniInt.get(l)[f][v];
            aniEndNew[f][v] = gif.layerAniEnd.get(l)[f][v];
          }
        }
        for (int f = kfOld; f < gif.keyFrames; f++) {
          for (int v = 0; v < gif.layerVars; v++) {
            aniStartNew[f][v] = false;
            aniIntNew [f][v] = 1;
            aniEndNew[f][v] = f;
          }
        }
        gif.layerAniStart.set(l, aniStartNew);
        gif.layerAniInt.set(l, aniIntNew);
        gif.layerAniEnd.set(l, aniEndNew);
      }
      // updating layerKeyFrame array
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
          Layer kfNew = new Layer(10);
          layerKeyFrames.set(copyLayer, copyLayerSettings(kfNew, 1, setLayer));
          layerKeyFrames.get(copyLayer).kf = kfOld + c;
        }
      }
      break;
    }
  }


  void updateAniGUI(int action) {
    switch(action) {
    case 0:
      // remove ani buttons
      for (int kf = gif.keyFrames; kf < kfOld; kf++) {
        for (int v = 0; v < gif.layerVars; v++) {
          gui.cp5.getController("Easing"+"0"+kf+"0"+v).remove();
          gui.cp5.getController("minus"+"0"+kf+"0"+v).remove();
          gui.cp5.getController("add"+"0"+kf+"0"+v).remove();
        }
      }
      //update positions & width of remaining buttons
      for (int f =0; f < gif.keyFrames; f++) {
        for (int v = 0; v < gif.layerVars; v++) {
          gui.cp5.getController("Easing"+"0"+f+"0"+v).setWidth(gif.layerAniInt.get(int(gui.layerSwitch.getValue()))[f][v]*gif.cellWidth);  
          gui.cp5.getController("Easing"+"0"+f+"0"+v).setPosition(10 + (f*gif.cellWidth), 525 + (v*gif.cellHeight));
          gui.cp5.getController("minus"+"0"+f+"0"+v).setPosition((f*gif.cellWidth)-5, 525 + (v*gif.cellHeight));
          gui.cp5.getController("add"+"0"+f+"0"+v).setPosition(((10+gif.cellWidth) + (f*gif.cellWidth) + ((gif.layerAniInt.get(int(gui.layerSwitch.getValue()))[f][v]-1)*gif.cellWidth)), 525 + (v*gif.cellHeight));
        }
      }
      break;
    case 1:
      // add buttons
      for (int f = kfOld; f < gif.keyFrames; f++) {
        for (int v = 0; v < gif.layerVars; v++) {
          gui.Easing =  gui.cp5.addScrollableList("Easing"+"0"+f+"0"+v).setPosition(10 + (f*gif.cellWidth), 525 + (v*gif.cellHeight)).setWidth(gif.cellWidth).setHeight(100).setBarHeight(gif.cellHeight).setType(ScrollableList.DROPDOWN).close();
          gui.Easing.addItems(gui.EasingNames);
          gui.cp5.getController("Easing"+"0"+f+"0"+v).setVisible(false);
          gui.cp5.getController("Easing"+"0"+f+"0"+v).moveTo("Ani Easing");
          gui.Increase = gui.cp5.addButton("add"+"0"+f+"0"+v).setPosition((10+gif.cellWidth) + (f*gif.cellWidth), 525 + (v*gif.cellHeight)).setWidth(15).setCaptionLabel("+").setId(f);
          gui.Decrease = gui.cp5.addButton("minus"+"0"+f+"0"+v).setPosition((f*gif.cellWidth)-5, 525 + (v*gif.cellHeight)).setWidth(15).setCaptionLabel("-").setId(f);
          gui.cp5.getController("minus"+"0"+f+"0"+v).setVisible(false);
          gui.cp5.getController("minus"+"0"+f+"0"+v).moveTo("Ani Easing");
          gui.cp5.getController("add"+"0"+f+"0"+v).setVisible(false);
          gui.cp5.getController("add"+"0"+f+"0"+v).moveTo("Ani Easing");
        }
      }
      // updating positions & width of existing buttons
      for (int f = 0; f < kfOld; f++) {
        for (int v = 0; v < gif.layerVars; v++) {
          gui.cp5.getController("Easing"+"0"+f+"0"+v).setWidth(gif.layerAniInt.get(int(gui.layerSwitch.getValue()))[f][v]*gif.cellWidth);  
          gui.cp5.getController("Easing"+"0"+f+"0"+v).setPosition(10 + (f*gif.cellWidth), 525 + (v*gif.cellHeight));
          gui.cp5.getController("minus"+"0"+f+"0"+v).setPosition((f*gif.cellWidth)-5, 525 + (v*gif.cellHeight));
          gui.cp5.getController("add"+"0"+f+"0"+v).setPosition(((10+gif.cellWidth) + (f*gif.cellWidth) + ((gif.layerAniInt.get(int(gui.layerSwitch.getValue()))[f][v]-1)*gif.cellWidth)), 525 + (v*gif.cellHeight));
        }
      }
      break;
    }
  }


  void updateMatrixGUI() {
    gui.gifKeyFrames.setValue(gif.keyFrames);
    gui.gifLength.setValue(gif.totalTime);
    gui.keyFrames.remove();   
    gui.keyFrames =  gui.cp5.addRadioButton("kf").setPosition(3, 500).setSize((gif.matrixWidth/gif.keyFrames), 20).setItemsPerRow(gif.keyFrames).moveTo("global");
    for (int i = 0; i < gif.keyFrames; i++) {       
      gui.keyFrames.addItem("KF" + (i+1), i);
      gui.keyFrames.getItem(i).getCaptionLabel().set("KF" + (i+1)).align(CENTER, CENTER);
    }
    gui.Ani.setInterval(gif.aniMatrixTiming);
    gui.Ani.setGrid(gif.keyFrames, gif.layerVars);
    gui.layerlock = true;
    updateMatrixLayerGUI(0);
    gui.layerlock = false;
  }

  void updateMatrixLayerGUI(int get) {
    if (gui.layerlock == true) {
      for (int f = 0; f < gif.keyFrames; f++) {
        for (int v = 0; v < gif.layerVars; v++) {
          gui.Ani.set(f, v, gif.layerAniStart.get(get)[f][v]); // falls over here because boolean array isnt updated yet, should be fixed when included in fileio
        }
      }
    }
  }

  void updateLayerGUI(int array, int get) {
    if (gui.layerlock == true) {
      gui.gear0.remove();
      gui.gear1.remove();
      gui.gear2.remove();
      gui.gear3.remove();
      gui.colorFill.remove();
      gui.colorStroke.remove();
      gui.gear0 = gui.cp5.addSlider2D("G0").setMinMax(-256, -256, 256, 256).setPosition(3, 240).setCaptionLabel("Radius Gear 0").setSize(150, 150).setValue(arraySelect(array, get).gear0.RX, arraySelect(array, get).gear0.RY).moveTo("global");
      gui.gear1 = gui.cp5.addSlider2D("G1").setMinMax(-256, -256, 256, 256).setPosition(158, 240).setCaptionLabel("Radius Gear 1").setSize(150, 150).setValue(arraySelect(array, get).gear1.RX, arraySelect(array, get).gear1.RY).moveTo("global");
      gui.gear2 = gui.cp5.addSlider2D("G2").setMinMax(-256, -256, 256, 256).setPosition(313, 240).setCaptionLabel("Radius Gear 2").setSize(150, 150).setValue(arraySelect(array, get).gear2.RX, arraySelect(array, get).gear2.RY).moveTo("global");
      gui.gear3 = gui.cp5.addSlider2D("G3").setMinMax(-256, -256, 256, 256).setPosition(468, 240).setCaptionLabel("Radius Gear 3").setSize(150, 150).setValue(arraySelect(array, get).gear3.RX, arraySelect(array, get).gear3.RY).moveTo("global");   
      gui.colorFill = gui.cp5.addColorWheel("Fill").setPosition(415, 3).setRGB(arraySelect(array, get).cFill).moveTo("global");
      gui.alphaFill.setValue(alpha(arraySelect(array, get).cFill));
      gui.colorStroke = gui.cp5.addColorWheel("Stroke").setPosition(209, 3).setRGB(arraySelect(array, get).cStroke).moveTo("global");
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

  Layer arraySelect(int select, int getlayer) {  
    Layer dummy = new Layer(10);
    if (select == 0) {
      dummy = layerActive.get(getlayer);
    }
    if (select == 1 ) {
      dummy = layerKeyFrames.get(getlayer);
    }
    return dummy;
  }

  void toggleKeyFrames(int frame) {
    layerActive.clear();
    for (int f = frame; f < layerKeyFrames.size(); f+= gif.keyFrames) {
      layerActive.add(layerKeyFrames.get(f));
    }
    gui.layerlock = true;
    updateLayerGUI(0, int(gui.layerSwitch.getValue()));
  }
}