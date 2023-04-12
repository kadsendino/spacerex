interface Enemy{
    void show();
    void update();
    boolean isHit(PVector[] shot_points);
}