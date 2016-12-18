class GUI extends PApplet {    //<>// //<>// //<>//

  int w, h, id, set, lp;
  PApplet parent;
  ControlP5 cp5;
  int bg ;
  Slider2D G0, G1, G2, G3;
  Slider P1, P2, P3, LX, LY, SW, D, G1c, G2c, G3c;
  Toggle Fill, Stroke, Lines, Dots, CS;
  ColorPicker cp;

  public GUI(PApplet theApplet) {
    super();
    parent = theApplet;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(512, 768);
  } 

  public void setup() {
    id = 0;
    cp5 = new ControlP5(this);
    // color
    cp5.addColorWheel("BackGround").setPosition(302, 10).setValue(128).plugTo(this, "BG");
    cp = cp5.addColorPicker("ColorPicker").setPosition(10, 10).setColorValue(layers.get(id).Fill).plugTo(this, "Controls");
    CS = cp5.addToggle("Switch").setPosition(270, 10).setSize(25, 25).plugTo(this, "Controls");
    // gear0
    G0 = cp5.addSlider2D("Radius Gear 0").setMinMax(-512, -512, 512, 512).setPosition(10, 90).setCaptionLabel("Radius Gear 0").plugTo(this, "Controls").setValue(layers.get(id).gear0.RX, layers.get(id).gear0.RY);
    //// gear1
    G1 = cp5.addSlider2D("Radius Gear1").setMinMax(-150, -150, 150, 150).setPosition(160, 90).setCaptionLabel("Radius Gear 1").plugTo(this, "Controls").setValue(layers.get(id).gear1.RX, layers.get(id).gear1.RY);
    P1 = cp5.addSlider("Petals_1").setRange(0, 50).setPosition(160, 80).setCaptionLabel("Petals").plugTo(this, "Controls").setValue(layers.get(id).gear1.P);
    // gear2
    G2 = cp5.addSlider2D("Radius Gear2").setMinMax(-150, -150, 150, 150).setPosition(10, 230).setCaptionLabel("Radius Gear 2").plugTo(this, "Controls").setValue(layers.get(id).gear2.RX, layers.get(id).gear2.RY);
    P2 = cp5.addSlider("Petals_2").setRange(0, 100).setPosition(10, 220).setCaptionLabel("Petals").plugTo(this, "Controls").setValue(layers.get(id).gear2.P);
    //// gear3
    G3 = cp5.addSlider2D("Radius Gear3").setMinMax(-150, -150, 150, 150).setPosition(160, 230).setCaptionLabel("Radius Gear 3").plugTo(this, "Controls").setValue(layers.get(id).gear3.RX, layers.get(id).gear3.RY);
    P3 = cp5.addSlider("Petals_3").setRange(0, 200).setPosition(160, 220).setCaptionLabel("Petals").plugTo(this, "Controls").setValue(layers.get(id).gear3.P);
    // fill stroke width for all modes
    Fill = cp5.addToggle("Fill").setPosition(10, 370).setSize(45, 15).setMode(ControlP5.SWITCH).setState(true).plugTo(this, "Controls");
    Stroke = cp5.addToggle("Stroke").setPosition(65, 370).setSize(45, 15).setMode(ControlP5.SWITCH).setState(false).plugTo(this, "Controls");
    LX = cp5.addSlider("LineX").setPosition(10, 350).setRange(0, 250).plugTo(this, "Controls").setValue(layers.get(id).LX);
    LY = cp5.addSlider("LineY").setPosition(160, 350).setRange(0, 250).plugTo(this, "Controls").setValue(layers.get(id).LY);
    SW = cp5.addSlider("StrokeWeight").setPosition(310, 330).setRange(0, 250).setValue(2).plugTo(this, "Controls").setValue(layers.get(id).Sw);    
    Lines = cp5.addToggle("Lines").setPosition(310, 290).setSize(20, 20).setState(false).plugTo(this, "Controls");  
    Dots = cp5.addToggle("Dots").setPosition(340, 290).setSize(20, 20).setState(false).plugTo(this, "Controls");
    // line density for spiro mode
    D = cp5.addSlider("Density").setPosition(10, 490).setSize(450, 15).setRange(0, 100000).plugTo(this, "Controls").setValue(layers.get(id).PlotDots);
    // gear connectors for line & dot mode
    G1c = cp5.addSlider("Connect G1").setPosition(310, 230).setRange(0, 100).plugTo(this, "Controls");
    G2c = cp5.addSlider("Connect G2").setPosition(310, 250).setRange(0, 100).plugTo(this, "Controls");
    G3c = cp5.addSlider("Connect G3").setPosition(310, 270).setRange(0, 100).plugTo(this, "Controls");
    // layers control
    cp5.addScrollableList("SwitchLayers").setPosition(310, 390).setType(ScrollableList.DROPDOWN).setCaptionLabel("Layers");
    cp5.addButton("New Layer").setPosition(310, 350).setSize(60, 15);
    cp5.addButton("Hide Layer").setPosition(380, 350).setSize(60, 15);
    // animation matrix
    //cp5.addMatrix("Matrix").setPosition(10, 550).setSize(400, 100).setGrid(5, lp).setInterval(500).setMode(ControlP5.MULTIPLES).stop().setGap(10, 0)
    //  .set(0, 0, false).isPlaying();
    //cp5.addButton("Add").setPosition(10, 525).setSize(60, 15);
  }

  void draw() {
    background(190);
  }

  void BG(color bg) {
    BG = bg;
  }

  void Controls() {
    for (Layer myLayer : layers) {
      myLayer.gear0.RX = G0.getArrayValue(0);
      myLayer.gear0.RY = G0.getArrayValue(1);
      myLayer.gear1.RX = G1.getArrayValue(0);
      myLayer.gear1.RY = G1.getArrayValue(1);
      myLayer.gear2.RX = G2.getArrayValue(0);
      myLayer.gear2.RY = G2.getArrayValue(1);
      myLayer.gear3.RX = G3.getArrayValue(0);
      myLayer.gear3.RY = G3.getArrayValue(1);
      myLayer.gear1.P = int(P1.getValue()); // note to self NOT casting to int produces interesting results! 
      myLayer.gear2.P = int(P2.getValue());
      myLayer.gear3.P = int(P3.getValue());
      myLayer.LX = LX.getValue();
      myLayer.LY = LY.getValue();
      myLayer.fill = Fill.getState();
      myLayer.stroke = Stroke.getState();
      myLayer.Sw = SW.getValue();
      myLayer.lines = Lines.getState();
      myLayer.dots = Dots.getState();
      myLayer.PlotDots = D.getValue();
      myLayer.gear1.Connect = int(G1c.getValue());
      myLayer.gear2.Connect = int(G2c.getValue());
      myLayer.gear3.Connect = int(G3c.getValue());
      myLayer.Fill = cp.getColorValue();
      
     
    }
  }
}