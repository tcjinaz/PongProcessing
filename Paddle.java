import processing.core.*;

public abstract class Paddle {

  // superclass for Pong paddles
    
  protected PApplet parent;
  protected int x, y; // current paddle position
  protected int maxX, maxY;  // size of table
  protected int sizeX, sizeY; // size of paddle
  protected boolean leftSide;  // true play left paddle, false play right
  private int speed;

  Paddle( PApplet parent, 
          boolean playLeft,
          int maxX, int maxY,
          int sizeX, int sizeY ) {
    this.parent = parent;
    this.maxX = maxX;
    this.maxY = maxY;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    leftSide = playLeft;
    reset();
  }  //  end paddle ctor

  // reset the position
  public void reset() {
    if ( leftSide ) {
      x = 0 + half(sizeX);
    } else {
      x = maxX - half(sizeX);
    }
    y = half(maxY);
  }

  // tell paddle where the ball is, update paddle position
  public abstract void update ( int ballX, int ballY );

  // draw the paddle at the current position
  public void display() {
    parent.rectMode( parent.CENTER );
    parent.fill( 0, 255, 0 );
    parent.rect( x, y, sizeX, sizeY );
//    System.out.println( "display " + x + " " + y + " " + sizeX + " " + sizeY );    
  }  //  end display

  public void move( int upORdown ) {
    System.out.println( "move " + x + " " + y + " " + upORdown );
    y = y + speed * upORdown;
  }  //  end move

  // where's the paddle?
  public boolean inPaddleYRange( int ballY ) {
    int deltaY = ballY - y;
    if ( Math.abs(deltaY) < half(sizeY) ) {
      return true;
    }
    return false;
  }  //  end inPaddleRange

  public boolean hitPaddle( int ballX, int ballY ) {
    if ( inPaddleYRange( ballY ) ) {
      if ( ballX <= sizeX | ballX >= maxX - sizeX ) {
        return true;
      }
    }
    return false;
  }  //  end hitPaddle
  
  
  // discrete math helper
  public int half( int z ) {
    return (int) ((float)z/2.0 + 0.5);
  }

}  //  end class Paddle