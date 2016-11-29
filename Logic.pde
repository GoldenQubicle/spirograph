class Logic {
  float RadiusX, RadiusY, Circumference;
  float RadiusX2, RadiusY2, Circumference2;
  float RadiusX3, RadiusY3, Circumference3;
  float RadiusX4, RadiusY4, Circumference4;
  float Petals, Petals2, Petals3, Ratio, Ratio2, Ratio3, Theta;
  PVector XY;  

  Logic() {
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
  }

  void display() {
    noStroke();

    //primary();
    //secundary();
    //tertiary();
    fourth();
  }

  void primary() {
    fill(0);
    for (float i = 0; i < Circumference; i++) {
      Theta = (TAU/Circumference)*i;
      XY.x = width/2 + cos(Theta) * RadiusX;
      XY.y = height/2 - sin(Theta) * RadiusY;
      ellipse(XY.x, XY.y, 2, 2);
    }
  }

  void secundary() {
    fill(255, 0, 0);
    for (float i = 0; i < Circumference + (Circumference2*Petals); i++) {
      Theta = (TAU/Circumference)*i;
      XY.x = width/2 + cos(Theta) * RadiusX + cos(Theta/Ratio)*RadiusX2;
      XY.y = height/2 - sin(Theta) * RadiusY + sin(Theta/Ratio)*RadiusY2;
      ellipse(XY.x, XY.y, 2, 2);
    }
  }

  void tertiary() {
    fill(0, 255, 0);
    for (float i = 0; i < (Circumference + (Circumference2*Petals) + (Circumference3*Petals2))*2; i++) {
      Theta = (TAU/Circumference)*i;
      XY.x = width/2 + cos(Theta) * RadiusX + cos(Theta/Ratio)*RadiusX2 + cos(Theta/Ratio2)*RadiusX3;
      XY.y = height/2 - sin(Theta) * RadiusY + sin(Theta/Ratio)*RadiusY2 + sin(Theta/Ratio2)*RadiusY3;
      ellipse(XY.x, XY.y, 2, 2);
    }
  }

  void fourth() {
    fill(0, 0,255);
    for (float i = 0; i < (Circumference + (Circumference2*Petals) + (Circumference3*Petals2) + (Circumference4*Petals3))*2; i++) {
      Theta = (TAU/Circumference)*i;
      XY.x = width/2 + cos(Theta) * RadiusX + cos(Theta/Ratio)*RadiusX2 + cos(Theta/Ratio2)*RadiusX3 + cos(Theta/Ratio3)*RadiusX4;
      XY.y = height/2 - sin(Theta) * RadiusY + sin(Theta/Ratio)*RadiusY2 + sin(Theta/Ratio2)*RadiusY3  + sin(Theta/Ratio3)*RadiusY4;
      ellipse(XY.x, XY.y, 2, 2);
    }
  }
}