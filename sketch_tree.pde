int windType = 0;
PVector gravity = new PVector(0, 0.02);  // gravity force

class Tree {
  float x, y;
  float trunkHeight;
  float leafSize;
  PVector force;

  Tree(float x, float y, float trunkHeight, float leafSize) {
    this.x = x;
    this.y = y;
    this.trunkHeight = trunkHeight;
    this.leafSize = leafSize;
    force = new PVector(0, 0);
  }

  void applyForce(PVector windForce) {
    this.force = windForce;
  }

  void display() {
    // trunk
    stroke(139, 69, 19);
    fill(139, 69, 19);
    rect(x, y - trunkHeight, trunkHeight/10, trunkHeight);
    
    // background shape for leaves
    fill(34, 139, 34);
    ellipse(x, y - trunkHeight + leafSize/2, leafSize, leafSize);
    
    // leaves with physics-based movement
    int leavesCount = int(leafSize/10);
    for (int i = 0; i < leavesCount; i++) {
      Leaf l = new Leaf(x + random(-leafSize/2, leafSize/2), y - trunkHeight + random(0, leafSize), leafSize/leavesCount, force);
      l.display();
    }
  }
}

class Leaf {
  float x, y;
  float size;
  PVector force;
  color leafColor;

  Leaf(float x, float y, float size, PVector force) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.force = force;
    this.leafColor = color(random(34, 85), random(100, 155), 34);
  }

  void display() {
    fill(leafColor);
    noStroke();
    ellipse(x + force.x*size + gravity.x*size, y + force.y*size + gravity.y*size, size, size*1.5);
  }
}

class WindParticle {
  PVector pos;
  PVector velocity;
  float size;
  
  WindParticle(float x, float y, PVector wind) {
    this.pos = new PVector(x, y);
    this.velocity = wind.copy().mult(10);
    this.size = random(10, 20);
  }
  
  void update() {
    pos.add(velocity);
  }
  
  void display() {
    stroke(100, 100, 255);
    line(pos.x, pos.y, pos.x - velocity.x, pos.y - velocity.y);
  }
}

Tree[] trees = new Tree[3];
ArrayList<WindParticle> windParticles = new ArrayList<WindParticle>();

void setup() {
  size(800, 800);
  trees[0] = new Tree(width/4, height, 150, 100);
  trees[1] = new Tree(width/2, height, 200, 120);
  trees[2] = new Tree(3*width/4, height, 150, 100);
}

void draw() {
  background(0);

  for (Tree t : trees) {
    t.display();
  }
  
  for (int i = windParticles.size() - 1; i >= 0; i--) {
    WindParticle wp = windParticles.get(i);
    wp.update();
    wp.display();
    
    if (wp.pos.x > width || wp.pos.x < 0) {
      windParticles.remove(i);
    }
  }
}

void mouseClicked() {
  PVector wind;
  if (windType == 0) {
    wind = new PVector(random(-0.1, 0.1), 0);
  } else {
    wind = new PVector(random(-0.05, 0.05), random(-0.05, 0.05));
  }
  windType = (windType + 1) % 2;

  for (Tree t : trees) {
    t.applyForce(wind);
  }
  
  for (int i = 0; i < 30; i++) {
    windParticles.add(new WindParticle(random(width), random(height), wind));
  }
}
