class LayerS {

  Gear gear0, gear1;
  float LX, LY, CX, CY;
  color C;
  int Shift;

  LayerS() {
    gear0 = new Gear(150, 150, 0);
    gear1 = new Gear(100, 100, 2);
    LX = 2;
    LY = 2;
    CX = width/2;
    CY = height/2;
    C = color (10, 127, 67);
    Shift = 0;
  }

  void display() {
    noStroke();

    switch(Shift) {
    case 0:
      Gear_0();
      break;
    case 1: 
      Gear_1();
      break;
    }
    //Gear_2();
    //Gear_3();
  }


  void Gear_0() {
    fill(C);
    for (float i = 0; i < gear0.C; i++) {
      gear0.grinding();
      gear0.T = TAU/gear0.C * i;
      ellipse(CX + gear0.Grind.x, CY - gear0.Grind.y, LX, LY);
    }
  }

  void Gear_1() {
    fill(C);
    for (float i = 0; i < (gear0.C + gear1.C); i++) {

      gear0.T = TAU/gear0.C * i;
      gear1.T = TAU/gear1.C * i;
      //gear0.grinding();
      //gear1.grinding();
      //ellipse(CX + gear0.Grind.x + gear1.Grind.x, CY - gear0.Grind.y + gear1.Grind.y, LX, LY);
      ellipse(CX + cos(gear0.T)*gear0.RX + cos(gear1.T/gear1.R)*gear1.RX, CY - sin(gear1.T)*gear1.RY + sin(gear1.T/gear1.R)*gear1.RY, LX, LY);
    }

    //for (float i = 0; i < Circumference + (Circumference2*Petals); i++) {
    //  Theta = (TAU/Circumference)*i;
    //  XY.x = width/2 + cos(Theta) * RadiusX + cos(Theta/Ratio)*RadiusX2;
    //  XY.y = height/2 - sin(Theta) * RadiusY + sin(Theta/Ratio)*RadiusY2;
    //  ellipse(XY.x, XY.y, 2, 2);
    //}
  }

  //void Gear_2() {
  //  fill(0, 255, 0);
  //  for (float i = 0; i < (Circumference + (Circumference2*Petals) + (Circumference3*Petals2))*2; i++) {
  //    Theta = (TAU/Circumference)*i;
  //    XY.x = width/2 + cos(Theta) * RadiusX + cos(Theta/Ratio)*RadiusX2 + cos(Theta/Ratio2)*RadiusX3;
  //    XY.y = height/2 - sin(Theta) * RadiusY + sin(Theta/Ratio)*RadiusY2 + sin(Theta/Ratio2)*RadiusY3;
  //    ellipse(XY.x, XY.y, 2, 2);
  //  }
  //}

  //void Gear_3() {
  //  fill(0, 0, 255);
  //  for (float i = 0; i < (Circumference + (Circumference2*Petals) + (Circumference3*Petals2) + (Circumference4*Petals3))*2; i++) {
  //    Theta = (TAU/Circumference)*i;
  //    XY.x = width/2 + cos(Theta) * RadiusX + cos(Theta/Ratio)*RadiusX2 + cos(Theta/Ratio2)*RadiusX3 + cos(Theta/Ratio3)*RadiusX4;
  //    XY.y = height/2 - sin(Theta) * RadiusY + sin(Theta/Ratio)*RadiusY2 + sin(Theta/Ratio2)*RadiusY3  + sin(Theta/Ratio3)*RadiusY4;
  //    ellipse(XY.x, XY.y, 2, 2);
  //  }
  //}

  void addGear() {
    if (key == '+') {
      println("check");
      Shift = 1;
    }
  }
}