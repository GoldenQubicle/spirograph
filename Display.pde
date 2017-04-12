class Display{
  
  PVector xyz;
  
  Display(){
   xyz = new PVector(); 
  }
  
  void display(Layer toDraw){
    cam.setActive(false);
    blendMode(toDraw.mode[toDraw.blendSelect]);
    if (toDraw.fill == true) {      
      fill(toDraw.cFill);
    }
    if (toDraw.fill == false) {
      noFill();
    }
    if (toDraw.stroke == true) {
      stroke(toDraw.cStroke);
    }
    if (toDraw.stroke == false) {
      noStroke();
    }
        
    for (int theta = 0; theta < toDraw.density; theta++) {
      toDraw.Gears(theta, 0);
      xyz.x = toDraw.gear0.xyz.x + toDraw.gear1.xyz.x + toDraw.gear2.xyz.x + toDraw.gear3.xyz.x;
      xyz.y = toDraw.gear0.xyz.y + toDraw.gear1.xyz.y + toDraw.gear2.xyz.y + toDraw.gear3.xyz.y;
      //radialColor(xyz.x, xyz.y);
      strokeWeight(toDraw.sw);
      ellipse(xyz.x, xyz.y, toDraw.lx, toDraw.ly);
      //point(xyz.x, xyz.y);
      if (theta == (toDraw.density-1) && render == true) {
        gif.renderPImage();
      }
      if (theta == toDraw.density && renderKeyFrames == true) {
        gif.renderLayer();
      }
    }
    
  }
  
  
}