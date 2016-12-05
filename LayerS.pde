class LayerS {
  //float RadiusX, RadiusY, Circumference;
  //float RadiusX2, RadiusY2, Circumference2;
  //float RadiusX3, RadiusY3, Circumference3;
  //float RadiusX4, RadiusY4, Circumference4;
  //float Petals, Petals2, Petals3, Ratio, Ratio2, Ratio3, Theta;
  //PVector XY;  

  //FloatDict Gear_0;
ControlP5 LayerC;
Gear gear0;
ArrayList <Gear> Gears;

  LayerS(PApplet theApplet) {
    //Petals = 7;
    //Petals2 = 49;
    //Petals3 = 21;
    //Ratio = 1/(Petals-1);
    //Ratio2 = 1/(Petals2-1);
    //Ratio3 = 1/(Petals3-1);
    //RadiusX = 150;
    //RadiusY = 150;
    //RadiusX2 = 100;
    //RadiusY2 = 100;
    //RadiusX3 = 50;
    //RadiusY3 = 50;
    //RadiusX4 = 15;
    //RadiusY4 = 15;
    //Circumference = RadiusX * TAU;
    //Circumference2 = RadiusX2 * TAU;
    //Circumference3 = RadiusX3 * TAU;
    //Circumference4 = RadiusX4 * TAU;
    //XY = new PVector();

    //Gear_0 = new FloatDict();
    //Gear_0.set("centerX", width/2);
    //Gear_0.set("centerY", height/2);
    //Gear_0.set("radiusX", 150);
    //Gear_0.set("radiusY", 150);
    //Gear_0.set("lineX", 2);
    //Gear_0.set("lineY", 2);
    //Gear_0.set("circumference", TAU*Gear_0.get("radiusX"));
    Gears = new ArrayList();
    gear0 = new Gear(theApplet, 150, 150, 2, 2, 0);
    Gears.add(gear0);
  }

  void display() {
    noStroke();
    fill(0);
    
  for(Gear myGear : Gears){
    for(myGear.I = 0 ; myGear.I < myGear.C ; myGear.I++){
      myGear.grinding();
      myGear.T = TAU/myGear.C * myGear.I;
      ellipse(width/2 + myGear.Grind.x, height/2 - myGear.Grind.y, myGear.LX, myGear.LY);
    }
  }

    //Gear_0();
    //Gear_1();
    //Gear_2();
    //Gear_3();
  }


  //void Gear_0() {
  //  fill(0);
  //  for (float i = 0; i < Circumference; i++) {
  //    Theta = (TAU/Gear_0.get("circumference"))*i;
  //    XY.x =  Gear_0.get("centerX") + cos(Theta) * Gear_0.get("radiusX");
  //    XY.y = Gear_0.get("centerY") - sin(Theta) * Gear_0.get("radiusY");
  //    ellipse(XY.x, XY.y, Gear_0.get("lineX"), Gear_0.get("lineY"));
  //  }
  //}

  //void Gear_1() {
  //  fill(255, 0, 0);
  //  for (float i = 0; i < Circumference + (Circumference2*Petals); i++) {
  //    Theta = (TAU/Circumference)*i;
  //    XY.x = width/2 + cos(Theta) * RadiusX + cos(Theta/Ratio)*RadiusX2;
  //    XY.y = height/2 - sin(Theta) * RadiusY + sin(Theta/Ratio)*RadiusY2;
  //    ellipse(XY.x, XY.y, 2, 2);
  //  }
  //}

  //void Gear_2() {
  //  fill(0, 255, 0);
  //  for (float i = 0; i < (Circumference + (Circumference2*Petals) + (Circumference3*Petals2))*2; i++) {
  //    Theta = (TAU/Circumference)*i;
  //    XY.x = width/2 + cos(Theta) * RadiusX + cos(Theta/Ratio)*RadiusX2 + cos(Theta/Ratio2)*RadiusX3;
  //    XY.y = height/2 - sin(Theta) * RadiusY + sin(Theta/Ratio)*RadiusY2 + sin(Theta/Ratio2)*RadiusY3;
  //    ellipse(XY.x, XY.y, 2, 2);
  //  }
  //}

  //void Gear_3() {
  //  fill(0, 0, 255);
  //  for (float i = 0; i < (Circumference + (Circumference2*Petals) + (Circumference3*Petals2) + (Circumference4*Petals3))*2; i++) {
  //    Theta = (TAU/Circumference)*i;
  //    XY.x = width/2 + cos(Theta) * RadiusX + cos(Theta/Ratio)*RadiusX2 + cos(Theta/Ratio2)*RadiusX3 + cos(Theta/Ratio3)*RadiusX4;
  //    XY.y = height/2 - sin(Theta) * RadiusY + sin(Theta/Ratio)*RadiusY2 + sin(Theta/Ratio2)*RadiusY3  + sin(Theta/Ratio3)*RadiusY4;
  //    ellipse(XY.x, XY.y, 2, 2);
  //  }
  //}
}