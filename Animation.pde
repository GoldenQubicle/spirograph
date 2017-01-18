class Animation { //<>//

  int Interval, LayerStates, Variables, CellWidth, CellHeight;
  float TotalTime, temp, aniInterval, LayerState;
  String [] Parameter = {"/Radius Gear 0", "/Radius Gear 1", "/Radius Gear 2", "/Radius Gear 3", "/Petals_1", "/Petals_2", "/Petals_3"}; 
  String[] Easing = {"Ani.LINEAR", "Ani.QUAD_IN", "Ani.QUAD_OUT", "Ani.QUAD_IN_OUT", "Ani.CUBIC_IN", "Ani.CUBIC_IN_OUT", "Ani.CUBIC_OUT", "Ani.QUART_IN", "Ani.QUART_OUT", "Ani.QUART_IN_OUT", "Ani.QUINT_IN", "Ani.QUINT_OUT", "Ani.QUINT_IN_OUT", "Ani.SINE_IN", "Ani.SINE_OUT", "Ani.SINE_IN_OUT", "Ani.CIRC_IN", "Ani.CIRC_OUT", "Ani.CIRC_IN_OUT", "Ani.EXPO_IN", "Ani.EXPO_OUT", "Ani.EXPO_IN_OUT", "Ani.BACK_IN", "Ani.BACK_OUT", "Ani.BACK_IN_OUT", "Ani.BOUNCE_IN", "Ani.BOUNCE_OUT", "Ani.BOUNCE_IN_OUT", "Ani.ELASTIC_IN", "Ani.ELASTIC_OUT", "Ani.ELASTIC_IN_OUT"};

  Animation() {
    Ani.setDefaultTimeMode(Ani.SECONDS);
    TotalTime = 2000;
    LayerStates = 8;
    Variables = 12; // one too many for top row matrix which needs to be active at all time
    Interval = int(TotalTime/LayerStates);
    aniInterval = float(Interval)/1000;
    CellWidth = 400/LayerStates;
    CellHeight = gui.mHeight/Variables;
  }

  void AniStart(int trigger, int variable) {
    // gets passed theX & theY from Matrix
  }


  void toggle() {
    for (int y = 1; y < Variables; y++) {
      for (int x = 0; x < LayerStates; x++) {
        if (gui.Ani.get(x, y) == true) {
          println(x,y); // need to store true x in array, and from arraylength construct same number of group with x as its start, possibly use xy as group name
          gui.cp5.getController(gui.Labels[y]).setVisible(true);
          gui.cp5.getController(gui.Labels[y]).setPosition(10+(x*CellWidth), 505+(20*y));
          //break; // so if break here, itll default to 1st x true, without break itll default to the last x true
        } 
      }
    }
  }
}