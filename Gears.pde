class Gears {

  float RX, RY, C, R, Connect;//, P;
  int P;
  Gears(float rx, float ry, int p) {
    RX = rx;
    RY = ry;
    P = p;
    R = 1/(P-1);
    C = RX * TAU;
  }

  float Ratio() {
    R = 1/float((P-1));
    return R;
  }
}