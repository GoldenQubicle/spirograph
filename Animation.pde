class Animation { //<>//
  int Interval, keyFrames, index;
  int start, delta, pdelta;
  float TotalTime, Start;

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
    //println(layers.size());
  }

  void Loop() {

    layers.get(index+1).display();
  }

  void Transitions() {
    // need to pass layer array
    // with number of layers corresponding to steps
    // lerp values by TotalTime / FPS = x number of steps
  }

  //void Rendering() {
  //  // write layer & subsequent lerp frames into pixel array / PIamge
  //  // than iterate over that array
  //}

  //int keyFrames() {

  //  //println(tick, tock, start, delta);

  //  // runs continuously
  //  if ((tick == false) && (pause == false) && (pdelta == 0)) {
  //    delta = millis() - start;
  //    tock = false;
  //  }
  //  // what makes it tick
  //  if (delta > Interval) {
  //    tick = true;
  //  }
  //  // update Frame and set start to current millisecond
  //  if ((tick == true) && (pause == false)) { 
  //    start = millis();
  //    tick = false;
  //    tock = true;
  //    index = index + 1;
  //    if (index >= keyFrames) {
  //      index = 0;
  //    }
  //  }
  //  //when paused, calculate milliseconds left in Tick
  //  //if ((tick == false) && (pause == true)) {
  //  //  pdelta = Interval-delta;
  //  //}
  //  //when resumed from pause, continue 
  //  if ((tick == false) && (pause == false) && (pdelta > 0)) {
  //    delta = millis() - start;
  //    tock = false;
  //    //delta = millis() - start;
  //    //if (delta > pdelta) {
  //    tick = true;
  //    //pdelta=0;
    
  //}
  //return index;
}
//