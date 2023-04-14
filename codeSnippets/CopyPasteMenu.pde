class A extends Menu implements Window{
  Button a_button;

  A(){
    super();
    this.back_window = 0;
    this.a_button = new Button(width/2-width/10, height/4, width/5, height/5, "a");
  }

  void draw(){
    super.draw();
    //^ has to be first ^

    this.a_button.show();
  }

  void touchStarted(){
    if(this.a_button.mouseOver(mouseX, mouseY)){
      this.a_button.setSelected(true);
    }

    //v has to be last v
    else{
      super.touchStarted();
    }
  }

  void touchEnded(){
    if(this.a_button.mouseOver(mouseX, mouseY) && this.a_button.getSelected()){
      window = 0;
    }

    //v has to be last v
    else {
      super.touchEnded();
    }
    this.a_button.setSelected(false);
  }

  void setup(){}
  void touchMoved(){}
}
