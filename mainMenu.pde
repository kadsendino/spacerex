class MainMenu extends Menu implements Window{
  private Button settings_button;
  private PlayButton play_button;

  MainMenu() {
    super();
    this.back_button.setLabel("QUIT");
    this.play_button = new PlayButton();
    this.settings_button = new Button(width/2-width/8, height*3/4, width/4, height/5, "SETTINGS");
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

  // vv play button is only used here vv
  private class PlayButton extends Button{
    float x1, y1, y2; //x1 = x2 -> redundat

    PlayButton(){
      super(width*5/9, height/2, 0, "");

      this.x1 = width*4/9;
      this.y1 = height*2/5;
      this.y2 = height*3/5;
      this.st = height/100;
      this.active_touch = -1;
    }

    void show(){
      fill(primCol,150);
      stroke(secCol);
      strokeWeight(this.st);
      triangle(this.x, this.y, this.x1, this.y1, this.x1, this.y2);

      if(this.selected){
        fill(secCol, 100);
      }
    }

    boolean mouseOver(float x,float y){
      return((this.x1<=x && this.x>=x) && (this.y1<=y && this.y2>=y));
    }
  }
}
