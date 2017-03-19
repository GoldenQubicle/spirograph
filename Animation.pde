class Animation {   //<>//

  int keyFrames, layerVars, matrixWidth, matrixHeight, cellWidth, cellHeight, nLayers, aniMatrixTiming, keyFrame, interval;
  float totalTime, aniTotalFrames, aniFrames;
  int [][] aniEnd, aniInt, aniEasing;
  ArrayList<int [][]> layerAniInt = new ArrayList();
  ArrayList<int [][]> layerAniEnd = new ArrayList();  
  ArrayList<int [][]> layerAniEasing = new ArrayList(); 
  Boolean [][] aniStart;
  ArrayList<Boolean[][]> layerAniStart = new ArrayList();

  Ani kf;
  ArrayList<Trigger> triggers;

  Animation() {
    nLayers = 1;
    layerVars = 18; 
    totalTime = 4000; 
    keyFrames = 4;
    aniMatrixTiming = int(totalTime/keyFrames);
    aniTotalFrames =  (totalTime/1000)*60 ;
    aniFrames = aniTotalFrames/keyFrames;

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


    // needs to be moved
    matrixWidth = 775; 
    matrixHeight = 400; 
    cellWidth = matrixWidth/keyFrames; 
    cellHeight = matrixHeight/layerVars; 
    // 
    triggers = new ArrayList();
  }

  void render() {
    int keyFrame = 0;
    int frame = 0;
    boolean aniStart = true;
    
    for (int f = 0; f < aniTotalFrames; f++) {    
      for (Trigger myTrigger : triggers) {
        if (keyFrame == myTrigger.Start && aniStart == true) {
          myTrigger.ani.start();
          aniStart = false;
          //println("check");
        }
      }
        //myTrigger.ani.pause();
        // write display to PIMage and then play
        
        println("rendering frame " + (f+1) + " of " + int(aniTotalFrames));

        frame+=1;
        if (frame == aniFrames) {
          keyFrame+=1;
          frame = 0;
          aniStart = true;
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
      aniFrames = aniTotalFrames/keyFrames;
      cellWidth = matrixWidth/keyFrames;
      println(aniTotalFrames);
    }

    void aniStart(int theX, int theY) {

      for (Trigger myTrigger : triggers) {
        if (theX == myTrigger.Start) {
          myTrigger.ani.start();
        }
      }
    }

    void triggerArray() {
      triggers.clear();
      layerAnimate.clear();
      for (int l = 0; l < nLayers; l++) { 
        Layer animate = new Layer(10);
        layerAnimate.add(controller.copyLayerSettings(animate, 0, l));
        //layerActive.clear();
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