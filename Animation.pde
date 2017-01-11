class Animation { //<>//
  int Interval, Triggers, Variables;
  float TotalTime, temp, aniInterval, LayerState;
  float values[];
  Trigger [] triggers;
  Trigger test1, test2;
  boolean Matrix[][];
  int start, intervals, end, check_fwd, check_bwd;

  Animation() {
    Ani.setDefaultTimeMode(Ani.SECONDS);
    TotalTime = 2000;
    Triggers = 8;
    Interval = int(TotalTime/Triggers);
    aniInterval = float(Interval)/1000;
    Variables = 3;
    Matrix = new boolean[Triggers][Variables];
    triggers = new Trigger[1];
    
  }

  void setLayerState(float buttonbar){
   int layerstate;
   layerstate = int(buttonbar);
 layer_1.gear0.RX = gui.LayerStates.getJSONObject(layerstate).getJSONObject("/Radius Gear 0").getJSONArray("arrayValue").getFloat(0);

  }

  void TriggerArray() {
    // construct boolean array 
    for (int x = 0; x < Triggers; x++) {
      for (int y = 0; y < Variables; y++) {
        Matrix[x][y] =  gui.Ani.get(x, y);
      }
    }
    for (int y = 1; y < Variables; y++) {
      for (int x = 0; x < Triggers; x++) {
        if (Matrix[x][y] == true) {
          start = x;
          check_fwd = (Triggers-1)-start;
          //println("start = " + start);

          for (int i=0; i <= check_fwd; i++) {
            if (Matrix[start+i][y] == true) {
              intervals = i+1;
              //println("intervals = " + intervals);
            }
          }
          for (int i = 0; i <= check_fwd; i++) {
            if (Matrix[start+i][y] == false) {
              end = (start+i)-1;
              //println("end = " + end);
              break;
            }
          }
          break;
        }
      }
    }
    // so this is here temporary, prolly want to move this? 
    test1 = new Trigger(start, intervals, end);
    triggers[0] = test1;
    //println(start, intervals, end);
  }


  void layerState(int trigger) {
    // this is reset when looped
    if (trigger == 0) {
      layer_1.gear0.RX = gui.LayerStates.getJSONObject(trigger).getJSONObject("/Radius Gear 0").getJSONArray("arrayValue").getFloat(0);
    }
  }


  void triggerState(int trigger, int variable) {
    // gets passed theX from matrix and checks if its the trigger ID
    if (variable > 0) { 
      for (Trigger myTrigger : triggers) {
        if (trigger == myTrigger.Start) {
          myTrigger.anit();
        }
      }
    }
  }
}



class Trigger {

  int LayerID;//
  int Start, Stop, Var; 
  float value, duration;

  Easing[] easings = { Ani.LINEAR, Ani.QUAD_IN, Ani.QUAD_OUT, Ani.QUAD_IN_OUT, Ani.CUBIC_IN, Ani.CUBIC_IN_OUT, Ani.CUBIC_OUT, Ani.QUART_IN, Ani.QUART_OUT, Ani.QUART_IN_OUT, Ani.QUINT_IN, Ani.QUINT_OUT, Ani.QUINT_IN_OUT, Ani.SINE_IN, Ani.SINE_OUT, Ani.SINE_IN_OUT, Ani.CIRC_IN, Ani.CIRC_OUT, Ani.CIRC_IN_OUT, Ani.EXPO_IN, Ani.EXPO_OUT, Ani.EXPO_IN_OUT, Ani.BACK_IN, Ani.BACK_OUT, Ani.BACK_IN_OUT, Ani.BOUNCE_IN, Ani.BOUNCE_OUT, Ani.BOUNCE_IN_OUT, Ani.ELASTIC_IN, Ani.ELASTIC_OUT, Ani.ELASTIC_IN_OUT};
  String[] easingsVariableNames = {"Ani.LINEAR", "Ani.QUAD_IN", "Ani.QUAD_OUT", "Ani.QUAD_IN_OUT", "Ani.CUBIC_IN", "Ani.CUBIC_IN_OUT", "Ani.CUBIC_OUT", "Ani.QUART_IN", "Ani.QUART_OUT", "Ani.QUART_IN_OUT", "Ani.QUINT_IN", "Ani.QUINT_OUT", "Ani.QUINT_IN_OUT", "Ani.SINE_IN", "Ani.SINE_OUT", "Ani.SINE_IN_OUT", "Ani.CIRC_IN", "Ani.CIRC_OUT", "Ani.CIRC_IN_OUT", "Ani.EXPO_IN", "Ani.EXPO_OUT", "Ani.EXPO_IN_OUT", "Ani.BACK_IN", "Ani.BACK_OUT", "Ani.BACK_IN_OUT", "Ani.BOUNCE_IN", "Ani.BOUNCE_OUT", "Ani.BOUNCE_IN_OUT", "Ani.ELASTIC_IN", "Ani.ELASTIC_OUT", "Ani.ELASTIC_IN_OUT"};
  int index;
  Easing currentEasing = easings[index];

  Trigger(int start, int intervals, int end) {
    Start = start;
    Stop = end;
    duration = (float(intervals) * gif.aniInterval);
    value = gui.LayerStates.getJSONObject(end).getJSONObject("/Radius Gear 0").getJSONArray("arrayValue").getFloat(0);
 
  }


  void anit() {
    Ani.to(layer_1.gear0, duration, "RX", value, Ani.LINEAR);
    println(value);
  }

}