class Menu{
  Button back_button;

  Menu() {
    this.back_button = new Button(width/2-width/10, height*3/4, width/5, height/5, "back");

  }

  void draw(){
    background(5,5,25);
    this.back_button.show();
  }

  void touchStarted(){
    if(this.back_button.mouseOver(mouseX, mouseY)){
      this.back_button.setSelected(true);
    }
  }

  void touchEnded(){
    if(this.back_button.mouseOver(mouseX, mouseY) && this.back_button.getSelected()){
      window = 1; //goes to main menu
    }
    this.back_button.setSelected(false);
  }
}
