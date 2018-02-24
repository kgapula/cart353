// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  PImage object;

  Mover(String image) {
    position = new PVector(random(400),random(50));
    velocity = new PVector(1,0);
    acceleration = new PVector(0,0);
    mass = 1;
    object = loadImage(image);
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    imageMode(CENTER);
    stroke(0);
    strokeWeight(2);
    fill(127);
    //ellipse(position.x,position.y,16,16);
    image(object, position.x, position.y, 32, 32);
  }

  void checkEdges() {

    if (position.x > width) {
      position.x = 0;
    } else if (position.x < 0) {
      position.x = width;
    }

    if (position.y > height) {
      velocity.y *= -1;
      position.y = height;
    }

  }

}