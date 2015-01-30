class Animal {
  
  float x, y;
  float speed;
  boolean dead;
  
  Animal () {
    x = -25;
    y = height/2 - 40.5;
  }
  
  void advance() {
    x = x + speed;
    
    if (x >= width + 25) {
      dead = true;
    }
  }
  
  void render() {
    noStroke();
    fill(255, 200);
    
    ellipse(x, y, 50, 50);    
  }
  
  
  
}
