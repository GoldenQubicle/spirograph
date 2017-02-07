class Layer3D {

  PVector XYZ; 
  Gears3D[] gears;
  Gears3D gear0, gear1, gear2, gear3;
  float SW, Theta, Phi;

  color Fill, Stroke;
  float LX, LY, PlotDots;
  boolean fill, stroke, lines, dots;


  Layer3D() {
    lights();
    XYZ = new PVector();
    gears = new Gears3D[4];
    gear0 = new Gears3D(120, 120, 102, 0);
    gear1 = new Gears3D(50, 50, 50, 7);
    gear2 = new Gears3D(30, 30, 30, 6);
    gear3 = new Gears3D(10, 10, 10, 5);
    gears[0] = gear0;
    gears[1] = gear1;
    gears[2] = gear2;
    gears[3] = gear3;
    SW=10;
  }

  void display() {
    noStroke();
    lights();

    //pushMatrix();
    //translate(width/2, height/2,0);

    float Spheres = 350;   
    for (float T = 0; T < Spheres; T+=2) {
      Theta = (TAU/Spheres)*T;
      for (float P = 0; P < Spheres; P+=2) {
        Phi = (PI/Spheres)*P;
        XYZ.x =  gear0.RX*cos(Theta)*sin(Phi) + gear1.RX*cos(Theta/gear1.Ratio())*sin(Phi/gear1.Ratio()) + gear2.RX*cos(Theta/gear2.Ratio())*sin(Phi/gear2.Ratio()) + gear3.RX*cos(Theta/gear3.Ratio())*sin(Phi/gear3.Ratio());
        XYZ.y =  gear0.RY*sin(Theta)*sin(Phi) + gear1.RY*sin(Theta/gear1.Ratio())*sin(Phi/gear1.Ratio()) + gear2.RY*sin(Theta/gear2.Ratio())*sin(Phi/gear2.Ratio()) + gear3.RY*sin(Theta/gear3.Ratio())*sin(Phi/gear3.Ratio()); 
        XYZ.z =  gear0.RZ*cos(Phi) + gear1.RZ*cos(Phi/gear1.Ratio()) + gear2.RZ*cos(Phi/gear2.Ratio()) + gear3.RZ*cos(Phi/gear3.Ratio());
        pushMatrix();
        translate(XYZ.x, XYZ.y, XYZ.z);
        sphere(0.5);
        sphereDetail(3);
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

  Gears3D(float rx, float ry, float rz, int p) {

    RX = rx;
    RY = ry;
    RZ = rz;
    A = (2*TAU)*sq(130);

    P = p;
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