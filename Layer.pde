class Layer {
  PVector XY, XY2;  
  float Theta, LX, LY, PlotDots, thelta, Sw, Connect;
  Gears gear0, gear1, gear2, gear3;
  color Fill, Stroke;
  boolean stroke, fill, lines;
  Gears[] gears;

  Layer() {
    XY = new PVector();
    XY2 = new PVector();
    gears = new Gears[3];
    gear0 = new Gears(75, 75, 0);
    gear1 = new Gears(75, 75, 8);
    gear2 = new Gears(0, 0, 8);
    gear3 = new Gears(0, 0, 0);
    gears[0] = gear1;
    gears[1] = gear2;
    gears[2] = gear3;
    LX = 2;
    LY = 2;
    Fill = color(random(155, 255), random(155, 255), random(155, 255));
    Stroke = color(random(155, 255), random(155, 255), random(155, 255));
    PlotDots = 5000;
    stroke = true;
    fill = true;
    lines = false;
    Sw = 2;
    Connect = 2;
  }

  void display() {

    if (fill == true) {
      fill(Fill);
    }
    if (fill == false) {
      noFill();
    }
    if (stroke == true) {
      //strokeWeight(Sw);
      stroke(Stroke);
    }
    if (stroke == false) {
      noStroke();
    }

    //Spiro();
    //Lines();

    if (lines == false) {
      Spiro();
    }
    if (lines == true) {
      Lines();
      //Dots();
    }
  }

  void Spiro() {
    for (float i = 0; i < PlotDots; i++) {
      Theta = (TAU/gear0.C)*i;
      XY.x = width/2 + cos(Theta)*gear0.RX + cos(Theta/gear1.Ratio())*gear1.RX + cos(Theta/gear2.Ratio())*gear2.RX + cos(Theta/gear3.Ratio())*gear3.RX;
      XY.y = height/2 - sin(Theta)*gear0.RY + sin(Theta/gear1.Ratio())*gear1.RY + sin(Theta/gear2.Ratio())*gear2.RY  + sin(Theta/gear3.Ratio())*gear3.RY;
      ellipse(XY.x, XY.y, LX, LY);
    }
  }

  void Lines() {
    for (int G = 0; G < gears.length; G++) {
      for (float i = 0; i < gears[G].P; i++) {
        Theta = (TAU/gears[G].P)*i; 
        thelta = (TAU/gears[G].P)*(i+gears[G].Connect);
        XY.x = width/2 + (cos(Theta) * (gear0.RX + gears[G].RX)); 
        XY.y =  height/2 - (sin(Theta) * (gear0.RY + gears[G].RY)); 
        XY2.x = width/2 + (cos(thelta) * (gear0.RX + gears[G].RX)); 
        XY2.y =  height/2 - (sin(thelta) * (gear0.RY + gears[G].RY));
        strokeCap(ROUND);
        strokeJoin(ROUND);
        strokeWeight(Sw);
        line(XY.x, XY.y, XY2.x, XY2.y);
      }
    }
  }

  void Dots() {
    for (float i = 0; i < gear1.P; i++) {
      Theta = (TAU/gear1.P)*i;
      XY.x = width/2 + cos(Theta)*gear0.RX + cos(Theta/gear1.Ratio())*gear1.RX + cos(Theta/gear2.Ratio())*gear2.RX + cos(Theta/gear3.Ratio())*gear3.RX;
      XY.y = height/2 - sin(Theta)*gear0.RY + sin(Theta/gear1.Ratio())*gear1.RY + sin(Theta/gear2.Ratio())*gear2.RY  + sin(Theta/gear3.Ratio())*gear3.RY;
      ellipse(XY.x, XY.y, LX, LY);
    }
  }
}