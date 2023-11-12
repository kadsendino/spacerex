class UpgradeBox{
  private float x,y,w,h,st;
  private int maxequipped;
  private ArrayList<Upgrade> equipped;

  UpgradeBox(float x,float y,float w,float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.st = width/240;
    this.maxequipped = 3;

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
        window.update();
        this.equipped.remove(i);
        return;
      }
    }
  }

  public boolean isMaxReached(){
    return this.maxequipped <= this.equipped.size();
  }

  private void loadData(){
    this.equipped = new ArrayList<Upgrade>(); //empty list to not load more items when equiping items
    float size_temp = this.w/10; //half size of one upgrade
    IntDict eqipped_anz = new IntDict();

    String[] ids = getList("equipped_upgrades"); //all IDs of all upgrades in player's inventory in order
    String[] data_temp = {""};

    BufferedReader reader;
    reader = createReader("upgrades.m1");

    try{ //skip first line because it just says the number of possible upgrades there are
      reader.readLine();
      data_temp = split(reader.readLine(), "; ");
    }
    catch(IOException e){ return; }

    for(int i=0; i<ids.length; i++){
      try{
        if((i>0 &&ids[i-1] != ids[i]) || i==0){ //if previous upgrade is unique -> load new data
          while(!data_temp[0].equals(ids[i])){
            data_temp = split(reader.readLine(), "; "); //data_temp[0] is ID of Upgrade
          }
        }
        if(!ids.contains(data_temp[0])){
          eqipped_anz.set(data_temp[0],1);
        }else{
          eqipped_anz.increment(data_temp[0]);
        }
        
      }
    }

    for (String id : eqipped_anz.keys()) {
      try{
          while(!data_temp[0].equals(id)){
            data_temp = split(reader.readLine(), "; ");
          }
        this.equipped.add(new Upgrade(this.x+size_temp*2+size_temp*this.equipped.size()*3, this.y+this.h/2, size_temp*2, size_temp*2, int(data_temp[0]), data_temp[1], data_temp[2], data_temp[3]),eqipped_anz.get(data_temp[0]));
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
