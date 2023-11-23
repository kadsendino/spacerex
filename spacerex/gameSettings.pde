class GameSettings extends Menu implements Window{
  private ToggleButton lastIndicatorTBt;

  GameSettings(){
    super();
    this.lastIndicatorTBt = new ToggleButton(width*2/3, height*4.5/10, width/5, height/5, "ON", "OFF");
    if(boolean(getStat("hide_lastIndicator"))){
      this.lastIndicatorTBt.toggle();
    }
  }

  void draw(){
    super.draw();

    pushStyle();
      fill(255);
      textAlign(RIGHT);
      text("LAST ENEMIES INDICATOR:", width*2/3, height/2);
    popStyle();
    this.lastIndicatorTBt.show();
  }

  void touchStarted(){
    if(this.lastIndicatorTBt.mouseOver(mouseX, mouseY)){
      this.lastIndicatorTBt.setSelected(true);
    }else{
      super.touchStarted();
    }
  }

  void touchEnded(){
    if(this.lastIndicatorTBt.mouseOver(mouseX, mouseY) && this.lastIndicatorTBt.getSelected()){
      this.lastIndicatorTBt.toggle();
      setStat("hide_lastIndicator", int(this.lastIndicatorTBt.getToggle()));
   	}else {
      super.touchEnded();
    }
    this.lastIndicatorTBt.setSelected(false);
  }
}
