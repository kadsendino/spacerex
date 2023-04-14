class Controlls extends Menu implements Window{
  ToggleButton ljs_tButton; //ljs - lock joy stick

  Controlls(){
    super();
    this.ljs_tButton = new ToggleButton(width/4, height/4, width/2, height/5, "joystick unlocked", "joystick locked");
  }

  void draw(){
    super.draw();
    //^ has to be first ^

    this.ljs_tButton.show();
  }

  void touchStarted(){
    if(this.ljs_tButton.mouseOver(mouseX, mouseY)){
      this.ljs_tButton.setSelected(true);
    }
    //v has to be last v
    else{
      super.touchStarted();
    }
  }

  void touchEnded(){
    if(this.ljs_tButton.mouseOver(mouseX, mouseY) && this.ljs_tButton.getSelected()){
      this.ljs_tButton.toggle(); //toggle setting: joystick locked
      setSetting(0, this.ljs_tButton.getToggle()); //update setting
    }

    //v has to be last v
    else {
      super.touchEnded();
    }
    this.ljs_tButton.setSelected(false);
  }

  void setup(){}
  void touchMoved(){}
}
