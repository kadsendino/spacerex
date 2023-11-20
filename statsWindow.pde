class StatsWindow extends Menu implements Window{
  private int killedRocks, shotsFired, finishedGames, highscore;

  StatsWindow(){
    this.back_window = 7;

    this.killedRocks = getStat("killedRocks");
    this.shotsFired = getStat("shotsFired");
    this.finishedGames = getStat("finishedGames");
    this.highscore = getStat("highscore");
  }

  void draw(){
    background(5,5,25);
    bg.drawStars();
    this.back_button.show();

    pushStyle();
      fill(255);
      textSize(height/13);
      text("HIGHSCORE: "+this.highscore, width/2, height/5);
      text("FINISHED GAMES: "+this.finishedGames, width/2, height*2/5);
      text("ROCKS DESTROYED: "+this.killedRocks, width/2, height*3/5);
      text("SHOTS FIRED: "+this.shotsFired, width/2, height*4/5);
    popStyle();
  }
}
