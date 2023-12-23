class Ship implements GameObject {
  PVector pos, vel, acc, Color;
  float health = DefaultShipHealth;
  GameObject leader;
  float r;

  ShipBehaviors behavior;
  boolean moving = false;

  Ship(PVector pos, PVector Color, ShipBehaviors behavior) {
    this.pos = pos;
    this.vel = new PVector(0.01, 0);
    this.acc = new PVector();
    this.Color = Color;
    this.behavior = behavior;

    r = 5.5f;
  };

  Ship(PVector pos, PVector Color, ShipBehaviors behavior, GameObject leader) {
    this(pos, Color, behavior);

    this.leader = leader;
  };

  void draw() {
    push();
    translate(pos.x, pos.y);
    rotate(vel.heading()-PI/2);
    triangle(0, 5, -3, -3, 3, -3);

    if (moving) {
      noStroke();
      fill(150, 25, 25);
      ellipse(0, -4, 5, 5);
    }
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

    if (behavior == ShipBehaviors.player) {
      if (forward) {
        moving = true;
        applyForce(new PVector(0, -movementSpeed));
      } else if (back) {
        moving = true;
        applyForce(new PVector(0, movementSpeed));
      }

      if (right) {
        moving = true;
        applyForce(new PVector(movementSpeed, 0));
      } else if (left) {
        moving = true;
        applyForce(new PVector(-movementSpeed, 0));
      }
      else if(!forward && !back){
        moving = false; 
      }

      if (fire) {
        this.shoot();
        fire = false;
      }
    } else if (behavior == ShipBehaviors.follow) {
      if (leader != null) {
        PVector force = leader.getPos().copy().sub(pos);
        moving = true;
        
        if(force.mag() < 25){
            force.mult(-1);
        }
        else if(force.mag() < 50){
            force.mult(0);
            moving = false;
        }
        
        applyForce(force);
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
