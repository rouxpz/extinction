Gear [] gears = new Gear [30];

void setup() {
  size (1920/2, 1080/2);
  smooth();

  for (int i = 0; i < gears.length; i++) {
    gears[i] = new Gear(25*i, height/2);
  }
}

void draw() {
  background(0);

  for (int i = 0; i < gears.length; i++) {
    gears[i].speed = map(mouseX, 0, width, 0, 0.2);
    gears[i].render();
    
    println(gears[i].speed);
  }
}

