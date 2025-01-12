class UpgradePicker implements Window{
  private Upgrade[] selection = new Upgrade[3];
  private Upgrade explain;

  UpgradePicker(){
    int[] picked = new int[selection.length];
    for(int i=0; i<this.selection.length; i++){
      picked[i] = -1;
    }

    String[][] allUpgrades = readFileM1("upgrades.m1");
    for(int i=0; i<this.selection.length; i++){
      int pick = int(random(0, allUpgrades.length-0.0000001)); //random upgrade in the range of all upgrades
      while(contains_int(picked,pick)){
        pick = int(random(0, allUpgrades.length-0.0000001)); //random upgrade in the range of all upgrades
      }
      picked[i]=pick;

      this.selection[i] = new Upgrade(width*(i+1)/(this.selection.length+1), height/2, width/8, int(allUpgrades[pick][0]), allUpgrades[pick][1], allUpgrades[pick][2], allUpgrades[pick][3]);
    }
  }

  public void draw(){
    background(5,5,25);
    bg.drawStars();

    for(int i=0; i<this.selection.length;i++){
      this.selection[i].show();
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
    for(int i=0; i<this.selection.length;i++){
      if(this.selection[i].isMouseOver(mouseX, mouseY)){
        this.selection[i].setSelected(true);
        Upgrade u = this.selection[i];
        this.explain = new Upgrade(width/2+height*2/8, height*13.5/16, height/8, u.getId(), u.getName(), "", u.getDescription(), u.getNumber());
        PImage temp_image = u.getImage().get();
        temp_image.resize(int(height/8),int(height/8));
        this.explain.setImage(temp_image);

      }
    }
  }

  public void touchEnded(){
    for(int i=0; i<this.selection.length;i++){
      if(this.selection[i].isMouseOver(mouseX, mouseY) && this.selection[i].getSelected()){
        if(this.selection[i].getId() >= 0){
          addToString("owned_upgrades", this.selection[i].getFullId());
        }
        setStat("wave", getStat("wave")+1); //save and set next wave
        setStat("waveUnfinished", 0);
        setWindow(11);
      }
      this.selection[i].setSelected(false);
      this.explain = null;
    }
  }

  public void touchMoved(){}
  public void setup(){}
  public void goBack(){}
  public void update(){}
}
