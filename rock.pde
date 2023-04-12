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
        this.level = level;
        this.anz_points = 8;
        this.st = 8;

        this.points = new PVector[anz_points];
        println("Test");

        
        for (int i = 0; i < this.anz_points; i++) {
            PVector pos = new PVector(x,y);
            float radius = r;
            float rand = random(1,100);
            if(rand < 40){
                //inner circle
                radius = r/2;
            }else {
                //outer circle
                radius = r;
            }

            points[i] = PVector.fromAngle((i/this.anz_points) * TWO_PI).normalize().mult(radius);
        } 
        textAlign(CENTER.CENTER);      
        text(points,width/2,height/2);

    }

    void show(){
        stroke(255);
        strokeWeight(st);
        noFill();
        beginShape();
        for (int i = 0; i < this.anz_points; i++) {
            vertex(this.points[i].x,this.points[i].y);
        }   
        endShape(CLOSE);
    }

}