class Joystick
{
    int x,y,r;
    int stick_r;
    int active_touch;

    Joystick() 
    {
        int offset = height/32;
        r = height/2 - height/6;
        x = r + offset;
        y = height - x;
        stick_r = r/3;
    }

    void show(){

        int x_temp = x - r/2;
        int y_temp = y - r/2;
        stroke(0);
        strokeWeight(1);
        ellipseMode(CENTER);
        fill(190,190,190,150);
        ellipse(x_temp,y_temp,r,r);

        fill(80,80,80,80);
        ellipse(x_temp,y_temp,stick_r,stick_r);
    }

    void setPositions(int x,int y){
        this.x = x;
        this.y = y;
    }

    void setActiveTouch(int i){
        this.active_touch = i;
    }

    int getActiveTouch(){
        return this.active_touch; 
    }
    
}