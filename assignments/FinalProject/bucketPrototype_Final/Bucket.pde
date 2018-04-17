// ----------------------------------------------------------------------
// USER CLASSES: BUCKET
// ----------------------------------------------------------------------

class Bucket {
  float mass;    // Mass, tied to size
  float G;       // Gravitational Constant
  PVector position;   // position
  boolean dragging = false; // Is the object being dragged?
  boolean rollover = false; // Is the mouse over it?
  PVector dragOffset;  // holds the offset for when object is clicked on
  PImage bucket; // Declare image object acting as the sprite

  Bucket(String image) {
    position = new PVector(width/2, 550);
    mass = 20;
    G = 5;
    dragOffset = new PVector(0.0,0.0);
    //get the image file from the constructor
    bucket = loadImage(image);
  }
  

  // Method to display
  void display() {
    imageMode(CENTER);
    strokeWeight(4);
    stroke(0);
    if (dragging) bucket = loadImage("bucket.png");
    else if (rollover) bucket = loadImage("bucket.png");
    else bucket = loadImage("bucket.png");
    //ellipse(position.x,position.y,mass*2,mass*2);
    image(bucket, position.x, position.y, mass*2, mass*2);
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
  
  boolean checkDragging() {
    return dragging;
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

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com