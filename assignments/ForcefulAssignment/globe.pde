// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A class for a draggable attractive body in our world

class Globe {
  float mass;    // Mass, tied to size
  float G;       // Gravitational Constant
  PVector position;   // position
  boolean dragging = false; // Is the object being dragged?
  boolean rollover = false; // Is the mouse over the ellipse?
  PVector dragOffset;  // holds the offset for when object is clicked on
  PImage globe; // Declare image object acting as the sprite

  Globe(String image) {
    position = new PVector((width/3)*2,(height/3));
    mass = 20;
    G = 1;
    dragOffset = new PVector(0.0,0.0);
    //get the image file from the constructor
    globe = loadImage(image);
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
    
    image(globe, position.x, position.y, mass*2, mass*2);
  }
}