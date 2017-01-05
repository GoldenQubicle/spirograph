class Animation { //<>//
  int Interval, Triggers, Variables;
  float TotalTime, temp, ms;
  float values[];
  Trigger [] triggers;
  Trigger test1, test2;
  boolean Matrix[][];
  int start, intervals, end, check_fwd, check_bwd;

  Animation() {
    Triggers = 8;
    Variables = 3;
    Matrix = new boolean[Triggers][Variables];

    TotalTime = 2000;
    Interval = int(TotalTime/Triggers);
    ms = Interval/1000;

    triggers = new Trigger[2];
    test1 = new Trigger(3, 1, 2);
    test2 = new Trigger(3, 1, 2);
    triggers[0] = test1;
    triggers[1] = test2;


    Ani.setDefaultTimeMode(Ani.SECONDS);
  }

  void TriggerArray() {
    // construct boolean array 
    for (int x = 0; x < Triggers; x++) {
      for (int y = 0; y < Variables; y++) {
        Matrix[x][y] =  gui.Ani.get(x, y);
      }
    }
    for (int y = 0; y < Variables; y++) {
      for (int x = 0; x < Triggers; x++) {
        if (Matrix[x][y] == true) {
          start = x;
          check_fwd = (Triggers-1)-start;

          for (int i=0; i <= check_fwd; i++) {
            if (Matrix[start+i][y] == true) {
              intervals = i+1;
              }
          }
          for(int i = 0;i <= check_fwd;i++){
           if(Matrix[start+i][y] == false){
             end = (start+i)-1;
             break;
           }
          }
          println(start,intervals,end);
          break;
        }
      }
    }
  }

  // so what I need in here is a function which creates an array of triggers based on the info send from pressing r

  void layerState(int trigger) {
    layer_1.gear0.RX = values[trigger];
  }

  void triggerState(int trigger) {
    // gets passed theX from matrix and checks if its the trigger ID
    for (Trigger myTrigger : triggers) {
      if (trigger == myTrigger.Start) {
        myTrigger.anit();
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

  Trigger(int thex, int thexstop, int var) {
    Start = thex;
    Stop = thexstop;
    Var = var;
    // in here want to calculate duration
    // also, need to make an update function
  }



  void anit() {
    //first 3 are passed via matrix, last two via yet to constructed gui elements 
    // Ani.to(

    Ani.to(layer_1.gear0, duration, "RX", random(-100, 100), easings[index]); //  easing index needs to be set with gui
    //Ani.to(layer_1.gear0, duration, "RY", random(-100, 100), easings[index]); //  value via snapshot gui - hopefully
    //Ani.to(layer_1.gear1, duration, "P", random(5, 25), easings[index]);      //  which parameter to act on comes in via theY matrix
    //  the layer id is going to be passed via trigger object
    //println(index);                                                         //  finally length is set by calculating active cells in matrix
  }
}