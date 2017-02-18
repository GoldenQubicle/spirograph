class Layer { //<>//
  PVector XYZ, XY2;  
  float Theta, Phi, lx, ly, PlotDots, sw, Connect;
  Gears[] gears;
  Gears gear0, gear1, gear2, gear3;
  color Fill, Stroke;
  boolean stroke, fill, lines, dots, spheres3d;
  int ID;
  float r = .1;
  float circumference;

  Layer() {
    XYZ = new PVector();
    XY2 = new PVector();
    gears = new Gears[4];
    gear0 = new Gears(100, 100, 0);
    gear1 = new Gears(0, 0, 0);
    gear2 = new Gears(0, 0, 0);
    gear3 = new Gears(0, 0, 0);
    gears[0] = gear0;
    gears[1] = gear1;
    gears[2] = gear2;
    gears[3] = gear3;
    lx = 25;
    ly = 25;
    Fill = color(random(155, 255), random(155, 255), random(155, 255));
    Stroke = color(random(155, 255), random(155, 255), random(155, 255));
    PlotDots = 5000;
    stroke = false;
    fill = true;
    lines = false;
    dots = false;
    sw = 2;
    Connect = 2;
    ID = 1;
  }

  void display() {

     

    if (fill == true) {
      fill(Fill);
    }
    if (fill == false) {
      noFill();
    }
    if (stroke == true) {
      stroke(Stroke);
    }
    if (stroke == false) {
      noStroke();
    }
    // faux 3D, spinning over axis
    //pushMatrix();
    //translate(256,256);    
    //rotateX(r);
    //rotateY(r);
    //rotateZ(r);
    //translate(-256, -256);
    //pushMatrix();

    if (dots == true && lines == true) {
      Dots();
      Lines();
    } else if (lines == true) {
      Lines();
    } else if (dots == true) {
      Dots();
    } else if (spheres3d == true) {

      //     pushMatrix();
      //      translate(width/2, height/2, 0);
      sphere3d();
      //popMatrix();
    } else {     
      //Spiro();
      spiroMode();
    }
    //popMatrix();
    //r+=5;
    //popMatrix();
  }

  void sphere3d() {
    cam.setActive(true);
    lights();  
    float Spheres = 500;   
    for (float T = 0; T < Spheres; T+=2) {
      Theta = (TAU/Spheres)*T;
      for (float P = 0; P < Spheres; P+=2) {
        Phi = (PI/Spheres)*P;
        XYZ.x =  gear0.RX*cos(Theta)*sin(Phi) + gear1.RX*cos(Theta/gear1.Ratio())*sin(Phi/gear1.Ratio()) + gear2.RX*cos(Theta/gear2.Ratio())*sin(Phi/gear2.Ratio()) + gear3.RX*cos(Theta/gear3.Ratio())*sin(Phi/gear3.Ratio());
        XYZ.y =  gear0.RY*sin(Theta)*sin(Phi) + gear1.RY*sin(Theta/gear1.Ratio())*sin(Phi/gear1.Ratio()) + gear2.RY*sin(Theta/gear2.Ratio())*sin(Phi/gear2.Ratio()) + gear3.RY*sin(Theta/gear3.Ratio())*sin(Phi/gear3.Ratio()); 
        XYZ.z =  gear0.RZ*cos(Phi) + gear1.RZ*cos(Phi/gear1.Ratio()) + gear2.RZ*cos(Phi/gear2.Ratio()) + gear3.RZ*cos(Phi/gear3.Ratio());
        //pushMatrix();
        //translate(XYZ.x, XYZ.y, XYZ.z);
        //sphere(1);
        stroke(Fill);
        point(XYZ.x, XYZ.y, XYZ.z);
        //sphereDetail(3);
        //popMatrix();
      }
    }
  }

  void spiroMode() {    
    cam.setActive(false);
    for (int i = 0; i < PlotDots; i++) {
      Gears(i);
      XYZ.x = gear0.xyz.x + gear1.xyz.x + gear2.xyz.x + gear3.xyz.x;
      XYZ.y = gear0.xyz.y + gear1.xyz.y + gear2.xyz.y + gear3.xyz.y;
      strokeWeight(sw);
      ellipse(XYZ.x, XYZ.y, lx, ly);
    }
  }

  void Gears(int i) {
    for (Gears myGear : gears) {
      myGear.grinding(0, 1, 0, i, gear0.C);
    }
  }

  void Spiro() {
    cam.setActive(false);
    for (float i = 0; i < PlotDots; i++) {
      Theta = (TAU/gear0.C)*i;
      //Phi = Theta;// + r;
      //rotateY(r);
      XYZ.x = cos(Theta/gear0.Ratio())*gear0.RX + (cos(Theta/gear1.Ratio())*gear1.RX) + cos(Theta/gear2.Ratio())*gear2.RX + cos(Theta/gear3.Ratio())*gear3.RX;
      XYZ.y =  sin(Theta/gear0.Ratio())*gear0.RY + (sin(Theta/gear1.Ratio())*gear1.RY) + sin(Theta/gear2.Ratio())*gear2.RY  + sin(Theta/gear3.Ratio())*gear3.RY;
      strokeWeight(sw);
      ellipse(XYZ.x, XYZ.y, lx, ly);
      //r += .00000001;
    }
  }

  void Lines() {
    for (int G = 0; G < gears.length; G++) {
      for (float i = 0; i < gears[G].P; i++) {
        Theta = (TAU/gears[G].P)*i; 
        Phi = (TAU/gears[G].P)*(i+gears[G].Connect);
        XYZ.x =  cos(Theta)*gear0.RX + cos(Theta/gear1.Ratio())*gear1.RX + cos(Theta/gear2.Ratio())*gear2.RX + cos(Theta/gear3.Ratio())*gear3.RX;
        XYZ.y =  sin(Theta)*gear0.RY + sin(Theta/gear1.Ratio())*gear1.RY + sin(Theta/gear2.Ratio())*gear2.RY  + sin(Theta/gear3.Ratio())*gear3.RY;
        XY2.x =  cos(Phi)*gear0.RX + cos(Phi/gear1.Ratio())*gear1.RX + cos(Phi/gear2.Ratio())*gear2.RX + cos(Phi/gear3.Ratio())*gear3.RX;
        XY2.y =  sin(Phi)*gear0.RY + sin(Phi/gear1.Ratio())*gear1.RY + sin(Phi/gear2.Ratio())*gear2.RY  + sin(Phi/gear3.Ratio())*gear3.RY;
        strokeCap(ROUND);
        strokeJoin(ROUND);
        strokeWeight(sw);
        line(XYZ.x, XYZ.y, XY2.x, XY2.y);
      }
    }
  }

  void Dots() {
    for (int G = 0; G < gears.length; G++) {
      for (float i = 0; i < gears[G].P; i++) {
        Theta = (TAU/gears[G].P)*(i);
        XYZ.x = cos(Theta)*gear0.RX + cos(Theta/gear1.Ratio())*gear1.RX + cos(Theta/gear2.Ratio())*gear2.RX + cos(Theta/gear3.Ratio())*gear3.RX;
        XYZ.y = sin(Theta)*gear0.RY + sin(Theta/gear1.Ratio())*gear1.RY + sin(Theta/gear2.Ratio())*gear2.RY  + sin(Theta/gear3.Ratio())*gear3.RY;
        strokeWeight(sw);
        ellipse(XYZ.x, XYZ.y, lx, ly);
      }
    }
  }
}

class Gears {
  PVector xyz;
  float theta, RX, RY, RZ, C, Connect, P, R, move;

  Gears(float rx, float ry, float rz) {
    xyz = new PVector();    
    RX = rx;
    RY = ry;
    RZ = rz;
    R = 1/(P-1);
    C = ((RX+RY)/2) * TAU;
  }

  void grinding(int trigX, int trigY, int trigZ, int i, float circumference) {
    theta = ((TAU/circumference)*i)+move;
    //move += .01;

    if (trigX == 0) {
      xyz.x = cos(theta/Ratio())*RX;
    }
    if (trigX == 1) {
      xyz.x = sin(theta/Ratio())*RX;
    }
    if (trigX == 2) {
      xyz.x = tan(theta/Ratio())*RX;
    }
    if (trigY == 0) {
      xyz.y = cos(theta/Ratio())*RY;
    }
    if (trigY == 1) {
      xyz.y = sin(theta/Ratio())*RY;
    }
    if (trigY == 2) {
      xyz.y = tan(theta/Ratio())*RY;
    }
    if (trigZ == 0) {
      xyz.z = cos(theta/Ratio())*RZ;
    }
    if (trigZ == 1) {
      xyz.x = sin(theta/Ratio())*RZ;
    }
    if (trigZ == 2) {
      xyz.x = tan(theta/Ratio())*RZ;
    }
  }

  float Ratio() {
    R = 1/((P-1));   
    return (R);
  }
}