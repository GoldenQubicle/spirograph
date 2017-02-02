class Animation { //<>//

  int Interval, LayerStates, Variables, MatrixWidth, MatrixHeight, CellWidth, CellHeight ;
  float TotalTime, aniInterval;
  int [][] AniEnd, AniInt;
  ArrayList<Trigger> triggers;
  boolean loadlayerstate;

  Animation() {

    TotalTime = 4000;
    LayerStates = 8;
    Variables = 19; // one too many for top row matrix which needs to be active at all time
    Interval = int(TotalTime/LayerStates);
    aniInterval = float(Interval)/1000;
    MatrixWidth = 500;
    MatrixHeight = 400;
    CellWidth = MatrixWidth/LayerStates;    
    CellHeight = MatrixHeight/Variables;
    AniEnd = new int[LayerStates][Variables];
    AniInt = new int[LayerStates][Variables];
    for (int x = 0; x < LayerStates; x++) {
      for (int y = 0; y < Variables; y++) {
        AniEnd[x][y] = x;
        AniInt[x][y] = 1;
      }
    }
    triggers = new ArrayList();
    println(aniInterval);
  }

  void AniStart(int theX, int theY) {
    if (theY > 0) {
      for (Trigger myTrigger : triggers) {
        if (theX == myTrigger.Start) {
          myTrigger.ani();
        }
      }
    } else {
      gui.Layer.load(JSON+theX);
    }
  }

  void triggerArray() {
    triggers.clear();
    for (int y = 1; y < Variables; y++) {
      for (int x = 0; x < LayerStates; x++) {
        if (gui.Ani.get(x, y) == true) {
          Trigger Animate;
          Animate = new Trigger(x, y, AniEnd[x][y]);
          triggers.add(Animate);
        }
      }
    }
  }

  void TabToggle() {
    for (int y = 1; y < Variables; y++) {
      for (int x = 0; x < LayerStates; x++) {
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