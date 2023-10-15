class Ball {
  PVector pos;
  PVector vel;
  PVector gravity = new PVector(0, 0.2, 0);
  float r;
  
  PImage ball_texture;
  PShape ball;
  
 Ball(float x, float y, float z, float vx, float vy, float vz, float r) {
   pos = new PVector(x, y, z);
   vel = new PVector(vx, vy, vz);
   this.r = r;
 
    // add the basketball texture
    ball_texture = loadImage("ball_texture.png");
    ball = createShape(SPHERE, r);
    textureWrap(REPEAT);
    ball.setTexture(ball_texture);
   }
    
   void applyVelocity() {
     vel.add(gravity);
     pos.add(vel); 
   }
   
   void display() {
     pushMatrix();
     // once the ball is launched, the ball location cannot be moved
     if (launched == true){
       translate(ball_locate, pos.y, pos.z);}
     else { // otherwise, the ball allows mouseX
     translate(mouseX, pos.y, pos.z);}
     
     shape(ball);
     popMatrix();
   }
 
   void checkWinLose(float x){
     
     // if ball hits the hoop
     if (225 <= x && x <= 275 && pos.y < 100){
       win = true;       
       // stops the ball from moving any more
       gravity = new PVector(0,0,0);
       vel = new PVector(0,0,0);
     }
     
     // if ball is falling fast (aka did not hit the hoop)
     else if (vel.y > 15){
       loss = true;
     }
   }  
  }
