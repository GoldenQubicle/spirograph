class Gears {

  float RX, RY, C, R, Connect, P;

  Gears(float rx, float ry, float p) {
    RX = rx;
    RY = ry;
    P = p;
    R = 1/(P-1);
    C = RX * TAU;
  }

  float Ratio() {
    R = 1/(P-1);
    return R;
  }
}