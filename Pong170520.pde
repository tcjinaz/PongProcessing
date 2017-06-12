final int MaxX = 640;
final int MaxY = MaxX/2;

PShape ball;
int bX, bY, dirX, dirY;

final int PaddleWidth = 8;
final int PaddleHeight = 32;

float angle;
final float angleRange = 120.0;
final float angleOffset = -60.0;

int wait;
double speed;

Paddle leftPaddle;
Paddle rightPaddle;

void settings() {
  size( MaxX, MaxY );
}

void setup() {
  ball = createShape( RECT, 10, 10, 10, 10 );
  ball.beginShape();
  ball.fill( 0,0,128 );
  ball.endShape(CLOSE);
  
  bX = -10; bY = 155; dirX = 1; dirY = 1;
  wait = 30; speed = 10;
  angle = newAngle();

  rightPaddle = new Paddle1( this, false, MaxX, MaxY, PaddleWidth, PaddleHeight );
  leftPaddle = new Paddle1( this, true, MaxX, MaxY, PaddleWidth, PaddleHeight );
}

void draw() {
  background( 128, 0, 0 );
  wait++;
  if ( wait > 25 ) {
    if ( moveBall() ) {
      // move Ball returns true when the ball gets past a paddle
      // reset the game, pick a new angle
      wait = 0;
      angle = newAngle();
      println( "angle = ", degrees(angle) );
      leftPaddle.reset();
      rightPaddle.reset();
    }
    rightPaddle.update( bX, bY );
    leftPaddle.update( bX, bY );
  }
  leftPaddle.display();
  rightPaddle.display();
}  //  end draw

boolean moveBall () {
  boolean scored = false;
  double dX = speed*dirX*Math.abs(Math.cos(angle));
  bX += dX;
  double dY = speed*dirY*Math.abs(Math.sin(angle));
  bY += dY;
//  println( angle, "  X", bX, "  ", dX, "  Y ", bY, " ", dY );

  // check if the ball hit a paddle
  if ( bX >= MaxX ) {
    scored = ! rightPaddle.inPaddleYRange(bY);
    bX = MaxX; dirX = -1;
  }
  else if ( bX <= 0 ) {
    scored = ! leftPaddle.inPaddleYRange(bY);
    bX = 0; dirX = 1;
  }
  
  // bounce the ball off of the sides
  if ( bY <= 0 ) {
    bY = 0; dirY = 1;
  } else if ( bY >= MaxY ) {
    bY = MaxY; dirY = -1;
  }
  ellipse( bX, bY, 10, 10 );
  fill( 0, 255, 0 );
  return scored;
}

float newAngle() {
  return radians((float)Math.random()*angleRange + angleOffset);
}