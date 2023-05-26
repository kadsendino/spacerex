class Achievement{
  private String name, testVariable;
  private int value, st; //value of testVariable to beat too comlete achievement; stroke weight
  private boolean completed;
  private float size, y;

  Achievement(String name, int value, String testVariable){
    this.name = name;
    this.value = value;
    this.testVariable = testVariable;
    this.completed = this.getTest();
    this.size = width/7;
    this.y = height/2;
    this.st = int(this.size/20);
  }

  public void show(float pos){
    strokeWeight(this.st);
    stroke(255);
    if(this.completed){
      fill(120, 120);
    }
    else{
      noFill();
    }
    rectMode(CENTER);
    rect(pos, this.y, this.size, this.size);
    rectMode(CORNER);
    fill(255);
    textSize(this.st*2);
    text(this.name, pos, this.y);
  }

  private boolean getTest(){ //to test with other operators (> or ==) descend this class
    return (getStat(this.testVariable) <= this.value);
  }
  public void test(){
    this.completed = this.getTest();
  }

  public boolean getCompleted(){
    return this.completed;
  }
}
