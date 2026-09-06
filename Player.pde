// Untitled Raccoon Game - Player (extends Character)
// By: Team Raccoon
// On: September 4, 2026

class Player extends Character {
  float gravity = 0.8;
  boolean grounded = false;
  boolean facingLeft = false;
  
  // Calculate angle
  boolean touching(Platform p) {
    if (p.angle == 0) {
      return position.x + hitboxWidth/2 > p.x && position.x - hitboxWidth/2 < p.x + p.w && position.y + hitboxHeight/2 > p.y && position.y - hitboxHeight/2 < p.y + p.h;
    }
    float relX = position.x - p.x;
    float relY = position.y - p.y;
    float unRotAngle = radians(-p.angle);
    float localX = relX * cos(unRotAngle) - relY * sin(unRotAngle);
    float localY = relX * sin(unRotAngle) + relY * cos(unRotAngle);
    return localX + hitboxWidth/2 > 0 && localX - hitboxWidth/2 < p.w && localY + hitboxHeight/2 > 0 && localY - hitboxHeight/2 < p.h;
  }

  AnimatedSprite sprite; // Bring in the animation
  
  // Sword settings
  boolean swinging = false;
  int swingID = 0;
  int swingTimer = 0;
  int swingDuration = 15;
  float bagStart = 25;
  float bagLength = 100;
  float bagWidth = 14;

  // Constructor
  Player(PVector position, PVector velocity, int health, float width, float height, PImage[] frames, int frameTime) {
    super(position, velocity, health, width, height);
    sprite = new AnimatedSprite(frames, frameTime);
  }
  
  // I hate math
  void moveCharacter() {
    grounded = false;
    velocity.y += gravity;
    velocity.x *= damp;
  
    // Check Position
    position.x += velocity.x;
    for (Platform p : platforms) {
      if (!p.oneWay && p.angle == 0 && touching(p)) {
        if (velocity.x > 0) {
          position.x = p.x - hitboxWidth/2;
        } 
        else if (velocity.x < 0) {
          position.x = p.x + p.w + hitboxWidth/2;
        }
        velocity.x = 0;
      }
    }
    float previousY = position.y;
    position.y += velocity.y;
    for (Platform p : platforms) {
      if (p.oneWay) {
        boolean crossedTop = previousY + hitboxHeight/2 <= p.y && position.y + hitboxHeight/2 >= p.y;
        if (velocity.y >= 0 && crossedTop) {
          position.y = p.y - hitboxHeight/2;
          velocity.y = 0;
          grounded = true;
        }
      }
      else if (p.angle == 0 && touching(p)) {
        if (velocity.y > 0) {
          position.y = p.y - hitboxHeight/2;
          velocity.y = 0;
          grounded = true;
        }
        else if (velocity.y < 0) {
          position.y = p.y + p.h + hitboxHeight/2;
          velocity.y = 0;
        }
      }
      else if (p.angle != 0 && touching(p) && velocity.y >= 0) {
        float relativeX = position.x - p.x;
        float angleRad = radians(p.angle);
        float surfaceY = p.y + relativeX * sin(angleRad) * cos(angleRad);
        position.y = surfaceY - hitboxHeight/2;
        velocity.y = 0;
        grounded = true;
      }
    }
    if (position.x - hitboxWidth/2 < 0) {
      position.x = hitboxWidth/2;
      velocity.x = 0;
    }
    if (position.x + hitboxWidth/2 > width) {
      position.x = width - hitboxWidth/2;
      velocity.x = 0;
    }
  }
  // https://stackoverflow.com/questions/401847/circle-rectangle-collision-detection-intersection
  // https://stackoverflow.com/questions/62028169/how-to-detect-when-rotated-rectangles-are-colliding-each-other
  // https://stackoverflow.com/questions/13464122/rotate-and-translate-in-processing-give-me-headaches

  void swingBag() {
    if (!swinging) {
      swinging = true;
      swingTimer = swingDuration;
      swingID++;
    }
  }

  void updateBag() {
    if (swinging) {
      swingTimer--;

      if (swingTimer <= 0) {
        swingTimer = 0;
        swinging = false;
      }
    }
  }

  float getBagAngle() {
    float progress = 1.0 - float(swingTimer) / swingDuration;
    float angle = radians(70 - progress * 140); // Swings bottom to top
    if (facingLeft) {
      angle = PI - angle;
    }
    return angle;
  }
  
  void drawBag() {
    if (!swinging) {
      return;
    }
    
    float bagAngle = getBagAngle();
    pushMatrix();
    translate(position.x, position.y);
    rotate(bagAngle);
    noFill();
    stroke(#FF0000);
    strokeWeight(1);
    rectMode(CORNERS);
    rect(bagStart, -bagWidth/2, bagStart + bagLength, bagWidth/2);
    popMatrix();
    rectMode(CORNER);
  }

  void update() {
    moveCharacter();
    updateBag();
    sprite.update();
  }

  void drawCharacter() {
    if (debugMode) drawBag();
    sprite.display(position.x, position.y, facingLeft, 192);
  }
}
