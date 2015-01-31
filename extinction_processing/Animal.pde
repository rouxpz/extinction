class Animal {

  float x, y;
  float edge;
  float speed;
  boolean dead;
  float gravity;
  
  PImage file;

  Animal (PImage _file) {
    x = -100;
    y = height/2 - 100;
    
    file = _file;
  }

  void advance() {

    if (x + 20 >= edge + 12.5) {
      x += 3;
      y += gravity;
      gravity += 0.98;
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
