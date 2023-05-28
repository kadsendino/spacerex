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
    //^ has to be first ^

    image(this.mOneLogo, width/2, height/3); //draw the M1P logo to the middle of the screen
  }

  void touchStarted(){

    //v has to be last v
    super.touchStarted();
  }

  void touchEnded(){
    super.touchEnded();
  }

  void setup(){}
  void touchMoved(){}
}
