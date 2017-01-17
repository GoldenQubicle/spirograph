class Animation { //<>//

  int Interval, Triggers, Cells, CellWidth, CellHeight;
  float TotalTime, temp, aniInterval, LayerState;

  String [] Parameter = {"/Radius Gear 0", "/Radius Gear 1", "/Radius Gear 2", "/Radius Gear 3", "/Petals_1", "/Petals_2", "/Petals_3"}; 
  String[] Easing = {"Ani.LINEAR", "Ani.QUAD_IN", "Ani.QUAD_OUT", "Ani.QUAD_IN_OUT", "Ani.CUBIC_IN", "Ani.CUBIC_IN_OUT", "Ani.CUBIC_OUT", "Ani.QUART_IN", "Ani.QUART_OUT", "Ani.QUART_IN_OUT", "Ani.QUINT_IN", "Ani.QUINT_OUT", "Ani.QUINT_IN_OUT", "Ani.SINE_IN", "Ani.SINE_OUT", "Ani.SINE_IN_OUT", "Ani.CIRC_IN", "Ani.CIRC_OUT", "Ani.CIRC_IN_OUT", "Ani.EXPO_IN", "Ani.EXPO_OUT", "Ani.EXPO_IN_OUT", "Ani.BACK_IN", "Ani.BACK_OUT", "Ani.BACK_IN_OUT", "Ani.BOUNCE_IN", "Ani.BOUNCE_OUT", "Ani.BOUNCE_IN_OUT", "Ani.ELASTIC_IN", "Ani.ELASTIC_OUT", "Ani.ELASTIC_IN_OUT"};

  Animation() {
    Ani.setDefaultTimeMode(Ani.SECONDS);
    TotalTime = 2000;
    Triggers = 8;
    Cells = 12;
    Interval = int(TotalTime/Triggers);
    aniInterval = float(Interval)/1000;
    CellWidth = 400/Triggers;
    CellHeight = gui.mHeight/Cells;
    println(CellWidth);
  }

  void AniStart(int trigger, int variable) {
    // gets passed theX & theY from Matrix
  }


  void toggle() {

    for (int x = 0; x < Triggers; x++) {
      for (int y = 1; y < Cells; y++) {
        if (gui.Ani.get(x, y) == true) {

          gui.cp5.getController(gui.Labels[y]).setPosition(10+(x*CellWidth), 505+(20*y));
          //println(gui.Ani.get(x, y), gui.Labels[y], x);
          //println(gui.Labels[y], (10+(x*CellWidth)), 505+(20*y));
        }
      }
    }
  }
}