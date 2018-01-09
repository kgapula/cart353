class blackSquare {
  int x;
  int y;
  int size;
  int col;

  //food gets initialized at random amount
  float food;

  //initialize the boolean with the color white
  boolean white;

  blackSquare(int x, int y, int size, boolean white) {
    this.x = x;
    this.y = y;
    this.size = size;

    this.white = white;

    // establish a random amount of food to start with
    this.food = random(500, 1000);

    //set colors
    if (white) {
      this.col = 255;
    } else {
      this.col = 0;
    }
  }


  void render() {
  //change color according to amount of food
    // if it is a black square
    if (!this.white) {

      // reflect the amount of food
      col = (int)map(this.food, 0, 1000, 255, 0);
      //map(value, start1, stop1, start2, stop2) in floats
      //value to be mapped

    }

    fill(col, 10); // calling fill with 2 arguments, second will be alpha channel
    rect(this.x * size, this.y * size, size, size);
  }

//black squares get hungry
  void update() {
    //shrink amount of food, black square gets hungry over time
    if(!this.white && this.food > 0) {
      this.food--;
    }
  }

  void feed() {
    if (!this.white && this.food < 1000) {
      this.food += 10;
      
    }
  }
}