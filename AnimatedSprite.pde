// Untitled Racoon Game - AnimatedSprite
// By: Team Racoon
// On: September 4, 2026

class AnimatedSprite {
  PImage sheet;
  int frameWidth;
  int frameHeight;
  int frameCount;
  int columns;
  int currentFrame = 0;
  int lastFrameChange;
  int[] frameDurations;

  AnimatedSprite( PImage sheet, int frameWidth, int frameHeight, int frameCount, int columns, int[] frameDurations) {
    this.sheet = sheet;
    this.frameWidth = frameWidth;
    this.frameHeight = frameHeight;
    this.frameCount = frameCount;
    this.columns = columns;
    this.frameDurations = frameDurations;
    lastFrameChange = millis();
  }

  void update() {
    if (millis() - lastFrameChange >= frameDurations[currentFrame]) {
      currentFrame++;
      lastFrameChange = millis();
      if (currentFrame >= frameCount) {
        currentFrame = 0;
      }
    }
  }

  void display(float x, float y) {
    int column = currentFrame % columns;
    int row = currentFrame / columns;
    int sourceX = column * frameWidth;
    int sourceY = row * frameHeight;
    imageMode(CENTER);
    image(sheet, x, y, frameWidth, frameHeight, sourceX, sourceY, frameWidth, frameHeight);
    imageMode(CORNER);
  }
}
