// Untitled Raccoon Game
// By: Team Raccoon
// On: September 4, 2026

// Debug Mode
boolean debugMode = true; // TO SET FALSE WHEN PUBLISHING

// Main Variables
Player player;
AnimatedSprite idleAnimation;
AnimatedSprite runAnimation;
AnimatedSprite spriteBeforeAttack;
AnimatedSprite attackAnimation;
ArrayList<Platform> platforms = new ArrayList<Platform>();

// Change Varibales
String currentScreen = "scene1";
int jumpPower = 16;
float runSpeed = 2.15;
boolean attacking = false;

// Key Variables
boolean left = false;
boolean right = false;

// Player Image Variables
PImage[] playerSarahIdle = new PImage[4];
PImage[] playerSarahRun = new PImage[6];
PImage[] playerSarahAttack = new PImage[6];

// Other Image Varibles
PImage bgScene1_Room;
PImage key_f;

// Scene Doors
boolean playerAtDoor = false;

// - Scene 1
float doorX = 227;
float doorY = 284;
float doorW = 92;
float doorH = 132;

// Setup
void setup() {
  // Setup Screen
  fullScreen(P2D);
  surface.setSize(1280, 720);
  surface.setLocation(displayWidth/2 - width/2, displayHeight/2 - height/2);
  surface.setTitle("Untitle Racoon Game");
  surface.setResizable(false);
  frameRate(60);
  smooth();
  
  // Setup Player
  // - Idle
  for (int i = 0; i < playerSarahIdle.length; i++) playerSarahIdle[i] = loadImage("sarah/playerSarahIdle_"+i+".png");
  idleAnimation = new AnimatedSprite(playerSarahIdle, 300);
  // - Run
  for (int i = 0; i < playerSarahRun.length; i++) playerSarahRun[i] = loadImage("sarah/playerSarahRun_"+i+".png");
  runAnimation = new AnimatedSprite(playerSarahRun, 100);
  // - Attack
  for (int i = 0; i < playerSarahAttack.length; i++) playerSarahAttack[i] = loadImage("sarah/playerSarahAttack_"+i+".png");
  attackAnimation = new AnimatedSprite(playerSarahAttack, 50);

  // Setup Player Location
  PVector playerStart = new PVector(1080, 560);
  player = new Player(playerStart, new PVector(0, 0), 100, 64, 186, playerSarahIdle, 100);
  player.sprite = idleAnimation;
  
  // Setup Scene Images
  bgScene1_Room = loadImage("bg/bgScene1_Room.png");
  
  // Setup Scene Images
  key_f = loadImage("keyboard_f_outline.png");
}

void draw() {
  background(255); // Default
  // Main code starts here
  switch (currentScreen) {
    case "title":
      // Title screen with play button, keep it simple, this is a single runthrough
      break; // XXX FOR NOW
    case "scene1":
      background(bgScene1_Room);
      // Home, MC wakes up, basic intro of student life
      // Gameplay: moving character WASD
      
      // Platform
      platforms.clear();
      // - Make Platform (addPlatform(x, y, w, h, color);
      addPlatform(0, 656, 1280, 64, 0, #00FF00);
      //addPlatform(0, 333, 100, 25, 30, #00FF00); // Top angled platform, not needed
      addPlatform(89, 410, 100, 25, 35, #00FF00);
      addPlatform(154, 475, 100, 25, 30, #00FF00);
      addPlatform(240, 525, 100, 25, 30, #00FF00);
      addPlatform(340, 594, 100, 25, 30, #00FF00);
      addPlatform(600, 427, 1000, 25, 0, #00FF00);
      addOneWayPlatform(0, 427, 600, 25, 0, #00FF00);
      addWall(60, 0, 25, 720, 0, #00FF00);
      addWall(1187, 0, 25, 720, 0, #00FF00);
      addWall(389, 0, 25, 279, 0, #00FF00);
      addPlatform(65, 157, 1000, 25, 0, #00FF00);
      // - Draw Platform (only when in debug mode)
      if (debugMode) {
        for (Platform platform : platforms) {
          platform.drawPlatform();
          platform.drawCollisionBox();
        }
      }
      
      // Draw Door (only when in debug mode)
      if (debugMode) {
        fill(#00FF00);
        rectMode(CORNER);
        rect(doorX, doorY, doorW, doorH);
      }
      playerAtDoor = isPlayerAtDoor();
      if (playerAtDoor) {
        image(key_f, doorX + doorW, doorY + (doorH/4));
      }
      break; // XXX FOR NOW
    case "scene2":
      background(255);
      // While transiting, racoon steals UPass
      // Gameplay: moving character WASD
      
      // Platform
      platforms.clear();
      // - Make Platform (addPlatform(x, y, w, h, color);
      addPlatform(0, 656, 1280, 64, 0, #FFFF00);
      // - Draw Platform (only when in debug mode)
      if (debugMode) {
        for (Platform platform : platforms) {
          platform.drawPlatform();
          platform.drawCollisionBox();
        }
      }
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
      // Gameplay: Mostly moving character WASD + story wrapup
      break; // XXX FOR NOW
  }
  
  // Player
  updateMovement();
  player.update();
  if (attacking && attackAnimation.finished) {
    attacking = false;
    player.sprite = spriteBeforeAttack;
  }
  player.drawCharacter();
  player.drawCollisionBox();
}

// Speed of movement
void updateMovement() {
  PVector movement = new PVector();
  if (left) {
    movement.x -= runSpeed;
    player.facingLeft = true;
  }
  if (right) {
    movement.x += runSpeed;
    player.facingLeft = false;
  }
  player.accelerate(movement);
}

void addPlatform(float x, float y, float w, float h, float angle, color platformColor) {
  platforms.add(new Platform(x, y, w, h, angle, platformColor, false));
}

void addOneWayPlatform(float x, float y, float w, float h, float angle, color platformColor) {
  platforms.add(new Platform(x, y, w, h, angle, platformColor, true));
}

void addWall(float x, float y, float w, float h, float angle, color platformColor) {
  platforms.add(new Platform(x, y, w, h, angle, platformColor, false));
  // Not different from addPlatform, just for naming convention
}

boolean isPlayerAtDoor() {
  float playerLeft = player.position.x - player.hitboxWidth/2;
  float playerRight = player.position.x + player.hitboxWidth/2;
  float playerBottom = player.position.y + player.hitboxHeight/2;
  boolean overlapsDoor = playerRight > doorX && playerLeft < doorX + doorW && playerBottom > doorY && player.position.y - player.hitboxHeight/2 < doorY + doorH;
  boolean standingOnGround = player.grounded;
  return overlapsDoor && standingOnGround;
}

void enterDoor(String nextScreen, int x, int y) {
  currentScreen = nextScreen;
  platforms.clear();
  player.position.set(x, y);
  player.velocity.set(0, 0);
}

// On mouse press
void mousePressed() {
  // Debugging
  if (debugMode) println("Mouse pressed: " + mouseX + ", " + mouseY);
  if (!attacking) {
    attacking = true;
    spriteBeforeAttack = player.sprite;
    player.sprite = attackAnimation;
    attackAnimation.playOnce();
  }
}

// On key press
void keyPressed() {
  // Moving
  if (key == CODED) {
    if (keyCode == UP && player.grounded) player.velocity.y = -jumpPower;
    if (keyCode == LEFT) {
      left = true; 
      if (!attacking) {
        player.sprite = runAnimation;
        runAnimation.reset();
      }
    }
    if (keyCode == RIGHT) {
      right = true; 
      if (!attacking) {
        player.sprite = runAnimation;
        runAnimation.reset();
      }
    }
  }
  if (key == 'a' || key == 'A') {
    left = true;
    if (!attacking) {
      player.sprite = runAnimation;
      runAnimation.reset();
    }
  }
  if (key == 'd' || key == 'D') {
    right = true; 
    if (!attacking) {
      player.sprite = runAnimation;
      runAnimation.reset();
    }
  }
  if ((key == ' ' || key == 'w' || key == 'W') && player.grounded) player.velocity.y = -jumpPower;
  
  // Interaction
  if (key == ENTER || key == 'f' || key == 'F') {
    if (playerAtDoor) {
      enterDoor("scene2", 300, 300);
    }
  }
}

// on key release
void keyReleased() {
  // Slow Down
  if (key == CODED) {
    if (keyCode == LEFT) {
      left = false; 
      if (!attacking) {
        player.sprite = idleAnimation;
        idleAnimation.reset();
      }
    }
    if (keyCode == RIGHT) {
      right = false; 
      if (!attacking) {
        player.sprite = idleAnimation;
        idleAnimation.reset();
      }
    }
  }
  if (key == 'a' || key == 'A') {
    left = false; 
    if (!attacking) {
      player.sprite = idleAnimation;
      idleAnimation.reset();
    }
  }
  if (key == 'd' || key == 'D') {
    right = false; 
    if (!attacking) {
      player.sprite = idleAnimation;
      idleAnimation.reset();
    }
  }
}
