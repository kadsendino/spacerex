class ManagePlayer implements Window{
  private ArrayList<Upgrade> upgrades;
  private UpgradeBox upgradeBox;
  private PlayButton playbutton;
  private RegexBox regexBox;

  private float box_width, box_height;

  ManagePlayer(){
    this.box_width = width/4;
    this.box_height = height/6;

    this.upgradeBox = new UpgradeBox(height/8,height/8+box_height,box_width,5*box_height-height/4);
    this.playbutton = new PlayButton(width-height/8,height/8,height/20);
    this.regexBox = new RegexBox(height/8,height/8,box_width-box_height,box_height);

    this.loadUpgrades();
  }

  public void draw(){
    background(5,5,25);
    bg.drawStars();

    this.upgradeBox.show();
    this.playbutton.show();
    this.regexBox.show();

    this.showPlayer();

    for(int i=0; i<this.upgrades.size(); i++){
      this.upgrades.get(i).show();
    }
  }

  public void touchStarted(){
    if(this.playbutton.mouseOver(mouseX, mouseY)){
      this.playbutton.setSelected(true);
    }
    else{
      for(int i=0; i<this.upgrades.size(); i++){
        if(this.upgrades.get(i).isMouseOver(mouseX, mouseY) && this.upgradeBox.canTake(this.upgrades.get(i).getId())){
          equipUpgrade(this.upgrades.get(i).getFullId());
          this.upgradeBox.loadData();
          this.upgrades.remove(i);
          return;
        }
      }
    }
    this.upgradeBox.click();
  }

  public void touchEnded(){
    if(this.playbutton.mouseOver(mouseX, mouseY) && this.playbutton.getSelected()){
      setWindow(5); //continue game
    }
    this.playbutton.setSelected(false);
  }

  void touchMoved(){}
  void goBack(){}

  private void showPlayer(){
    float x = height/8+width/4-box_height;
    float y = height/8;
    float w = height/32;
    float h = height/12;
    float point_y = h/3;

    pushStyle();
      noFill();
      strokeWeight(width/240);
      rect(x,y,box_height,box_height);
    popStyle();

    x += box_height/2;
    y += box_height/4;

    pushMatrix();
      noFill();
      strokeWeight(4);
      translate(x,y+(2*h)/3);
      triangle(0, -(2*h)/3, -w, point_y, w, point_y);
    popMatrix();
  }

  public void update(){
    this.loadUpgrades();
  }

  private void loadUpgrades(){
    String[] ids = getList("owned_upgrades"); //all IDs of all upgrades in player's inventory in order
    IntDict owned_anz = new IntDict(); //to store all currently equiped ubgrades

    for(int i=0; i<ids.length; i++){
      String tempId = split(ids[i], ",")[0];
      int tempNum = int(split(ids[i], ",")[1]);
      if(owned_anz.hasKey(tempId)){
        owned_anz.add(tempId, tempNum);
      }else{
        owned_anz.set(tempId, tempNum);
      }
    }

    float size_temp = width/10; //size of one upgrade
    this.upgrades = new ArrayList<Upgrade>(); //empty list to not load more items when equiping items
    String allUpgrades[][] = readFileM1("upgrades.m1");

    for(int i=0; i<allUpgrades.length; i++){
      if(owned_anz.hasKey(allUpgrades[i][0])){
        this.upgrades.add(new Upgrade(random(width/2, width-size_temp), random(size_temp, height-size_temp), size_temp, size_temp, int(allUpgrades[i][0]), allUpgrades[i][1], allUpgrades[i][2], allUpgrades[i][3], owned_anz.get(allUpgrades[i][0])));
      }
    }
  }
}
