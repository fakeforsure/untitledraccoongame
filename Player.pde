// Untitled Raccoon Game - Player (extends Character)
// By: Team Raccoon
// On: September 4, 2026

class Player extends Character {
  float gravity = 0.8;
  boolean grounded = false;
  boolean touching(Platform p) {
    return position.x + hitboxWidth / 2 > p.x && position.x - hitboxWidth / 2 < p.x + p.w && position.y + hitboxHeight / 2 > p.y && position.y - hitboxHeight / 2 < p.y + p.h;
  }
  boolean facingLeft = false;
  boolean isDashing = false;
  PVector dashDirection;
  int dashTime = 0;
  int maxDashTime = 10;
  float dashSpeed = 25;

  AnimatedSprite sprite; // Bring in the animation

  // Constructor
  Player(PVector position, PVector velocity, int health, float width, float height, PImage[] frames, int frameTime) {
    super(position, velocity, health, width, height);
    sprite = new AnimatedSprite(frames, frameTime);
  }
  
  void moveCharacter() {
    grounded = false;
    velocity.y += gravity;
    velocity.x *= damp;
    position.x += velocity.x;
    for (Platform p : platforms) {
      if (touching(p)) {
        if (velocity.x > 0) {
          position.x = p.x - hitboxWidth / 2;
        } 
        else if (velocity.x < 0) {
          position.x = p.x + p.w + hitboxWidth / 2;
        }
        velocity.x = 0;
      }
    }
    position.y += velocity.y;
    for (Platform p : platforms) {
      if (touching(p)) {
        if (velocity.y > 0) {
          position.y = p.y - hitboxHeight / 2;
          velocity.y = 0;
          grounded = true;
        } 
        else if (velocity.y < 0) {
          position.y = p.y + p.h + hitboxHeight / 2;
          velocity.y = 0;
        }
      }
    }
    if (position.x - hitboxWidth / 2 < 0) {
      position.x = hitboxWidth / 2;
      velocity.x = 0;
    }
    if (position.x + hitboxWidth / 2 > width) {
      position.x = width - hitboxWidth / 2;
      velocity.x = 0;
    }
    if (isDashing) {
      float totalDash = (float)dashTime/maxDashTime;
      float easingDash = sin(totalDash*PI);
      PVector dashStep = dashDirection.copy().mult(dashSpeed*easingDash);
      position.add(dashStep);
      dashTime++;
      if (dashTime >= maxDashTime) {
        isDashing = false;
      }
    }
  }


  void update() {
    moveCharacter();
    sprite.update();
  }


  void drawCharacter() {
    sprite.display(position.x, position.y, facingLeft);
  }
}
