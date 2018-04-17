// A subclass of Particle
// extending the Particle class so that we inherit its original functions, plus the ability to build on top of that
class Lollipop extends Particle {

  // Just adding one new variable to a Lollipop
  // It inherits all other fields from "Particle", and we don't have to retype them!
  float theta;


  // The Lollipop constructor can call the parent class (super class) constructor
  Lollipop(PVector l) {
    // "super" means do everything from the constructor in Particle
    super(l);
    // One more line of code to deal with the new variable, theta
    theta = 0.0;
  }

  // Notice we don't have the method run() here; it is inherited from Particle

  // This update() method overrides the parent class update() method
  void update() {
    //call the update method from the superclass
    super.update();
    // Increment rotation based on horizontal velocity
    float theta_vel = (velocity.x * velocity.mag()) / 10.0f;
    theta += theta_vel;
  }

  // This display() method overrides the parent class display() method
  void display() {
    // Render the ellipse just like in a regular particle
    super.display();
    // Then add a rotating line
    pushMatrix();
    imageMode(CENTER);
    translate(position.x, position.y);
    rotate(theta);
    stroke(255, lifespan);
    line(0, 0, 25, 0);
    popMatrix();
    //give the lollipop candy portion a random color and partial opacity
    fill(random(255), random(255), random(255), 170);
    ellipse(position.x, position.y, 8, 8);
  }
}