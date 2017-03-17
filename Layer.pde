class Layer {  //<>//

  String name;
  PVector xyz, xy2;  
  float theta, phi, lx, ly, density, sw, connectLines;
  Gears[] gears;
  Gears gear0, gear1, gear2, gear3;
  color cFill, cStroke;
  boolean stroke, fill, lines, dots, spheres3d;
  IntDict trig;
  int [] mode = {1, 2, 4, 16, 8, 64, 128, 256, 0};
  int blendSelect, id, kf;

  Layer(float radius) {
    id = 1;
    name = "Layer 1";
    xyz = new PVector();
    xy2 = new PVector();
    gears = new Gears[4];
    gear0 = new Gears(radius, radius, 0);
    gear1 = new Gears(0, 0, 0);
    gear2 = new Gears(0, 0, 0);
    gear3 = new Gears(0, 0, 0);
    gears[0] = gear0;
    gears[1] = gear1;
    gears[2] = gear2;
    gears[3] = gear3;
    lx = 2;
    ly = 2;
    cFill = color(random(155, 255), random(155, 255), random(155, 255));
    cStroke = color(random(155, 255), random(155, 255), random(155, 255));
    density = 25000;
    stroke = false;
    fill = true;
    lines = false;
    dots = false;
    sw = 2;
    connectLines = 2;
    trig = new IntDict();
    for (int g = 0; g < 4; g++) {
      trig.set("G"+g+"trigX", gears[g].trigX);
      trig.set("G"+g+"trigX2", gears[g].trigX2);
      trig.set("G"+g+"trigY", gears[g].trigY);
      trig.set("G"+g+"trigY2", gears[g].trigY2);
      trig.set("G"+g+"trigZ", gears[g].trigZ);
    }
  }

  void display() {     
    blendMode(mode[blendSelect]);
    if (fill == true) {      
      fill(cFill);
    }
    if (fill == false) {
      noFill();
    }
    if (stroke == true) {
      stroke(cStroke);
    }
    if (stroke == false) {
      noStroke();
    }
    if (dots == true && lines == true) {
      Dots();
      Lines();
    } else if (lines == true) {
      Lines();
    } else if (dots == true) {
      Dots();
    } else if (spheres3d == true) {
      sphere3d();
    } else {    
      spiroMode();
    }
  }

  void sphere3d() {
    cam.setActive(true);
    lights();  
    density = 500;       
    for (int t = 0; t < density; t+=2) {
      theta = (TAU/density)*t;
      for (int p = 0; p < density; p+=2) {
        phi = (PI/density)*p;
        Gears(theta, phi);
        xyz.x = gear0.xyz.x + gear1.xyz.x + gear2.xyz.x + gear3.xyz.x;
        xyz.y = gear0.xyz.y + gear1.xyz.y + gear2.xyz.y + gear3.xyz.y;
        xyz.z = gear0.xyz.z + gear1.xyz.z + gear2.xyz.z + gear3.xyz.z;
        stroke(cFill);
        strokeWeight(sw);
        point(xyz.x, xyz.y, xyz.z);   
        //pushMatrix();
        //translate(xyz.x, xyz.y, xyz.z);
        //sphere(3);
        //sphereDetail(3);
        //popMatrix();
      }
    }
  }

  void radialColor(float x, float y) {
    float X = map(x, -256, 256, -1, 1); // mapping here needs to be dynamic, i.e. dependent on radius gear0 - or rather overall radiuas?
    float Y = map(y, -256, 256, -1, 1);
    float c = sq(X)+sq(Y);
    float lerp = sqrt(c);
    color interA = lerpColor(cFill, cStroke, lerp);
    fill(interA);
  }

  void spiroMode() {    
    cam.setActive(false);
    for (int theta = 0; theta < density; theta++) {
      Gears(theta, 0);
      xyz.x = gear0.xyz.x + gear1.xyz.x + gear2.xyz.x + gear3.xyz.x;
      xyz.y = gear0.xyz.y + gear1.xyz.y + gear2.xyz.y + gear3.xyz.y;
      radialColor(xyz.x, xyz.y);
      strokeWeight(sw);
      ellipse(xyz.x, xyz.y, lx, ly);
    }
  }

  void Gears(float theta, float phi) {
    for (int g = 0; g < 4; g++) {
      gears[g].grinding(trig.get("G"+g+"trigX"), trig.get("G"+g+"trigY"), trig.get("G"+g+"trigZ"), trig.get("G"+g+"trigX2"), trig.get("G"+g+"trigY2"), theta, phi, gear0.C, spheres3d);
    }
  }

  void Lines() {
    for (int G = 0; G < gears.length; G++) {
      for (float i = 0; i < gears[G].P; i++) {
        theta = (TAU/gears[G].P)*i; 
        phi = (TAU/gears[G].P)*(i+gears[G].Connect);
        xyz.x =  cos(theta)*gear0.RX + cos(theta/gear1.Ratio())*gear1.RX + cos(theta/gear2.Ratio())*gear2.RX + cos(theta/gear3.Ratio())*gear3.RX;
        xyz.y =  sin(theta)*gear0.RY + sin(theta/gear1.Ratio())*gear1.RY + sin(theta/gear2.Ratio())*gear2.RY  + sin(theta/gear3.Ratio())*gear3.RY;
        xy2.x =  cos(phi)*gear0.RX + cos(phi/gear1.Ratio())*gear1.RX + cos(phi/gear2.Ratio())*gear2.RX + cos(phi/gear3.Ratio())*gear3.RX;
        xy2.y =  sin(phi)*gear0.RY + sin(phi/gear1.Ratio())*gear1.RY + sin(phi/gear2.Ratio())*gear2.RY  + sin(phi/gear3.Ratio())*gear3.RY;
        strokeCap(ROUND);
        strokeJoin(ROUND);
        strokeWeight(sw);
        line(xyz.x, xyz.y, xy2.x, xy2.y);
      }
    }
  }

  void Dots() {
    for (int G = 0; G < gears.length; G++) {
      for (float i = 0; i < gears[G].P; i++) {
        theta = (TAU/gears[G].P)*(i);
        xyz.x = cos(theta)*gear0.RX + cos(theta/gear1.Ratio())*gear1.RX + cos(theta/gear2.Ratio())*gear2.RX + cos(theta/gear3.Ratio())*gear3.RX;
        xyz.y = sin(theta)*gear0.RY + sin(theta/gear1.Ratio())*gear1.RY + sin(theta/gear2.Ratio())*gear2.RY  + sin(theta/gear3.Ratio())*gear3.RY;
        strokeWeight(sw);
        ellipse(xyz.x, xyz.y, lx, ly);
      }
    }
  }
}

class Gears {
  PVector xyz;
  float theta, phi, RX, RY, RZ, C, Connect, P, R, rotate, speed, cossintan;
  int trigX = 0, trigY = 1, trigX2, trigY2, trigZ;

  Gears(float rx, float ry, float rz) {
    xyz = new PVector();    
    RX = rx;
    RY = ry;
    RZ = rz;
    R = 1/(P-1);
    C = ((RX+RY)/2) * TAU;
  }
  void grinding(int trigx, int trigy, int trigz, int trigx2, int trigy2, float theta, float phi, float circumference, boolean threed) {
    trigX = trigx;
    trigX2 = trigx2;
    trigY = trigy;
    trigY2 = trigy2;
    trigZ = trigz;

    if (threed != true) {
      theta = ((TAU/circumference)*theta)+rotate;
      //rotateY(rotate);   
      //rotateX(move);
      xyz.x = cossintan(trigX, theta)*RX;
      xyz.y = cossintan(trigY, theta)*RY;
      rotate = rotate + speed;      
      if (rotate > TAU || rotate < -TAU) {
        rotate = 0;
      }
    } else {
      xyz.x = cossintan(trigX, theta)*cossintan(trigX2, phi)*RX;
      xyz.y = cossintan(trigY, theta)*cossintan(trigY2, phi)*RY;
      xyz.z = cossintan(trigZ, phi)*RZ;
    }
  }

  float cossintan(int trig, float theta) {
    if (trig == 0) {
      cossintan = cos(theta/Ratio());
    }
    if (trig == 1) {
      cossintan = sin(theta/Ratio());
    }
    if (trig == 2) {
      cossintan = tan(theta/Ratio());
    }
    return cossintan;
  }

  float Ratio() {
    R = 1/((P-1));   
    return (R);
  }
}