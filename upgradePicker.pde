class UpgradePicker implements Window{
  private Upgrade one, two, three;

  UpgradePicker(){
    this.one = this.createRandomUpgrade(width/4);
    this.two = this.createRandomUpgrade(width*2/4);
    this.three = this.createRandomUpgrade(width*3/4);
  }

  private Upgrade createRandomUpgrade(float w){
    float max = 0; //number of upgrades, index of second to last upgrade in file

    BufferedReader reader;
    reader = createReader("upgrades.m1"); //open file with all upgrades listed
    try{
      max = float(reader.readLine()); //set max to the number in the first line of the file, which says how many upgrades there are
    }
    catch(IOException e){}

    int pick = int(random(0, max-0.000001)); //random upgrade in the range of all upgrades
    for(int i=0; i<pick; i++){ //skipping the lines before (cause the reader cant skipp, just go line by line)
      try{
        reader.readLine();
      }
      catch(IOException e){}
    }

    try{
        String[] pieces = split(reader.readLine(), "; ");
        return new Upgrade(w, height/2, width/8, width/8, int(pieces[0]), pieces[1], pieces[2], pieces[3]);
    }
    catch(IOException e){}
    catch(NullPointerException e){} //to end when file is done

    return new Upgrade(w, height/2, width/8, width/8, -1, "error", "error.png", "error");
  }

  public void draw(){
    background(5,5,25);
    bg.drawStars();

    this.one.show();
    this.two.show();
    this.three.show();
  }

  public void touchStarted(){
    if(this.one.isMouseOver(mouseX, mouseY)){
      this.one.setSelected(true);
    }
    else if(this.two.isMouseOver(mouseX, mouseY)){
      this.two.setSelected(true);
    }
    else if(this.three.isMouseOver(mouseX, mouseY)){
      this.three.setSelected(true);
    }
  }

  public void touchEnded(){
    if(this.one.isMouseOver(mouseX, mouseY) && this.one.getSelected()){
      this.chooseItem(this.one.getId());
    }
    else if(this.two.isMouseOver(mouseX, mouseY) && this.two.getSelected()){
      this.chooseItem(this.two.getId());
    }
    else if(this.three.isMouseOver(mouseX, mouseY) && this.three.getSelected()){
      this.chooseItem(this.three.getId());
    }

    this.one.setSelected(false);
    this.two.setSelected(false);
    this.three.setSelected(false);
  }

  private void chooseItem(int id){
    if(id >= 0){
      addToList("owned_upgrades", id);
    }
    setWindow(11);
  }

  public void touchMoved(){}
  public void setup(){}
  public void goBack(){}
}
