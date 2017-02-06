class Layer3D {

  PVector XYZ; 
  Gears3D[] gears;
  Gears3D gear0, gear1, gear2, gear3;
  float SW, Theta, Phi;

  color Fill, Stroke;
  float LX, LY, PlotDots;
  boolean fill, stroke, lines, dots;


  Layer3D() {

    XYZ = new PVector();
    gears = new Gears3D[4];
    gear0 = new Gears3D(50, 50, 50);
    gear1 = new Gears3D(0, 0, 0);
    gear2 = new Gears3D(0, 0, 0);
    gear3 = new Gears3D(0, 0, 0);
    gears[0] = gear0;
    gears[1] = gear1;
    gears[2] = gear2;
    gears[3] = gear3;
    SW=10;
  }

  void display() {
    noStroke();
    lights();
    float Spheres = 10;   
    for (float i2 = 0; i2 <= (Spheres*2); i2++) {
 
    Theta = (TAU/(Spheres*2))*i2;
 
    for (float i = 0; i <= Spheres; i++) {
 
      float u = map (i, 0, Spheres, -1, 1);  
 
      XYZ.x =  gear0.RX*cos(Theta)*sqrt(1-(u*u));
      XYZ.y =  gear0.RY*sin(Theta)*sqrt(1-(u*u)); 
      XYZ.z =  gear0.RZ*u;
 
      pushMatrix();
      translate(XYZ.x, XYZ.y, XYZ.z);
      sphere(2);
      popMatrix();
    }
  }
    //popMatrix();
  }
}




class Gears3D {

  boolean cast;
  float RX, RY, RZ, A, C, R, fP, Connect;
  int P;

  Gears3D(float rx, float ry, float rz) {

    RX = rx;
    RY = ry;
    RZ = rz;
    A = (2*TAU)*sq(130);

    //P = p;
    R = 1/(P-1);
    C = ((RX+RY)/2) * TAU;
    cast = false;
    println(A);
  }


  float Area() {
    A =  sq((RX+RY+RZ/3)) * (2*TAU);    
    C = ((RX+RY)/2) * TAU;
    return C;
  }

  float Ratio() {
    if (cast == false) {
      R = 1/float((P-1));
    }
    if (cast == true) {
      fP = float(P);
      R = 1/((fP-1));
    }
    return R;
  }
}