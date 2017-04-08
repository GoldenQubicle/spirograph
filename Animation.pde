class Animation {    //<>//

  int keyFrames, layerVars, matrixWidth, matrixHeight, cellWidth, cellHeight, nLayers, aniMatrixTiming, renderFrame, renderKeyFrame, fTemp, fps;
  float totalTime, aniTotalFrames, aniFrames;
  int [][] aniEnd, aniInt, aniEasing;
  ArrayList<int [][]> layerAniInt = new ArrayList();
  ArrayList<int [][]> layerAniEnd = new ArrayList();  
  ArrayList<int [][]> layerAniEasing = new ArrayList(); 
  Boolean [][] aniStart;
  ArrayList<Boolean[][]> layerAniStart = new ArrayList();
  ArrayList<Trigger> triggers;
  float renderStart;
  PImage frame;
  PImage[] frames; 

  Animation() {
    nLayers = 1;
    layerVars = 18; 
    totalTime = 4000; 
    keyFrames = 4;
    aniMatrixTiming = int(totalTime/keyFrames);
    triggers = new ArrayList();

    fps = 60;
    aniTotalFrames =  (totalTime/1000)*fps ; 
    aniFrames = round(aniTotalFrames/keyFrames);
    aniTotalFrames = aniFrames * keyFrames;
    frames = new PImage[int(aniTotalFrames)];
    renderKeyFrame = 0;
    renderFrame = 0;

    for (int l = 0; l < nLayers; l++) {
      aniStart = new Boolean [keyFrames][layerVars];
      aniInt = new int[keyFrames][layerVars]; 
      aniEnd = new int[keyFrames][layerVars];
      aniEasing = new int[keyFrames][layerVars]; 
      for (int f =0; f < keyFrames; f++) {
        for (int v = 0; v < layerVars; v++) {
          aniStart[f][v] = false;
          aniInt[f][v] = 1;
          aniEnd[f][v] = f;
          aniEasing[f][v] = 0;
        }
      }
      layerAniStart.add(aniStart);
      layerAniInt.add(aniInt);
      layerAniEnd.add(aniEnd);
      layerAniEasing.add(aniEasing);
    }
    // values used for aniMatrix tabs in GUI, should prolly be moved at some point
    matrixWidth = 775; 
    matrixHeight = 400; 
    cellWidth = matrixWidth/keyFrames; 
    cellHeight = matrixHeight/layerVars;
  }

  void renderPImage() {
    PImage frame = createImage(Width, Height, ARGB);
    loadPixels();
    frame.loadPixels();
    frame.pixels = pixels;
    frame.updatePixels();
    frame.save("frame " + renderFrame + ".png");
    frames[renderFrame] = frame;
    println("rendered frame " + renderFrame + " out of " + int(aniTotalFrames));
    render = true;
    //renderKeyFrames = true;
  }

  void renderLayer() {
    Layer interpolated = new Layer(10);
    layerKeyFrames.set(renderKeyFrame, controller.copyLayerSettings(interpolated, 2, gui.layerID));  
    renderKeyFrames = true;
  }

  void renderKeyFrames() {    
    if (renderKeyFrames) {
      renderKeyFrames = false;
      //render = false;
    }
    if (renderKeyFrames == false) {
      aniStart(renderKeyFrame); 
      for (Trigger myTrigger : triggers) {
        if (myTrigger.Start <= renderKeyFrame ) {
          myTrigger.renderFrame+=int(aniFrames);
          myTrigger.ani.seek(myTrigger.aniSeek*myTrigger.renderFrame);    
          myTrigger.renderFrame+=(myTrigger.aniDuration/myTrigger.interval);
        }
      }
      //render = true;
      renderKeyFrames = true;
      renderKeyFrame+=1;

      if (renderKeyFrame == keyFrames) {
        renderKeyFrames = false;
        play = false;
        println("staaaph");
      }
    }
  }


  void renderLoop() {
    if (render == true) {
      renderFrame+=1;
      render = false;
    }

    if (render == false) {
      fTemp+=1;
      aniStart(renderKeyFrame); 
      for (Trigger myTrigger : triggers) {
        if (myTrigger.Start <= renderKeyFrame ) {
          myTrigger.ani.seek(myTrigger.aniSeek*myTrigger.renderFrame);
          myTrigger.renderFrame+=1;
        }
      }

      // setKeyFrame for aniStart
      if (fTemp == aniFrames) {
        renderKeyFrame+=1; 
        fTemp = 0;
      }
      render = true;

      // check for end
      if (renderFrame == aniTotalFrames) {
        render = false;
        play = false;
        fTemp = 0;
        renderKeyFrame = 0;
        renderFrame = 0;
        float end = millis() - renderStart;
        println("done rendering in " + (end/1000) + " seconds" );
      }
    }
  }

  void setupArrays() { 
    layerAniStart.clear();
    layerAniInt.clear();
    layerAniEnd.clear();
    layerAniEasing.clear();
    for (int l = 0; l < nLayers; l++) {
      aniStart = new Boolean [keyFrames][layerVars];
      aniInt = new int[keyFrames][layerVars]; 
      aniEnd = new int[keyFrames][layerVars];
      aniEasing = new int[keyFrames][layerVars]; 
      for (int f =0; f < keyFrames; f++) {
        for (int v = 0; v < layerVars; v++) {
          aniStart[f][v] = false;
          aniInt[f][v] = 1;
          aniEnd[f][v] = f;
          aniEasing[f][v] = 0;
        }
      }
      layerAniStart.add(aniStart);
      layerAniInt.add(aniInt);
      layerAniEnd.add(aniEnd);
      layerAniEasing.add(aniEasing);
    }
  }

  void updateAniMatrixTiming() {
    aniMatrixTiming = int(totalTime/keyFrames);
    aniTotalFrames =  (totalTime/1000)*60 ;
    aniFrames = round(aniTotalFrames/keyFrames);
    aniTotalFrames = aniFrames * keyFrames;
    cellWidth = matrixWidth/keyFrames;
    frames = new PImage[int(aniTotalFrames)];
  }

  void aniStart(int theX) {
    for (Trigger myTrigger : triggers) {
      if (theX == myTrigger.Start) {
        myTrigger.ani();
      }
    }
  }

  void triggerArray() {
    triggers.clear();
    layerAnimate.clear();
    for (int l = 0; l < nLayers; l++) { 
      Layer animate = new Layer(10);
      layerAnimate.add(controller.copyLayerSettings(animate, 0, l));
      for (int x = 0; x < keyFrames; x++) {
        for (int y = 0; y < layerVars; y++) {
          if (layerAniStart.get(l)[x][y] == true) {
            Trigger Animate;
            Animate = new Trigger(x, y, layerAniEnd.get(l)[x][y], l);
            triggers.add(Animate);
          }
        }
      }
    }
  }

  void tabToggle() {
    for (int x = 0; x < keyFrames; x++) {
      for (int y = 0; y < layerVars; y++) {
        if (layerAniStart.get(int(gui.layerSwitch.getValue()))[x][y] == true) {
          gui.cp5.getController("Easing"+"0"+x+"0"+y).setVisible(true); 
          gui.cp5.getController("add"+"0"+x+"0"+y).setVisible(true); 
          gui.cp5.getController("minus"+"0"+x+"0"+y).setVisible(true);
        }
        if (layerAniStart.get(int(gui.layerSwitch.getValue()))[x][y] == false) {
          gui.cp5.getController("Easing"+"0"+x+"0"+y).setVisible(false); 
          gui.cp5.getController("add"+"0"+x+"0"+y).setVisible(false); 
          gui.cp5.getController("minus"+"0"+x+"0"+y).setVisible(false);
        }
      }
    }
  }
}