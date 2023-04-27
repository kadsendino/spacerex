class ClearedWave implements Window{

    int nextWave;

    ClearedWave(int nextWave){
        this.nextWave = nextWave;
    }

  void setup(){
    background(5,5,25);
    stroke(255);
    text("PRESS TO PLAY NEXT WAVE: " + this.nextWave.toString(),width/2,height/2);
  }

  void draw(){}
  
  void touchStarted(){}
  
  void touchEnded(){
    // Write data to SharedPreferences
    SharedPreferences.Editor editor = sharedPreferences.edit();
    editor.putInt("wave", this.nextWave);
    editor.commit();

    windows[0] = new Game();
    window = 0;
  }
  
  void touchMoved(){}
  void goBack(){}
}