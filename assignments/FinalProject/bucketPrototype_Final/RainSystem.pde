// ----------------------------------------------------------------------
// USER CLASSES: RainSystem (to be used to manage the list of Raindrop particles)
// ----------------------------------------------------------------------

// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class RainSystem {
  //create an array list of raindrops
  ArrayList<Raindrop> raindrops;
  //give them a PVector for an origin
  PVector origin;

  RainSystem(PVector position, int tempIntensity, int dropletCount) {
    origin = position.copy();
    raindrops = new ArrayList<Raindrop>();
    
  }

  void addRaindrop() {
    raindrops.add(new Raindrop(origin, tempIntensity));
  }

  void run() {
    for (int i = raindrops.size()-1; i >= 0; i--) {
      Raindrop r = raindrops.get(i);
      r.run();
      //r.checkCollisions();
      
      if (r.isDead()) {
        raindrops.remove(i); // remove if the lifespan is up
      }
      
      if (r.checkCollisions()) {
        raindrops.remove(i); //remove when collision with the bucket returns true
        dropletCount++;
      }
    }
  }
}