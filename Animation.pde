class Animation { //<>//
  int Interval, Triggers, frames;
  float TotalTime, temp;
  int am[][];
  float values[];
  Trigger Test;


  Animation() {
    TotalTime = 1000;
    Triggers = 5 ;
    Interval = int(TotalTime/Triggers);
    frames = 5;
    Test = new Trigger(1); // to start with, triggers need to be constructed with id passed as keyframes, than put it into array
     temp = 100;
    values = new float[Triggers];
    for (int i = 0; i < Triggers;i++){
     values[i] = temp; 
     temp = temp + 25;
    }
    //am = new int[keyFrames][1];
    //for (int i = 0; i < keyFrames; i++) {
    //  am[i][0] = temp;
    //  temp = temp + 50;       
    //}
  }
  
  
  void layerState(int trigger){
   layer_1.gear0.RX = values[trigger]; 
  }

  void triggerState(int trigger) {

    if (trigger == Test.id) {
      Test.increase();
    }
  }
}


class Trigger {
  int id;
  int temp; 
  Ani test;
  // so the trigger constructor is going to take a lot of parameters so I can pass all kinds of values & variables
  Trigger(int ID) {
    id = ID;
    // object|length*|variable|value|anistyle 
    //test = new Ani(layer_1.gear0, 1, "RX", temp);
  }

  void increase() {

    Ani.to(layer_1.gear0, .2, "RX", temp);
    temp = temp + 50;
    println(temp);
 
  }
}