// Untitled Raccoon Game
// By: Team Raccoon
// On: September 5, 2026

// *** HOW PLATFORMS WORK **
// In draw(), add this:
// platforms.clear();
// Then, add your platforms using this command:
// addPlatform(0, 656, 1280, 64, #FF0000);
// addPlatform(200, 570, 250, 30, #FF0000);
// addPlatform(550, 520, 40, 136, #FF0000);
// addPlatform(700, 420, 250, 30, #FF0000);
// addPlatform(1050, 300, 40, 356, #FF0000);
// Those are examples

class Platform {
  float x, y, w, h;
  color platformColor;

  // Constructor
  Platform(float x, float y, float w, float h, color platformColor) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.platformColor = platformColor;
  }

  void drawPlatform() {
    rectMode(CORNER);
    fill(platformColor);
    rect(x, y, w, h);
  }
}
