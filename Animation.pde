class Animation {
  int Interval, Steps, Parameters, FPS;
  float TotalTime;

  Animation() {
    TotalTime = 1000;
    Steps = 5;
    Interval = int(TotalTime/Steps);
    FPS = 15;
  
    
  }


  void Transitions() {
    // need to pass layer array
    // with number of layers corresponding to steps
    // lerp values by TotalTime / FPS = x number of steps
    
    
  }

  void Rendering(){
   // write layer & subsequent lerp frames into pixel array / PIamge
   // than iterate over that array
    
  }

}