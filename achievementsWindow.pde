class AchievementsWindow extends Menu implements Window{
  private ArrayList<Achievement> clearedAchievements;
  private int scroll;
  private Button leftScroll, rightScroll;

  AchievementsWindow(){
    super();
    this.back_window = 7;

    this.scroll = 0;
    this.leftScroll = new Button(width/20, height/2-width/40, width/20, width/20, "<-");
    this.rightScroll = new Button(width-width/10, height/2-width/40, width/20, width/20, "->");

    this.clearedAchievements = new ArrayList<Achievement>();

    //todo : add achievements

    this.testButtonsActive();
  }

  void draw(){
    super.draw();

    this.rightScroll.show();
    this.leftScroll.show();

    for(int i=this.scroll; i<=this.scroll+2; i++){
      Achievement a = this.clearedAchievements.get(i);
      if(a == null){
        break;
      }
      a.show(width*(i+1-this.scroll)/4);
    }
  }

  void touchStarted(){
    //todo
  }

  void touchEnded(){
    //todo

    this.testButtonsActive();
  }

  private void testButtonsActive(){
    this.rightScroll.setActive(this.clearedAchievements.size() > 3 && this.scroll < this.clearedAchievements.size()-3);
    this.leftScroll.setActive(this.scroll > 0);
  }
}
