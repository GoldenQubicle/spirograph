class Layer {  //<>//
  String name;
  PVector xyz, xy2;  
  float theta, phi, lx, ly, sw, connectLines;
  Gears[] gears;
  Gears gear0, gear1, gear2, gear3;
  color cFill, cStroke; // used read & write JSON + update gui
  boolean stroke, fill, lines, dots;
  IntDict trig;
  int [] mode = {1, 2, 4, 16, 8, 64, 128, 256, 0};
  int blendSelect, id, kf, density;
  float fillR, fillG, fillB, fillA, strokeR, strokeG, strokeB, strokeA; // used for ani

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
    fillR = red(cFill);
    fillG = green(cFill);
    fillB = blue(cFill);
    fillA = alpha(cFill);
    cStroke = color(random(155, 255), random(155, 255), random(155, 255));
    strokeR = red(cStroke);
    strokeG = green(cStroke);
    strokeB = blue(cStroke);
    strokeA = alpha(cStroke);
    density = 2500;
    stroke = false;
    fill = true;
    lines = false;
    dots = false;
    sw = 2;
    connectLines = 2;
    trig = new IntDict();
    for (int g = 0; g < 4; g++) {
      trig.set("G"+g+"trigX", gears[g].trigX);
      trig.set("G"+g+"trigY", gears[g].trigY);
    }
  }

  void radialColor(float x, float y) {
    float X = map(x, -256, 256, -1, 1); // mapping here needs to be dynamic, i.e. dependent on radius gear0 - or rather overall radius?
    float Y = map(y, -256, 256, -1, 1);
    float c = sq(X)+sq(Y);
    float lerp = sqrt(c);
    color interA = lerpColor(cFill, cStroke, lerp);
    fill(interA);
  }

  void Gears(float theta, float phi) {
    for (int g = 0; g < 4; g++) {
      gears[g].grinding(trig.get("G"+g+"trigX"), trig.get("G"+g+"trigY"), theta, phi, density, lines);
    }
  }
}

class Gears {
  PVector xyz, xy2;
  float theta, phi, rX, rY, rZ, connect, ratio, rotate, speed, cossintan;
  int trigX = 0, trigY = 1, petals;
  boolean cast = false;

  Gears(float rx, float ry, float rz) {
    xyz = new PVector();    
    xy2 = new PVector();
    rX = rx;
    rY = ry;
    rZ = rz;
    connect = 2;
  }

  void grinding(int trigx, int trigy, float theta, float phi, float density, boolean lines) {
    trigX = trigx;
    trigY = trigy;

    if (lines == true) {
      theta+=rotate;
      //phi+=rotate;
      xyz.x = cossintan(trigX, theta)*rX;
      xyz.y = cossintan(trigY, theta)*rY;
      xy2.x = cossintan(trigX, phi)*rX;
      xy2.y = cossintan(trigY, phi)*rY;
    } else {
      theta = ((TAU/density)*theta)+rotate;
      //rotateY(rotate);   
      //rotateX(move);
      xyz.x = cossintan(trigX, theta)*rX;
      xyz.y = cossintan(trigY, theta)*rY;
    }
    //rotate = rotate + speed;      
    //if (rotate > TAU || rotate < -TAU) {
    //  rotate = 0;
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
      ratio = 1/(float(petals-1));
    return ratio;
  }
}