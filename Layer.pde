class Layer { //<>//
  PVector xyz, xy2;  
  float theta, phi, lx, ly, density, sw, connectLines, circumference;
  Gears[] gears;
  Gears gear0, gear1, gear2, gear3;
  color cFill, cStroke;
  boolean stroke, fill, lines, dots, spheres3d;
  int id;
  float r = .1;
  IntDict trig;

  Layer() {
    id = 0;
    xyz = new PVector();
    xy2 = new PVector();
    gears = new Gears[4];
    gear0 = new Gears(100, 100, 0, false);
    gear1 = new Gears(0, 0, 0, false);
    gear2 = new Gears(0, 0, 0, false);
    gear3 = new Gears(0, 0, 0, false);
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
    trig.set("G0trigX", 0);
    trig.set("G0trigY", 1);
    trig.set("G0trigZ", 1);
    trig.set("G1trigX", 0);
    trig.set("G1trigY", 1);
    trig.set("G1trigZ", 1);
    trig.set("G2trigX", 0);
    trig.set("G2trigY", 1);
    trig.set("G2trigZ", 1);
    trig.set("G3trigX", 0);
    trig.set("G3trigY", 1);
    trig.set("G3trigZ", 1);
    trig.set("G0trigX2", 0);
    trig.set("G0trigY2", 1);
    trig.set("G1trigX2", 0);
    trig.set("G1trigY2", 1);
    trig.set("G2trigX2", 0);
    trig.set("G2trigY2", 1);
    trig.set("G3trigX2", 0);
    trig.set("G3trigY2", 1);
    //spheres3d = true;
  }

  void display() {     
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
    density = 500;       
    for (int t = 0; t < density; t+=2) {
      theta = (TAU/density)*t;
      for (int p = 0; p < density; p+=2) {
        phi = (PI/density)*p;
        Gears(theta, phi);
        xyz.x = gear0.xyz.x + gear1.xyz.x + gear2.xyz.x + gear3.xyz.x;
        xyz.y = gear0.xyz.y + gear1.xyz.y + gear2.xyz.y + gear3.xyz.y;
        xyz.z = gear0.xyz.z + gear1.xyz.z + gear2.xyz.z + gear3.xyz.z;
        //pushMatrix();
        //translate(XYZ.x, XYZ.y, XYZ.z);
        //sphere(1);
        stroke(cFill);
        strokeWeight(sw);
        point(xyz.x, xyz.y, xyz.z);
        //sphereDetail(3);
        //popMatrix();
        //}
      }
    }
  }

  void spiroMode() {    
    cam.setActive(false);
    for (int theta = 0; theta < density; theta++) {
      Gears(theta, 0);
      xyz.x = gear0.xyz.x + gear1.xyz.x + gear2.xyz.x + gear3.xyz.x;
      xyz.y = gear0.xyz.y + gear1.xyz.y + gear2.xyz.y + gear3.xyz.y;
      strokeWeight(sw);
      ellipse(xyz.x, xyz.y, lx, ly);
      //pushMatrix();
      //translate(xyz.x, xyz.y, xyz.z);
      //sphere(lx);
      //sphereDetail(3);
      //popMatrix();
    }
  }

  void Gears(float theta, float phi) {
    for (int g = 0; g < 4; g++) {
      gears[g].grinding(trig.get("G"+g+"trigX"), trig.get("G"+g+"trigY"), trig.get("G"+g+"trigZ"), trig.get("G"+g+"trigX2"), trig.get("G"+g+"trigY2"), theta, phi, gear0.C, spheres3d);
    }
  }

  void Spiro() {
    cam.setActive(false);
    for (float i = 0; i < density; i++) {
      theta = (TAU/gear0.C)*i;
      phi = theta + r;
      //rotateY(r);
      xyz.x = cos(theta/gear0.Ratio())*gear0.RX + (cos(phi/gear1.Ratio())*gear1.RX) + cos(theta/gear2.Ratio())*gear2.RX + cos(theta/gear3.Ratio())*gear3.RX;
      xyz.y =  sin(theta/gear0.Ratio())*gear0.RY + (sin(phi/gear1.Ratio())*gear1.RY) + sin(theta/gear2.Ratio())*gear2.RY  + sin(theta/gear3.Ratio())*gear3.RY;
      strokeWeight(sw);
      ellipse(xyz.x, xyz.y, lx, ly);
      r += .00001;
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
  float theta, phi, RX, RY, RZ, C, Connect, P, R, move, speed, cossintan;
  boolean rotate;

  Gears(float rx, float ry, float rz, boolean r) {
    xyz = new PVector();    
    RX = rx;
    RY = ry;
    RZ = rz;
    R = 1/(P-1);
    C = ((RX+RY)/2) * TAU;
    rotate = r;
  }


  void grinding(int trigX, int trigY, int trigZ, int trigX2, int trigY2, float theta, float phi, float circumference, boolean threed) {
    if (threed != true) {
      theta = ((TAU/circumference)*theta)+move;
      //rotateY(move);   
      //rotateX(move);
      xyz.x = cossintan(trigX, theta)*RX;
      xyz.y = cossintan(trigY, theta)*RY;
      move = move + speed;      
      if (move > TAU || move < -TAU) {
        move = 0;
      }
    } else {
      xyz.x = cossintan(trigX, theta)*cossintan(trigX2, phi)*RX;
      xyz.y = cossintan(trigY, theta)*cossintan(trigY2, phi)*RY;
      xyz.z = cossintan(trigZ, phi)*RZ;
    }

    //if (rotate == true) {
    //  //rotateY(move);   
    //  //rotateX(move);   
    //  //xyz.x = cossintan(trigX, theta)*RX;
    //  //xyz.y = cossintan(trigY, theta)*RY;

    //  phi  = theta + move;
    //  xyz.x = cossintan(trigX, phi)*RX;
    //  xyz.y = cossintan(trigY, phi)*RY;
    //  move += .0000035;
    //}
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