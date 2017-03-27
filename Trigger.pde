class Trigger {

  Ani ani;
  Easing[] easings = { Ani.LINEAR, Ani.QUAD_IN, Ani.QUAD_OUT, Ani.QUAD_IN_OUT, Ani.CUBIC_IN, Ani.CUBIC_IN_OUT, Ani.CUBIC_OUT, Ani.QUART_IN, Ani.QUART_OUT, Ani.QUART_IN_OUT, Ani.QUINT_IN, Ani.QUINT_OUT, Ani.QUINT_IN_OUT, Ani.SINE_IN, Ani.SINE_OUT, Ani.SINE_IN_OUT, Ani.CIRC_IN, Ani.CIRC_OUT, Ani.CIRC_IN_OUT, Ani.EXPO_IN, Ani.EXPO_OUT, Ani.EXPO_IN_OUT, Ani.BACK_IN, Ani.BACK_OUT, Ani.BACK_IN_OUT, Ani.BOUNCE_IN, Ani.BOUNCE_OUT, Ani.BOUNCE_IN_OUT, Ani.ELASTIC_IN, Ani.ELASTIC_OUT, Ani.ELASTIC_IN_OUT};
  int Start, End, layerKF, layerParameter, interval, gear, gearVar, layerVar, layerGet;
  float aniDuration, aniValue, aniSeek, render;
  String [] GearVars = {"RX", "RY", "P", "Connect", "RZ"};
  String [] LayerVars = {"LX", "LY", "SW", "PlotDots"};

  Trigger(int thex, int they, int end, int layer) {
    layerParameter = they;
    Start = thex;
    End = end;
    layerGet = layer;
    layerKF = End + (layer*gif.keyFrames);
    interval = (End - Start) + 1;
    aniDuration = gif.aniMatrixInterval*interval;
    aniSeek = 1 / (60/interval);

    //// gear parameters
    if (layerParameter == 0) {
      gear = 0;
      gearVar = 0;
      aniValue = gif.layersKeyFrames.getJSONArray("Layer " + layerGet).getJSONObject(layerKF).getJSONObject("Gears").getInt("Gear 0 RX");
      //aniValue = layerKeyFrames.get(layerKF).gears[gear].RX;
    }
    if (layerParameter == 1) {
      gear = 0;
      gearVar = 1;
      aniValue = gif.layersKeyFrames.getJSONArray("Layer " + layerGet).getJSONObject(layerKF).getJSONObject("Gears").getInt("Gear 0 RY");
      //aniValue = layerKeyFrames.get(layerKF).gears[gear].RY;
    }
    //if (layerParameter == 2) {
    //  gear = 1;
    //  gearVar = 2;
    //  aniValue = layerKeyFrames.get(layerKF).gears[gear].P;
    //}
    //if (layerParameter == 3) {
    //  gear = 1;
    //  gearVar = 0;
    //  aniValue = layerKeyFrames.get(layerKF).gears[gear].RX;
    //}
    //if (layerParameter == 4) {
    //  gear = 1;
    //  gearVar = 1;
    //  aniValue = layerKeyFrames.get(layerKF).gears[gear].RY;
    //}
    //if (layerParameter == 5) {
    //  gear = 2;
    //  gearVar = 2;
    //  aniValue = layerKeyFrames.get(layerKF).gears[gear].P;
    //}
    //if (layerParameter == 6) {
    //  gear = 2;
    //  gearVar = 0;
    //  aniValue = layerKeyFrames.get(layerKF).gears[gear].RX;
    //}
    //if (layerParameter == 7) {
    //  gear = 2;
    //  gearVar = 1;
    //  aniValue = layerKeyFrames.get(layerKF).gears[gear].RY;
    //}
    //if (layerParameter == 8) {
    //  gear = 3;
    //  gearVar = 2;
    //  aniValue = layerKeyFrames.get(layerKF).gears[gear].P;
    //}
    //if (layerParameter == 9) {
    //  gear = 3;
    //  gearVar = 0;
    //  aniValue = layerKeyFrames.get(layerKF).gears[gear].RX;
    //}
    //if (layerParameter == 10) {
    //  gear = 3;
    //  gearVar = 1;
    //  aniValue = layerKeyFrames.get(layerKF).gears[gear].RY;
    //}
    
    // layer parameters to follow below
    //if (layerParameter == 11) {
    //  LV = 0;
    //  aniValue = LayerState.getJSONObject(Parameter[7]).getFloat("value");
    //}
    //if (layerParameter == 12) {
    //  LV = 1;
    //  aniValue = LayerState.getJSONObject(Parameter[8]).getFloat("value");
    //}
    //if (layerParameter == 13) {
    //  LV = 2;
    //  aniValue = LayerState.getJSONObject(Parameter[9]).getFloat("value");
    //}
    //if (layerParameter == 14) {
    //  G = 1;
    //  GV = 3;
    //  aniValue = LayerState.getJSONObject(Parameter[10]).getFloat("value");
    //}
    //if (layerParameter == 15) {
    //  G = 2;
    //  GV = 3;
    //  aniValue = LayerState.getJSONObject(Parameter[11]).getFloat("value");
    //}
    //if (layerParameter == 16) {
    //  G = 3;
    //  GV = 3;
    //  aniValue = LayerState.getJSONObject(Parameter[12]).getFloat("value");
    //}
    //if (layerParameter == 17) {
    //  aniValue = LayerState.getJSONObject(Parameter[13]).getFloat("value");
    //  LV = 3;
    //}
  }

  void aniType() { 
    if (layerParameter <= 10) {
      ani = Ani.to(layerActive.get(layerGet).gears[gear], aniDuration, GearVars[gearVar], aniValue, easings[gif.layerAniEasing.get(layerGet)[Start][layerParameter]]);
    } else {
      ani = Ani.to(layerActive.get(layerGet), aniDuration, LayerVars[layerVar], aniValue, easings[gif.layerAniEasing.get(layerGet)[Start][layerParameter]]);
    }
  }


  void ani() {
    aniType();
    ani.start();
  }
}