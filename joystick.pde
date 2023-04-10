class Joystick
{
    int x,y,r;
    int stick_r;

    Joystick() 
    {
        int offset = height/16;
        r = height/2 - height/6;
        x = r + offset;
        y = height - offset;
        stick_r = r/3;
    }

    void show(){
        stroke(0);
        strokeWeight(1);
        ellipseMode(CENTER);
        fill(190,190,190,150);
        ellipse(x,y,r,r);

        fill(80,80,80,80);
        ellipse(x,y,stick_r,stick_r);


    }

}