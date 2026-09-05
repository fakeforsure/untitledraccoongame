// Untitled Racoon Game - Player (extends Character)
// By: Team Racoon
// On: September 4, 2026

class Player extends Character {
  float gravity = 0.8;
  boolean facingLeft = false;
  boolean isDashing = false;
  PVector dashDirection;
  int dashTime = 0;
  int maxDashTime = 10;
  float dashSpeed = 25;

  AnimatedSprite sprite;

  Player(PVector position, PVector velocity, int health, float width, float height, PImage[] frames, int frameTime) {
    super(position, velocity, health, width, height);
    sprite = new AnimatedSprite(frames, frameTime);
  }


  void moveCharacter() {
    velocity.y += gravity;
    velocity.x *= damp;
    position.add(velocity);
    
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
    checkWalls();
    sprite.update();
  }

  void drawCharacter() {
    sprite.display(position.x, position.y, facingLeft);
  }
}
