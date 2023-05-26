class ManagePlayer implements Window{

  //Upgrade[] upgrades;
  Player player_show;
  UpgradeBox upgradeBox;
  PlayButton playbutton;
  RegexBox regexBox;

  ManagePlayer(){
    this.setup();
  }


  void setup(){
   this.upgradeBox = new UpgradeBox(height/8,height/8+height/6,width/4,5*height/6-height/4);
   this.playbutton = new PlayButton(width-height/8,height/8,height/20);
   this.regexBox = new RegexBox(height/8,height/8,width/4,height/6);
  }

  void draw(){
    background(5,5,25);
    
    upgradeBox.show();
    playbutton.show();
    regexBox.show();
  }

  void touchStarted(){
    if(this.playbutton.mouseOver(mouseX, mouseY)){
      this.playbutton.setSelected(true);
    }
  }

  void touchEnded(){
    if(this.playbutton.mouseOver(mouseX, mouseY) && this.playbutton.getSelected()){
      setWindow(5); //goes to saved menu
    }
    this.playbutton.setSelected(false);
  }

  void touchMoved(){}
  void goBack(){}


}