// ----------------------------------------------------------------------
// USER CLASSES: RAINDROPS (using arrayLists)
// ----------------------------------------------------------------------

class Raindrop {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Raindrop(PVector l, int tempIntensity) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = l.copy();
    lifespan = 255.0;
    tempIntensity = intensity;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    
    
    println("rainIntensity " + ": " + intensity);
    if(intensity > 100 && intensity < 200) {
      fill(0,30,255,127);
      stroke(0,30,255, lifespan);
    } else if (intensity > 200 && intensity < 300) {
      fill(100,30,255,127);
      stroke(100,30,255, lifespan);
    } else if (intensity > 300 && intensity < 400) {
      fill(200,30,255,127);
      stroke(200,30,255, lifespan);
    } else if (intensity > 400) {
      fill(255,30,255,127);
      stroke(255,0,0, lifespan);
    }
    ellipse(position.x, position.y, 10, 10);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean checkCollisions(){
    float distance = dist(mouseX,mouseY,position.x,position.y);
    boolean collision = false;
    if(distance < 30 && isDragging) {
      //position.x = random(width);
      //position.y = 0;
      //velocity.sub(velocity);
      //acceleration.mult(0);
      
      collision = true;
      
    }
    return collision;
  }
}