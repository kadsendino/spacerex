class About extends Menu implements Window{ //credits window
  private PImage mOneLogo; //M1Productions logo

  About(){
    super();
    this.back_window = 2; //settings
    this.mOneLogo = loadImage("M1Productions.png"); //loading the logo
    this.mOneLogo.resize(height/2, height/2); //set the logo to a set size to simplify the drawing statement
  }

  void draw(){
    super.draw();
    imageMode(CENTER); //to simplify the drawing statement you only have to calculate the center coordinates of the picture
    image(this.mOneLogo, width/2, height/2); //draw the M1P logo to the middle of the screen
  }

  void touchStarted(){
    super.touchStarted();
  }

  void touchEnded(){
    super.touchEnded();
  }
}
