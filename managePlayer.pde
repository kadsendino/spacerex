class ManagePlayer implements Window{

  //Upgrade[] upgrades;
  Player player_show;
  UpgradeBox upgradeBox;
  PlayButton playbutton;
  RegexBox regexBox;

  float box_width;
  float box_height;


  ManagePlayer(){
    this.setup();
  }


  void setup(){
    this.box_width = width/4;
    this.box_height = height/6;

    this.upgradeBox = new UpgradeBox(height/8,height/8+box_height,box_width,5*box_height-height/4);
    this.playbutton = new PlayButton(width-height/8,height/8,height/20);
    this.regexBox = new RegexBox(height/8,height/8,box_width-box_height,box_height);  
  }

  void draw(){
    background(5,5,25);
    
    upgradeBox.show();
    playbutton.show();
    regexBox.show();

    showPlayer();
  
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

  void showPlayer(){

    float x = height/8+width/4-box_height;
    float y = height/8;
    float w = height/32;
    float h = height/12;
    float point_y = h/3;

    strokeWeight(width/240);
    stroke(255);
    noFill();
    rect(x,y,box_height,box_height);

    x += box_height/2;
    y += box_height/4; 

    pushMatrix();
    strokeWeight(4);
    translate(x,y+(2*h)/3);
    stroke(255);
    triangle(0, -(2*h)/3, -w, point_y, w, point_y);
    popMatrix();
  }
}