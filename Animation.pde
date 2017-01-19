class Animation { //<>//

  int Interval, LayerStates, Variables, MatrixWidth, MatrixHeight, CellWidth, CellHeight, GV, G;
  float TotalTime, temp, aniInterval, LayerState;
  String [] Parameter = {"/Radius Gear 0", "/Radius Gear 1", "/Radius Gear 2", "/Radius Gear 3", "/Petals_1", "/Petals_2", "/Petals_3"}; 
  Easing[] easings = { Ani.LINEAR, Ani.QUAD_IN, Ani.QUAD_OUT, Ani.QUAD_IN_OUT, Ani.CUBIC_IN, Ani.CUBIC_IN_OUT, Ani.CUBIC_OUT, Ani.QUART_IN, Ani.QUART_OUT, Ani.QUART_IN_OUT, Ani.QUINT_IN, Ani.QUINT_OUT, Ani.QUINT_IN_OUT, Ani.SINE_IN, Ani.SINE_OUT, Ani.SINE_IN_OUT, Ani.CIRC_IN, Ani.CIRC_OUT, Ani.CIRC_IN_OUT, Ani.EXPO_IN, Ani.EXPO_OUT, Ani.EXPO_IN_OUT, Ani.BACK_IN, Ani.BACK_OUT, Ani.BACK_IN_OUT, Ani.BOUNCE_IN, Ani.BOUNCE_OUT, Ani.BOUNCE_IN_OUT, Ani.ELASTIC_IN, Ani.ELASTIC_OUT, Ani.ELASTIC_IN_OUT};
  Ani Trigger;
  String [] GearVars = {"RX", "RY", "P"};

  Animation() {
    Ani.setDefaultTimeMode(Ani.SECONDS);
    TotalTime = 2000;
    LayerStates = 8;
    Variables = 12; // one too many for top row matrix which needs to be active at all time
    Interval = int(TotalTime/LayerStates);
    aniInterval = float(Interval)/1000;
    MatrixWidth = 400;
    MatrixHeight = 240;
    CellWidth = MatrixWidth/LayerStates;    
    CellHeight = MatrixHeight/Variables;
    //Trigger = Ani.to(layer_1.gear0, aniInterval, GearVars[GV], 200, easings[0]);
  }

  void AniStart(int trigger, int variable) {

    // gets passed theX & theY from Matrix
    if (variable > 0 ) {
      if (variable == 1) {
        G = 0;
        GV = 0;
      }
      if (variable == 2) {
        G = 0;
        GV = 1;
      }
      if (variable == 3) {
        G = 1;
        GV = 2;
      }
      if (variable == 4) {
        G = 1;
        GV = 0;
      }
      if (variable == 5) {
        G = 1;
        GV = 1;
      }
      if (variable == 6) {
        G = 2;
        GV = 2;
      }
      if (variable == 7) {
        G = 2;
        GV = 0;
      }
      if (variable == 8) {
        G = 2;
        GV = 1;
      }
      if (variable == 9) {
        G = 3;
        GV = 2;
      }
      if (variable == 10) {
        G = 3;
        GV = 0;
      }
      if (variable == 11) {
        G = 3;
        GV = 1;
      }

      Ani.to(layer_1.gears[G], aniInterval, GearVars[GV], 20, easings[int(gui.cp5.getController("Easing" + trigger + variable).getValue())]);
    }
  }


  void toggle() {
    for (int y = 1; y < Variables; y++) {
      for (int x = 0; x < LayerStates; x++) {
        if (gui.Ani.get(x, y) == true) {
          //println(x,y); 
          gui.cp5.getController("Easing" + x + y).setVisible(true);
        }  
        if (gui.Ani.get(x, y) == false) {
          gui.cp5.getController("Easing" + x + y).setVisible(false);
        }
      }
    }
  }
}