int gearNum = 42;
Gear [] gears = new Gear [gearNum];
ArrayList<Animal> animals = new ArrayList<Animal>();

PImage [] images = new PImage[17];

PImage background;
PImage belt;
PImage trash;
JSONArray data;

int connections;
int count;
int interval;
int select;
int time;
int last;

void setup() {
  size (1280, 800);
  smooth();
  collectData();
  background = loadImage("background.jpg");
  belt = loadImage("belt.png");
  trash = loadImage("trash.png");

  for (int i = 0; i < images.length; i++) {
    images[i] = loadImage("" + i + ".png");
  }

  for (int i = 0; i < gears.length; i++) {
    gears[i] = new Gear(25*i, height/2);
  }

  count = 0;
  // time = 19;
}

void draw() {

  if (frameCount % 3600 == 0) {
    thread("collectData");
    // collectData();
  }
  background(200);
  tint(255, 100);
  // background.resize(1920/2, 1080/2);
  image(background, 0, 0);
  tint(255, 255);
  belt.resize(1075, 60);
  image(belt, 0, height/2-30);

  for (int i = 0; i < gears.length; i++) {
    gears[i].speed = map(connections, 100, 800, 0.01, 0.5);
    gears[i].render();

    // println(gears[i].speed);
  }
  for (int i = 0; i < animals.size (); i++) {
    Animal a = animals.get(i);
    a.speed = map(connections, 100, 800, 0.3, 20);
    a.gravity = 15;
    a.advance();
    a.render();

    if (a.dead) {
      animals.remove(a);
      // println(animals.size());
    }
  }

  if (animals.size() > 0) {
    last = animals.size()-1;

    interval = round(map(connections, 115, 800, 120, 0));
    // interval = round(map(mouseX, 0, width, 120, 10));
    // println("Interval:" + interval);
    if (animals.get(last).x >= -20) {
      if (count >= interval) {
        birth();
        count = 0;
      } else {
        count++;
        // println(count);
      }
    }
  }
  // println("Count:" + count);

  trash.resize(400, 400);
  image(trash, width-400, height-300);
}

void mousePressed() {  

  birth();
  println(mouseX);
}

void birth() {

  time = hour();
  // println(time);
  if (time >= 23) {
    select = 16;
  } else if (time == 22) {
    select = round(random(8, 16));
  } else if (time == 20) {
    select = round(random(15));
  } else {
    select = round(random(7));
  }
  // select = round(random(16));
  // println(select);
  Animal a = new Animal(images[select]);
  a.edge = gears[gearNum-1].x + 12.5;
  animals.add(a);
}

void collectData() {
  data = loadJSONArray("https://pubsub-1.pubnub.com/v2/history/sub-key/sub-c-fc32499e-a8b4-11e4-bf84-0619f8945a4f/channel/extinction");
  JSONArray messages = data.getJSONArray(0);
  connections = messages.getInt(messages.size()-1);
  println("Data collected, amount of connections: " + connections);
}
