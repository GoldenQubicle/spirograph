class Animation { //<>//
  int Interval, keyFrames, index;
  float TotalTime;

  Animation() {
    TotalTime = 5000;
    keyFrames = 5;
    Interval = int(TotalTime/keyFrames);
    index = 0;

    for (int i  = 0; i <= keyFrames; i++) {
      Layer KF = new Layer();
      KF.ID = i;
      layers.add(KF);
    } 
  
  }
}

  