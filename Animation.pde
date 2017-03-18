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
    nLayers = 2;
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

    //aniEnd = new int[keyFrames][layerVars]; 
    //aniInt = new int[keyFrames][layerVars]; 
    //for (int x = 0; x < keyFrames; x++) {
    //  for (int y = 0; y < layerVars; y++) {
    //    aniEnd[x][y] = x; 
    //    aniInt[x][y] = 1;
    //  }
    //}
    //triggers = new ArrayList();
  }
  
  
  void setupArrays(){ 
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
  }

  void aniStart(int theX, int theY) {
    // so since layerActive contains references to layerKeyFrames I may actually need another array with NEW layers - and then the start need to copy settings from keyFrame(0)
    // on which the animation will actually act. And then on play, switch between layerActive (or rename to layerDisplay) and e.g. layerAnimate
    kf = Ani.to(layerActive.get(0).gears[1], aniFrames, "RX", layerKeyFrames.get(theX).gears[1].RX, Ani.LINEAR);
    kf.start();
    //println(theX);


    //for (Trigger myTrigger : triggers) {
    //  if (theX == myTrigger.Start) {
    //    myTrigger.ani();
    //}
    //}
  }

  void triggerArray() {
    //triggers.clear();
    for (int l = 0; l < nLayers; l++) { 
      for (int x = 0; x < keyFrames; x++) {
        for (int y = 0; y < layerVars; y++) {
          if (layerAniStart.get(l)[x][y] == true) {
            //Trigger Animate;
            //Animate = new Trigger(x, y, aniEnd[x][y]);
            //triggers.add(Animate);
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