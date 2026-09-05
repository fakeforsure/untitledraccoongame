// Untitled Racoon Game - Character
// By: Team Racoon
// On: September 4, 2026

// Variables
float damp = 0.8;

class Character {
  PVector position;
  PVector velocity;
  int health;
  float hitboxWidth;
  float hitboxHeight;

  // Constructor
  Character(PVector position, PVector velocity, int health, float hitboxWidth, float hitboxHeight) {
    this.position = position.copy();
    this.velocity = velocity.copy();
    this.health = health;
    this.hitboxWidth = hitboxWidth;
    this.hitboxHeight = hitboxHeight;
  }

  void moveCharacter() {
    velocity.mult(damp);
    position.add(velocity);
  }

  void accelerate(PVector accelerator) {
    velocity.add(accelerator);
  }

  void drawCharacter() { // Random box for test
    fill(150);
    rectMode(CENTER);
    rect(position.x, position.y, 64, 64);
  }

  boolean hitCharacter(Character other) {
    // Axis-Aligned bounding box collision
    return !(position.x + hitboxWidth/2 < other.position.x - other.hitboxWidth/2 || position.x - hitboxWidth/2 > other.position.x + other.hitboxWidth/2 || position.y + hitboxHeight/2 < other.position.y - other.hitboxHeight/2 || position.y - hitboxHeight/2 > other.position.y + other.hitboxHeight/2);
  }

  // Will we need health damage? Or is it loss right away?
  void decreaseHealth(int damage) {
    health -= damage;
  }

  void checkWalls() {
    if (position.x < 32) position.x = 32;
    if (position.x > width - 32) position.x = width - 32;
    if (position.y > height - 32) {
      position.y = height - 32;
      velocity.y = 0;
    }
  }

  void update() {
    moveCharacter();
    checkWalls();
  }
}
