class Layer {
  PVector XY, XY2;  
  float Theta, LX, LY, PlotDots, thelta;
  Gears gear0, gear1, gear2, gear3;
  color Fill, Stroke;
  boolean stroke, fill, mode;


  Layer() {
    XY = new PVector();
    XY2 = new PVector();
    gear0 = new Gears(75, 75, 0);
    gear1 = new Gears(75, 75, 8);
    gear2 = new Gears(0, 0, 8);
    gear3 = new Gears(0, 0, 0);
    LX = 2;
    LY = 2;
    Fill = color(random(155, 255), random(155, 255), random(155, 255));
    Stroke = color(random(155, 255), random(155, 255), random(155, 255));
    PlotDots = 5000;
    stroke = true;
    fill = true;
    mode = false;
  }

  void display() {

    if (fill == true) {
      fill(Fill);
    }
    if (fill == false) {
      noFill();
    }
    if (stroke == true) {
      //strokeWeight(2);
      stroke(Stroke);
    }
    if (stroke == false) {
      noStroke();
    }

    //Spiro();
    //Lines();

    if (mode == false) {
      Spiro();
    }
    if (mode == true) {
      Lines();
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
    for (float i = 0; i < gear1.P; i++) {
      Theta = (TAU/gear1.P)*i; 
      thelta = (TAU/gear1.P)*(i+2);
      XY.x = width/2 + cos(Theta) * (gear0.RX); 
      XY.y =  height/2 - sin(Theta) * (gear0.RY); 
      XY2.x = width/2 + cos(thelta) * (gear0.RX); 
      XY2.y =  height/2 - sin(thelta) * (gear0.RY);
      strokeCap(ROUND);
      strokeJoin(ROUND);
      strokeWeight(LX);
      line(XY.x, XY.y, XY2.x, XY2.y);
    }
  }
}