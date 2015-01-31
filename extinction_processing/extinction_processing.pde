int gearNum = 30;
Gear [] gears = new Gear [gearNum];
ArrayList<Animal> animals = new ArrayList<Animal>();

PImage [] images = new PImage[17];

PImage background;
JSONArray data;

int connections;

void setup() {
  size (1920/2, 1080/2);
  smooth();
  collectData();
  background = loadImage("background.jpg");
  
  for (int i = 0; i < images.length; i++) {
    images[i] = loadImage("" + i + ".png");
  }
  
  for (int i = 0; i < gears.length; i++) {
    gears[i] = new Gear(25*i, height/2);
  }
}

void draw() {
  
  if (frameCount % 3600 == 0) {
    collectData();
  }
  background(0);
  tint(255, 100);
  background.resize(1920/2, 1080/2);
  image(background, 0, 0);

  for (int i = 0; i < animals.size (); i++) {
    Animal a = animals.get(i);
    a.speed = map(connections, 10, 1000, 0.3, 20);
    a.gravity = 10;
    a.advance();
    a.render();

    if (a.dead) {
      animals.remove(a);
      println(animals.size());
    }
  }

  for (int i = 0; i < gears.length; i++) {
    gears[i].speed = map(connections, 200, 1000, 0.01, 0.5);
    gears[i].render();

    // println(gears[i].speed);
  }
}

void mousePressed() {  

  birth();
  println("clicked");
}

void birth() {
  int select = round(random(17));
  Animal a = new Animal(images[select]);
  a.edge = gears[gearNum-1].x + 12.5;
  animals.add(a);
}

void collectData() {
  data = loadJSONArray("https://pubsub-1.pubnub.com/v2/history/sub-key/sub-c-fc32499e-a8b4-11e4-bf84-0619f8945a4f/channel/extinction");
  JSONArray messages = data.getJSONArray(0);
  connections = messages.getInt(messages.size()-1);
  println(connections);
}
