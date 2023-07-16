class PlayerMenu extends Menu implements Window{
  Button stats_button, achievements_button;

  PlayerMenu(){
    super();
    this.back_window = 1; //main menu
    this.stats_button = new Button(width/2-width/6, height/4-height/10, width/3, height/5, "STATS");
    this.achievements_button = new Button(width/2-width/6, height*3/4-height/10, width/3, height/5, "ACHIEVEMENTS");
  }

  void draw(){
    super.draw();

    this.stats_button.show();
    this.achievements_button.show();
  }

  void touchStarted(){
    if(this.stats_button.mouseOver(mouseX, mouseY)){
      this.stats_button.setSelected(true);
    }
    else if(this.achievements_button.mouseOver(mouseX, mouseY)){
      this.achievements_button.setSelected(true);
    }
    else{
      super.touchStarted();
    }
  }

  void touchEnded(){
    if(this.stats_button.mouseOver(mouseX, mouseY) && this.stats_button.getSelected()){
     setWindow(8); //stats overview window
    }
    else if(this.achievements_button.mouseOver(mouseX, mouseY) && this.achievements_button.getSelected()){
     setWindow(10); //achievements window
    }
    else {
      super.touchEnded();
    }
    this.stats_button.setSelected(false);
    this.achievements_button.setSelected(false);
  }
}
