class ManagePlayer implements Window{

  //Upgrade[] upgrades;
  Player player_show;
  UpgradeBox upgradeBox;
  PlayButton playbutton;
  //RegexBox regexBox;

  ManagePlayer(){
    this.setup();
  }


  void setup(){
   this.upgradeBox = new UpgradeBox(width/8,height/8+height/3,width/3,2*height/3-height/4);
   this.playbutton = new PlayButton(width-width/8,height/8,height/20);
  }

  void draw(){
    background(5,5,25);
    
    upgradeBox.show();
    playbutton.show();
  }

  void touchStarted(){
    if(this.playbutton.mouseOver(mouseX, mouseY)){
      this.playbutton.setSelected(true);
    }
  }

  void touchEnded(){
    if(this.playbutton.mouseOver(mouseX, mouseY) && this.playbutton.getSelected()){
      setWindow(7); //goes to saved menu
    }
    this.playbutton.setSelected(false);
  }

  void touchMoved(){}
  void goBack(){}


}