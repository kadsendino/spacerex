class ManagePlayer implements Window{
  private ArrayList<Upgrade> upgrades;
  private Player player_show;
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

    this.upgrades = new ArrayList<Upgrade>();
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
        if(this.upgrades.get(i).isMouseOver(mouseX, mouseY)){
          equipUpgrade(Integer.toString(this.upgrades.get(i).getId()));
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

    String[] ids = getList("owned_upgrades"); //all IDs of all upgrades in player's inventory in order
    String[] data_temp = {""};

    BufferedReader reader;
    reader = createReader("upgrades.m1");

    try{ //skip first line because it just says the number of possible upgrades there are
      reader.readLine();
    }
    catch(IOException e){ return; }

    for(int i=0; i<ids.length; i++){
      try{
        if((i>0 &&ids[i-1] != ids[i]) || i==0){ //if previous upgrade is unique -> load new data
          data_temp = split(reader.readLine(), "; ");
        }
        if(data_temp[0].equals(ids[i])){
         this.upgrades.add(new Upgrade(random(width/2, width-size_temp), random(size_temp, height-size_temp), size_temp, size_temp, int(data_temp[0]), data_temp[1], data_temp[2], data_temp[3]));
        }
      }
      catch(IOException e){
        return;
      }
      catch(NullPointerException e){
        break;
      }
    }
  }
}
