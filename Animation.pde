class Animation { //<>//
  int Interval, keyFrames, frames;
  float TotalTime;
  int am[][];
  int temp; // represents G0.RX
  Ani Trigger;
  ;


  Animation() {
    TotalTime = 1000;
    keyFrames = 5;
    Interval = int(TotalTime/keyFrames);
    frames = 1;
    temp = 0;

    //am = new int[keyFrames][1];
    //for (int i = 0; i < keyFrames; i++) {
    //  am[i][0] = temp;
    //  temp = temp + 50;       
    //}
  }

  void Trigger() {

    temp = temp + 50;
    Trigger = new Ani(layer_1.gear0, .2, "RX", temp);
  }
}