// Untitled Raccoon Game
// By: Team Raccoon
// On: September 4, 2026

// Imports

// Main Variables
Player player;
AnimatedSprite idleAnimation;
AnimatedSprite runAnimation;
String currentScreen = "title";
int jumpPower = 16;

// Key Variables
boolean left = false;
boolean right = false;

// Image Variables
PImage[] playerSarahIdle = new PImage[4];
PImage[] playerSarahRun = new PImage[6];

// Setup
void setup() {
  // Setup Screen
  size(1280, 720, P2D);
  surface.setTitle("Untitle Racoon Game");
  surface.setResizable(false);
  frameRate(60);
  smooth();
  
  // Setup Player Idle
  for (int i = 0; i < playerSarahIdle.length; i++) playerSarahIdle[i] = loadImage("sarah/playerSarahIdle_"+i+".png");
  idleAnimation = new AnimatedSprite(playerSarahIdle, 300);
  
  // Setup Player Run
  for (int i = 0; i < playerSarahRun.length; i++) playerSarahRun[i] = loadImage("sarah/playerSarahRun_"+i+".png");
  runAnimation = new AnimatedSprite(playerSarahRun, 100);

  // Setup Player Location
  PVector playerStart = new PVector(300, 300);
  player = new Player(playerStart, new PVector(0, 0), 100, 128, 128, playerSarahIdle, 100);
  player.sprite = idleAnimation;
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
  if (left) {
    movement.x -= 1.5;
    player.facingLeft = true;
  }
  if (right) {
    movement.x += 1.5;
    player.facingLeft = false;
  }
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
    if (keyCode == LEFT) {
      left = true; 
      player.sprite = runAnimation; 
      runAnimation.reset();
    }
    if (keyCode == RIGHT) {
      right = true; 
      player.sprite = runAnimation; 
      runAnimation.reset();
    }
  }
  if (key == 'a' || key == 'A') {
    left = true;
    player.sprite = runAnimation; 
    runAnimation.reset();
  }
  if (key == 'd' || key == 'D') {
    right = true; 
    player.sprite = runAnimation; 
    runAnimation.reset();
  }
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
    if (keyCode == LEFT) {
      left = false; 
      player.sprite = idleAnimation; 
      idleAnimation.reset();
    }
    if (keyCode == RIGHT) {
      right = false; 
      player.sprite = idleAnimation; 
      idleAnimation.reset();
    }
  }
  if (key == 'a' || key == 'A') {
    left = false; 
    player.sprite = idleAnimation; 
    idleAnimation.reset();
  }
  if (key == 'd' || key == 'D') {
    right = false; 
    player.sprite = idleAnimation; 
    idleAnimation.reset();
  }
}
