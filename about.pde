class About extends Menu implements Window{
  PImage mOneLogo;

  About(){
    super();
    this.mOneLogo = loadImage("M1Productions.png");
    this.mOneLogo.resize(height/2, height/2);
  }

  void draw(){
    super.draw();
    //^ has to be first ^

    imageMode(CENTER);
    image(this.mOneLogo, width/2, height/3);
  }

  void touchStarted(){
    //v has to be last v
    super.touchStarted();
  }

  void touchEnded(){
    //v has to be last v
    super.touchEnded();
  }

  void setup(){}
  void touchMoved(){}
}
