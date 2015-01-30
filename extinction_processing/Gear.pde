class Gear {
  
  float x, y;
  float r = 0;
  float speed;
  
  Gear (float _x, float _y) {
    
    x = _x;
    y = _y;
    
  }
  
  void render () {
    pushMatrix();
      translate(x, y);
      rotate(r);
      stroke(0);
      fill(150);
      ellipse(0, 0, 25, 25);
      line(0, -12.5, 0, 12.5);
      line(-12.5, 0, 12.5, 0);
    popMatrix();  
    
    r += speed;
  }
  
  
  
}
