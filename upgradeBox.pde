class UpgradeBox{
  private float x,y,w,h,st;
  private ArrayList<Upgrade> equiped;

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
    //this.upgradeBox.loadData();
    }
  }

  private void loadData(){
    float size_temp = width/10; //size of one upgrade

    String[] ids = getList("equiped_upgrades"); //all IDs of all upgrades in player's inventory in order
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
         this.equiped.add(new Upgrade(random(width/2, width-size_temp), random(size_temp, height-size_temp), size_temp, size_temp, int(data_temp[0]), data_temp[1], data_temp[2], data_temp[3]));
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
