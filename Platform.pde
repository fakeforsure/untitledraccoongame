// Untitled Raccoon Game - Platform
// By: Team Raccoon
// On: September 5, 2026

// *** HOW PLATFORMS WORK **
// In draw(), add this:
// platforms.clear();
// Then, add your platforms using this command:
// addPlatform(0, 656, 1280, 64, 0, #FF0000);
// addPlatform(200, 570, 250, 30, 0, #FF0000);
// addPlatform(550, 520, 40, 136, 0, #FF0000);
// addPlatform(700, 420, 250, 30, 0, #FF0000);
// addPlatform(1050, 300, 40, 356, 0, #FF0000);

class Platform {
  float x, y, w, h;
  float angle;
  color platformColor;
  boolean oneWay;

  // Constructor
  Platform(float x, float y, float w, float h, float angle, color platformColor, boolean oneWay) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.angle = angle;
    this.platformColor = platformColor;
    this.oneWay = oneWay;
  }

  void drawPlatform() {
    pushMatrix();
    translate(x, y);
    rotate(radians(angle));
    rectMode(CORNER);
    fill(platformColor);
    rect(0, 0, w, h);
    popMatrix();
  }
  
  void drawCollisionBox() {
    pushMatrix();
    translate(x, y);
    rotate(radians(angle));
    noFill();
    rectMode(CORNER);
    stroke(255, 0, 0);
    rect(0, 0, w, h);
    noStroke();
    popMatrix();
  }
}
