/*
 Kyle Gapulan
 CART353
 Prof. R. Khaled
 February 6 2018
 
 Rando Video
 Create a program that:
 
 Uses Gaussian distribution or a Montecarlo algorithm
 Uses 2D or 3D Perlin noise
 Acts on a video (live or pre-recorded)
 */
 
//import the library for noise
import java.util.*;
//import the video library
import processing.video.*;
//declare a variable for the random number generator
Random generator;
//declare a movie object
Movie rainMovie;

void setup() {
  //cut the framerate by a third
  frameRate(40);
  size(854, 480);
  //create the movie object
  rainMovie = new Movie(this, "Rainy_Street_1.mp4");
  rainMovie.loop();
  //declare a variable of type Random and create the Random object
  generator = new Random();
}

//captureEvent for webcam, movieEvent for recorded video
void movieEvent(Movie m) {
  m.read();
}

void draw() {
  //do a background refresh
  background(255);
  tint(255);
  
  //load pixels from the video file
  loadPixels();
  rainMovie.loadPixels();
  
  //display video
  image(rainMovie, 0, 0, width, height);

  //produce a random number with a Gaussian distribution
  float num = (float) generator.nextGaussian();

  //multiply the random number by a given amount, since random numbers are always between 0 and 1
  float scale  = num * 10;

  //use noise function
  float n = noise(scale);
  float offset = noise(num);
  
  //walk through every pixel in the image
  for (int x = 0; x < rainMovie.width; x++) {
    for (int y = 0; y < rainMovie.height; y++) {
      //get the position of the pixels 
      int loc = x + y * rainMovie.width;
      
      //get the color value for every pixel
      color c = rainMovie.pixels[loc];
      
      //since RGB values can only reach a maximum of 255, we need to constrain them
      // color each pixel using Perlin noise for the brightness
      // map(value to be converted, start1, stop1, start2, stop2)
      float brightness = map(n, 0, 1, 0, 255);
      float r = red(c);
      float g = green(c);
      float b = blue(c);
      
      //change current RGB values according to the position of the mouse and/or the offset value
      r += brightness/(2*offset);
      g += brightness*(mouseY*offset);
      b += brightness*(mouseX*offset); 
      
      //put the new RGB values into the pixel array and further affect those values by adding an offset
      rainMovie.pixels[loc] = int(color(r, g, b)*offset);
    }
  }
  //update the pixels
  rainMovie.updatePixels();
}

//Video source: "Rainy Street" @ Coverr

/*References:
The Nature of Code textbook
http://natureofcode.com/book/introduction/

Processing reference & tutorials
https://processing.org/reference/map_.html
https://processing.org/tutorials/video/
https://processing.org/reference/noise_.html
https://processing.org/reference/frameRate_.html
*/