/*

Kyle Gapulan
CART353
A2: Image Processing
January 23 2018

*/


//Declare two Image objects 
Image img1;
Image img2;

//Instantiate a PImage and load an image file
void setup() {
  size(500, 500);
  //loadImage("string"), where string is the filename
  //loadImage will look for image files in the Processing sketch folder
  // avoid calling loadImage() above setup() as Processing will not yet know the location of the “data” folder

  //instantiate the image object and point to which image we are loading
  //this will pass a string down to the loadImage function in the Image class
  img1 = new Image("image_one.png");
  img2 = new Image("image_two.png");

  //load the pixels for both images
  loadPixels();
}

void draw () {
  //refresh the background
  background(0); 

  if (mousePressed && mouseButton == LEFT) {
    //if the left mouse button is pressed, display the second image img2. if not, then display the first one img1.
    img2.display();
    
    //refresh the pixels
    updatePixels();
    if (keyPressed) {
      if (key == 't' || key == 'T') {
        //run the function that tints the image when the T key is held
        img2.tintImage();
      }
      
      if (key == 'b' || key == 'B') {
        //run the function that tints the image when the B key is held
        img2.blackwhite();
        
        //refresh the pixels
        updatePixels();
      }
      
    }
  } else {
    //call the display function in the img1 object, which is of Image class
    img1.display();
    
    //refresh the pixels
    updatePixels();
    if (keyPressed) {
      if (key == 't' || key == 'T') {
        //run the function that tints the image when the T key is held
        img1.tintImage();
      }
      
      if (key == 'b' || key == 'B') {
        //run the function that tints the image when the B key is held
        img1.blackwhite();
        
        //refresh the pixels
        updatePixels();
      }
    }
  }
}

//add a function that saves and exports an image to the sketch's data folder
void keyPressed() {
  //if the spacebar is pressed, export the current window as export.jpg
  if (key == 32) {
    save("export.jpg");
  }
}