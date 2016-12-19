class Animation { //<>//
  int Interval, keyFrames, frames;
  float TotalTime;
  int am[][];
  int temp; // represents G0.RX
  Ani diameterAni;
  AniSequence seq;

  Animation() {
    TotalTime = 1000;
    keyFrames = 5;
    Interval = int(TotalTime/keyFrames);
    frames = 1;
    temp = 0;
    am = new int[keyFrames][1];
    for (int i = 0; i < keyFrames; i++) {
      am[i][0] = temp;
      temp = temp + 50;
    }
    
    seq = new AniSequence(gui.parent);
    seq.beginSequence();   
    seq.add(Ani.to(layer_1.gear0, frames, "RX", am[0][0]));
    seq.add(Ani.to(layer_1.gear0, frames, "RX", am[1][0]));
    seq.add(Ani.to(layer_1.gear0, frames, "RX", am[2][0]));
    seq.add(Ani.to(layer_1.gear0, frames, "RX", am[3][0]));
    seq.add(Ani.to(layer_1.gear0, frames, "RX", am[4][0]));
    seq.endSequence();
    seq.start();
  }

}