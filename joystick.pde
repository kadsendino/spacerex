class Joystick
{
    float x,y,r;
    float stick_r;
    int active_touch;
    float active_touch_x;
    float active_touch_y;

    Joystick() 
    {
        float offset = height/32;
        r = height/2 - height/6;
        x = r + offset;
        y = height - x;
        stick_r = r/3;
    }

    void show(){

        float x_temp = active_touch_x;
        float y_temp = active_touch_y;
        stroke(0);
        strokeWeight(1);
        ellipseMode(CENTER);
        fill(190,190,190,150);
        ellipse(x,y,r,r);

        fill(80,80,80,80);
        ellipse(x_temp,y_temp,stick_r,stick_r);
    }

    void setPositions(float x,float y){
        this.x = x;
        this.y = y;
        this.active_touch_x = x;
        this.active_touch_y = y;
    }

    void setActiveTouch(int i){
        this.active_touch = i;
    }

    void setActiveTouchPosition(float x,float y){
        this.active_touch_x = x;
        this.active_touch_y = y;

        float x_cos = cos((this.x - this.active_touch_x));
        float y_sin = sin((this.y - this.active_touch_y));
        if( x_cos + y_sin > 1){
            this.active_touch_x = this.x + this.r * x_cos;
            this.active_touch_y = this.y + this.r * y_cos;
        }
    }

    int getActiveTouch(){
        return this.active_touch; 
    }

    
    
}