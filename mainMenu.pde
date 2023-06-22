class MainMenu extends Menu implements Window{
  private AnimationButton settings_button, playerMenu_button;
  private PlayButton play_button;

  MainMenu() {
    super();
    this.play_button = new PlayButton(width/2,height/2,height/9);
    this.playerMenu_button = new AnimationButton(width-height*3/14, height/14, height/7, height/7, "crown");
    this.settings_button = new AnimationButton(width-height*3/14, height*4/14, height/7, height/7, "gear");
  }

  void draw() {
    super.draw();
    this.play_button.show();
    this.settings_button.show();
    this.settings_button.update();
    this.playerMenu_button.show();
    this.playerMenu_button.update();
  }

  void touchStarted(){
    if(this.play_button.mouseOver(mouseX, mouseY)){
      this.play_button.setSelected(true);
    }
    else if(this.settings_button.mouseOver(mouseX, mouseY)){
      this.settings_button.setSelected(true);
    }
    else if(this.playerMenu_button.mouseOver(mouseX, mouseY)){
      this.playerMenu_button.setSelected(true);
    }
    else {
      super.touchStarted();
    }
  }

  void touchEnded(){
    if(this.play_button.mouseOver(mouseX, mouseY) && this.play_button.getSelected()) {
      int wave = getStat("wave");
      if(wave == 0){
        wave++;
        String todo; //todo : give getStat a default variable in case it isnt there yet
      }
      setStat("wave", wave-1);
      setWindow(5); //pre game window
    }
    else if(this.settings_button.mouseOver(mouseX, mouseY) && this.settings_button.getSelected()) {
      setWindow(2); //settings menu
    }
    else if(this.playerMenu_button.mouseOver(mouseX, mouseY) && this.playerMenu_button.getSelected()) {
      setWindow(7); //player menu
    }
    else{
      super.touchEnded();
    }

    this.play_button.setSelected(false);
    this.settings_button.setSelected(false);
    this.playerMenu_button.setSelected(false);
  }

  void goBack(){
    System.exit(0);
  }
}
