/**
 * Verlet Integration - ragdoll chain
 * Pos  = pos + (pos-posOld)
 * alternative to  x += speed
 *  -with free rotational velocity
 */
 
 //Resources: Ira Greenberg, Daniel Shiffman
Flock flock;
int particles = 100;
VerletBall[] balls = new VerletBall[particles];
int bonds = particles-1;
VerletStick[] sticks = new VerletStick[bonds];
//PVector[] incidence = new PVector[150];

void setup() {
  size(400, 400);
  flock = new Flock();
  for (int i=0; i<100; i++) {
    flock.addBoid(new Boid(width/2, height/2)); 
    //incidence[i] = PVector.mult(flock[i].velocity, -1);
  }
  float shapeR = 40;
  float tension = .9;
  for (int i=0; i<particles; i++) {
    PVector push = new PVector(random(3, 6.5), random(3, 6.5));
    PVector p = new PVector(width/2+shapeR*i, height/2);
    balls[i] = new VerletBall(p, push, 5);

    if (i>0) {
      sticks[i-1] = new VerletStick(balls[i-1], balls[i], tension);
    }
  }
}

void draw() {
  background(0);
  flock.run();
  //for(int i=0; i<flock.size(); i++){
  //checkCollision(flock[i]);   
  //}
  for (int i=0; i<bonds; i++) {
    sticks[i].render();
    sticks[i].constrainLen();
  }
  stroke(0);
  //filter( BLUR, 6);
  fill(255);
  beginShape();
  for (int i=0; i<particles; i++) {
    balls[i].verlet();
    balls[i].render();
    balls[i].boundsCollision();
    //vertex(balls[i].x, balls[i].y);
  }
  endShape(CLOSE);
}
void checkCollision(Boid other) {
  PVector incidence = PVector.mult(other.velocity, -1);
  incidence.normalize();
  //PVector offset = new PVector(.5, .5);
  //offset.normalize();
  for (int i=0; i<particles; i++) {
    if (PVector.dist(other.location, balls[i].pos) - 5 < other.r) {
      PVector baseDelta = new PVector(balls[i].x, balls[i].y);
      baseDelta.normalize();
      PVector normal = new PVector(-baseDelta.y, baseDelta.x);
      float dot = incidence.dot(normal);
      //stopped here
      other.velocity.set(2*normal.x*dot - incidence.x, 2*normal.y*dot - incidence.y, 0);
      other.velocity.mult(30);
    }
  }
}

