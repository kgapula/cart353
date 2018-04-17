/*
Kyle Gapulan
 CART353
 Prof. R. Khaled
 April 10 2018
 
 Full Prototype (Processing portion, requires Arduino Sketch to work)
 
 */

import processing.serial.*; //import the Serial library

// ----------------------------------------------------------------------
// Variables for reading values from Arduino
// ----------------------------------------------------------------------

int end = 10;    // the number 10 is ASCII for linefeed (end of serial.println), later we will look for this to break up individual messages
String serial;   // declare a new string called 'serial' . A string is a sequence of characters (data type know as "char")
Serial port;  // The serial port, this is a new instance of the Serial class (an Object)

// ----------------------------------------------------------------------
// Variables for the Lightning effects
// ----------------------------------------------------------------------
float maxDTheta = PI/10;
float minDTheta = PI/20;
float maxTheta = PI/2;
float childGenOdds = .01;

float minBoltWidth = 3;
float maxBoltWidth = 10;

float minJumpLength = 1;
float maxJumpLength = 10;

boolean stormMode = true;
boolean fadeStrikes = true;
boolean randomColors = false;
float maxTimeBetweenStrikes = 3000;
color boltColor;
float lastStrike = 0;
float nextStrikeInNms = 0;
boolean playThunder = false;
//distance, in milliseconds, of the storm.
float meanDistance = 0;
//if the current time matches the time in this arraylist, trigger it!
ArrayList thunderTimes = new ArrayList();



// ----------------------------------------------------------------------
// Variables for Processing Objects
// ----------------------------------------------------------------------

//Initialize our objects
Bucket bucket; // draggable bucket
int dropletCount = 0;
Terrain terrain; // used for background effects
Background background; // used for background effects
RainSystem rs; // particle system-esque raindrops
//Initialize an array of raindrops
//Mover[] movers = new Mover[1];
lightningBolt bolt;

//arrays for background tiles
//X and Y positions
int[] bgX = new int[50];
int[] bgY = new int[50];
int intensity;
int tempIntensity = 0;
String intensityLevel;
boolean isDragging;

void setup() {

  // ----------------------------------------------------------------------
  // Setup Arduino elements
  // ----------------------------------------------------------------------

  port = new Serial(this, Serial.list()[0], 9600); // initializing the object by assigning a port and baud rate (must match that of Arduino)
  port.clear();  // function from serial library that throws out the first reading, in case we started reading in the middle of a string from Arduino
  serial = port.readStringUntil(end); // function that reads the string from serial port until a println and then assigns string to our string variable (called 'serial')
  serial = null; // initially, the string will be null (empty)

  // ----------------------------------------------------------------------
  // Setup Processing elements
  // ----------------------------------------------------------------------
  size(900, 750, P3D);
  noSmooth();
  //create a background object
  //create an bucket object, to be controlled
  background = new Background();
  terrain = new Terrain();
  bucket = new Bucket("bucket.png");

  //Initialize all elements of the XY arrays to zero
  for (int i = 0; i < bgX.length; i++) {
    bgX[i] = 0;
    bgY[i] = 0;
  }

  randomSeed(1);
  //for (int i = 0; i < movers.length; i++) {
  //  movers[i] = new Mover(random(1, 4), random(width), 0, tempIntensity);
  //}

  rs = new RainSystem(new PVector(width/2, -50), tempIntensity, dropletCount);

  meanDistance = 1000*.5;
  boltColor = color(0, 0, 99);
  //skyColor = color(0,0,10,20);
  bolt = new lightningBolt(random(0, width), 0, random(minBoltWidth, maxBoltWidth), 0, minJumpLength, maxJumpLength, boltColor);
}

void draw() {

  // ----------------------------------------------------------------------
  // Read elements from Arduino
  // ----------------------------------------------------------------------  

  readValue();
  

  // ----------------------------------------------------------------------
  // Call functions for Processing Sketch
  // ----------------------------------------------------------------------     

  background(255);
  background.display();

  terrain.fly();
  terrain.display(intensity);

  rs.addRaindrop();
  rs.run();

  //call the function that enables the "rolling" movement when dragged
  bucket.drag();
  bucket.hover(mouseX, mouseY);

  //display the draggable object
  bucket.display();
  
  isDragging = bucket.checkDragging();

  //Draw a new lightning bolt when intensity is high
  if (intensity > 400) { 
    //thunderclap.display(); //WRITE A FUNCTION FOR THIS
    bolt = new lightningBolt(random(0, width), 0, random(minBoltWidth, maxBoltWidth), 0, minJumpLength, maxJumpLength, boltColor);
    bolt.display();
    thunderTimes.add(bolt.getThunderTime());
  }

  //check if any of the stored times need to make a 'ding'
  if (playThunder && thunderTimes.size() > 0)
    if (millis() > (Float)thunderTimes.get(0)) {
      thunderTimes.remove(0);
      // thunderSound.trigger();
      println("boom!");
    }

  if (stormMode && millis()-lastStrike>nextStrikeInNms) {
    //check if it is time for a new bolt
    lastStrike = millis();
    nextStrikeInNms = random(0, maxTimeBetweenStrikes);

    bolt = new lightningBolt(random(0, width), 0, random(minBoltWidth, maxBoltWidth), 0, minJumpLength, maxJumpLength, boltColor);
    bolt.display();
    if (playThunder)
      thunderTimes.add(bolt.getThunderTime());
  } else {
    if (fadeStrikes) {
      noStroke();
      //fill(skyColor);
      rect(0, 0, width, height);
      noFill();
    }
  }
  displayText();
}

//}

// ----------------------------------------------------------------------
// Enable Mouse events
// ---------------------------------------------------------------------- 

void mousePressed() {
  bucket.clicked(mouseX, mouseY);
}

void mouseReleased() {
  bucket.stopDragging();
}

// ----------------------------------------------------------------------
// Keyboard and mouse events (for debugging purposes )
// ---------------------------------------------------------------------- 

void keyTyped() {
  //force a background refresh
  if (key==' ')
  {
    noStroke();
    fill(0);
    rect(0, 0, width, height);
    noFill();
    stroke(255, 255, 0);
  }
}


//Force a lightning bolt to be drawn
void mouseClicked() {
  //bolt = new lightningBolt(random(0, width), 0, random(minBoltWidth, maxBoltWidth), 0, minJumpLength, maxJumpLength, boltColor);
  //bolt.display();
  //thunderTimes.add(bolt.getThunderTime());
}

void stop() {
  //in case we want to use sound
  //thunderSound.close(); // remember to store the sound in thunderSound
  //minim.stop(); 
  super.stop();
}

// ----------------------------------------------------------------------
// These functions handle the LightningBolt events (see the Lightning bolt tab)
// ----------------------------------------------------------------------

int randomSign() //returns +1 or -1
{
  float num = random(-1, 1);
  if (num==0)
    return -1;
  else
    return (int)(num/abs(num));
}

//returns a random color
color randomColor() {
  return color(random(0, 100), 99, 99);
}

//returns a random color similar to the one already there
color slightlyRandomColor(color inputCol, float length) {
  float h = hue(inputCol);
  h = (h+random(-length, length))%100;
  return color(h, 99, 99);
}

// ----------------------------------------------------------------------
// Get Arduino Values
// ---------------------------------------------------------------------- 

int readValue() {
  while (port.available() > 0) { //as long as there is data coming from serial port, read it and store it 
    serial = port.readStringUntil(end);
  }
  if (serial != null) {  //if the string is not empty, print the following

    /*  Note: the split function used below is not necessary if sending only a single variable. However, it is useful for parsing (separating) messages when
     reading from multiple inputs in Arduino. Split function commented out in case we want to read from multiple Arduino variables. 
     */

    //String[] a = split(serial, ',');  //a new array (called 'a') that stores values into separate cells (separated by commas specified in your Arduino program)
    String a = serial;  //a new array (called 'a') that stores values into separate cells (separated by commas specified in your Arduino program)

    println("serial " + ": " + a); //print Value1 (in cell 1 of Array - remember that arrays are zero-indexed)
    //println(a[1]); //print Value2 value

    // println("serial" + " :" + serial);

    // trim the string
    String intensityValue = trim(a);

    // convert the value to an int that can be used in other methods or classes
    intensity = Integer.parseInt(intensityValue);

    println("intensity" + " :" + intensity);
  }
  return intensity; // return the value so that it can be used in other functions
}

// ----------------------------------------------------------------------
// Display text for relevant values
// ----------------------------------------------------------------------

void displayText() {
  //pushStyle();
  int textX = 20;
  int textY = 30;
  fill(255);
  
  if(intensity > 100 && intensity < 200) {
      intensityLevel = "(LOW)";
    } else if (intensity > 200 && intensity < 300) {
      intensityLevel = "(MEDIUM)";
    } else if (intensity > 300 && intensity < 400) {
      intensityLevel = "(MEDIUM-HIGH)";
    } else if (intensity > 400) {
      intensityLevel = "(HIGH)";
    }
  
  text("Intensity :" + " " + intensity + " " + intensityLevel, textX, textY);
  text("Collected Drops :" + " " + dropletCount, textX, textY+20);
  //popStyle();
}

// ----------------------------------------------------------------------
// Credits & References
// ----------------------------------------------------------------------

// ----------------------------------------------------------------------
// Daniel Shiffman, Nature of Code / The Coding Train (ArrayLists, Perlin noise terrain generation, Forces, Particle Systems)
// Aaron Alai, Electromagnetic Field Detector
// Daniel Christopher, Arduino to Processing Setup
// OpenProcessing for the LightningBolt background element
// Processing Reference
// Processing Forum
// ---------------------------------------------------------------------- 