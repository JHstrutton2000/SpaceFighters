class Ship implements GameObject {
  PVector pos, vel, acc, Color;
  float health = DefaultShipHealth;
  float r;
  
  boolean player = false;

  Ship(PVector pos, PVector Color, boolean player) {
    this.pos = pos;
    this.vel = new PVector();
    this.acc = new PVector();
    this.Color = Color;
    this.player = player;

    r = 5.5f;
  };

  void draw() {
    push();
      translate(pos.x, pos.y);
      rotate(vel.heading()-PI/2);
      triangle(0, 5, -3, -3, 3, -3);
    pop();
  }

  void update() {
    if (acc.mag() > maxAcc) {
      acc.setMag(maxAcc);
    }

    if (vel.mag() > maxVel) {
      vel.setMag(maxVel);
    }

    pos.add(vel);

    vel.mult(DampenVel);
    vel.add(acc);

    acc.set(0, 0);
    
    if(player){
      if (forward) {
        applyForce(new PVector(0, -movementSpeed));
      } else if (back) {
        applyForce(new PVector(0, movementSpeed));
      }
  
      if (right) {
        applyForce(new PVector(movementSpeed, 0));
      } else if (left) {
        applyForce(new PVector(-movementSpeed, 0));
      }
  
      if (fire) {
        this.shoot();
        fire = false;
      }
    }
  }

  void applyForce(PVector vec) {
    acc.add(vec);
  }

  void shoot() {
    gameObjects.add(new Bullet(pos.copy(), vel.copy().setMag(BulletSpeed), 3, this));
  }

  int getPriority() {
    return 1;
  }

  PVector getPos() {
    return pos;
  }

  float hit(float val) {
    return health -= val;
  }

  boolean isColliding(GameObject gameObject) {
    return false;
  }

  float getRadius() {
    return r;
  }

  boolean isDead() {
    return (health <= 0);
  }
}
