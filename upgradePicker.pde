class UpgradePicker implements Window{
  private Upgrade[] selection = new Upgrade[3];

  UpgradePicker(){
    String[][] allUpgrades = readFileM1("upgrades.m1");
    for(int i=0; i<this.selection.length; i++){
      int pick = int(random(0, allUpgrades.length-0.0000001)); //random upgrade in the range of all upgrades
      this.selection[i] = new Upgrade(width*(i+1)/(this.selection.length+1), height/2, width/8, width/8, int(allUpgrades[pick][0]), allUpgrades[pick][1], allUpgrades[pick][2], allUpgrades[pick][3]);
    }
  }

  public void draw(){
    background(5,5,25);
    bg.drawStars();

    for(int i=0; i<this.selection.length;i++){
      this.selection[i].show();
    }
  }

  public void touchStarted(){
    for(int i=0; i<this.selection.length;i++){
      if(this.selection[i].isMouseOver(mouseX, mouseY)){
        this.selection[i].setSelected(true);
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
    }
  }

  public void touchMoved(){}
  public void setup(){}
  public void goBack(){}
  public void update(){}
}
