class LayerS {
  PVector XY;  
  float Theta, LX, LY, PlotDots;
  Gears gear0, gear1, gear2, gear3;
  color C, Cs;

  LayerS() {
    XY = new PVector();
    gear0 = new Gears(75, 75, 0);
    gear1 = new Gears(75, 75, 6);
    gear2 = new Gears(15, 15, 12);
    gear3 = new Gears(0, 0, 0);
    LX = 2;
    LY = 2;
    C = color(random(155, 255), random(155, 255), random(155, 255));
    PlotDots = 10000;
  }

  void display() {

  
    if (gui.cp5.getController("Stroke").getValue() == 0) {
      noStroke();
    }

    if (gui.cp5.getController("Stroke").getValue() == 1) {
      stroke(Cs);
      //strokeWeight(5);
    }

    if (gui.cp5.getController("Fill").getValue() == 0) {
      noFill();
    }

    if (gui.cp5.getController("Fill").getValue() == 1) {
      fill(C);
    }
    //gear1.animate();
    //gear2.animate();
    Gears();
  }

  void Gears() {
    for (float i = 0; i < PlotDots; i++) {
      Theta = (TAU/gear0.C)*i;
      XY.x = width/2 + cos(Theta)*gear0.RX + cos(Theta/gear1.Ratio())*gear1.RX + cos(Theta/gear2.Ratio())*gear2.RX + cos(Theta/gear3.Ratio())*gear3.RX;
      XY.y = height/2 - sin(Theta)*gear0.RY + sin(Theta/gear1.Ratio())*gear1.RY + sin(Theta/gear2.Ratio())*gear2.RY  + sin(Theta/gear3.Ratio())*gear3.RY;
      ellipse(XY.x, XY.y, LX, LY);
    }
  }
}