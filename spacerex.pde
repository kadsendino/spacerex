//A Game by M1Productions 2023

int window; //which window is currently displayed, touched etc.
int[] settings; //global settings register, gets loaded from save files and edited in settings menu
PFont font; //custom font
Window[] windows = new Window[5]; //list of all available windows, listed below
/*
0 = Game
1 = main menu
2 = settings menu
3 = about screen
4 = controls menu
*/
BackGround bg; //background animation with stars and rocks flying arround

void setup (){
  bg = new BackGround(); //not every window draws it so it gets drawn in the window, not in main draw loop

  windows[0] = new Game();
  windows[1] = new MainMenu();
  windows[2] = new Settings();
  windows[3] = new About();
  windows[4] = new Controls();

  font = createFont("font.TTF",256); //loading the custom font from the data folder

  window = 1; //default starting window when opening the app is main menu

  settings = new int [1];
  settings[0] = 1; //joystick unlocked
  fullScreen();
  frameRate(60);
  textFont(font);
}

void draw (){ //cycles through every frame
  try { //potentilally faulty integrated menues get catched
    windows[window].draw();
  }
  catch (IndexOutOfBoundsException e) {
    window = 1;
  }
}

void touchStarted(){ //touching the screen
  windows[window].touchStarted();
}

void touchEnded(){ //lifting a touching object (finger) from screen
  windows[window].touchEnded();
}

void touchMoved(){ //moving touching object (finger) arround on the screen
  windows[window].touchMoved();
}

void onBackPressed(){ //(hardware) button on
  if(window == 1) { //in main menu
    System.exit(0); //quit programm
  }
  else {
    windows[window].goBack(); //the menu knows where to return to
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
