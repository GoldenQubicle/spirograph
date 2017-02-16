class Trigger {

  Ani ani;
  Easing[] easings = { Ani.LINEAR, Ani.QUAD_IN, Ani.QUAD_OUT, Ani.QUAD_IN_OUT, Ani.CUBIC_IN, Ani.CUBIC_IN_OUT, Ani.CUBIC_OUT, Ani.QUART_IN, Ani.QUART_OUT, Ani.QUART_IN_OUT, Ani.QUINT_IN, Ani.QUINT_OUT, Ani.QUINT_IN_OUT, Ani.SINE_IN, Ani.SINE_OUT, Ani.SINE_IN_OUT, Ani.CIRC_IN, Ani.CIRC_OUT, Ani.CIRC_IN_OUT, Ani.EXPO_IN, Ani.EXPO_OUT, Ani.EXPO_IN_OUT, Ani.BACK_IN, Ani.BACK_OUT, Ani.BACK_IN_OUT, Ani.BOUNCE_IN, Ani.BOUNCE_OUT, Ani.BOUNCE_IN_OUT, Ani.ELASTIC_IN, Ani.ELASTIC_OUT, Ani.ELASTIC_IN_OUT};
  int Start, End, Duration, LayerParameter, G, GV, XY, LS, LV, Interval;
  float aniDuration, aniValue;
  String [] Parameter = {"/Radius Gear 0", "/Radius Gear 1", "/Radius Gear 2", "/Radius Gear 3", "/Petals_1", "/Petals_2", "/Petals_3", "/LineX", "/LineY", "/StrokeWeight", "/Connect G1", "/Connect G2", "/Connect G3", "/Density"}; 
  String [] GearVars = {"RX", "RY", "P", "Connect", "RZ"};
  String [] LayerVars = {"LX", "LY", "SW", "PlotDots"};
  JSONObject LayerState;


  Trigger(int thex, int they, int end) {
    LayerParameter = they;
    Start = thex;
    End = end;
    Interval = (End - Start) + 1;
    aniDuration = gif.aniInterval*Interval;
    LS = gif.AniEnd[Start][LayerParameter];     
    LayerState = loadJSONObject(JSON + LS  + ".json");

    if (LayerParameter == 1) {
      G = 0;
      GV = 0;
      aniValue = map(LayerState.getJSONObject(Parameter[0]).getJSONArray("arrayValue").getFloat(0), 0, 512, -256, 256);
    }
    if (LayerParameter == 2) {
      G = 0;
      GV = 1;
      aniValue = map(LayerState.getJSONObject(Parameter[0]).getJSONArray("arrayValue").getFloat(1), 0, 512, -256, 256);
    }
    if (LayerParameter == 3) {
      G = 1;
      GV = 2;
      aniValue = int(LayerState.getJSONObject(Parameter[4]).getFloat("value"));
    }
    if (LayerParameter == 4) {
      G = 1;
      GV = 0;
      aniValue = map(LayerState.getJSONObject(Parameter[1]).getJSONArray("arrayValue").getFloat(0), 0, 256, -128, 128);
    }
    if (LayerParameter == 5) {
      G = 1;
      GV = 1;
      aniValue = map(LayerState.getJSONObject(Parameter[1]).getJSONArray("arrayValue").getFloat(1), 0, 256, -128, 128);
    }
    if (LayerParameter == 6) {
      G = 2;
      GV = 2;
      aniValue = int(LayerState.getJSONObject(Parameter[5]).getFloat("value"));
    }
    if (LayerParameter == 7) {
      G = 2;
      GV = 0;
      aniValue = map(LayerState.getJSONObject(Parameter[2]).getJSONArray("arrayValue").getFloat(0), 0, 256, -128, 128);
    }
    if (LayerParameter == 8) {
      G = 2;
      GV = 1;
      aniValue = map(LayerState.getJSONObject(Parameter[2]).getJSONArray("arrayValue").getFloat(1), 0, 256, -128, 128);
    }
    if (LayerParameter == 9) {
      G = 3;
      GV = 2;
      aniValue = int(LayerState.getJSONObject(Parameter[6]).getFloat("value"));
    }
    if (LayerParameter == 10) {
      G = 3;
      GV = 0;
      aniValue = map(LayerState.getJSONObject(Parameter[3]).getJSONArray("arrayValue").getFloat(0), 0, 256, -128, 128);
    }
    if (LayerParameter == 11) {
      G = 3;
      GV = 1;
      aniValue = map(LayerState.getJSONObject(Parameter[3]).getJSONArray("arrayValue").getFloat(1), 0, 256, -128, 128);
    }
    if (LayerParameter == 12) {
      LV = 0;
      aniValue = LayerState.getJSONObject(Parameter[7]).getFloat("value");
    }
    if (LayerParameter == 13) {
      LV = 1;
      aniValue = LayerState.getJSONObject(Parameter[8]).getFloat("value");
    }
    if (LayerParameter == 14) {
      LV = 2;
      aniValue = LayerState.getJSONObject(Parameter[9]).getFloat("value");
    }
    
    if (LayerParameter == 14 && gui.Spheres.getState() == true) {
      G = 0;
      GV = 4;
      aniValue = LayerState.getJSONObject(Parameter[9]).getFloat("value");
     }

    if (LayerParameter == 15) {
      G = 1;
      GV = 3;
      aniValue = LayerState.getJSONObject(Parameter[10]).getFloat("value");
    }
    if (LayerParameter == 16) {
      G = 2;
      GV = 3;
      aniValue = LayerState.getJSONObject(Parameter[11]).getFloat("value");
    }
    if (LayerParameter == 17) {
      G = 3;
      GV = 3;
      aniValue = LayerState.getJSONObject(Parameter[12]).getFloat("value");
    }
    if (LayerParameter == 18) {
      aniValue = LayerState.getJSONObject(Parameter[13]).getFloat("value");
      LV = 3;
    }
  }

  void aniType() {
    for (Layer myLayer : layers) {
      
      if (LayerParameter == 14 && myLayer.spheres3d == true) {
        ani = Ani.to(myLayer.gears[G], aniDuration, GearVars[GV], aniValue, easings[int(gui.cp5.getController("Easing"+"0"+Start+"0"+LayerParameter).getValue())]);
     
      }

      if (LayerParameter <= 11 || LayerParameter >= 15 && LayerParameter <= 17  ) {
        ani = Ani.to(myLayer.gears[G], aniDuration, GearVars[GV], aniValue, easings[int(gui.cp5.getController("Easing"+"0"+Start+"0"+LayerParameter).getValue())]);
      } else {
        //for (Layer myLayer : layers) {
        ani = Ani.to(myLayer, aniDuration, LayerVars[LV], aniValue, easings[int(gui.cp5.getController("Easing"+"0"+Start+"0"+LayerParameter).getValue())]);
      }
    }
  }

  void ani() {
    aniType();
    ani.start();
  }
}