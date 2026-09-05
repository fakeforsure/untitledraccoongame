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
  int frameTime;

  // Constructor
  AnimatedSprite( PImage sheet, int frameWidth, int frameHeight, int frameCount, int columns, int frameTime) {
    this.sheet = sheet;
    this.frameWidth = frameWidth;
    this.frameHeight = frameHeight;
    this.frameCount = frameCount;
    this.columns = columns;
    this.frameTime = frameTime;
    lastFrameChange = millis();
  }

  void update() {
    int currentTime = millis();
    if (currentTime - lastFrameChange >= frameTime) {
      currentFrame++;
      if (currentFrame >= frameCount) currentFrame = 0;
      lastFrameChange += frameTime;
    }
  }

  void display(float x, float y) {
    int column = currentFrame % columns;
    int row = currentFrame / columns;
    int sourceX = column * frameWidth;
    int sourceY = row * frameHeight;
    imageMode(CENTER);
    image(sheet, round(x), round(y), frameWidth*2, frameHeight*2, sourceX, sourceY, frameWidth, frameHeight);
    imageMode(CORNER);
  }
}
