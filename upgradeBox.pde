class UpgradeBox{
  private float x,y,w,h,st;
  private Upgrade[] equiped;

  UpgradeBox(float x,float y,float w,float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.st = width/240;

    this.loadData();
  }

  public void show(){
    pushStyle();
      noFill();
      strokeWeight(st);
      rect(x,y,w,h);
    popStyle();
  }

  public void click(){
    if(mouseX >= this.x && mouseX <= this.x+this.w && mouseY >= this.y && mouseY <= this.y+this.h){
      //todo
    this.upgradeBox.loadData();
    }
  }

  public void loadData(){
    this.equiped = getList("equiped_upgrades");
  }
}
