class Gears {
  ControlP5 controls;
  float RX, RY, C, T, R, I, GX, GY;
  int P;
  PVector Grind;

  Gears(PApplet theApplet, float rx, float ry, int p) {

    controls = new ControlP5(theApplet);
    controls.addSlider("RadiusX");
    controls.addSlider("RadiusY");
    controls.addSlider("LineX");
    controls.addSlider("LineY");
    controls.addSlider("Petals");

    RX = rx;
    RY = ry;
    P = p;
    R = 1/(P-1);
    C = RX * TAU;
    T = TAU/C * I;
    I = 0;
    Grind = new PVector();
  }

  void grinding(int shift) {
    int Shift = shift;
    for (I = 0; I < C; I++) {
      T = TAU/C * I;
      if (Shift == 0) {  
        Grind.x = cos(T/R) * RX;
        Grind.y = sin(T/R) * RY;
        //println(Grind.x, Layer1.GearsXY.x );
      }
    }
    //return Grind;
  }
}