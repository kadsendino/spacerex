class MainMenu extends Menu implements Window{
  private AnimationButton settings_button, playerMenu_button;
  private PlayButton play_button;

  MainMenu() {
    super();
    this.play_button = new PlayButton();
    this.playerMenu_button = new AnimationButton(width/3-height/6, height/2-height/12, height/6, height/6, "crown", 6);
    this.settings_button = new AnimationButton(width*2/3, height/2-height/12, height/6, height/6, "gear", 5);
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
      setWave(getWave()-1);
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

  // vv play button is only used here vv
  private class PlayButton extends Button{
    float x1, y1, y2; //x1 = x2 -> redundat

    PlayButton(){
      super(width*5/9, height/2, width/9, "");

      this.x1 = width*4/9;
      this.y1 = height/2-this.w/2;
      this.y2 = height/2+this.w/2;
      this.st = height/100; //stroke
    }

    void show(){
      if(this.selected){
        fill(secCol, 200);
      }
      else{
        fill(primCol, 150);
      }
      stroke(secCol);
      strokeWeight(this.st);
      triangle(this.x, this.y, this.x1, this.y1, this.x1, this.y2);
    }

    boolean mouseOver(float x,float y){
      return((this.x1<=x && this.x>=x) && (this.y1<=y && this.y2>=y));
    }
  }
}
