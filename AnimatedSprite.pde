// Untitled Racoon Game - AnimatedSprite
// By: Team Racoon
// On: September 4, 2026

class AnimatedSprite {
  PImage[] frames;

  int currentFrame = 0;
  int frameTime;
  int lastFrameChange;

  AnimatedSprite(PImage[] frames, int frameTime) {
    this.frames = frames;
    this.frameTime = frameTime;
    this.lastFrameChange = millis();
  }

  void update() {
    int currentTime = millis();
    if (currentTime - lastFrameChange >= frameTime) {
      currentFrame++;
      if (currentFrame >= frames.length) currentFrame = 0;
      lastFrameChange += frameTime;
    }
  }
  
  void reset() {
    currentFrame = 0;
    lastFrameChange = millis();
  }

  void display(float x, float y, boolean facingLeft) {
    imageMode(CENTER);
    if (facingLeft) {
      pushMatrix();
      translate(round(x), round(y));
      scale(-1, 1);
      image( frames[currentFrame], 0, 0, 128, 128);
      popMatrix();
    }
    else image( frames[currentFrame], round(x), round(y), 128, 128);
    imageMode(CORNER);
  }
}
