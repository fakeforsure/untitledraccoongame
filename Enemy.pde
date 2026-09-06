// Untitled Raccoon Game - Enemy (extends Character)
// By: Team Raccoon
// On: September 6, 2026

// To spawn a Richard
//richard.update(player);
//richard.drawCharacter();
//checkBagHitEnemy(richard, player);

class BasicEnemy extends Character {
  boolean isDead = false;
  int deathTimer = 0;
  int deathDuration = 30; // Frames
  boolean isSpawning = true;
  int spawnTimer = 0;
  int spawnDuration = 120;
  int healthLost = 5;
  int maxHealth;
  int lastBagSwingID = -1;
  float gravity = 0.8;
  boolean grounded = false;
  boolean isHealthBar = false;

  
  AnimatedSprite sprite;

  // Constructor
  BasicEnemy(PVector position, PVector velocity, int health, float width, float height, AnimatedSprite startingAnimation) {
    super(position, velocity, health, width, height);
    this.maxHealth = health;
    this.sprite = startingAnimation;
  }
  
  void update(Player player) {
    if (isSpawning) {
      spawnTimer++;
      if (spawnTimer > spawnDuration) {
        isSpawning = false;
      }
    } 
    else if (!isDead) {
      grounded = false;
      velocity.x = 0; // I don't want him to run off rn
      // Use "richard.velocity.x = 2;" for him to run off somewhere
      velocity.y += gravity;
    
      float previousY = position.y;
      position.y += velocity.y;
    
      for (Platform p : platforms) {
        boolean insidePlatformX = position.x + hitboxWidth/2 > p.x && position.x - hitboxWidth/2 < p.x + p.w;
        boolean crossedPlatformTop = previousY + hitboxHeight/2 <= p.y && position.y + hitboxHeight/2 >= p.y;
        
        if (insidePlatformX && crossedPlatformTop && velocity.y >= 0) {
          position.y = p.y - hitboxHeight / 2;
          velocity.y = 0;
          grounded = true;
        }
      }
    }
    else {
      deathTimer++;
    }
  }

  void drawCharacter() {
    if (isDead) {
      if (deathTimer < deathDuration) {
        drawBoom(position.x, position.y, 1, #FFA500);
      }
      return;
    }
    
    if (isSpawning && (spawnTimer / 15) % 2 == 0) {
      return;
    }
    
    sprite.update();
    sprite.display(position.x, position.y, false, 100);
    if (isHealthBar) drawEnemyHealth();
  }

  boolean hitCharacter(Player player) {
    return !(position.x + hitboxWidth/2 < player.position.x - player.hitboxWidth/2 || position.x - hitboxWidth/2 > player.position.x + player.hitboxWidth/2 || position.y + hitboxHeight/2 < player.position.y - player.hitboxHeight/2 || position.y - hitboxHeight/2 > player.position.y + player.hitboxHeight/2);
  }

  void takeDamage(int dmg) {
    if (!isDead) {
      health -= dmg;
      if (health <= 0) {
        isDead = true;
        sfxExplosion.play();
        deathTimer = 0;
      }
    }
  }
  
  void drawEnemyHealth() {
    pushMatrix();
    translate(position.x - 50, position.y - 65);
    noFill();
    strokeWeight(4);
    stroke(0);
    line(0, 0, 100, 0);
    strokeWeight(3);
    stroke(255, 0, 0);
    line(0, 0, 100, 0);
    float healthRatio = constrain((float) health / maxHealth, 0, 1);
    stroke(0, 255, 0);
    line(0, 0, 100 * healthRatio, 0);
    fill(0);
    textAlign(LEFT);
    textFont(font);
    textSize(16);
    text(health, 112.5, 5);
    strokeWeight(1);
    noStroke();
    popMatrix();
  }
}

// Math was borrowed from past projects :c
void checkBagHitEnemy(BasicEnemy enemy, Player player) {
  if (!player.swinging || enemy.isDead) {
    return;
  }

  if (enemy.lastBagSwingID == player.swingID) {
    return;
  }

  float bagAngle = player.getBagAngle();

  float dx = enemy.position.x - player.position.x;
  float dy = enemy.position.y - player.position.y;

  float localX = dx * cos(-bagAngle) - dy * sin(-bagAngle);
  float localY = dx * sin(-bagAngle) + dy * cos(-bagAngle);

  float enemyHalfWidth = enemy.hitboxWidth/2;
  float enemyHalfHeight = enemy.hitboxHeight/2;

  float rotatedHalfWidth = enemyHalfWidth * abs(cos(bagAngle)) + enemyHalfHeight * abs(sin(bagAngle));
  float rotatedHalfHeight = enemyHalfWidth * abs(sin(bagAngle)) + enemyHalfHeight * abs(cos(bagAngle));

  float bagLeft = player.bagStart;
  float bagRight = player.bagStart + player.bagLength;
  float bagTop = -player.bagWidth/2;
  float bagBottom = player.bagWidth/2;

  boolean hit = localX + rotatedHalfWidth > bagLeft && localX - rotatedHalfWidth < bagRight && localY + rotatedHalfHeight > bagTop && localY - rotatedHalfHeight < bagBottom;

  if (hit) {
    enemy.takeDamage(1);
    enemy.lastBagSwingID = player.swingID;
  }
}

void drawBoom(float x, float y, int s, color c) {
  pushMatrix();
  translate(x, y);
  scale(s);
  fill(0);
  triangle(45, -45, -30, 0, 0, 30);
  triangle(45, 45, 0, -30, -30, 0);
  triangle(-45, 45, 30, 0, 0, -30);
  triangle(-45, -45, 0, 30, 30, 0);
  fill(c);
  scale(0.75*s);
  triangle(45, -45, -30, 0, 0, 30);
  triangle(45, 45, 0, -30, -30, 0);
  triangle(-45, 45, 30, 0, 0, -30);
  triangle(-45, -45, 0, 30, 30, 0);
  popMatrix();
}
