boolean launched = false;
boolean win = false;
boolean loss = false;
Ball b1;
Hoop h1;
float ball_locate;

void setup() {
  size(500, 500, P3D);  
  noStroke();
  b1 = new Ball (250,500,0, 0,-15,-5, 50); 
  h1 = new Hoop(250,100,0);
  
  // only used to print text isf ball is a lose or win
  // delete after win/lose animations are done
  fill(0);
  textSize(50);
}

void draw() {
  background(220);
  
  // when ball is launched, apply velocity & gravity and continously
  // check if user has won or lost
  if (launched) {
    println(ball_locate);
    b1.applyVelocity(); 
    b1.checkWinLose(ball_locate);
    if (win == true){
      text("you win", 200, 300);
    }    
    if (loss == true){
      text("you lose", 200, 300);
    }
  }  
  
  
  // display the ball and hoop
  h1.display();
  b1.display();
  
}

void mousePressed() {
  if (!launched) {
    launched = true;
    // stores the x value the ball is launched at
    // to be used in determining in the user won or lost
    ball_locate = mouseX;
  }
}

// if the user presses the space key, the game resets
void keyPressed(){
  if (key == ' '){
    launched = false;
    win = false;
    loss = false;
    b1 = new Ball(250,500,0, 0,-15,-5, 50); 
  }
  
}
