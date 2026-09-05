class Player extends Character {
  boolean isDashing = false;

  float gravity = 0.8;

  PVector dashDirection;
  int dashTime = 0;
  int maxDashTime = 10;
  float dashSpeed = 25;

  AnimatedSprite sprite;

  Player(PVector position, PVector velocity, int health, float width, float height, PImage spriteSheet, int frameWidth, int frameHeight, int frameCount, int columns, int[] frameDurations) {
    super(position, velocity, health, width, height);
    sprite = new AnimatedSprite(spriteSheet, frameWidth, frameHeight, frameCount, columns, frameDurations);
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
    sprite.display(position.x, position.y);
  }
}
