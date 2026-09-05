// Untitled Racoon Game
// By: Team Racoon
// On: September 4, 2026

// Imports

// Main Variables
Player player;
String currentScreen = "title";

// Key Variables
boolean left = false;
boolean right = false;

// Image Variables
PImage playerTest;

// Setup
void setup() {
  // Setup Screen
  size(1280, 720, P2D);
  surface.setTitle("Untitle Racoon Game");
  surface.setResizable(false);
  frameRate(60);
  smooth();
  
  // Setup Main Images
  playerTest = loadImage("playerTest.png");
  if (playerTest != null) println("Image loaded: " + playerTest.width + " x " + playerTest.height);
  
  // Setup Player
  PVector playerStart = new PVector(300, 300);
  int[] playerTiming = {1000, 1000, 1000, 1000};
  player = new Player(playerStart, new PVector(0, 0), 100, 64, 64, playerTest, 64, 64, 4, 4, playerTiming);
}

void draw() {
  background(255);

  // Testing sprite anim
  updateMovement();
  player.update();
  player.drawCharacter();
   
  // Main code starts here
  switch (currentScreen) {
    case "title":
      // Title screen with play button, keep it simple, this is a single runthrough
    case "scene1":
      // Home, MC wakes up, basic intro of student life
      // Gameplay: moving character WASD
    case "scene2":
      // While transiting, racoon steals UPass
      // Gameplay: moving character WASD
    case "scene3":
      // Student chases racoon into sewer
      // Gameplay: platformer, defeat racoon, get back UPass
    case "scene4":
      // Student finally arrives on campus, lost, ask student for direction
      // Gameplay: moving character WASD
    case "scene5":
      // Student needs to get to class on time
      // Gameplay: platformer (copy pasted), to class
    case "scene6":
      // Arrive at classroom in AQ, but the racoon is there
      // Gameplay: ^Mostly moving character WASD + story wrapup
  }
}

// Speed of movement
void updateMovement() {
  PVector movement = new PVector();
  if (left) movement.x -= 1.5;
  if (right) movement.x += 1.5;
  player.accelerate(movement);
}

// On mouse press
void mousePressed() {
  // Debugging
  println("Mouse pressed: " + mouseX + ", " + mouseY);
}

// On key press
void keyPressed() {
  // Moving
  if (key == CODED) {
    if (keyCode == UP && player.position.y >= height - 32) player.velocity.y = -15;
    if (keyCode == LEFT) left = true;
    if (keyCode == RIGHT) right = true;
  }
  if (key == 'a' || key == 'A') left = true;
  if (key == 'd' || key == 'D') right = true;
  if ((key == ' ' || key == 'w' || key == 'W') && player.position.y >= height - 32) player.velocity.y = -15;
  
  // Dash on Shift
  if (key == CODED && keyCode == SHIFT && !player.isDashing) {
    player.isDashing = true;
    player.dashTime = 0;
    PVector dir = new PVector(0, 0);
    if (left) dir.x -= 1;
    if (right) dir.x += 1;
    if (dir.mag() > 0) {
      dir.normalize();
      player.dashDirection = dir;
    } 
    else {
      player.dashDirection = new PVector(0, -1);
    }
  }
}

// on key release
void keyReleased() {
  // Slow Down
  if (key == CODED) {
    if (keyCode == LEFT) left = false;
    if (keyCode == RIGHT) right = false;
  }
  if (key == 'a' || key == 'A') left = false;
  if (key == 'd' || key == 'D') right = false;
}
