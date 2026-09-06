// Untitled Dungeon - Projectile
// By: Team Raccoon
// On: September 6, 2026

// Variables
float upX = 37.5;
float upY = -37.5;

class Projectile {
  PVector position;
  PVector velocity;
  int element;
  
  // Constructor
  Projectile(PVector position, PVector velocity, int element) {
    this.position = position.copy();
    this.velocity = velocity.copy();
    this.element = element;
  }
  
  void moveProjectile() {
    position.add(velocity);
  }

  void accelerate(PVector accelerator) {
    velocity.add(accelerator);
  }

  void drawProjectile(boolean isBoss) { // Random Box For Test
    pushMatrix();
    noFill();
    noStroke();
    if (isBoss) drawBoom(position.x, position.y, 1, #009DDC);
    projectileBombAnimation.display(10, 10, false, 64);
    projectileBombAnimation.reset();
    popMatrix();
  }
}

void updateProjectiles() {
  float projectileSize = 64;
  float halfSize = projectileSize / 2;

  float screenLeft = -halfSize;
  float screenRight = width + halfSize;
  float screenTop = -halfSize;
  float screenBottom = height + halfSize;

  // Boss' bullets
  //for (int i = bossProjectiles.size() - 1; i >= 0; i--) {
  //  Projectile pewBoss = bossProjectiles.get(i);

  //  pewBoss.moveProjectile();
  //  pewBoss.drawProjectile(true);

  //  if (pewBoss.position.x < screenLeft || pewBoss.position.x > screenRight || pewBoss.position.y < screenTop || pewBoss.position.y > screenBottom) {
  //    bossProjectiles.remove(i);
  //  }
  //}
}
