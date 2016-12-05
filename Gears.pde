class Gear {
  float RX, RY, C, T, R, I, GX, GY;
  int P;
  PVector Grind;

  Gear(float rx, float ry, int p) {

    RX = rx;
    RY = ry;
    P = p;
    R = 1/(P-1);
    C = RX * TAU;
    T = TAU/C * I;
    //I = 0;
    Grind = new PVector();
  }


  void grinding() {
    Grind.x = cos(T/R) * RX;
    Grind.y = sin(T/R) * RY;
  }


  //void display() {
  //  fill(0);
  //  for (I = 0; I < C; I++) {
  //    grinding();
  //    T = TAU/C * I;
  //    ellipse(CX + Grind.x, CY - Grind.y, LX, LY);
  //  }
  //}
}