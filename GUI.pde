class GUI {
  String RadiusX, RadiusY;

  GUI() {
    textSize(17);
    RadiusX = new String();
    RadiusY = new String();
  }


  void display() {
    rectMode(CENTER);
    fill(20);
    rect(width/2, height/2-5, 50, 30);
    fill(255);
    textAlign(CENTER);
    RadiusX = str(round(Outer.RadiusX));
    text(RadiusX, width/2, height/2);
  }
}