class Animal {

  float x, y;
  float edge;
  float speed;
  boolean dead;
  float gravity;
  
  float r;
  
  PImage file;

  Animal (PImage _file) {
    x = -100;
    y = height/2 - 120;
    
    file = _file;
    r = 0;
  }

  void advance() {

    if (x + 20 >= edge + 12.5) {

       pushMatrix();
        translate(x, y);
        rotate(r);
              x += 2;
      y += gravity;
      gravity += 0.98;
      popMatrix();
      r += 0.3;
      

      
    } else {
      x = x + speed;
    }

    if (y >= height + 25) {
      dead = true;
    }
  }

  void render() {
    noStroke();

    tint(255, 255);
    file.resize(100, 100);
    image(file, x, y);
    // ellipse(x, y, 50, 50);
  }
}
