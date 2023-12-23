interface GameObject {
  void update();
  void draw();
  boolean isColliding(GameObject gameObject);
  boolean isDead();
  float hit(float val);

  PVector getPos();
  float getRadius();

  int getPriority();
};
