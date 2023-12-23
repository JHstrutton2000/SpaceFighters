class Bullet implements GameObject {
  PVector pos, vel;
  float damage;
  int safeTime;

  Ship ship;


  Bullet(PVector pos, PVector dir, float r, Ship ship) {
    this.pos = pos;
    this.vel = dir;

    this.damage = r;

    this.ship = ship;

    this.safeTime = 25;
  }

  void update() {
    pos.add(vel);
  }

  void draw() {
    ellipse(pos.x, pos.y, damage, damage);
  }

  PVector getPos() {
    return pos;
  }

  int getPriority() {
    return 2;
  }

  boolean isColliding(GameObject gameObject) {
    if (pos.x > width || pos.x < 0 || pos.y > height || pos.y < 0) {
      damage = 0;
      return true;
    }

    if (safeTime <= 0 && pos.copy().sub(gameObject.getPos()).mag() < (damage + gameObject.getRadius())/2) {
      damage = gameObject.hit(damage);  // if this bullets damage is greater than other bullets damage than survives
      return true;
    } else {
      safeTime--;
    }

    return false;
  }

  float getRadius() {
    return damage;
  }

  boolean isDead() {
    return (damage <= 0);
  }

  float hit(float val) {
    damage -= val;

    return 0;
  }
}
