class ToggleButton extends Button{
  private Boolean toggle = false;
  private String secLabel="";

  ToggleButton(float x, float y, float w, float h, String label, String secLabel){
    super(x, y, w, h, label);
    this.secLabel = secLabel; // label of the button changes when toggled
  }
  ToggleButton(float x, float y, float w, float h, String label){
    super(x, y, w, h, label);
    this.secLabel = label; //no change in label when toggled
  }

  void show(){
    super.show();

    if(this.toggle){
      noStroke();
      fill(secCol, 150);
      rect(this.x, this.y, this.w, this.h, corner1, corner2, corner3, corner4);
    }
  }

  void toggle(){
    this.toggle = !this.toggle;

    String labelSave = this.label;
    this.label = this.secLabel;
    this.secLabel = labelSave;
  }

  boolean getToggle(){
    return this.toggle;
  }
}
