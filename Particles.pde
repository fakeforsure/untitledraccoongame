// Untitled Raccoon Game - Particles
// By: Team Raccoon
// On: September 6, 2026

// Particle Class
class Particle {
  PVector pos;
  PVector vel;
  float size;
  float alpha;

  // Constructor
  Particle(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(random(-0.2, 0.2), random(-1, -0.1));
    size = random(2, 10);
    alpha = 255;
  }

  void update() {
    pos.add(vel);
    alpha -= 0.5;
  }

  void display() {
    noStroke();
    fill(255, alpha);
    ellipse(pos.x, pos.y, size, size);
  }

  boolean isDead() {
    return alpha <= 0;
  }
}
