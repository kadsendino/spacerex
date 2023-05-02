//A Game by M1Productions 2023
import android.content.Context;
import android.content.SharedPreferences;

Context context;
SharedPreferences sharedPreferences;



int[] settings;
PFont font;
Window window;
/*
0 = game
1 = main menu
2 = settings menu
3 = about screen
4 = controls menu
5 = cleared wave
6 = gameover
*/
BackGround bg;


void setup (){
  // Get the Context object
  context = getContext();
  
  // Get SharedPreferences object
  sharedPreferences = context.getSharedPreferences("spacerex", Context.MODE_PRIVATE);


  bg = new BackGround();

  //Enters MainMenue to start
  setWindow(1);


  font = createFont("font.TTF",256);


  settings = new int [1];
  settings[0] = 1; //joystick unlocked
  fullScreen();
  frameRate(60);
  textFont(font);
}

void draw (){ //cycles through
  try {
    window.draw();
  }
  catch (IndexOutOfBoundsException e) {
    setWindow(1);
  }
}

void touchStarted(){
  window.touchStarted();
}

void touchEnded(){
  window.touchEnded();
}

void touchMoved(){
  window.touchMoved();
}

void onBackPressed(){
  if(window == 1) { //in main menu
    System.exit(0); //quit programm
  }
  else {
    window.goBack();
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

/*
0 = game
1 = main menu
2 = settings menu
3 = about screen
4 = controls menu
5 = cleared wave
6 = gameover
*/
void setWindow(int windowID){
  switch (windowID) {
    case 0:
      window = new Game();
      break;
    case 1:
      window = new MainMenu();
      break;
    case 2:
      window = new Settings();
      break;
    case 3:
      window = new About();
      break;
    case 4:
      window = new Controls();
      break;
    case 5:
      window = new ClearedWave();
      break;
    case 6:
      window = new Gameover();
      break;
        
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
