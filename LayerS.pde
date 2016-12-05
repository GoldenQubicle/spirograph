class LayerS {

  ControlP5 LayerC;
  Gears gears;
  int Shift;
  float CX,CY;

  
  LayerS(PApplet theApplet) {

    gears = new Gears(theApplet, 150, 150, 0);
    Shift = 0;
    CX = width/2;
    CY = height/2;
 
  }

  void display() {
    noStroke();
    fill(0);

    gears.grinding(Shift);

    println(gears.Grind.x);
  
    ellipse(CX+ gears.Grind.x, CY - gears.Grind.y, 2, 2);
  }
}