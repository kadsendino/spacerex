class Settings extends Menu implements Window{
  private Button about_button, controlls_button;

  Settings(){
    super();
    this.controlls_button = new Button(width/2-width/7, height/4, width/3.5, height/5, "CONTROLLS");
    this.about_button = new Button(width/2-width/10, height*2/4, width/5, height/5, "ABOUT");
  }

  void draw(){
    super.draw();

    this.controlls_button.show();
    this.about_button.show();
  }

  void touchStarted(){
    if(this.controlls_button.mouseOver(mouseX, mouseY)){
      this.controlls_button.setSelected(true);
    }
    else if(this.about_button.mouseOver(mouseX, mouseY)){
      this.about_button.setSelected(true);
    }

    else{
      super.touchStarted();
    }
  }

  void touchEnded(){
    if(this.controlls_button.mouseOver(mouseX, mouseY) && this.controlls_button.getSelected()){
     setWindow(4); //controll menu
    }
    else if(this.about_button.mouseOver(mouseX, mouseY) && this.about_button.getSelected()){
     setWindow(3); //about menu
    }

    else {
      super.touchEnded();
    }
    this.controlls_button.setSelected(false);
    this.about_button.setSelected(false);
  }

  void setup(){}
  void touchMoved(){}
}
