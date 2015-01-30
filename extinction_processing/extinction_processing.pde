Gear [] gears = new Gear [30];
ArrayList<Animal> animals = new ArrayList<Animal>();

void setup() {
  size (1920/2, 1080/2);
  smooth();

  for (int i = 0; i < gears.length; i++) {
    gears[i] = new Gear(25*i, height/2);
  }
}

void draw() {
  background(0);
  
  for (int i = 0; i < animals.size(); i++) {
    Animal a = animals.get(i);
    a.speed = map(mouseX, 0, width, 0, 20);
    a.advance();
    a.render();
    
    if (a.dead) {
      animals.remove(a);
      println(animals.size());
    }
    
  }
  
  for (int i = 0; i < gears.length; i++) {
    gears[i].speed = map(mouseX, 0, width, 0, 0.5);
    gears[i].render();
    
    // println(gears[i].speed);
  }
 
}

void mousePressed() {  
  
  birth();  
}

void birth() {
  
  Animal a = new Animal();
  a.edge = gears[29].x + 12.5;
  animals.add(a);
  
}
