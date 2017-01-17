class Animation { //<>//
  int Interval, Triggers, Variables;
  float TotalTime, temp, aniInterval, LayerState;
  ArrayList <Trigger> triggers = new ArrayList<Trigger>();
  Trigger test1, test2;
  boolean Matrix[][];
  boolean Lock[][];
  int start, intervals, end, check_fwd, check_bwd;

  Animation() {
    Ani.setDefaultTimeMode(Ani.SECONDS);
    TotalTime = 2000;
    Triggers = 8;
    Interval = int(TotalTime/Triggers);
    aniInterval = float(Interval)/1000;
    Variables = 3;
    Matrix = new boolean[Triggers][Variables];
    Lock = new boolean[Triggers][Variables];
    for (int x = 0; x < Triggers; x++) {
      for (int y = 1; y < Variables; y++) {
        Lock[x][y] = false;
      }
    }
    test1 = new Trigger(0);
    test2 = new Trigger(1);
    triggers.add(test1);
    triggers.add(test2);
   }

  void TriggerArray() {

    // update boolean Matrix with current state of Ani
    for (int y = 1; y < Variables; y++) {
      for (int x = 0; x < Triggers; x++) {
        Matrix[x][y] =  gui.Ani.get(x, y);
      }
    }
    updateTrigger();
  }

  void updateTrigger() {

    for (int y = 1; y < Variables; y++) {
      for (int x = 0; x < Triggers; x++) {
        if (Matrix[x][y] == true) {
          start = x;
          check_fwd = (Triggers-1)-start;
          //println("start = " + start);

          for (int i=0; i <= check_fwd; i++) {
            if (Matrix[start+i][y] == false) {
              intervals = i;
              end = (start + i)-1;
              //Lock[start+i][y] = true;
              check_fwd = (Triggers-1)-end;
              //println(start, intervals, end, check_fwd);
              break;
            }
          }
          for(Trigger myTrigger : triggers){
           myTrigger.update(start, intervals); 
           println(start, intervals, end, y);
          }
          
          //Trigger newTrigger;
          //newTrigger = new Trigger(start, intervals, end, y);
          //triggers.add(newTrigger); 
          break;
        }
      }
    }
  }




  void layerState(int trigger) {
    // this is reset when looped
    if (trigger == 0) {
      gui.Layer.load(JSON+0);
    }
  }


  void triggerState(int trigger, int variable) {
    // gets passed theX from matrix and checks if its the trigger ID
    if (variable > 0) {
   
      for (Trigger myTrigger : triggers) {
        if (trigger == myTrigger.Start && variable == myTrigger.ParameterID+1) {
          myTrigger.anit();
         
        }
      }
    }
  }
}


class Trigger {

  //ScrollableList Easing;

  int LayerID, TriggerID, ParameterID;//
  int Start, Stop, Interval, Var;
  int xpos, xwidth, ypos;
  float value, duration;
  JSONObject LayerStateStart, LayerStateEnd;
  String[] Parameters = {"RX", "RY"};
  Easing[] easings = { Ani.LINEAR, Ani.QUAD_IN, Ani.QUAD_OUT, Ani.QUAD_IN_OUT, Ani.CUBIC_IN, Ani.CUBIC_IN_OUT, Ani.CUBIC_OUT, Ani.QUART_IN, Ani.QUART_OUT, Ani.QUART_IN_OUT, Ani.QUINT_IN, Ani.QUINT_OUT, Ani.QUINT_IN_OUT, Ani.SINE_IN, Ani.SINE_OUT, Ani.SINE_IN_OUT, Ani.CIRC_IN, Ani.CIRC_OUT, Ani.CIRC_IN_OUT, Ani.EXPO_IN, Ani.EXPO_OUT, Ani.EXPO_IN_OUT, Ani.BACK_IN, Ani.BACK_OUT, Ani.BACK_IN_OUT, Ani.BOUNCE_IN, Ani.BOUNCE_OUT, Ani.BOUNCE_IN_OUT, Ani.ELASTIC_IN, Ani.ELASTIC_OUT, Ani.ELASTIC_IN_OUT};
  //String[] easingsVariableNames = {"Ani.LINEAR", "Ani.QUAD_IN", "Ani.QUAD_OUT", "Ani.QUAD_IN_OUT", "Ani.CUBIC_IN", "Ani.CUBIC_IN_OUT", "Ani.CUBIC_OUT", "Ani.QUART_IN", "Ani.QUART_OUT", "Ani.QUART_IN_OUT", "Ani.QUINT_IN", "Ani.QUINT_OUT", "Ani.QUINT_IN_OUT", "Ani.SINE_IN", "Ani.SINE_OUT", "Ani.SINE_IN_OUT", "Ani.CIRC_IN", "Ani.CIRC_OUT", "Ani.CIRC_IN_OUT", "Ani.EXPO_IN", "Ani.EXPO_OUT", "Ani.EXPO_IN_OUT", "Ani.BACK_IN", "Ani.BACK_OUT", "Ani.BACK_IN_OUT", "Ani.BOUNCE_IN", "Ani.BOUNCE_OUT", "Ani.BOUNCE_IN_OUT", "Ani.ELASTIC_IN", "Ani.ELASTIC_OUT", "Ani.ELASTIC_IN_OUT"};
  int index;
  Easing currentEasing = easings[index];

  //Trigger(int start, int intervals, int stop, int parameter) {
  Trigger(int parameter) {
    //Start = start;
    //Stop = stop;
    //Interval = intervals + 1;
    //duration = (float(intervals) * gif.aniInterval);
    TriggerID = int(random(0, 1000));
    ParameterID = parameter;

    //xpos = start * (gui.mWidth/gif.Triggers);
    //xwidth = intervals * (gui.mWidth/gif.Triggers);
    //ypos = 530 + (parameter*50);
    //Easing = gui.cp5.addScrollableList("Easing" + TriggerID).setPosition(xpos, ypos).setWidth(xwidth).setHeight(140).close(); 
    //Easing.addItems(easingsVariableNames);
    //gui.cp5.getController("Easing" + TriggerID).moveTo("Easing Styles");

    LayerStateStart = loadJSONObject(JSON + Start + ".json");
    LayerStateEnd = loadJSONObject(JSON + Stop + ".json");
    if (ParameterID == 0) {
      value = map(LayerStateEnd.getJSONObject("/Radius Gear 0").getJSONArray("arrayValue").getFloat(0), 0, 1024, -512, 512);
    }
    if (ParameterID == 1) {
      value = map(LayerStateEnd.getJSONObject("/Radius Gear 0").getJSONArray("arrayValue").getFloat(1), 0, 1024, -512, 512);
    }
  }

  void update(int start, int intervals) {
    Start = start;
    Stop = (start + intervals)-1;
    duration = (float(intervals) * gif.aniInterval);
    //ParameterID = y - 1;
    xpos = start * (gui.mWidth/gif.Triggers);
    xwidth = intervals * (gui.mWidth/gif.Triggers);
    ypos = 530 + (50);
  }

  void anit() {
    Ani.to(layer_1.gear0, duration, Parameters[ParameterID], 200, Ani.QUAD_IN);
    println(ParameterID);
  }
}