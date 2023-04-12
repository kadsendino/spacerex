class Rock{
    float x,y,r;
    int level;
    int anz_points;
    PVector[] points;
    PVector vel;
    float st;

    Rock(int level, float x, float y, float r){
        this.x = x;
        this.y = y;
        this.r = r;
        this.level = level
        this.anz_points = 8;
        this.st = 8;

        PVector pos = new PVector(x,y);
        for (int i = 0; i < anz_points; i++) {
            float rand = random(1,100);
            if(rand < 40){
                //inner circle
                this.radius = r/2;
            }else {
                //outer circle
                this.radius = r;
            }

            points[i] = PVector.fromAngle((i/anz_points) * TWO_PI).normalize().mult(radius);
        }       

    }

    void show(){
        stroke(255);
        strokeWeight(st);
        noFill();
        beginShape();
        for (int i = 0; i < anz_points; i++) {
                vertex(points[i].x,points[i].y);
            }   
        endShape(CLOSE);
    }

}