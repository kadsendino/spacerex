class ManagePlayer implements Window{
  Upgrade[] upgrades;
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

    this.loadUpgrades();
  }

  public void draw(){
    background(5,5,25);
    bg.drawStars();

    this.upgradeBox.show();
    this.playbutton.show();
    this.regexBox.show();

    this.showPlayer();

    for(int i=0; i<this.upgrades.length; i++){
      this.upgrades[i].show();
    }
  }

  public void touchStarted(){
    if(this.playbutton.mouseOver(mouseX, mouseY)){
      this.playbutton.setSelected(true);
    }
    else{
      for(int i=0; i<this.upgrades.length; i++){
        if(this.upgrades[i].isMouseOver(mouseX, mouseY)){
          equipUpgrade(this.upgrades[i].getId());
          this.upgradeBox.loadData();
          return;
        }
      }
      this.upgradeBox.click();
    }
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

    strokeWeight(width/240);
    rect(x,y,box_height,box_height);

    x += box_height/2;
    y += box_height/4;

    pushMatrix();
      noFill();
      strokeWeight(4);
      translate(x,y+(2*h)/3);
      triangle(0, -(2*h)/3, -w, point_y, w, point_y);
    popMatrix();
  }

  private void loadUpgrades(){
    float size_temp = width/10; //size of one upgrade
    ArrayList<Upgrade> upgrades_temp = new ArrayList<Upgrade>(); //stash for all upgrades pulled from inventory
    String[] ids = getList("owned_upgrades"); //all IDs of all upgrades in player's inventory in order

    BufferedReader reader;
    reader = createReader("upgrades.m1");
    try{
      reader.readLine(); //skip first line because it just says the number of possible upgrades there are
    }
    catch(IOException e){
      return;
    }
    boolean jump = false;
    for(int i=0; i<ids.length; i++){ //cycle through upgrades in inventory
      while(true){ //cycle through possible upgrades
        try{
          String[] data_temp = split(reader.readLine(), "; "); //load all data of that upgrade
          if(int(data_temp[0]) == int(ids[i])){ //if this upgrade is in player's inventory
            upgrades_temp.add(new Upgrade(random(width/2, width-size_temp), random(size_temp, height-size_temp), size_temp, size_temp, int(data_temp[0]), data_temp[1], data_temp[2], data_temp[3], 0));
            break; //no more possible upgrades are cycled through, doesn't need to reset because inventory is in order
          }
        }
        catch(IOException e){
          return;
        }
        catch(NullPointerException e){
          i=ids.length-1;
          break;
        }
      }
    }

    this.upgrades = new Upgrade[upgrades_temp.size()];
    for(int i=0; i< this.upgrades.length; i++){
      this.upgrades[i] = upgrades_temp.get(i);
    }
  }
}
