class Animation {   //<>//
  
  int keyFrames, Variables, MatrixWidth, MatrixHeight, CellWidth, CellHeight;
  float totalTime, aniInterval, Interval;
  int [][] AniEnd, AniInt;
  ArrayList<Trigger> triggers;

  Animation() {
    totalTime = 4000;
    keyFrames = 12;
    Variables = 19; // one too many for top row matrix which needs to be active at all time
    Interval = int(totalTime/keyFrames);
    aniInterval = Interval/1000;
    MatrixWidth = 500;
    MatrixHeight = 400;
    CellWidth = MatrixWidth/keyFrames;    
    CellHeight = MatrixHeight/Variables;
    AniEnd = new int[keyFrames][Variables];
    AniInt = new int[keyFrames][Variables];
    for (int x = 0; x < keyFrames; x++) {
      for (int y = 0; y < Variables; y++) {
        AniEnd[x][y] = x;
        AniInt[x][y] = 1;
      }
    }
    triggers = new ArrayList();
    for(int i =0; i < keyFrames; i++){
     layerFrames.add(layers.get(gui.layerID)); 
    }
  }

  void Update() {
    CellWidth = MatrixWidth/keyFrames;  
    Interval = int(totalTime/keyFrames);
    aniInterval = Interval/1000;
    AniEnd = new int[keyFrames][Variables];
    AniInt = new int[keyFrames][Variables];
    for (int x = 0; x < keyFrames; x++) {
      for (int y = 0; y < Variables; y++) {
        AniEnd[x][y] = x;
        AniInt[x][y] = 1;
      }
    }
    gui.cp5.dispose();
    gui.setup();
    update= true;
  }

  void aniStart(int theX, int theY) {
    if (theY > 0) {
      for (Trigger myTrigger : triggers) {
        if (theX == myTrigger.Start) {
          myTrigger.ani();
        }
      }
    } else {
      //gui.layerProperties.load(JSON+theX);
    }
  }

  void triggerArray() {
    triggers.clear();
    for (int y = 1; y < Variables; y++) {
      for (int x = 0; x < keyFrames; x++) {
        if (gui.Ani.get(x, y) == true) {
          Trigger Animate;
          Animate = new Trigger(x, y, AniEnd[x][y]);
          triggers.add(Animate);
        }
      }
    }
  }

  void tabToggle() {
    for (int y = 1; y < Variables; y++) {
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