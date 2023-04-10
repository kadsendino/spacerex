class Joystick
{
    int x,y,r;
    int stick_r;

    Joystick() 
    {
        r = height/2 - height/8
        x = r + height/8
        y = height/2 + height/8
        stick_r = r/4;
    }

    void show(){
        stroke(0);
        strokeWeight(1);
        fill(190,190,190,150)
        ellipse(x,y,r,r);

        fill(80,80,80,80);
        ellipse(x,y,stick_r,stick_r);


    }

}