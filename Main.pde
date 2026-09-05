// Untitled Racoon Game
// By: Team Racoon
// On: September 4, 2026

// Imports

// Main Variables
String currentScreen = "title";

// Setup
void setup() {
  // Setup Screen
  size(1280, 720, P2D);
  surface.setTitle("Untitle Racoon Game");
  surface.setResizable(false);
  frameRate(60);
  smooth();
}

void draw() {
  // Background
  background(255);
  // Main code starts here
  switch(currentScreen) {
    case "title":
      // Title screen with play button, keep it simple, this is a single runthrough
    case "intro":
      // Intro cutscene
    case "level1":
      // Train chase platformer
    case "level2":
      // Sewer boss battle platformer
      // I think that's all for now, don't wanna complicate ourselves too much rn
  }
}

// On mouse press
void mousePressed() {
  // Debugging
  println("Mouse pressed: " + mouseX + ", " + mouseY);
}
