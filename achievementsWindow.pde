class AchievementsWindow extends Menu implements Window{
  private ArrayList<Achievement> allAchievements;
  private int scroll;
  private Button leftScroll, rightScroll;

  AchievementsWindow(){
    super();
    this.back_window = 7;

    this.scroll = 0;
    this.leftScroll = new Button(width/20, height/2-width/40, width/20, width/20, "<-");
    this.rightScroll = new Button(width-width/10, height/2-width/40, width/20, width/20, "->");

    this.allAchievements = new ArrayList<Achievement>();

    this.loadAchievemments();

    this.buttonsActivate();
  }

  void draw(){
    super.draw();

    this.rightScroll.show();
    this.leftScroll.show();

    for(int i=this.scroll; i<=this.scroll+2; i++){
      Achievement a = this.allAchievements.get(i);
      if(a == null){
        break;
      }
      a.show(width*(i+1-this.scroll)/4);
    }
  }

  public void touchStarted(){
    if(this.leftScroll.mouseOver(mouseX, mouseY)){
      this.leftScroll.setSelected(true);
    }
    else if(this.rightScroll.mouseOver(mouseX, mouseY)){
      this.rightScroll.setSelected(true);
    }
    else{
      super.touchStarted();
    }
  }

  public void touchEnded(){
    if(this.leftScroll.mouseOver(mouseX, mouseY) && this.leftScroll.getSelected()){
      this.scroll -= 3;
      if(this.scroll < 0){
        this.scroll = 0;
      }
      this.buttonsActivate();
    }
    else if(this.rightScroll.mouseOver(mouseX, mouseY) && this.rightScroll.getSelected()){
      this.scroll += 3;
      if(this.scroll > this.allAchievements.size()-3){
        this.scroll = this.allAchievements.size()-3;
      }
      this.buttonsActivate();
    }
    else{
      super.touchEnded();
    }

    this.leftScroll.setSelected(false);
    this.rightScroll.setSelected(false);
  }

  private void buttonsActivate(){
    this.rightScroll.setActive(this.scroll < this.allAchievements.size()-3);
    this.leftScroll.setActive(this.scroll > 0);
  }

  private void loadAchievemments(){
    BufferedReader reader;
    reader = createReader("allAchievements.mone");
    while(true){
      try{
        String[] pieces = split(reader.readLine(), ", ");
        this.allAchievements.add(new Achievement(pieces[0], int(pieces[2]), pieces[1]));
      }
      catch(IOException e){
        return;
      }
      catch(NullPointerException e){
        return;
      }
    }
  }
}
