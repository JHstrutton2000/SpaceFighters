class WormHole implements GameObject{
  PVector pos;
  float r;
  
  WormHole linked;
  
  WormHole(PVector pos, float r){
    this.pos = pos;
    this.r = r;
    
  }
  
  WormHole(PVector pos, float r, WormHole linked){
    this(pos, r);
    
    setLinked(linked);
    linked.setLinked(this);
  }
  
  void setLinked(WormHole linked){
    this.linked = linked;
  }
  
  void update(){
    
  }
  
  void draw(){
    push();
      translate(pos.x, pos.y);
      ellipse(0, 0, r, r);
    pop();
  }
  
  boolean isColliding(GameObject gameObject){ //with WormHole, this should always return false since I want to handle mutiple collisions...
    if(linked == null){
      return false;  
    }
    
    if (pos.copy().sub(gameObject.getPos()).mag() < (r + gameObject.getRadius())/2) {
      PVector colliderPos = gameObject.getPos();
      
      PVector offset = pos.copy().sub(colliderPos);
      offset.setMag(linked.getRadius() + gameObject.getRadius());
      
      colliderPos.set(linked.pos);
      colliderPos.add(offset);
      
      return false;
    } 
    
    return false;
  }
  
  boolean isDead(){
    return false;
  }
  
  float hit(float val){
    return val;
  }
  
  PVector getPos(){
    return pos;
  }
  
  float getRadius(){
    return r;  
  }

  int getPriority(){
    return 3;
  }
}
