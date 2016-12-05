//class Gear {
//  ControlP5 controls;
//  float RX, RY, LX, LY, C, T, R, CX, CY, I, GX, GY;
//  int P;
//  PVector Grind;

//  Gear(PApplet theApplet, float rx, float ry, float lx, float ly, int p) {
//    controls = new ControlP5(theApplet);
//    //Group G_0 = GearC.addGroup("G_0")
//    //  .setLabel("Gear 0")
//    //  .setGroup(gui.cp5.getGroup("L_1"))
//    //  .setPosition(10, 10)
//    //  ;
//    //controls.addSlider("RadiusX");
//    //controls.addSlider("RadiusY");
//    //controls.addSlider("LineX");
//    //controls.addSlider("LineY");
//    //controls.addSlider("Petals");
//      //.setPosition(0, 0)
//      ////.setGroup(G_0)
//      //.setMin(-width/2)
//      //.setMax(width/2)
//      //.setValue(150)
//      ;

//    RX = rx;
//    RY = ry;
//    LX = lx;
//    LY = ly;
//    P = p;
//    R = 1/(P-1);
//    C = RX * TAU;
//    T = TAU/C * I;
//    I = 0;
//    CX = width/2; // + cos(T) * RX;
//    CY = height/2; //- sin(T) * RY;
//    Grind = new PVector();

//  }


//  void grinding() {
//    Grind.x = cos(T/R) * RX;
//    Grind.y = sin(T/R) * RY;
//  }


//  //void display() {
//  //  fill(0);
//  //  for (I = 0; I < C; I++) {
//  //    grinding();
//  //    T = TAU/C * I;
//  //    ellipse(CX + Grind.x, CY - Grind.y, LX, LY);
//  //  }
//  //}
//}