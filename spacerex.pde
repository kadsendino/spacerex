//A Game by M1Productions 2023
import android.content.Context;
import android.content.SharedPreferences;

Context context;
SharedPreferences sharedPreferences;

String[] settings; //global settings register, gets loaded from save files and edited in settings menu
PFont font; //custom font
Window window;
BackGround bg; //background animation with stars and rocks flying arround

void setup (){
  context = getContext(); // Get the Context object

  sharedPreferences = context.getSharedPreferences("spacerex", Context.MODE_PRIVATE); // Get SharedPreferences object

  bg = new BackGround(); //not every window draws it so it gets drawn in the window, not in main draw loop

  setWindow(1); //Enters MainMenue to start

  try{
    font = createFont("font.TTF",256); //loading the custom font from the data folder
    textFont(font);
  }
  catch(RuntimeException e){}

  settings = getList("settings");

  //vv basic style. pop style after changing them, if not declared otherwhise, these are applied vv
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  rectMode(CORNER);
  stroke(255);
  noFill();

  fullScreen();
  frameRate(60);
}

void draw (){ //cycles through every frame
  window.draw();
}

void touchStarted(){ //touching the screen
  window.touchStarted();
}

void touchEnded(){ //lifting a touching object (finger) from screen
  window.touchEnded();
}

void touchMoved(){ //moving touching object (finger) arround on the screen
  window.touchMoved();
}

void onBackPressed(){ //(hardware) button pressed
    window.goBack();
}

void setSetting(int position, String value){
  try{
    settings[position] = value;
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
7 = player Menu
8 = stats overview
9 = scoreboard
10 = achievements
11 = ManagePlayer
12 = upgradePicker
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
    case 7:
      window = new PlayerMenu();
      break;
    case 8:
      window = new StatsWindow();
      break;
    case 9:
      window = new Menu(); //todo
      break;
    case 10:
      window = new AchievementsWindow();
      break;
    case 11:
      window = new ManagePlayer();
      break;
    case 12:
      window = new UpgradePicker();
      break;
    default:
      window = new MainMenu();
      break;
  }
}

//chatgpt generated intersection funtion of two lines
boolean intersect(PVector p1, PVector p2, PVector p3, PVector p4) {
  // Calculate slopes of the two lines
  float slope1 = (p2.y - p1.y) / (p2.x - p1.x);
  float slope2 = (p4.y - p3.y) / (p4.x - p3.x);

  if (slope1 == slope2) { // If the slopes are equal, the lines are parallel and do not intersect
    return false;
  }

  // Calculate y-intercepts of the two lines
  float yIntercept1 = p1.y - slope1 * p1.x;
  float yIntercept2 = p3.y - slope2 * p3.x;

  float xIntersect = (yIntercept2 - yIntercept1) / (slope1 - slope2); // Calculate x-coordinate of the point of intersection

  // Check if the x-coordinate of the point of intersection lies within the range of the x-coordinates of the two line segments
  if ((xIntersect >= min(p1.x, p2.x) && xIntersect <= max(p1.x, p2.x))
    && (xIntersect >= min(p3.x, p4.x) && xIntersect <= max(p3.x, p4.x))) {
    return true;
  }

  return false;
}

public String[] intToStringArray (int[] in){
  String[] out = new String[in.length];
  for(int i=0; i<in.length; i++){
    out[i] = Integer.toString(in[i]);
  }
  return out;
}
