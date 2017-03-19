class Trigger {

  Ani ani;
  Easing[] easings = { Ani.LINEAR, Ani.QUAD_IN, Ani.QUAD_OUT, Ani.QUAD_IN_OUT, Ani.CUBIC_IN, Ani.CUBIC_IN_OUT, Ani.CUBIC_OUT, Ani.QUART_IN, Ani.QUART_OUT, Ani.QUART_IN_OUT, Ani.QUINT_IN, Ani.QUINT_OUT, Ani.QUINT_IN_OUT, Ani.SINE_IN, Ani.SINE_OUT, Ani.SINE_IN_OUT, Ani.CIRC_IN, Ani.CIRC_OUT, Ani.CIRC_IN_OUT, Ani.EXPO_IN, Ani.EXPO_OUT, Ani.EXPO_IN_OUT, Ani.BACK_IN, Ani.BACK_OUT, Ani.BACK_IN_OUT, Ani.BOUNCE_IN, Ani.BOUNCE_OUT, Ani.BOUNCE_IN_OUT, Ani.ELASTIC_IN, Ani.ELASTIC_OUT, Ani.ELASTIC_IN_OUT};
  int Start, End, layerKF, layerParameter, interval;
  float aniDuration;

  Trigger(int thex, int they, int end, int layer) {
    layerParameter = they;
    Start = thex;
    End = end;
    layerKF = End + (layer*gif.keyFrames);
    interval = (End - Start) + 1;
    aniDuration = gif.aniFrames*interval;

    // gear parameters
    if (layerParameter == 0) {
      ani =  Ani.to(layerAnimate.get(layer).gears[0], aniDuration, "RX", layerKeyFrames.get(layerKF).gears[0].RX, easings[gif.layerAniEasing.get(layer)[Start][layerParameter]]);
    }
    if (layerParameter == 1) {
      ani =  Ani.to(layerAnimate.get(layer).gears[0], aniDuration, "RY", layerKeyFrames.get(layerKF).gears[0].RY, easings[gif.layerAniEasing.get(layer)[Start][layerParameter]]);
    }
    if (layerParameter == 2) {
      ani =  Ani.to(layerAnimate.get(layer).gears[1], aniDuration, "P", layerKeyFrames.get(layerKF).gears[1].P, easings[gif.layerAniEasing.get(layer)[Start][layerParameter]]);
    }
    if (layerParameter == 3) {
      ani =  Ani.to(layerAnimate.get(layer).gears[1], aniDuration, "RX", layerKeyFrames.get(layerKF).gears[1].RX, easings[gif.layerAniEasing.get(layer)[Start][layerParameter]]);
    }
    if (layerParameter == 4) {
      ani =  Ani.to(layerAnimate.get(layer).gears[1], aniDuration, "RY", layerKeyFrames.get(layerKF).gears[1].RY, easings[gif.layerAniEasing.get(layer)[Start][layerParameter]]);
    }
    if (layerParameter == 5) {
      ani =  Ani.to(layerAnimate.get(layer).gears[2], aniDuration, "P", layerKeyFrames.get(layerKF).gears[2].P, easings[gif.layerAniEasing.get(layer)[Start][layerParameter]]);
    }
    if (layerParameter == 6) {
      ani =  Ani.to(layerAnimate.get(layer).gears[2], aniDuration, "RX", layerKeyFrames.get(layerKF).gears[2].RX, easings[gif.layerAniEasing.get(layer)[Start][layerParameter]]);
    }
    if (layerParameter == 7) {
      ani =  Ani.to(layerAnimate.get(layer).gears[2], aniDuration, "RY", layerKeyFrames.get(layerKF).gears[2].RY, easings[gif.layerAniEasing.get(layer)[Start][layerParameter]]);
    }
    if (layerParameter == 8) {
      ani =  Ani.to(layerAnimate.get(layer).gears[3], aniDuration, "P", layerKeyFrames.get(layerKF).gears[3].P, easings[gif.layerAniEasing.get(layer)[Start][layerParameter]]);
    }
    if (layerParameter == 9) {
      ani =  Ani.to(layerAnimate.get(layer).gears[3], aniDuration, "RX", layerKeyFrames.get(layerKF).gears[3].RX, easings[gif.layerAniEasing.get(layer)[Start][layerParameter]]);
    }
    if (layerParameter == 10) {
      ani =  Ani.to(layerAnimate.get(layer).gears[3], aniDuration, "RY", layerKeyFrames.get(layerKF).gears[3].RY, easings[gif.layerAniEasing.get(layer)[Start][layerParameter]]);
    }
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
}