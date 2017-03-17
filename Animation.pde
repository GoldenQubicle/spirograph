class Animation {   //<>//

  int keyFrames, layerVars, matrixWidth, matrixHeight, cellWidth, cellHeight, nLayers, aniMatrixTiming;
  float totalTime, aniTotalFrames, aniFrames;
  int [][] aniEnd, aniInt;
  ArrayList<Trigger> triggers;
  Boolean [][] aniStart, test;
  ArrayList<Boolean[][]> layerAniStart = new ArrayList();
  int keyFrame, interval;
  Ani kf;

  Animation() {
    nLayers = 2;
    layerVars = 18; 
    totalTime = 4000; 
    keyFrames = 4;
    aniMatrixTiming = int(totalTime/keyFrames);
    aniTotalFrames =  (totalTime/1000)*60 ;
    aniFrames = aniTotalFrames/keyFrames;

    layerAniStart = new ArrayList();
    for (int l = 0; l < nLayers; l++) {
      aniStart = new Boolean [keyFrames][layerVars];
      for (int f =0; f < keyFrames; f++) {
        for (int v = 0; v < layerVars; v++) {
          aniStart[f][v] = false;
        }
      }
      layerAniStart.add(aniStart);
    }


    // needs to be moved
    matrixWidth = 775; 
    matrixHeight = 400; 
    cellWidth = matrixWidth/keyFrames; 
    cellHeight = matrixHeight/layerVars; 
    // 

    aniEnd = new int[keyFrames][layerVars]; 
    aniInt = new int[keyFrames][layerVars]; 
    for (int x = 0; x < keyFrames; x++) {
      for (int y = 0; y < layerVars; y++) {
        aniEnd[x][y] = x; 
        aniInt[x][y] = 1;
      }
    }
    triggers = new ArrayList();
  }

  void updateAniMatrixTiming() {
    aniMatrixTiming = int(totalTime/keyFrames);
    aniTotalFrames =  (totalTime/1000)*60 ;
    aniFrames = aniTotalFrames/keyFrames;
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
    for (int y = 0; y < layerVars; y++) {
      for (int x = 0; x < keyFrames; x++) {
        if (gui.Ani.get(x, y) == true) {
          //println(gui.Ani.get(x, y)); 

          //Trigger Animate;
          //Animate = new Trigger(x, y, AniEnd[x][y]);
          //triggers.add(Animate);
        }
      }
    }
  }
  
  void testButtons(int x, int y){
    
  }

  void tabToggle() {
    for (int x = 0; x < keyFrames; x++) {
      for (int y = 0; y < layerVars; y++) {
        if (layerAniStart.get(int(gui.layerSwitch.getValue()))[x][y] == true) {
          gui.cp5.getController("Easing"+"0"+x+"0"+y).setVisible(true); 
          gui.cp5.getController("add"+"0"+x+"0"+y).setVisible(true); 
          gui.cp5.getController("minus"+"0"+x+"0"+y).setVisible(true);
        }  else {
          gui.cp5.getController("Easing"+"0"+x+"0"+y).setVisible(false); 
          gui.cp5.getController("add"+"0"+x+"0"+y).setVisible(false); 
          gui.cp5.getController("minus"+"0"+x+"0"+y).setVisible(false);
        }
      }
    }
  }
}