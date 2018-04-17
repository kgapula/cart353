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

// This sketch creates particles using dollar bills
// I was going for a similar effect to the Money trail in Rocket League:
// https://vignette.wikia.nocookie.net/rocketleague/images/7/71/Money_trail_animated.gif/revision/latest?cb=20161229055438
// Using Particles, by Daniel Shiffman as a base
// This sketch has Mouse events! Particles come out from the cursor's position

ParticleSystem ps;
PImage sprite;  

void setup() {
  size(1024, 768, P2D);
  orientation(LANDSCAPE);
  sprite = loadImage("dollar.png");
  ps = new ParticleSystem(1000);

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
  
  fill(255);
  textSize(16);
  text("Frame rate: " + int(frameRate), 10, 20);
  
}
