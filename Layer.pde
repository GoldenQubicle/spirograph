class Layer {
  PVector XY;  
  float Theta, LX, LY, PlotDots;
  Gears gear0, gear1, gear2, gear3;
  color Fill, Stroke;
  boolean stroke, fill;

  Layer() {
    XY = new PVector();
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


    Spiro();
    //gear1.animate();
    //gear2.animate();
  }

  void Spiro() {
    for (float i = 0; i < PlotDots; i++) {
      Theta = (TAU/gear0.C)*i;
      XY.x = width/2 + cos(Theta)*gear0.RX + cos(Theta/gear1.Ratio())*gear1.RX + cos(Theta/gear2.Ratio())*gear2.RX + cos(Theta/gear3.Ratio())*gear3.RX;
      XY.y = height/2 - sin(Theta)*gear0.RY + sin(Theta/gear1.Ratio())*gear1.RY + sin(Theta/gear2.Ratio())*gear2.RY  + sin(Theta/gear3.Ratio())*gear3.RY;
      ellipse(XY.x, XY.y, LX, LY);
      //rect(XY.x, XY.y, LX, LY);
    }
  }

}