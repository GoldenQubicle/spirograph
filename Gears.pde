class Gears {

  float RX, RY, C, R, GX, GY;
  float P;
  PVector Grind;
  boolean back = false;
  
  Gears(float rx, float ry, float p) {
    RX = rx;
    RY = ry;
    P = p;
    R = 1/(P-1);
    C = RX * TAU;
    Grind = new PVector(RX, RY);
  }

  float Ratio() {
    R = 1/(P-1);
    return R;
  }
  
  
  void animate(){
  if(back == false){
   RX++;
   RY++;
  }
  if(RX > 150){
   back = true; 
  }
  if(back == true){ 
  RX--; 
  RY--;
  }
  if(RX < -150){
   back = false; 
  }
   println(RX);

    }
  
}