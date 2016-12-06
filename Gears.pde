class Gears {

  float RX, RY, C, T, R, CX, CY, I, GX, GY;
  float P;
  PVector Grind;

  Gears(float rx, float ry, float p) {
    RX = rx;
    RY = ry;
    P = p;
    R = 1/(P-1);
    C = RX * TAU;
 
    I = 0;
    CX = width/2; // + cos(T) * RX;
    CY = height/2; //- sin(T) * RY;
    Grind = new PVector();

  }

  float Ratio(){
    R = 1/(P-1);
    return R;
  }

}