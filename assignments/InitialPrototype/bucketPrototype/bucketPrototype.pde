/*
Kyle Gapulan
CART353
Prof. R. Khaled
March 6 2018

Initial Prototype

*/

Bucket bucket;
Mover[] movers = new Mover[5];

void setup() {
  size(600, 600);
  noSmooth();
  //create an attractor object
  bucket = new Bucket("bucket.png");
  
  randomSeed(1);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(1, 4), random(width), 0);
  }
}

void draw() {
  background(255);
  //call the function that enables the "rolling" movement when dragged
  bucket.drag();
  bucket.hover(mouseX, mouseY);
  
  //display the draggable object
  bucket.display();
  
  for (int i = 0; i < movers.length; i++) {

    PVector wind = new PVector(0.01, 0);
    PVector gravity = new PVector(0, 0.1*movers[i].mass);

    float c = 0.05;
    PVector friction = movers[i].velocity.get();
    friction.mult(-1); 
    friction.normalize();
    friction.mult(c);

    movers[i].applyForce(friction);
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);

    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
  
}

void mousePressed() {
  bucket.clicked(mouseX, mouseY);
}

void mouseReleased() {
  bucket.stopDragging();
}