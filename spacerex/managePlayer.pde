class ManagePlayer implements Window{
  private ArrayList<Upgrade> upgrades;
  private UpgradeBox upgradeBox;
  private PlayButton playbutton;
  private RegexBox regexBox;
  private Upgrade explain;
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

    if(this.explain != null){
      explain.show();
      pushStyle();
        rect(width/2+height/8, height*6/8, width/2-height*2/8, height/16*3);
        fill(255);
        textSize(height/30);
        text(explain.getName(), width*3/4+height/8, height*13/16);
        textSize(height/40);
        text(explain.getDescription(), width*3/4+height/8, height*14/16);
      popStyle();
    }
  }

  public void touchStarted(){
    if(this.playbutton.mouseOver(mouseX, mouseY)){
      this.playbutton.setSelected(true);
    }
    else{
      for(int i=0; i<this.upgrades.size(); i++){
        if(this.upgrades.get(i).isMouseOver(mouseX, mouseY)){
          Upgrade u = this.upgrades.get(i);
          this.explain = new Upgrade(width/2+height*2/8, height*13.5/16, height/8, u.getId(), u.getName(), "", u.getDescription(), u.getNumber());
          this.explain.setImage(u.getImage());

          if(this.upgradeBox.canTake(this.upgrades.get(i).getId())){
            equipUpgrade(this.upgrades.get(i).getFullId());
            this.upgradeBox.loadData();
            this.upgrades.remove(i);
          }
          return;
        }
      }
      this.upgradeBox.click();
      this.explain = null;
    }
  }

  public void touchEnded(){
    if(this.playbutton.mouseOver(mouseX, mouseY) && this.playbutton.getSelected()){
      setWindow(5); //continue game
    }
    this.playbutton.setSelected(false);
  }

  private void showPlayer(){
    float x = height/8+width/4-box_height;
    float y = height/8;
    float w = height/32;
    float h = height/12;
    float point_y = h/3;

    pushStyle();
      rect(x,y,box_height,box_height);
    popStyle();

    x += box_height/2;
    y += box_height/4;

    pushMatrix();
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

    float size_temp = height/8; //size of one upgrade
    this.upgrades = new ArrayList<Upgrade>(); //empty list to not load more items when equiping items
    String allUpgrades[][] = readFileM1("upgrades.m1");

    boolean[] grid = new boolean[20]; //5 horizontal, h vertical
    for(int i=0; i<allUpgrades.length; i++){
      if(owned_anz.hasKey(allUpgrades[i][0])){
        int rand = (int)random(0,20);
        while(grid[rand]){
          rand++;
          if(rand >= grid.length){
            rand = 0;
          }
        }
        grid[rand] = true;
        this.upgrades.add(new Upgrade(width/2+size_temp*((rand%4)+1), size_temp*((rand%5)+1), size_temp, int(allUpgrades[i][0]), allUpgrades[i][1], allUpgrades[i][2], allUpgrades[i][3], owned_anz.get(allUpgrades[i][0])));
      }
    }
  }

  public void touchMoved(){}
  public void goBack(){}
}
