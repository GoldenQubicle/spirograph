class Layer { //<>//
  PVector XYZ, XY2;  
  float Theta, Phi, LX, LY, PlotDots, SW, Connect;
  Gears[] gears;
  Gears gear0, gear1, gear2, gear3;
  color Fill, Stroke;
  boolean stroke, fill, lines, dots, spheres3d;
  int ID;
  float r = .1;
  Layer() {
    XYZ = new PVector();
    XY2 = new PVector();
    gears = new Gears[4];
    gear0 = new Gears(130, 130, 0);
    gear1 = new Gears(0, 0, 0);
    gear2 = new Gears(0, 0, 0);
    gear3 = new Gears(0, 0, 0);
    gears[0] = gear0;
    gears[1] = gear1;
    gears[2] = gear2;
    gears[3] = gear3;
    LX = 2.5;
    LY = 2.5;
    Fill = color(random(155, 255), random(155, 255), random(155, 255));
    Stroke = color(random(155, 255), random(155, 255), random(155, 255));
    PlotDots = 5000;
    stroke = true;
    fill = true;
    lines = false;
    dots = false;
    SW = 2;
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
    ////rotateX(r);
    ////rotateY(r);
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
      Spiro();
    }
    //popMatrix();
    //r+=.01;
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
        stroke(255, 255, 255);
        point(XYZ.x, XYZ.y, XYZ.z);
        //sphereDetail(3);
        //popMatrix();
      }
    }

  }


  void Spiro() {
    cam.setActive(false);
    for (float i = 0; i < PlotDots; i++) {
      Theta = (TAU/gear0.C)*i;
      XYZ.x = cos(Theta)*gear0.RX + cos(Theta/gear1.Ratio())*gear1.RX + cos(Theta/gear2.Ratio())*gear2.RX + cos(Theta/gear3.Ratio())*gear3.RX;
      XYZ.y =  sin(Theta)*gear0.RY + sin(Theta/gear1.Ratio())*gear1.RY + sin(Theta/gear2.Ratio())*gear2.RY  + sin(Theta/gear3.Ratio())*gear3.RY;
      strokeWeight(1);
      ellipse(XYZ.x, XYZ.y, LX, LY);
    }

  }

  void Lines() {
    for (int G = 0; G < gears.length; G++) {
      for (float i = 0; i < gears[G].P; i++) {
        Theta = (TAU/gears[G].P)*i; 
        Phi = (TAU/gears[G].P)*(i+gears[G].Connect);
        XYZ.x = width/2 + cos(Theta)*gear0.RX + cos(Theta/gear1.Ratio())*gear1.RX + cos(Theta/gear2.Ratio())*gear2.RX + cos(Theta/gear3.Ratio())*gear3.RX;
        XYZ.y = height/2 - sin(Theta)*gear0.RY + sin(Theta/gear1.Ratio())*gear1.RY + sin(Theta/gear2.Ratio())*gear2.RY  + sin(Theta/gear3.Ratio())*gear3.RY;
        XY2.x = width/2 + cos(Phi)*gear0.RX + cos(Phi/gear1.Ratio())*gear1.RX + cos(Phi/gear2.Ratio())*gear2.RX + cos(Phi/gear3.Ratio())*gear3.RX;
        XY2.y = height/2 - sin(Phi)*gear0.RY + sin(Phi/gear1.Ratio())*gear1.RY + sin(Phi/gear2.Ratio())*gear2.RY  + sin(Phi/gear3.Ratio())*gear3.RY;
        strokeCap(ROUND);
        strokeJoin(ROUND);
        strokeWeight(SW);
        line(XYZ.x, XYZ.y, XY2.x, XY2.y);
      }
    }
  }

  void Dots() {
    for (int G = 0; G < gears.length; G++) {
      for (float i = 0; i < gears[G].P; i++) {
        Theta = (TAU/gears[G].P)*(i);
        XYZ.x = width/2 + cos(Theta)*gear0.RX + cos(Theta/gear1.Ratio())*gear1.RX + cos(Theta/gear2.Ratio())*gear2.RX + cos(Theta/gear3.Ratio())*gear3.RX;
        XYZ.y = height/2 - sin(Theta)*gear0.RY + sin(Theta/gear1.Ratio())*gear1.RY + sin(Theta/gear2.Ratio())*gear2.RY  + sin(Theta/gear3.Ratio())*gear3.RY;
        strokeWeight(SW);
        ellipse(XYZ.x, XYZ.y, LX, LY);
      }
    }
  }
}

class Gears {
  float RX, RY, RZ, C, fP, Connect;

  float P, R;

  Gears(float rx, float ry, float rz) {
    RX = rx;
    RY = ry;
    RZ = rz;
    R = 1/(P-1);
    C = ((RX+RY)/2) * TAU;
  }

  float Ratio() {

    R = 1/((P-1));    


    return (R);
  }
}