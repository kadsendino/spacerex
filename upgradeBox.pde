class UpgradeBox{
  private float x,y,w,h,st;
  private int maxEquipped;
  private ArrayList<Upgrade> equipped;

  UpgradeBox(float x,float y,float w,float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.st = width/240;
    this.maxEquipped = 3;

    this.loadData();
  }

  public void show(){
    pushStyle();
      noFill();
      strokeWeight(st);
      rect(x,y,w,h);
    popStyle();
    for(Upgrade u : this.equipped){
      u.show();
    }
  }

  public void click(){
    for(int i=0; i<this.equipped.size(); i++){
      if(this.equipped.get(i).isMouseOver(mouseX, mouseY)){
        unEquipUpgrade(Integer.toString(this.equipped.get(i).getId()));
        if(this.equipped.get(i).getNumber() > 1){
          this.equipped.get(i).decreaseNumber();
        } else{
          this.equipped.remove(i);
        }
        window.update();
        return;
      }
    }
  }

  public boolean canTake(int id){
    if(this.maxEquipped <= this.equipped.size()){
      return true;
    } else{
      for(Upgrade u : this.equipped){
        if(u.getId() == id){
          return true;
        }
      }
    }
    return false;
  }

  private void loadData(){
    String[] ids = getList("equipped_upgrades"); //all IDs of all upgrades in player's inventory in order
    IntDict equipped_anz = new IntDict(); //to store all currently equiped ubgrades

    for(int i=0; i<ids.length; i++){
      if(equipped_anz.hasKey(ids[i])){ //if previous upgrade is unique -> load new data
        equipped_anz.increment(ids[i]);
      }else{
        equipped_anz.set(ids[i],1);
      }
    }

    float size_temp = this.w/10; //half size of one upgrade
    this.equipped = new ArrayList<Upgrade>(); //empty list to not load more items when equiping items
    String allUpgrades[][] = readFileM1("upgrades.m1");

    for(int i=0; i<allUpgrades.length; i++){
      if(equipped_anz.hasKey(allUpgrades[i][0])){
        this.equipped.add(new Upgrade(this.x+size_temp*2+size_temp*this.equipped.size()*3, this.y+this.h/2, size_temp*2, size_temp*2, int(allUpgrades[i][0]), allUpgrades[i][1], allUpgrades[i][2], allUpgrades[i][3], equipped_anz.get(allUpgrades[i][0])));
      }
    }
  }
}
