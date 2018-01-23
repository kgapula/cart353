class Image {
  //Declare a variable of type PImage
  PImage img;

  Image(String file) {
    //loadImage("string"), where string is the filename
    img = loadImage(file);
  }

  void display () {
    //this function has brightness manipulation as its default
    for (int x = 0; x < img.width; x++) {
      for (int y = 0; y < img.height; y++) {
        // Calculate the 1D pixel location
        int loc = x + y * img.width;
        // Get the red, green, blue values
        float r = red (img.pixels[loc]);
        float g = green(img.pixels[loc]);
        float b = blue (img.pixels[loc]);

        // Adjust brightness with mouseX
        //width-1 to assure that we reach the whole range of values
        float adjustBright = map(mouseX, 0, width-1, 0, 8);
        r *= adjustBright;
        g *= adjustBright;
        b *= adjustBright;
        r = constrain(r, 0, 255);
        g = constrain(g, 0, 255);
        b = constrain(b, 0, 255);
        // Make a new color
        color c = color(r, g, b);
        pixels[loc] = c;
      }
    }
  }

  void tintImage() {
    //write a function responsible for tinting the image blue
    // Tint the image blue and set partial transparency
    tint(0, 153, 204, 126);
    
    //display the image
    image(img, 0, 0);
  }
  
  void blackwhite() {
    //create a function responsible for tinting the image black and white
    for (int x = 0; x < img.width; x++) {
      for (int y = 0; y < img.height; y++) {
        // Calculate the 1D pixel location
        int locP = x + y * img.width;
        // Get the blue value
        float b = blue(img.pixels[locP]);
        color c = color(b);
        //assign the color (black) to the pixels
        pixels[locP] = c;
      }
    }
  }
}

//references: 
//Learning Processing, chapter 15
//https://processing.org/reference/save_.html
//https://processing.org/reference/tint_.html
//https://processing.org/reference/key.html

//Image sources: Scott Webb & Thaddeus Lim @ Unsplash