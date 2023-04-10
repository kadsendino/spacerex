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

        PVector v1 = new PVector(this.x,this.y);
        PVector v2 = new PVector(active_touch_x,active_touch_y);        
        float distance = v1.dist(v2);      
        if(distance > r*0.5){
            PVector v = v1.sub(v2).normalize().mult(this.r*(-0.5));
            active_touch_x = this.x + v.x;
            active_touch_y = this.y + v.y;
        }
    }

    int getActiveTouch(){
        return this.active_touch; 
    }

    float getX(){
        return this.x;
    }

    float getY(){
        return this.y;
    }


    
}