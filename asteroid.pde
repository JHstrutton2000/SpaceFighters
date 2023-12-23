class Astroid implements GameObject{
  PVector pos, vel, Color;
  float r;
  
  Astroid(PVector pos, PVector vel, PVector Color, float r){
    this.pos = pos;
    this.vel = vel;
    this.Color = Color;
    this.r = r;
  }
  
  void update(){
    pos.add(vel);
  }
  
  void draw(){
    push();
      translate(pos.x, pos.y);
      fill(Color.x, Color.y, Color.z);
      ellipse(0, 0, r, r);
    pop();
  }
  
  boolean isColliding(GameObject gameObject){
    if (pos.x-r > width || pos.x+r < 0 || pos.y-r > height || pos.y+r < 0) {
      r = 0;
      return true;
    }
    return false;
  }
  
  boolean isDead(){
    return (r < 1);
  }
  
  float hit(float val){
    int childCount = (int)random(1, 10);
    
    r /= val;
    r /= childCount;
    
    vel.set(random(-1, 1), random(-1, 1));
    for(int i=0; i<childCount; i++){
      PVector childvel = vel.copy().set(random(-1, 1), random(-1, 1));
      
      gameObjects.add(new Astroid(pos.copy(), childvel, Color, r)); 
    }
    
    
    return 0;
  }

  PVector getPos(){
    return pos;
  }
  
  float getRadius(){
    return r; 
  }

  int getPriority(){
    return 2;
  }
}
