class Particle {

  PVector velocity;
  float lifespan = 255;
  
  // variable that holds our particle shape and size
  PShape part;
  float partSize;
  
  PVector gravity = new PVector(0,0.1);


  Particle() {
    imageMode(CENTER);
    partSize = random(10,60);
    part = createShape();
    part.beginShape(QUAD);
    part.noStroke();
    //give it an image texture
    part.texture(sprite);
    //affect the lighting
    part.normal(0, 0, 1);
    //build the shape
    part.vertex(-partSize/2, -partSize/2, 0, 0);
    part.vertex(+partSize/2, -partSize/2, sprite.width, 0);
    part.vertex(+partSize/2, +partSize/2, sprite.width, sprite.height);
    part.vertex(-partSize/2, +partSize/2, 0, sprite.height);
    part.endShape();
    
    rebirth(width/2,height/2);
    
    //randomize their lifespan
    lifespan = random(255);
  }

  PShape getShape() {
    return part;
  }
  
  void rebirth(float x, float y) {
    float a = random(TWO_PI);
    float speed = random(0.5,4);
    velocity = new PVector(cos(a), sin(a));
    velocity.mult(speed);
    lifespan = 255;   
    part.resetMatrix();
    part.translate(x, y); 
  }
  
  // boolean controls whether the particle is displayed or not
  boolean isDead() {
    if (lifespan < 0) {
     return true;
    } else {
     return false;
    } 
  }
  

  public void update() {
    //decrement the lifespan of each particle every frame
    lifespan = lifespan - 1;
    velocity.add(gravity);
    
    //give it some color variation
    part.setTint(color(random(255), random(255), 0,lifespan));
    part.translate(velocity.x, velocity.y);
  }
}