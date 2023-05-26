class MainMenu extends Menu implements Window{
  private AnimationButton settings_button;
  private PlayButton play_button;

  MainMenu() {
    super();
    this.play_button = new PlayButton(width/2,height/2,height/3);
    PImage[] frames_temp = new PImage[6];
    frames_temp[0] = loadImage("settings1.png");
    frames_temp[1] = loadImage("settings2.png");
    frames_temp[2] = loadImage("settings3.png");
    frames_temp[3] = loadImage("settings4.png");
    frames_temp[4] = loadImage("settings5.png");
    this.settings_button = new AnimationButton(width*2/3, height/2-height/12, height/6, height/6, frames_temp);
  }

  void draw() {
    super.draw();
    this.play_button.show();
    this.settings_button.show();
    this.settings_button.update();
  }

  void touchStarted(){
    if(this.play_button.mouseOver(mouseX, mouseY)){
      this.play_button.setSelected(true);
    }
    else if(this.settings_button.mouseOver(mouseX, mouseY)){
      this.settings_button.setSelected(true);
    }
    else {
      super.touchStarted();
    }
  }

  void touchEnded(){
    if(this.play_button.mouseOver(mouseX, mouseY) && this.play_button.getSelected()) {
     setWindow(0); //game starts
    }
    else if(this.settings_button.mouseOver(mouseX, mouseY) && this.settings_button.getSelected()) {
     setWindow(2); //settings menu
    }
    else{
      super.touchEnded();
    }
    this.play_button.setSelected(false);
    this.settings_button.setSelected(false);
  }

  void goBack(){
    System.exit(0);
  }

  void setup(){}
  void touchMoved(){}


}
