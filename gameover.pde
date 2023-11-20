class Gameover implements Window{
  private Button newAchievement;
  private int endWave, highscore; //current end score
  private int coolDown;
  private boolean achievementCompleted;

  Gameover(){
    this.newAchievement = new Button(width*2/3+width/28, height/2-height/30, width/14, height/15, "MOVE");
    this.endWave = getStat("wave")-1;
    setStat("wave", 1);
    clearPlayerInventory();
    updateStat("finishedGames");
    this.highscore = getStat("highscore");
    setStat("highscore", max(this.endWave, this.highscore));
    this.achievementCompleted = TestAchievements();
    this.newAchievement.setActive(this.achievementCompleted);
    this.setup();
  }

  public void setup(){
    coolDown = 0;
  }

  public void draw(){
    background(0);
    bg.drawStars();
    pushStyle();
      fill(255);
      textSize(height/13);
      if(this.highscore < this.endWave){
        text("NEW HIGHSCORE: "+this.endWave, width/2, height/3);
      }
      else{
        text("YOU SURVIVED: " +this.endWave, width/2, height/3);
      }
      text("HIGHSCORE: " +this.highscore, width/2, height*2/3);

      if(this.achievementCompleted){
        textAlign(RIGHT);
        textSize(height/26);
        text("Achievement unlocked", width*2/3, height/2);
      }
    popStyle();

    this.newAchievement.show();

    if(coolDown < 120){
      coolDown += 2; //set 120 lower
    }
  }

  public void touchStarted(){
    if(this.newAchievement.mouseOver(mouseX, mouseY)){
      this.newAchievement.setSelected(true);
    }
  }

  public void touchEnded(){
    if(this.newAchievement.mouseOver(mouseX, mouseY) && this.newAchievement.getSelected()){
      setWindow(10);
    }
    else if(coolDown >= 120){
      stroke(255);
      setWindow(1);
    }

    this.newAchievement.setSelected(false);
  }

  public void goBack(){
    setWindow(1);
  }

  public void touchMoved(){}
  public void update(){}
}
