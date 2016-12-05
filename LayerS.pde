class LayerS {
<<<<<<< HEAD

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
=======
  float RadiusX, RadiusY, Circumference;
  float RadiusX2, RadiusY2, Circumference2;
  float RadiusX3, RadiusY3, Circumference3;
  float RadiusX4, RadiusY4, Circumference4;
  float Petals, Petals2, Petals3, Ratio, Ratio2, Ratio3, Theta;
  PVector XY;  

  LayerS() {
    Petals = 7;
    Petals2 = 49;
    Petals3 = 21;
    Ratio = 1/(Petals-1);
    Ratio2 = 1/(Petals2-1);
    Ratio3 = 1/(Petals3-1);
    RadiusX = 150;
    RadiusY = 150;
    RadiusX2 = 100;
    RadiusY2 = 100;
    RadiusX3 = 50;
    RadiusY3 = 50;
    RadiusX4 = 15;
    RadiusY4 = 15;
    Circumference = RadiusX * TAU;
    Circumference2 = RadiusX2 * TAU;
    Circumference3 = RadiusX3 * TAU;
    Circumference4 = RadiusX4 * TAU;
    XY = new PVector();
>>>>>>> parent of 628746b... some streamlining
  }

  void display() {
    noStroke();

<<<<<<< HEAD
    switch(Shift) {
    case 0:
      Gear_0();
      break;
    case 1: 
      Gear_1();
      break;
    }
=======
    //Gear_0();
    Gear_1();
>>>>>>> parent of 628746b... some streamlining
    //Gear_2();
    //Gear_3();
  }


  void Gear_0() {
<<<<<<< HEAD
    fill(C);
    for (float i = 0; i < gear0.C; i++) {
      gear0.grinding();
      gear0.T = TAU/gear0.C * i;
      ellipse(CX + gear0.Grind.x, CY - gear0.Grind.y, LX, LY);
=======
    fill(0);
    for (float i = 0; i < Circumference; i++) {
      Theta = (TAU/Circumference)*i;
      XY.x = width/2 + cos(Theta) * RadiusX;
      XY.y = height/2 - sin(Theta) * RadiusY;
      ellipse(XY.x, XY.y, 2, 2);
>>>>>>> parent of 628746b... some streamlining
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