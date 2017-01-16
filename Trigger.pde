class Trigger {

  Matrix matrix;
  ScrollableList Parameters, Easing;

  int LayerID, ID;//
  int Start, Stop, Var, X,Ym,Ydd; 
  float value, duration;
  JSONObject LayerStateStart, LayerStateEnd;
  Easing[] easings = { Ani.LINEAR, Ani.QUAD_IN, Ani.QUAD_OUT, Ani.QUAD_IN_OUT, Ani.CUBIC_IN, Ani.CUBIC_IN_OUT, Ani.CUBIC_OUT, Ani.QUART_IN, Ani.QUART_OUT, Ani.QUART_IN_OUT, Ani.QUINT_IN, Ani.QUINT_OUT, Ani.QUINT_IN_OUT, Ani.SINE_IN, Ani.SINE_OUT, Ani.SINE_IN_OUT, Ani.CIRC_IN, Ani.CIRC_OUT, Ani.CIRC_IN_OUT, Ani.EXPO_IN, Ani.EXPO_OUT, Ani.EXPO_IN_OUT, Ani.BACK_IN, Ani.BACK_OUT, Ani.BACK_IN_OUT, Ani.BOUNCE_IN, Ani.BOUNCE_OUT, Ani.BOUNCE_IN_OUT, Ani.ELASTIC_IN, Ani.ELASTIC_OUT, Ani.ELASTIC_IN_OUT};
  String[] easingsVariableNames = {"Ani.LINEAR", "Ani.QUAD_IN", "Ani.QUAD_OUT", "Ani.QUAD_IN_OUT", "Ani.CUBIC_IN", "Ani.CUBIC_IN_OUT", "Ani.CUBIC_OUT", "Ani.QUART_IN", "Ani.QUART_OUT", "Ani.QUART_IN_OUT", "Ani.QUINT_IN", "Ani.QUINT_OUT", "Ani.QUINT_IN_OUT", "Ani.SINE_IN", "Ani.SINE_OUT", "Ani.SINE_IN_OUT", "Ani.CIRC_IN", "Ani.CIRC_OUT", "Ani.CIRC_IN_OUT", "Ani.EXPO_IN", "Ani.EXPO_OUT", "Ani.EXPO_IN_OUT", "Ani.BACK_IN", "Ani.BACK_OUT", "Ani.BACK_IN_OUT", "Ani.BOUNCE_IN", "Ani.BOUNCE_OUT", "Ani.BOUNCE_IN_OUT", "Ani.ELASTIC_IN", "Ani.ELASTIC_OUT", "Ani.ELASTIC_IN_OUT"};
  String [] test;
  int index;
  Easing currentEasing = easings[index];



  Trigger(int triggerid) {
    ID = triggerid;
    X = 10;
    Ym = 500 + (55*ID);
    Ydd = 525 + (55*ID);
    matrix = gui.cp5.addMatrix("triggerMatrix" + ID).setPosition(X, Ym).setSize(400, 20).setGap(10, 5).setMode(ControlP5.MULTIPLES)
      .setInterval(gif.Interval).setGrid(gif.Segments, 1).stop().plugTo(this).setCaptionLabel("");
    //Parameters = gui.cp5.addScrollableList("Parameters" + ID).setPosition(X, Ydd).setType(ScrollableList.DROPDOWN);
    Easing = gui.cp5.addScrollableList("Easing" + ID).setPosition(150, Ydd).setType(ScrollableList.DROPDOWN).setHeight(140).close(); 
    Easing.addItems(easingsVariableNames);

    //Start = start;
    //Stop = end;
    //duration = (float(end-start) * gif.aniInterval);
    //String JSON = "C:\\Users\\Erik\\Documents\\Processing\\sprgphv2\\data\\LayerState";
    //LayerStateStart = loadJSONObject(JSON + start + ".json");
    //LayerStateEnd = loadJSONObject(JSON + end + ".json");
    //value = map(LayerStateEnd.getJSONObject("/Radius Gear 0").getJSONArray("arrayValue").getFloat(0), 0, 1024, -512, 512);
  }


  void anit() {
    Ani.to(layer_1.gear0, duration, "RX", value, Ani.LINEAR);
    //println(value);
  }
}