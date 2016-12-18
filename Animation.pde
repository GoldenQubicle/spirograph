class Animation { //<>//
  int Interval, keyFrames, keyFrame;
  int start, delta, pdelta;
  float TotalTime, Start;

  Animation() {
    TotalTime = 1500;
    keyFrames = 16;
    Interval = int(TotalTime/keyFrames);
    keyFrame = 1;
    
    for(int i = 0; i <= keyFrames; i++){
      Layer KF = new Layer();
      KF.ID = i;
      layers.add(KF);
    }    
  }

  void Loop() {
    keyFrames();

    layers.get(keyFrame).display();

  }



  void Transitions() {
    // need to pass layer array
    // with number of layers corresponding to steps
    // lerp values by TotalTime / FPS = x number of steps
  }

  void Rendering() {
    // write layer & subsequent lerp frames into pixel array / PIamge
    // than iterate over that array
  }
  
  void keyFrames() {
    // runs continuously
    if ((tick == false) && (pause == false) && (pdelta == 0)) {
      delta = millis() - start;
      tock = false;
    }
    // what makes it tick
    if (delta > Interval) {
      tick = true;
    }
    // update Frame and set start to current millisecond
    if ((tick == true) && (pause == false)) { 
      start = millis();
      tick = false;
      tock = true;
      keyFrame = keyFrame + 1;
      if(keyFrame > keyFrames){
        keyFrame = 1;
      }
    }
    // when paused, calculate milliseconds left in Tick
    if ((tick == false) && (pause == true)) {
      pdelta = Interval-delta;
    }
    // when resumed from pause, continue 
    if ((tick == false) && (pause == false) && (pdelta > 0)) {
      delta = millis() - start;
      if (delta > pdelta) {
        tick = true;
        pdelta=0;
      }
    }
    println(keyFrame);
  }
}