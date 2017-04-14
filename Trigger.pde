class Trigger {
  Ani ani, aniR, aniG, aniB, aniA;
  Easing[] easings = { Ani.LINEAR, Ani.QUAD_IN, Ani.QUAD_OUT, Ani.QUAD_IN_OUT, Ani.CUBIC_IN, Ani.CUBIC_IN_OUT, Ani.CUBIC_OUT, Ani.QUART_IN, Ani.QUART_OUT, Ani.QUART_IN_OUT, Ani.QUINT_IN, Ani.QUINT_OUT, Ani.QUINT_IN_OUT, Ani.SINE_IN, Ani.SINE_OUT, Ani.SINE_IN_OUT, Ani.CIRC_IN, Ani.CIRC_OUT, Ani.CIRC_IN_OUT, Ani.EXPO_IN, Ani.EXPO_OUT, Ani.EXPO_IN_OUT, Ani.BACK_IN, Ani.BACK_OUT, Ani.BACK_IN_OUT, Ani.BOUNCE_IN, Ani.BOUNCE_OUT, Ani.BOUNCE_IN_OUT, Ani.ELASTIC_IN, Ani.ELASTIC_OUT, Ani.ELASTIC_IN_OUT};
  int Start, End, layerKF, layerParameter, gear, gearVar, layerVar, layerGet;
  float aniDuration, aniValue, aniSeek, renderFrame, interval, renderKeyFrame;
  String [] GearVars = {"rX", "rY", "petals", "rotate", "connect", "rZ"};
  String [] LayerVars = {"lx", "ly", "sw", "cFill", "cStroke", "density"};
  float r, g, b, a;

  Trigger(int thex, int they, int end, int layer) {
    layerParameter = they;
    Start = thex;
    End = end;
    layerGet = layer;
    layerKF = End + (layer*gif.keyFrames);
    interval = (End - Start) + 1;
    aniDuration = gif.aniFrames*interval;
    aniSeek = 1 / aniDuration;
    renderFrame = 0;

    // gear parameters
    if (layerParameter == 0) {
      gear = 0;
      gearVar = 0;
      aniValue = layerKeyFrames.get(layerKF).gears[gear].rX;
    }
    if (layerParameter == 1) {
      gear = 0;
      gearVar = 1;
      aniValue = layerKeyFrames.get(layerKF).gears[gear].rY;
    }
    if (layerParameter == 2) {
      gear = 0;
      gearVar = 2;
      aniValue = layerKeyFrames.get(layerKF).gears[gear].petals;
    }
    if (layerParameter == 3) {
      gear = 0;
      gearVar = 3;
      aniValue = layerKeyFrames.get(layerKF).gears[gear].rotate;
    }
    if (layerParameter == 4) {
      gear = 1;
      gearVar = 0;
      aniValue = layerKeyFrames.get(layerKF).gears[gear].rX;
    }
    if (layerParameter == 5) {
      gear = 1;
      gearVar = 1;
      aniValue = layerKeyFrames.get(layerKF).gears[gear].rY;
    }
    if (layerParameter == 6) {
      gear = 1;
      gearVar = 2;
      aniValue = layerKeyFrames.get(layerKF).gears[gear].petals;
    }
    if (layerParameter == 7) {
      gear = 1;
      gearVar = 3;
      aniValue = layerKeyFrames.get(layerKF).gears[gear].rotate;
    }
    if (layerParameter == 8) {
      gear = 2;
      gearVar = 0;
      aniValue = layerKeyFrames.get(layerKF).gears[gear].rX;
    }
    if (layerParameter == 9) {
      gear = 2;
      gearVar = 1;
      aniValue = layerKeyFrames.get(layerKF).gears[gear].rY;
    }
    if (layerParameter == 10) {
      gear = 2;
      gearVar = 2;
      aniValue = layerKeyFrames.get(layerKF).gears[gear].petals;
    }
    if (layerParameter == 11) {
      gear = 2;
      gearVar = 3;
      aniValue = layerKeyFrames.get(layerKF).gears[gear].rotate;
    }
    if (layerParameter == 12) {
      gear = 3;
      gearVar = 0;
      aniValue = layerKeyFrames.get(layerKF).gears[gear].rX;
    }
    if (layerParameter == 13) {
      gear = 3;
      gearVar = 1;
      aniValue = layerKeyFrames.get(layerKF).gears[gear].rY;
    }
    if (layerParameter == 14) {
      gear = 3;
      gearVar = 2;
      aniValue = layerKeyFrames.get(layerKF).gears[gear].petals;
    }
    if (layerParameter == 15) {
      gear = 3;
      gearVar = 3;
      aniValue = layerKeyFrames.get(layerKF).gears[gear].rotate;
    }
    if (layerParameter == 16) {
      layerVar = 0;
      aniValue = layerKeyFrames.get(layerKF).lx;
    }
    if (layerParameter == 17) {
      layerVar = 1;
      aniValue = layerKeyFrames.get(layerKF).ly;
    }
    if (layerParameter == 18) {
      layerVar = 2;
      aniValue = layerKeyFrames.get(layerKF).sw;
    }
    if (layerParameter == 19) {
      r = layerKeyFrames.get(layerKF).fillR;
      g = layerKeyFrames.get(layerKF).fillG;
      b = layerKeyFrames.get(layerKF).fillB;
      a = layerKeyFrames.get(layerKF).fillA;
    }
    if (layerParameter == 20) {
      r = layerKeyFrames.get(layerKF).strokeR;
      g = layerKeyFrames.get(layerKF).strokeG;
      b = layerKeyFrames.get(layerKF).strokeB;
      a = layerKeyFrames.get(layerKF).strokeA;
    }
  }

  void aniType() {
    if (layerParameter <= 15) {
      ani = Ani.to(layerAnimate.get(layerGet).gears[gear], aniDuration, GearVars[gearVar], aniValue, easings[gif.layerAniEasing.get(layerGet)[Start][layerParameter]]);
    } else if (layerParameter >= 16 && layerParameter <=18) {
      ani = Ani.to(layerAnimate.get(layerGet), aniDuration, LayerVars[layerVar], aniValue, easings[gif.layerAniEasing.get(layerGet)[Start][layerParameter]]);
    } else if (layerParameter == 19) {
      aniR = Ani.to(layerAnimate.get(layerGet), aniDuration, "fillR", r, easings[gif.layerAniEasing.get(layerGet)[Start][layerParameter]]);
      aniG = Ani.to(layerAnimate.get(layerGet), aniDuration, "fillG", g, easings[gif.layerAniEasing.get(layerGet)[Start][layerParameter]]);
      aniB = Ani.to(layerAnimate.get(layerGet), aniDuration, "fillB", b, easings[gif.layerAniEasing.get(layerGet)[Start][layerParameter]]);
      aniA = Ani.to(layerAnimate.get(layerGet), aniDuration, "fillA", a, easings[gif.layerAniEasing.get(layerGet)[Start][layerParameter]]);
    } else if (layerParameter == 20) {
      aniR = Ani.to(layerAnimate.get(layerGet), aniDuration, "strokeR", r, easings[gif.layerAniEasing.get(layerGet)[Start][layerParameter]]);
      aniG = Ani.to(layerAnimate.get(layerGet), aniDuration, "strokeG", g, easings[gif.layerAniEasing.get(layerGet)[Start][layerParameter]]);
      aniB = Ani.to(layerAnimate.get(layerGet), aniDuration, "strokeB", b, easings[gif.layerAniEasing.get(layerGet)[Start][layerParameter]]);
      aniA = Ani.to(layerAnimate.get(layerGet), aniDuration, "strokeA", a, easings[gif.layerAniEasing.get(layerGet)[Start][layerParameter]]);
    }
  }

  void ani() {
    aniType();
    if (layerParameter == 19 || layerParameter == 20) {
      aniR.start();
      aniG.start();
      aniB.start();
      aniA.start();
    } else {
    ani.start();
    }
  }
}