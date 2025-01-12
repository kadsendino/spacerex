//A Game by M1Productions 2023
import android.content.Context;
import android.content.SharedPreferences;

Context context;
SharedPreferences sharedPreferences;

String errorMessage;
int fade;
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

  if(getStat("game_version") < 8){
    clearPlayerInventory(); //there could be a descrepency between upgrades being saved as (id) and (id+","+number)

    SharedPreferences.Editor editor = sharedPreferences.edit();
    editor.putInt("game_version", 8);
    editor.putString("game_version_name", "3.0.2");
    editor.commit();
  }

  //vv basic style. pop style after changing them, if not declared otherwhise, these are applied vv
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  textSize(height/15);
  rectMode(CORNER);
  strokeWeight(width/240);
  stroke(255); //stroke color
  strokeCap(SQUARE);
  noFill();

  fullScreen(P2D);
  frameRate(60);
}

void draw (){ //cycles through every frame
  window.draw();
  printError();
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

String getSetting(int position){
  try{
    return settings[position];
  }
  catch (IndexOutOfBoundsException e){
    e.printStackTrace();
    return "0";
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
9 = game settings
10 = achievements
11 = ManagePlayer
12 = upgradePicker
*/
void setWindow(int windowID){
  switch (windowID) {
    case 0:
      window = new Game();                break;
    case 1:
      window = new MainMenu();            break;
    case 2:
      window = new Settings();            break;
    case 3:
      window = new About();               break;
    case 4:
      window = new Controls();            break;
    case 5:
      window = new ClearedWave();         break;
    case 6:
      window = new Gameover();            break;
    case 7:
      window = new PlayerMenu();          break;
    case 8:
      window = new StatsWindow();         break;
    case 9:
      window = new GameSettings();      break;
    case 10:
      window = new AchievementsWindow();  break;
    case 11:
      window = new ManagePlayer();        break;
    case 12:
      window = new UpgradePicker();       break;
    default:
      window = new MainMenu();            break;
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

boolean contains_Array(String[] strings, String searchString) {
    for (String string : strings) {
        if (string.equals(searchString))
        return true;
    }

    return false;
}

boolean contains_int(int[] arr, int value) {
  for (int num : arr) {
    if (num == value) {
      return true;
    }
  }
  return false;
}

public void createError(String error){
  fade = 255;
  errorMessage = error;
}

public void printError(){
  pushStyle();
    fill(250, 0, 0, fade);
    if(errorMessage != null && fade>0)
    text(errorMessage, width/2, height/2);
    fade -= 2;
  popStyle();
}

public String[][] readFileM1(String name){
  BufferedReader reader = createReader(name);
  String[] data_temp = {};
  String[][] allLines={};
  try{ //read first line because it says the number of possible upgrades there are
    data_temp = split(reader.readLine(), "; "); //read the head of the document: number lines;number variales per line
    allLines = new String[int(data_temp[0])][int(data_temp[1])];
  } catch(IOException e){
    return allLines;
  }

  for(int i=0; i<int(data_temp[0]); i++){
    try{
      allLines[i] = split(reader.readLine(), "; ");
    } catch(IOException e){
      return allLines;
    } catch(ArrayIndexOutOfBoundsException e){
      return allLines;
    }
  }
  return allLines;
}
