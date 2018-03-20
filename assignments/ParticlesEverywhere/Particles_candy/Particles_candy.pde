/*
Kyle Gapulan
CART353
Prof. R. Khaled
March 20 2018

Brief:
Create three different particle systems, with behaviours specific to the phenomena they represent
Use of inheritance
Use of Iterators, ArrayLists, and enhanced for loops
How well you convey a sense of place through particle behaviour
*/

// This sketch displays candy themed particles
// Going for a particle system that could be used for something like the Popsicle attack from Fire Emblem Heroes: https://kagerochart.com/images/hero/medium/gaius-thief-exposed-special-attack.png
// Using Multiple Particle Systems by Daniel Shiffman as a base

ArrayList<ParticleSystem> systems;

//variables to hold our image sprites
PImage candy;
PImage lollipop;

void setup() {
  size(640, 360);
  systems = new ArrayList<ParticleSystem>();
}

void draw() {
  //background refresh
  background(0);
  
  //run the respective methods for each particle system
  for (ParticleSystem ps : systems) {
    ps.run();
    ps.addParticle();
  }
  //display instructions if there aren't any particle systems displayed
  if (systems.isEmpty()) {
    fill(255);
    textAlign(CENTER);
    text("click to add particle systems", width/2, height/2);
  }
}

//add particle systems with every mouse click, at the specific mouse location
void mousePressed() {
  systems.add(new ParticleSystem(1, new PVector(mouseX, mouseY)));
}

// Image sources: iconsDB, Icon Archive
