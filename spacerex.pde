//A Game by M1Productions 2023
import android.content.Context;
import android.content.SharedPreferences;

Context context;
SharedPreferences sharedPreferences;


int window;
int[] settings;
PFont font;
Window[] windows = new Window[7];
/*
0 = Game
1 = main menu
2 = settings menu
3 = about screen
4 = controls menu
*/
BackGround bg;


void setup (){
  // Get the Context object
  context = getContext();
  
  // Get SharedPreferences object
  sharedPreferences = context.getSharedPreferences("spacerex", Context.MODE_PRIVATE);


  bg = new BackGround();

  windows[0] = new Game();
  windows[1] = new MainMenu();
  windows[2] = new Settings();
  windows[3] = new About();
  windows[4] = new Controls();
  windows[5] = new ClearedWave();
  windows[6] = new Gameover();

  font = createFont("font.TTF",256);

  window = 1;

  settings = new int [1];
  settings[0] = 1; //joystick unlocked
  fullScreen();
  frameRate(60);
  textFont(font);
}

void draw (){ //cycles through
  try {
    windows[window].draw();
  }
  catch (IndexOutOfBoundsException e) {
    window = 1;
  }
}

void touchStarted(){
  windows[window].touchStarted();
}

void touchEnded(){
  windows[window].touchEnded();
}

void touchMoved(){
  windows[window].touchMoved();
}

void onBackPressed(){
  if(window == 1) { //in main menu
    System.exit(0); //quit programm
  }
  else {
    windows[window].goBack();
  }
}

void setSetting(int position, boolean value){
  try{
    settings[position] = int(value);
  }
  catch (IndexOutOfBoundsException e){
    e.printStackTrace();
  }
}

int getSetting(int position){
  try{
    return settings[position];
  }
  catch (IndexOutOfBoundsException e){
    e.printStackTrace();
    return 0;
  }
}

int getWave(){
  return sharedPreferences.getInt("wave", 1);
}

void setWave(int wave){
      // Write data to SharedPreferences
    SharedPreferences.Editor editor = sharedPreferences.edit();
    editor.putInt("wave", wave);
    editor.commit();
}
