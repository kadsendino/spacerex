
int window;
PFont font;
Window[] windows = new Window[2];
/*
0 = Game
1 = main menu
*/

void setup (){
  windows[0] = new Game();
  windows[1] = new MainMenu();
  font = createFont("font.TTF",256);
  window = 1;
  fullScreen();
  frameRate(60);
  textFont(font);
}

void draw (){ //cycles through
  windows[window].draw();
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
    window = 1;
  }
}
