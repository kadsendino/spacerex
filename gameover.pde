class Gameover implements Window{
  private int endWave, highscore; //current end score
  private int coolDown;

  Gameover(){
    this.endWave = getWave()-1;
    setWave(1);
    this.highscore = getStat("highscore");
    updateStats("highscore", this.endWave);
    Achievements.test();
    this.setup();
  }

  public void setup(){
    coolDown = 0;
  }

  public void draw(){
    background(5,5,25);
    fill(255);
    text("YOU SURVIVED: " + Integer.toString(this.endWave), width/2, height/4);
    text("HIGHSCORE: " + Integer.toString(this.highscore), width/2, height*2/4);
    if(this.highscore < this.endWave){
      text("NEW HIGHSCORE", width/2, height*3/4);
    }

    if(coolDown < 120){
      coolDown++;
    }
  }

  public void touchEnded(){
    if(coolDown >= 120){
      setWave(1);
      setWindow(1);
    }
  }

  public void goBack(){
    setWindow(1);
  }

  public void touchStarted(){}
  public void touchMoved(){}
}
