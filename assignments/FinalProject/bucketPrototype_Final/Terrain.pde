// ----------------------------------------------------------------------
// USER CLASSES: Terrain (background/visual element)
//
// This is the background element that changes depending on the intensity value.
// ----------------------------------------------------------------------

class Terrain {

  //variables for grid
  int cols, rows;
  //scale
  int scl = 21;
  int w = 2000;
  int h = 1600;
  float terrainIntensity;
  
  //a value holding the speed at which we are "flying" over the terrain
  float flying = 0;

  //a data structure to hold the x and y values as well as a z value for each
  float[][] terrain;

  Terrain() {
    //make colummns and rows depending on the scale
    cols = w / scl;
    rows = h / scl;
    
    
    terrain = new float[cols][rows];
  }

  void fly() {
    
    flying -= (0.1)+(0);

    float yoff = flying;
    //draw the grid
    //start with y since we're thinking about rows
    //make each row a triangle strip
    for (int y = 0; y < rows; y++) {
      float xoff = 0;
      for (int x = 0; x < cols; x++) {
        // using Perlin noise to create ridges in terrain
        // Perlin noise is extruding vertices
        // map(value, start1, stop1, start2, stop2)
        terrain[x][y] = map(noise(xoff, yoff), 0, 1, -(intensity/2), intensity/2);
        //xoff += (0.2 + (intensity*0.01));
        xoff += 0.2;
      }
     // yoff += (0.2 + (intensity*0.01));
     yoff += 0.2;
    }
  }

  void display(int intensity) {
    pushMatrix();
    strokeWeight(1);
    stroke(255, 100);
    noFill();
    translate(width/2, height/2+100); // draw it relative to the center of the window
    rotateX(PI/3); //rotate it along the x axis by 60 degrees
    translate(-w/2, -h/2); // create an offset since triangles are being drawn at 0,0 and we want to be able to see them
    for (int y = 0; y < rows-1; y++) {
      //we can only go to the row below what we have (the second to last one), so subtract 1
      //SPECIFY that we want triangle strips, make it so that every vertex is connected with triangles
      beginShape(TRIANGLE_STRIP);
      for (int x = 0; x < cols; x++) {
        //go across
        vertex(x*scl, y*scl, terrain[x][y]); //where terrain[x][y] is the z axis
        //y+1 so that we make the bottom vertex
        vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
        //rect(x*scl, y*scl, scl, scl);
      }
      endShape();
    }
    popMatrix();
  }
}