class Settings extends Menu implements Window{
  private Button about_button, controlls_button, game_button;

  Settings(){
    super();
    this.controlls_button = new Button(width/2-width/7, height/4, width/3.5, height/5, "CONTROLLS");
    this.game_button = new Button(width/2-width/7, height*2/4, width/3.5, height/5, "GAME");
    this.about_button = new Button(width/2-width/7, height*3/4, width/3.5, height/5, "ABOUT");
  }

  void draw(){
    super.draw();
    this.controlls_button.show();
    this.game_button.show();
    this.about_button.show();
  }

  void touchStarted(){
    if(this.controlls_button.mouseOver(mouseX, mouseY)){
      this.controlls_button.setSelected(true);
    }else if(this.game_button.mouseOver(mouseX, mouseY)){
      this.game_button.setSelected(true);
    }else if(this.about_button.mouseOver(mouseX, mouseY)){
      this.about_button.setSelected(true);
    }else{
      super.touchStarted();
    }
  }

  void touchEnded(){
    if(this.controlls_button.mouseOver(mouseX, mouseY) && this.controlls_button.getSelected()){
     setWindow(4); //controls menu
    }else if(this.game_button.mouseOver(mouseX, mouseY) && this.game_button.getSelected()){
     setWindow(9); //game settings menu
    }else if(this.about_button.mouseOver(mouseX, mouseY) && this.about_button.getSelected()){
     setWindow(3); //about menu
    }else {
      super.touchEnded();
    }
    this.controlls_button.setSelected(false);
    this.game_button.setSelected(false);
    this.about_button.setSelected(false);
  }
}
