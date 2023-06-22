class UpgradePicker implements Window{
  private Upgrade one, two, three;

  UpgradePicker(){
    this.one = this.createRandomUpgrade(width/4);
    this.two = this.createRandomUpgrade(width*2/4);
    this.three = this.createRandomUpgrade(width*3/4);
  }

  private Upgrade createRandomUpgrade(float w){
    float max = 0;

    BufferedReader reader;
    reader = createReader("upgrades.m1");
    try{
      max = float(reader.readLine());
    }
    catch(IOException e){}

    int pick = int(random(0, max-0.000001));
    for(int i=1; i<=pick; i++){ //skipping the lines before
      try{
        reader.readLine();
      }
      catch(IOException e){}
    }

    try{
        String[] pieces = split(reader.readLine(), "; ");
        return new Upgrade(w, height/2, width/8, width/8, int(pieces[0]), pieces[1], pieces[2], pieces[3], 0);
    }
    catch(IOException e){}
    catch(NullPointerException e){} //to end when file is done

    return new Upgrade(w, height/2, width/8, width/8, -1, "error", "error.png", "error", 0);
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
      addUpgrade(one.getId());
      setWindow(11);
    }
    else if(this.two.isMouseOver(mouseX, mouseY) && this.two.getSelected()){
      addUpgrade(two.getId());
      setWindow(11);
    }
    else if(this.three.isMouseOver(mouseX, mouseY) && this.three.getSelected()){
      addUpgrade(three.getId());
      setWindow(11);
    }

    this.one.setSelected(false);
    this.two.setSelected(false);
    this.three.setSelected(false);
  }

  public void touchMoved(){}
  public void setup(){}
  public void goBack(){}
}
