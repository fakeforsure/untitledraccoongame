// Untitled Racoon Game
// By: Team Racoon
// On: September 4, 2026

// Imports

// Main Variables
Player player;
String currentScreen = "title";
int jumpPower = 16;

// Key Variables
boolean left = false;
boolean right = false;

// Image Variables
PImage playerSarahIdle, playerSarahRun;

// Setup
void setup() {
  // Setup Screen
  size(1280, 720, P2D);
  surface.setTitle("Untitle Racoon Game");
  surface.setResizable(false);
  frameRate(60);
  noSmooth();
  
  // Setup Main Images
  playerSarahIdle = loadImage("playerSarahIdle.png");
  playerSarahRun = loadImage("playerSarahRun.png");
  
  // Setup Player
  PVector playerStart = new PVector(300, 300);
  int playerFrameTime = 100;
  player = new Player(playerStart, new PVector(0, 0), 100, 128, 128, playerSarahIdle, 64, 64, 4, 4, playerFrameTime);
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
      break; // XXX FOR NOW
    case "scene1":
      // Home, MC wakes up, basic intro of student life
      // Gameplay: moving character WASD
      break; // XXX FOR NOW
    case "scene2":
      // While transiting, racoon steals UPass
      // Gameplay: moving character WASD
      break; // XXX FOR NOW
    case "scene3":
      // Student chases racoon into sewer
      // Gameplay: platformer, defeat racoon, get back UPass
    case "scene4":
      // Student finally arrives on campus, lost, ask student for direction
      // Gameplay: moving character WASD
      break; // XXX FOR NOW
    case "scene5":
      // Student needs to get to class on time
      // Gameplay: platformer (copy pasted), to class
      break; // XXX FOR NOW
    case "scene6":
      // Arrive at classroom in AQ, but the racoon is there
      // Gameplay: ^Mostly moving character WASD + story wrapup
      break; // XXX FOR NOW
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
    if (keyCode == UP && player.position.y >= height - 64) player.velocity.y = -jumpPower;
    if (keyCode == LEFT) left = true;
    if (keyCode == RIGHT) right = true;
  }
  if (key == 'a' || key == 'A') left = true;
  if (key == 'd' || key == 'D') right = true;
  if ((key == ' ' || key == 'w' || key == 'W') && player.position.y >= height - 64) player.velocity.y = -jumpPower;
  
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
