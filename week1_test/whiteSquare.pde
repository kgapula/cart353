class WhiteSquare {
  int x;
  int y;
  int size;
  int col;

  //food gets initialized at random amount
  float food;

  //initialize the boolean with the color white
  boolean white;

  WhiteSquare(int x, int y, int size, boolean white) {
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
    rect(this.x * size, this.y * size, size, size);
  }
}