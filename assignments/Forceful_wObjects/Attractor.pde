// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A class for a draggable attractive body in our world

class Attractor {
  float mass;    // Mass, tied to size
  float G;       // Gravitational Constant
  PVector position;   // position
  boolean dragging = false; // Is the object being dragged?
  boolean rollover = false; // Is the mouse over the ellipse?
  PVector dragOffset;  // holds the offset for when object is clicked on
  PImage magnet; // Declare image object acting as the sprite

  Attractor(String image) {
    position = new PVector(width/2,height/2);
    mass = 20;
    G = 1;
    dragOffset = new PVector(0.0,0.0);
    //get the image file from the constructor
    magnet = loadImage(image);
  }
  
  //write a function that returns a PVector
  PVector attract(Mover m) {
    
    PVector force = PVector.sub(position,m.position);   // Calculate direction of force
    float d = force.mag();                              // Distance between objects
    //get the length of the vector to see what the distance is 
    // distance * distance can get very large and weird behaviour can happen, so constrain it
    d = constrain(d,5.0,25.0);                          // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (G * mass * m.mass) / (d * d);     // Calculate gravitional force magnitude
    //Putting magnitude and direction together
    force.mult(strength);     // Get force vector --> magnitude * direction
    return force;
  }

  // Method to display
  void display() {
    imageMode(CENTER);
    strokeWeight(4);
    stroke(0);
    if (dragging) magnet = loadImage("magnet-red.png");
    else if (rollover) magnet = loadImage("magnet-darkred.png");
    else magnet = loadImage("magnet-black.png");
    //ellipse(position.x,position.y,mass*2,mass*2);
    image(magnet, position.x, position.y, mass*2, mass*2);
  }

  // The methods below are for mouse interaction
  void clicked(int mx, int my) {
    float d = dist(mx,my,position.x,position.y);
    if (d < mass) {
      dragging = true;
      dragOffset.x = position.x-mx;
      dragOffset.y = position.y-my;
    }
  }

  void hover(int mx, int my) {
    float d = dist(mx,my,position.x,position.y);
    if (d < mass) {
      rollover = true;
    } 
    else {
      rollover = false;
    }
  }

  void stopDragging() {
    dragging = false;
  }



  void drag() {
    if (dragging) {
      position.x = mouseX + dragOffset.x;
      position.y = mouseY + dragOffset.y;
    }
  }

}