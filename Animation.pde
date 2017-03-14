class Animation {   //<>//

  int keyFrames, layerVars, matrixWidth, matrixHeight, cellWidth, cellHeight, nLayers, interval;
  float totalTime, aniInterval;
  int [][] aniEnd, aniInt;
  ArrayList<Trigger> triggers;
  Boolean [][] aniStart, test;
  ArrayList<Boolean[][]> layerAniStart = new ArrayList();

  Animation() {
    nLayers = 2;
    keyFrames = 4;
    layerVars = 18; 
    layerAniStart = new ArrayList();
    for (int l = 0; l < nLayers; l++) {
      aniStart = new Boolean [keyFrames][layerVars];
      for(int f =0; f < keyFrames; f++){
        for(int v = 0; v < layerVars; v++){
       aniStart[f][v] = false;   
        }
      }
      layerAniStart.add(aniStart);
    }
    totalTime = 4000; 
    interval = int(totalTime/keyFrames); 
    aniInterval = interval/1000; 
    matrixWidth = 775; 
    matrixHeight = 400; 
    cellWidth = matrixWidth/keyFrames; 
    cellHeight = matrixHeight/layerVars; 
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

  void updateTiming(){
    interval = int(totalTime/keyFrames);     
  }

  void aniStart(int theX, int theY) {
    for (Trigger myTrigger : triggers) {
      if (theX == myTrigger.Start) {
        myTrigger.ani();
      }
    }
  }

  void triggerArray() {
    //triggers.clear();
    for (int y = 0; y < layerVars; y++) {
      for (int x = 0; x < keyFrames; x++) {
        if (gui.Ani.get(x, y) == true) {
          println(gui.Ani.get(x, y)); 

          //Trigger Animate;
          //Animate = new Trigger(x, y, AniEnd[x][y]);
          //triggers.add(Animate);
        }
      }
    }
  }

  void tabToggle() {
    for (int y = 1; y < layerVars; y++) {
      for (int x = 0; x < keyFrames; x++) {
        if (gui.Ani.get(x, y) == true) {
          gui.cp5.getController("Easing"+"0"+x+"0"+y).setVisible(true); 
          gui.cp5.getController("add"+"0"+x+"0"+y).setVisible(true); 
          gui.cp5.getController("minus"+"0"+x+"0"+y).setVisible(true);
        }  
        if (gui.Ani.get(x, y) == false) {
          gui.cp5.getController("Easing"+"0"+x+"0"+y).setVisible(false); 
          gui.cp5.getController("add"+"0"+x+"0"+y).setVisible(false); 
          gui.cp5.getController("minus"+"0"+x+"0"+y).setVisible(false);
        }
      }
    }
  }
}