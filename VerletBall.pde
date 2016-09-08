class VerletBall {

  PVector pos, posOld;
  PVector push;
  float radius;
  float w;
  float h;
  float x;
  float y;
  //float theta;
  VerletBall(){
  }

  VerletBall(PVector pos,  PVector push, float radius){
    this.pos = pos;
    this.push = push;
    this.radius = radius;
    this.posOld  = new PVector(pos.x, pos.y);
    this.w = (width-150);
    this.h = (height-150);
    this.x = 150;
    this.y = 150;
    //float a = (rotateX / (float) width) * 90f;
    //theta = radians(a); 


    
    // start motion
    pos.add(push);
  }

  void verlet(){
    PVector posTemp = new PVector(pos.x, pos.y);
    pos.x += (pos.x-posOld.x);
    pos.y += (pos.y-posOld.y);
    posOld.set(posTemp);
  }

  void render(){
   /* pushMatrix();
    translate(pos.x, pos.y);
    branch(radius); */
    //ellipse(pos.x, pos.y, radius*2, radius*2);
    vertex(pos.x, pos.y);
  }

  void boundsCollision(){
    
    if (pos.x>(w-radius)){
      pos.x = w-radius;
      posOld.x = pos.x;
      pos.x -= push.x;
    } 
    else if(pos.x<(radius+x)){
      pos.x = (radius+x);
      posOld.x = pos.x;
      pos.x += push.x;
    }

    if (pos.y<(radius+y)){
      pos.y = (radius+y);
      posOld.y = pos.y;
      pos.y += push.y;
    } 
    
    if (pos.y>(h-radius)){
      pos.y = h-radius;
      posOld.y = pos.y;
      pos.y -= push.y;
    } 
  }


}

