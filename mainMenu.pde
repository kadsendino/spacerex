class MainMenu extends Menu implements Window{
  Button play_button, settings_button;

  MainMenu() {
    super();
    this.back_button.setLabel("quit");
    this.play_button = new Button(width/2-width/10, height/4, width/5, height/5, "play");
    this.settings_button = new Button(width/2-width/10, height*2/4, width/5, height/5, "settings");
  }

  void draw() {
    super.draw();
    //^ has to be first ^

    this.play_button.show();
    this.settings_button.show();
  }

  void touchStarted(){
    if(this.play_button.mouseOver(mouseX, mouseY)){
      this.play_button.setSelected(true);
    }
    else if(this.settings_button.mouseOver(mouseX, mouseY)){
      this.settings_button.setSelected(true);
    }

    //v has to be last v
    else {
      super.touchStarted();
    }
  }

  void touchEnded(){
    if(this.back_button.mouseOver(mouseX, mouseY) && this.back_button.getSelected()){
      System.exit(0);
    }
    else if(this.play_button.mouseOver(mouseX, mouseY) && this.play_button.getSelected()) {
      window = 0; //game starts
    }
    else if(this.settings_button.mouseOver(mouseX, mouseY) && this.settings_button.getSelected()) {
      window = 2; //settings menu
    }
    this.back_button.setSelected(false);
    this.play_button.setSelected(false);
    this.settings_button.setSelected(false);
  }

  void setup(){}
  void touchMoved(){}
}
