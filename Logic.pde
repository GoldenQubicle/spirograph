class Logic {
  float RadiusX, RadiusY, Circumference;
  float RadiusX2, RadiusY2, Circumference2;
  float RadiusX3, RadiusY3, Circumference3;
  float Petals, Petals2, Ratio, Ratio2, Theta;
  PVector XY;  

  Logic() {
    Petals = 5;
    Petals2 = 50;
    Ratio = 1/(Petals-1);
    Ratio2 = 1/(Petals2-1);
    RadiusX = 150;
    RadiusY = 150;
    RadiusX2 = 100;
    RadiusY2 = 100;
    RadiusX3 = 50;
    RadiusY3 = 50;
    Circumference = RadiusX * TAU;
    Circumference2 = RadiusX2 * TAU;
    Circumference3 = RadiusX3 * TAU;
    XY = new PVector();
  }

  void display() {
    noStroke();
 
    //primary();
    secundary();
    tertiary();
  }

  void primary() {
    fill(255, 0, 0);
    for (float i = 0; i < Circumference; i++) {
      Theta = (TAU/Circumference)*i;
      XY.x = width/2 + cos(Theta) * RadiusX;
      XY.y = height/2 - sin(Theta) * RadiusY;
      ellipse(XY.x, XY.y, 2, 2);
    }
  }

  void secundary() {
     fill(0, 0, 255);
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
}