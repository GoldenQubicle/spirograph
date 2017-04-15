class Display {

  PVector xyz, xy2;

  Display() {
    xyz = new PVector();
    xy2 = new PVector();
  }

  void display(Layer toDraw) {
    cam.setActive(false);
    blendMode(toDraw.mode[toDraw.blendSelect]);
    if (toDraw.fill == true) {      
      fill(toDraw.fillR, toDraw.fillG, toDraw.fillB, toDraw.fillA);
    }
    if (toDraw.fill == false) {
      noFill();
    }
    if (toDraw.stroke == true) {
      stroke(toDraw.strokeR, toDraw.strokeG, toDraw.strokeB, toDraw.strokeA);
    }
    if (toDraw.stroke == false) {
      noStroke();
    }
    if (toDraw.lines == true) {
      for (int G = 0; G < toDraw.gears.length; G++) {
        for (float i = 0; i < toDraw.gears[G].petals; i++) {
          float theta = (TAU/toDraw.gears[G].petals)*i; 
          float  phi = (TAU/toDraw.gears[G].petals)*(i+toDraw.gears[G].connect);
          toDraw.Gears(theta, phi);
          xyz.x = toDraw.gear0.xyz.x + toDraw.gear1.xyz.x + toDraw.gear2.xyz.x + toDraw.gear3.xyz.x;
          xyz.y = toDraw.gear0.xyz.y + toDraw.gear1.xyz.y + toDraw.gear2.xyz.y + toDraw.gear3.xyz.y;
          xy2.x = toDraw.gear0.xy2.x + toDraw.gear1.xy2.x + toDraw.gear2.xy2.x + toDraw.gear3.xy2.x;
          xy2.y = toDraw.gear0.xy2.y + toDraw.gear1.xy2.y + toDraw.gear2.xy2.y + toDraw.gear3.xy2.y;
          strokeCap(ROUND);
          strokeJoin(ROUND);
          strokeWeight(toDraw.sw);
          line(xyz.x, xyz.y, xy2.x, xy2.y);
        }
      }
    } else {
      //spiromode
      for (int theta = 0; theta < toDraw.density; theta++) {
        toDraw.Gears(theta, 0);
        xyz.x = toDraw.gear0.xyz.x + toDraw.gear1.xyz.x + toDraw.gear2.xyz.x + toDraw.gear3.xyz.x;
        xyz.y = toDraw.gear0.xyz.y + toDraw.gear1.xyz.y + toDraw.gear2.xyz.y + toDraw.gear3.xyz.y;
        strokeWeight(toDraw.sw);
        ellipse(xyz.x, xyz.y, toDraw.lx, toDraw.ly);
        //point(xyz.x, xyz.y);     
      }
    }
  }
}