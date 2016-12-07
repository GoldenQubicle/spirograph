class LayerS {
  PVector XY;  
  float Theta, LX, LY;
  Gears gear0, gear1, gear2, gear3;
  color C;
  int Shift;

  LayerS() {
    XY = new PVector();
    gear0 = new Gears(75, 75, 0);
    gear1 = new Gears(75, 75, 7);
    gear2 = new Gears(50, 50, 0);
    gear3 = new Gears(25, 25, 0);
    LX = 2;
    LY = 2;
    C = color(random(155,255), random(155,255), random(155,255));
    Shift = 4;
  }

  void display() {
    noStroke();
    fill(C);
     Gear_3();
    //switch(Shift) {
    //  case 0:
    //    Gear_0();
    //    break;
    //  case 1:
    //    Gear_1();
    //    break;
    //  case 2:
    //    Gear_2();
    //    break;
    //  case 3:
    //    Gear_3();
    //    break;
    //}
  }

  //void Gear_0() {
  //  for (float i = 0; i < gear0.C; i++) {
  //    Theta = (TAU/gear0.C)*i;
  //    XY.x = width/2 + cos(Theta) * gear0.RX;
  //    XY.y = height/2 - sin(Theta) * gear0.RY;
  //    ellipse(XY.x, XY.y, LX, LY);
  //  }
  //}

  //void Gear_1() {
  //  for (float i = 0; i < (gear0.C + (gear1.C*gear1.P)*2); i++) {
  //    Theta = (TAU/gear0.C)*i;
  //    XY.x = width/2 + cos(Theta)*gear0.RX + cos(Theta/gear1.Ratio())*gear1.RX;
  //    XY.y = height/2 - sin(Theta)*gear0.RY + sin(Theta/gear1.Ratio())*gear1.RY;     
  //    ellipse(XY.x, XY.y, LX, LY);
  //  }
    
  //}

  //void Gear_2() {
  //  for (float i = 0; i < (gear0.C + (gear1.C*gear1.P)*2 + (gear2.C*gear2.P)*2); i++) {
  //    Theta = (TAU/gear0.C)*i;
  //    XY.x = width/2 + cos(Theta)*gear0.RX + cos(Theta/gear1.Ratio())*gear1.RX + cos(Theta/gear2.Ratio())*gear2.RX;
  //    XY.y = height/2 - sin(Theta)*gear0.RY + sin(Theta/gear1.Ratio())*gear1.RY + sin(Theta/gear2.Ratio())*gear2.RY;
  //    ellipse(XY.x, XY.y, LX, LY);
  //  }
  //}

  void Gear_3() {
    for (float i = 0; i < (gear0.C + (gear1.C*gear1.P) + (gear2.C*gear2.P)*2 + (gear3.C*gear3.P)*2); i++) {
      Theta = (TAU/gear0.C)*i;
      XY.x = width/2 + cos(Theta)*gear0.RX + cos(Theta/gear1.Ratio())*gear1.RX + cos(Theta/gear2.Ratio())*gear2.RX + cos(Theta/gear3.Ratio())*gear3.RX;
      XY.y = height/2 - sin(Theta)*gear0.RY + sin(Theta/gear1.Ratio())*gear1.RY + sin(Theta/gear2.Ratio())*gear2.RY  + sin(Theta/gear3.Ratio())*gear3.RY;
      ellipse(XY.x, XY.y, LX, LY);
    }
  }
}