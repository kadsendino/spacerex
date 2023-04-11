class Joystick
{
    float x,y,r;
    float stick_r;
    int active_touch;
    float active_touch_x;
    float active_touch_y;
    float st;

    Joystick() 
    {      
        r = height/2 - height/6;
        float offset = height/12;
        x = r/2 + offset;
        y = height - x;
        stick_r = r/3;
        active_touch = -1;
        st = r/40;
        active_touch_x = x;
        active_touch_y = y;
    }

    void show(){

        float x_temp = active_touch_x;
        float y_temp = active_touch_y;
        stroke(255);
        strokeWeight(st);
        ellipseMode(CENTER);
        fill(230,230,230,150);
        ellipse(x,y,r,r);

        fill(80,80,80,150);
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
    
    float getAngle(){
        PVector v1 = new PVector(this.x,this.y);
        PVector v2 = new PVector(active_touch_x,active_touch_y);
        PVector v = v1.sub(v2).normalize().mult(-1);
        return PI*0.5 + v.heading();
    }

    float getDist(){
        PVector v1 = new PVector(this.x,this.y);
        PVector v2 = new PVector(active_touch_x,active_touch_y);        
        float distance = v1.dist(v2);      
        if(distance > r*0.5){
            return 1;
        }
        return distance/(r*0.5);
    }


    
}