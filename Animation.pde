class Animation { //<>//
  int Interval, Triggers, easing;
  float TotalTime, temp, ms;
  float values[];
  Trigger [] triggers;
  Trigger trig;

  Animation() {
    TotalTime = 5000;
    Triggers = 5 ;
    Interval = int(TotalTime/Triggers);
    ms = (TotalTime/1000)/5;

    triggers = new Trigger[Triggers];
    for (int i = 0; i < Triggers; i++) {
      trig = new Trigger(i, easing); 
      easing = easing + 5;
      triggers[i] = trig;
    }


    Ani.setDefaultTimeMode(Ani.SECONDS);

    temp = 100;
    values = new float[Triggers];
    for (int i = 0; i < Triggers; i++) {
      values[i] = temp; 
      temp = temp + 25;
    }
  }



  void layerState(int trigger) {
    layer_1.gear0.RX = values[trigger];
  }

  void triggerState(int trigger) {
    
   
    
    //for (Trigger myTrigger : triggers) {
    //  if (trigger == myTrigger.id) {
    //    myTrigger.anit();
    //  }
      //Ani.to(layer_1.gear0, ms, "RX", values[trigger], Ani.LINEAR);
    }
  }



class Trigger {
  int id, value;


  Easing[] easings = { Ani.LINEAR, Ani.QUAD_IN, Ani.QUAD_OUT, Ani.QUAD_IN_OUT, Ani.CUBIC_IN, Ani.CUBIC_IN_OUT, Ani.CUBIC_OUT, Ani.QUART_IN, Ani.QUART_OUT, Ani.QUART_IN_OUT, Ani.QUINT_IN, Ani.QUINT_OUT, Ani.QUINT_IN_OUT, Ani.SINE_IN, Ani.SINE_OUT, Ani.SINE_IN_OUT, Ani.CIRC_IN, Ani.CIRC_OUT, Ani.CIRC_IN_OUT, Ani.EXPO_IN, Ani.EXPO_OUT, Ani.EXPO_IN_OUT, Ani.BACK_IN, Ani.BACK_OUT, Ani.BACK_IN_OUT, Ani.BOUNCE_IN, Ani.BOUNCE_OUT, Ani.BOUNCE_IN_OUT, Ani.ELASTIC_IN, Ani.ELASTIC_OUT, Ani.ELASTIC_IN_OUT};
  String[] easingsVariableNames = {"Ani.LINEAR", "Ani.QUAD_IN", "Ani.QUAD_OUT", "Ani.QUAD_IN_OUT", "Ani.CUBIC_IN", "Ani.CUBIC_IN_OUT", "Ani.CUBIC_OUT", "Ani.QUART_IN", "Ani.QUART_OUT", "Ani.QUART_IN_OUT", "Ani.QUINT_IN", "Ani.QUINT_OUT", "Ani.QUINT_IN_OUT", "Ani.SINE_IN", "Ani.SINE_OUT", "Ani.SINE_IN_OUT", "Ani.CIRC_IN", "Ani.CIRC_OUT", "Ani.CIRC_IN_OUT", "Ani.EXPO_IN", "Ani.EXPO_OUT", "Ani.EXPO_IN_OUT", "Ani.BACK_IN", "Ani.BACK_OUT", "Ani.BACK_IN_OUT", "Ani.BOUNCE_IN", "Ani.BOUNCE_OUT", "Ani.BOUNCE_IN_OUT", "Ani.ELASTIC_IN", "Ani.ELASTIC_OUT", "Ani.ELASTIC_IN_OUT"};
  int index;
  Easing currentEasing = easings[index];

  Trigger(int ID, int Index) {
    id = ID;
    index = Index;
  }



  void anit() {
    Ani.to(layer_1.gear0, gif.ms, "RX", random(-100, 100), easings[index]); //  easing index needs to be set with gui
    Ani.to(layer_1.gear0, gif.ms, "RY", random(-100, 100), easings[index]); //  value via snapshot gui - hopefully
    Ani.to(layer_1.gear1, gif.ms, "P", random(5, 25), easings[index]);      //  which parameter to act on comes in via theY matrix
                                                                            //  the layer id is going to be passed via trigger object
    println(index);                                                         //  finally length is set by calculating active cells in matrix
  }
}