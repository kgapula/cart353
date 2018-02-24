/*
Kyle Gapulan
CART353
Prof. R. Khaled
February 27 2018

Forceful

Design brief:
Make a simple 2D world based on the roll mechanic of Katamari Damacy, including:
The ability to roll an entity around on screen 
(come up with what "roll" means for your 2D world)
Modelling of gravitational force on entities
Entities that can “amass” other objects (hint hint)
The presence of other forces in your world too i.e. oil slicks, sand, etc.

*/


//import Video library
import processing.video.*;

//Initialize an array of mover objects. These will be the "attracted" entities.
Mover[] movers = new Mover[10];
//Mover m;
//Initialize the entity that can be "rolled" and attract other objects.
Attractor a;
//Initialize the sludge object that can slow movement.
Sludge sludge;
//Initialize a boolean that tracks whether or not a mover object collides with the sludge object.
boolean inSludge = false;
//Initialize the movie object we are using as a background
Movie noise;


void setup() {
  size(640, 360);
  noise = new Movie(this, "noise.mp4");
  noise.loop();
  
  //m = new Mover(); 
  for (int i = 0; i < movers.length; i++) {
    //populate our mover array with mover objects
    //give them a corresponding object image
    movers[i] = new Mover("object" + i + ".png");
  }
  
  //create an attractor object
  a = new Attractor("magnet-black.png");
  
  //create a patch of sludge to slow object movement
  //x, y, width, height, coefficient of drag
  sludge = new Sludge(100, height/2, 150, 100, 0.1);
}

void movieEvent(Movie noise) {
  noise.read();
}

void draw() {
  background(255);
  image(noise, 0, 0, noise.width*2, noise.height*2);
  sludge.display();
  
  //call the function that enables the "rolling" movement
  a.drag();
  a.hover(mouseX, mouseY);
  
  //display the draggable object
  a.display();

  //create a for loop that updates the inSludge boolean and applies the drag force appropriately
  for (int i = 0; i < movers.length; i++) {
    PVector force = a.attract(movers[i]);
    if (sludge.contains(movers[i])) {
      inSludge = true;
      PVector drag = sludge.drag(movers[i]);
      movers[i].applyForce(drag);
    } else {
      inSludge = false;
    }
    
    //apply any applicable forces
    movers[i].applyForce(force);
    //update the mover objects
    movers[i].update();
    //display the mover objects
    movers[i].display();
  }
}

void mousePressed() {
  a.clicked(mouseX, mouseY);
}

void mouseReleased() {
  a.stopDragging();
}

// Citations & References:
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
// https://processing.org/reference/PImage.html
// https://processing.org/reference/PVector.html
// https://processing.org/reference/imageMode_.html