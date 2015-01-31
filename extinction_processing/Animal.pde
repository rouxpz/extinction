class Animal {

  float x, y;
  float edge;
  float speed;
  boolean dead;
  float gravity;
  
  float r;
  int a;
  
  PImage file;

  Animal (PImage _file) {
    x = -175;
    y = height/2 - 190;
    
    file = _file;
    r = 0;
  }

  void advance() {

    if (x + 70 >= edge) {

       pushMatrix();
        translate(x, y);
        rotate(r);
              x += 3;
      y += gravity;
      gravity += 0.98;
      popMatrix();
      r += 0.3;
      

      
    } else {
      x = x + speed;
    }

    if (y >= height - 250) {
      a = 0;
      dead = true;
    } else {
      a = 255;
    }
  }

  void render() {
    noStroke();

    tint(255, a);
    file.resize(175, 175);
    image(file, x, y);
    // ellipse(x, y, 50, 50);
  }
}
