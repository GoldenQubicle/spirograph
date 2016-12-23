class Gears {
  boolean cast;
  float RX, RY, C, R, Connect, fP;
  int P;
  Gears(float rx, float ry, int p) {
    RX = rx;
    RY = ry;
    P = p;
    R = 1/(P-1);
    C = RX * TAU;
    cast = false;
  }

  float Ratio() {
    if(cast == false){
    R = 1/float((P-1));
    }
    if(cast == true){
        fP = float(P);
      R = 1/((fP-1));
    }
    return R;
  }
}