class Controls extends Menu implements Window{
  private ToggleButton ljs_tButton; //ljs - lock joy stick

  Controls(){
    super();
    this.back_window = 2; //settings
    this.ljs_tButton = new ToggleButton(width/4, height/4, width/2, height/5, "JOYSTICK LOCKED", "JOYSTICK UNLOCKED");
    if(boolean(getSetting(0))){
      this.ljs_tButton.toggle(); //unlocks joystick
    }
  }

  void draw(){
    super.draw();

    this.ljs_tButton.show();
  }

  void touchStarted(){
    if(this.ljs_tButton.mouseOver(mouseX, mouseY)){
      this.ljs_tButton.setSelected(true);
    }
    else{
      super.touchStarted();
    }
  }

  void touchEnded(){
    if(this.ljs_tButton.mouseOver(mouseX, mouseY) && this.ljs_tButton.getSelected()){
      this.ljs_tButton.toggle(); //toggle setting: joystick locked
      setSetting(0, int(this.ljs_tButton.getToggle())); //update setting
    }
    else {
      if(this.back_button.mouseOver(mouseX, mouseY) && this.back_button.getSelected()){

        saveList("settings", settings);
        this.goBack(); //goes to saved menu
      }
    }
    this.back_button.setSelected(false);
    this.ljs_tButton.setSelected(false);
  }
}
