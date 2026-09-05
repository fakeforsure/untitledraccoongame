// Untitled Raccoon Game - AnimatedSprite
// By: Team Raccoon
// On: September 4, 2026

class AnimatedSprite {
  PImage[] frames;

  int currentFrame = 0;
  int frameTime;
  int lastFrameChange;
  
  boolean looping = true;
  boolean finished = false;

  // Constructor
  AnimatedSprite(PImage[] frames, int frameTime) {
    this.frames = frames;
    this.frameTime = frameTime;
    this.lastFrameChange = millis();
  }

  void update() {
    if (finished) return;
    int currentTime = millis();
    if (currentTime - lastFrameChange >= frameTime) {
      if (currentFrame < frames.length - 1) currentFrame++;
      else if (looping) currentFrame = 0; 
      else finished = true;
      lastFrameChange = currentTime;
    }
  }
 
  void reset() {
    currentFrame = 0;
    lastFrameChange = millis();
    finished = false;
  }
  
  void playOnce() {
    looping = false;
    finished = false;
    reset();
  }

  void display(float x, float y, boolean facingLeft, int size) {
    // Default size should be 192
    imageMode(CENTER);
    if (facingLeft) {
      pushMatrix();
      translate(round(x), round(y));
      scale(-1, 1);
      image(frames[currentFrame], 0, 0, size, size);
      popMatrix();
    }
    else image(frames[currentFrame], round(x), round(y), size, size);
    imageMode(CORNER);
  }
}
