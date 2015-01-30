class Animal {

  float x, y;
  float edge;
  float speed;
  boolean dead;
  float gravity;

  Animal () {
    x = -25;
    y = height/2 - 40.5;
  }

  void advance() {

    if (x-25 >= edge + 12.5) {
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
    fill(255, 200);

    ellipse(x, y, 50, 50);
  }
}
