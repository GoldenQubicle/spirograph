class Layer { //<>//
  PVector XY, XY2;  
  float Theta, LX, LY, PlotDots, thelta, SW, Connect;
  Gears[] gears;
  Gears gear0, gear1, gear2, gear3;
  color Fill, Stroke;
  boolean stroke, fill, lines, dots;
  int ID;
  float r = .1;
  Layer() {
    XY = new PVector();
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
    } else {     
      Spiro();
    }
    //popMatrix();
    //r+=.01;
    //popMatrix();
  }

  void sphere3d() {

    noStroke();
    lights();
    translate(gear1.RX, gear1.RY, gear2.RX);
    sphere(SW);
  }

  void experimental() {
    XY.x = gear0.RX;
    XY.y =  gear0.RY;
    LX = gear1.RX;
    LY = gear1.RY;
    rectMode(CENTER);
    strokeWeight(SW);
    rect(XY.x, XY.y, LX, LY);
  }

  void Spiro() {
    for (float i = 0; i < PlotDots; i++) {
      Theta = (TAU/gear0.C)*i;
      XY.x = width/2 + cos(Theta)*gear0.RX + cos(Theta/gear1.Ratio())*gear1.RX + cos(Theta/gear2.Ratio())*gear2.RX + cos(Theta/gear3.Ratio())*gear3.RX;
      XY.y = height/2 - sin(Theta)*gear0.RY + sin(Theta/gear1.Ratio())*gear1.RY + sin(Theta/gear2.Ratio())*gear2.RY  + sin(Theta/gear3.Ratio())*gear3.RY;
      strokeWeight(1);
      ellipse(XY.x, XY.y, LX, LY);
    }
  }

  void Lines() {
    for (int G = 0; G < gears.length; G++) {
      for (float i = 0; i < gears[G].P; i++) {
        Theta = (TAU/gears[G].P)*i; 
        thelta = (TAU/gears[G].P)*(i+gears[G].Connect);
        XY.x = width/2 + cos(Theta)*gear0.RX + cos(Theta/gear1.Ratio())*gear1.RX + cos(Theta/gear2.Ratio())*gear2.RX + cos(Theta/gear3.Ratio())*gear3.RX;
        XY.y = height/2 - sin(Theta)*gear0.RY + sin(Theta/gear1.Ratio())*gear1.RY + sin(Theta/gear2.Ratio())*gear2.RY  + sin(Theta/gear3.Ratio())*gear3.RY;
        XY2.x = width/2 + cos(thelta)*gear0.RX + cos(thelta/gear1.Ratio())*gear1.RX + cos(thelta/gear2.Ratio())*gear2.RX + cos(thelta/gear3.Ratio())*gear3.RX;
        XY2.y = height/2 - sin(thelta)*gear0.RY + sin(thelta/gear1.Ratio())*gear1.RY + sin(thelta/gear2.Ratio())*gear2.RY  + sin(thelta/gear3.Ratio())*gear3.RY;
        strokeCap(ROUND);
        strokeJoin(ROUND);
        strokeWeight(SW);
        line(XY.x, XY.y, XY2.x, XY2.y);
      }
    }
  }

  void Dots() {
    for (int G = 0; G < gears.length; G++) {
      for (float i = 0; i < gears[G].P; i++) {
        Theta = (TAU/gears[G].P)*(i);
        XY.x = width/2 + cos(Theta)*gear0.RX + cos(Theta/gear1.Ratio())*gear1.RX + cos(Theta/gear2.Ratio())*gear2.RX + cos(Theta/gear3.Ratio())*gear3.RX;
        XY.y = height/2 - sin(Theta)*gear0.RY + sin(Theta/gear1.Ratio())*gear1.RY + sin(Theta/gear2.Ratio())*gear2.RY  + sin(Theta/gear3.Ratio())*gear3.RY;
        strokeWeight(SW);
        ellipse(XY.x, XY.y, LX, LY);
      }
    }
  }
}

class Gears {
  boolean cast;
  float RX, RY, C, R, fP, Connect;
  int P;
  Gears(float rx, float ry, int p) {
    RX = rx;
    RY = ry;
    P = p;
    R = 1/(P-1);
    C = ((RX+RY)/2) * TAU;
    cast = false;
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