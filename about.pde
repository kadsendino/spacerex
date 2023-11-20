class About extends Menu implements Window{ //credits window
  private PImage m1Logo; //M1Productions logo
  private String version;

  About(){
    super();
    this.back_window = 2; //settings
    this.m1Logo = loadImage("M1Productions.png"); //loading the logo
    this.m1Logo.resize(height/2, height/2); //set the logo to a set size to simplify the drawing statement
    this.version = "v" + sharedPreferences.getString("game_version_name", "version error");
  }

  public void draw(){
    super.draw();
    image(this.m1Logo, width/2, height/2); //draw the M1P logo to the middle of the screen
    pushStyle();
      fill(255);
      text(version, width/2, height*4/5);
    popStyle();
  }

  public void touchStarted(){
    super.touchStarted();
  }

  public void touchEnded(){
    super.touchEnded();
  }
}
