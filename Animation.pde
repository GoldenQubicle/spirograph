class Animation { //<>//
  int Interval, Triggers, frames;
  float TotalTime;
  int am[][];

  Trigger Test;


  Animation() {
    TotalTime = 1000;
    Triggers = 5 ;
    Interval = int(TotalTime/Triggers);
    frames = 5;
    Test = new Trigger(1); // to start with, triggers need to be constructed with id passed as keyframes, than put it into array
   

    //am = new int[keyFrames][1];
    //for (int i = 0; i < keyFrames; i++) {
    //  am[i][0] = temp;
    //  temp = temp + 50;       
    //}
  }

  void Trigger(int trigger) {



    if (trigger == Test.id) {
      Test.increase();
  
      //Trigger = new Ani(layer_1.gear0, 1, "RX", temp);
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

    Ani.to(layer_1.gear0, 1, "RX", temp);
    temp = temp + 50;
 
  }
}