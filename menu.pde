class Menu implements Window{
  protected ImageButton back_button;
  protected int back_window; //the window u return to, wehn u click on the "back" button

  Menu() {
    this.back_button = new ImageButton(height/14, height/14, width/9, height/7, loadImage("backArrow.png"));
    this.back_window = 1; //standard return is main menu
  }

  void draw(){
    bg.draw();
    this.back_button.show();
  }

  void touchStarted(){
    if(this.back_button.mouseOver(mouseX, mouseY)){
      this.back_button.setSelected(true);
    }

    else{
      bg.touch();
    }
  }

  void touchEnded(){
    if(this.back_button.mouseOver(mouseX, mouseY) && this.back_button.getSelected()){
      this.goBack(); //goes to saved menu
    }
    this.back_button.setSelected(false);
  }

  void goBack() { //can be called by either the back button or the backPress on the phone
    setWindow(this.back_window);
  }

  void setup(){}
  void touchMoved(){}
}
