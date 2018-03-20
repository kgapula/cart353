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

// This sketch creates glitter-like particles
// Using Particles, by Daniel Shiffman as a base

ParticleSystem ps;
PImage sprite;  

void setup() {
  size(1024, 768, P2D);
  orientation(LANDSCAPE);
  sprite = loadImage("sprite.png");
  ps = new ParticleSystem(10000);

  // Writing to the depth buffer is disabled to avoid rendering
  // artifacts due to the fact that the particles are semi-transparent
  // but not z-sorted.
  hint(DISABLE_DEPTH_MASK);
} 

void draw () {
  background(0);
  ps.update();
  ps.display();
  
  ps.setEmitter(mouseX,mouseY);
}
