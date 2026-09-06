// Untitled Raccoon Game
// By: Team Raccoon
// On: September 4, 2026

// Debug Mode
boolean debugMode = true; // TO SET FALSE WHEN PUBLISHING

// Main Variables
Player player;

// - Animation
AnimatedSprite idleSarahAnimation;
AnimatedSprite jumpSarahAnimation;
AnimatedSprite runSarahAnimation;
AnimatedSprite attackSarahAnimation;
AnimatedSprite spriteBeforeAttacking; // For Sarah only
ArrayList<Platform> platforms = new ArrayList<Platform>();
AnimatedSprite fAnimation; // F key
AnimatedSprite downAnimation; // Arrow Down key
AnimatedSprite talkSarahAnimation;

// Change Varibales
String currentScreen = "scene1";
int jumpPower = 16;
float runSpeed = 2.15;
boolean attacking = false;
boolean jumping = false;

// Dialogue Variables
int currentDialogue = 1;
int lastDialogue = 0;
int dialogueStartTime = 0;
int charsPerSecond = 35;


// Key Variables
boolean left = false;
boolean right = false;

// Player Image Variables
PImage[] playerSarahIdle = new PImage[4];
PImage[] playerSarahJump = new PImage[4];
PImage[] playerSarahRun = new PImage[6];
PImage[] playerSarahAttack = new PImage[6];

// Talk Image Variables
int talkSarahTotalFrames = 2;
PImage[] talkSarahFrames = new PImage[talkSarahTotalFrames];
int talkSarahCurrentFrame = 0;
PImage talkSarah, talkSarahMad;

// Other Image Varibles
PImage bgScene1_Room;
PImage bgScene2_BusOut, bgScene2_BusIn, bgScene2_BusStop;
PImage[] key_f = new PImage[2];
PImage[] key_down = new PImage[2];

// Text Variables
PFont font;
int currentText = 0;

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
  
  // Setup Font
  font = createFont("Determination.ttf", 128);
  
  // Setup Player
  // - Idle
  for (int i = 0; i < playerSarahIdle.length; i++) playerSarahIdle[i] = loadImage("sarah/playerSarahIdle_"+i+".png");
  idleSarahAnimation = new AnimatedSprite(playerSarahIdle, 300);
  // - Jump
  for (int i = 0; i < playerSarahJump.length; i++) playerSarahJump[i] = loadImage("sarah/playerSarahJump_"+i+".png");
  jumpSarahAnimation = new AnimatedSprite(playerSarahJump, 150);
  // - Run
  for (int i = 0; i < playerSarahRun.length; i++) playerSarahRun[i] = loadImage("sarah/playerSarahRun_"+i+".png");
  runSarahAnimation = new AnimatedSprite(playerSarahRun, 100);
  // - Attack
  for (int i = 0; i < playerSarahAttack.length; i++) playerSarahAttack[i] = loadImage("sarah/playerSarahAttack_"+i+".png");
  attackSarahAnimation = new AnimatedSprite(playerSarahAttack, 50);

  // Setup Talk Images
  // - Sarah
  for (int i = 0; i < talkSarahTotalFrames; i++) {
    talkSarahFrames[i] = loadImage("sarah/talkSarah_" + i + ".png");
  }
  talkSarah = talkSarahFrames[0];
  talkSarahMad = loadImage("sarah/talkSarah_Mad.png");

  // Setup Player Location
  PVector playerStart = new PVector(1080, 560);
  player = new Player(playerStart, new PVector(0, 0), 100, 64, 186, playerSarahIdle, 100);
  player.sprite = idleSarahAnimation;
  
  // Setup Scene Images
  bgScene1_Room = loadImage("bg/bgScene1_Room.png");
  bgScene2_BusOut = loadImage("bg/bgScene2_BusOut.png");
  bgScene2_BusIn = loadImage("bg/bgScene2_BusIn.png");
  bgScene2_BusStop = loadImage("bg/bgScene2_BusStop.png");
  
  // Keyboard Images
  // - F
  for (int i = 0; i < key_f.length; i++) key_f[i] = loadImage("keyboard_f_"+i+".png");
  fAnimation = new AnimatedSprite(key_f, 300);
  // - Arrow Down
  for (int i = 0; i < key_down.length; i++) key_down[i] = loadImage("keyboard_arrow_down_"+i+".png");
  downAnimation = new AnimatedSprite(key_down, 300);
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
      addPlatform(600, 427, 160, 25, 0, #00FF00);
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
        fAnimation.display(doorX + doorW + 40, doorY + (doorH/2), false, 64);
        fAnimation.update();
      }
      break; // XXX FOR NOW
    case "scene2":
      background(bgScene2_BusStop);
      // At bus stop, racoon steals UPass, so player takes the bus, fade to black
      // Gameplay: moving character WASD
      
      // Platform
      platforms.clear();
      // - Make Platform (addPlatform(x, y, w, h, color);
      addPlatform(0, 450, 1280, 64, 0, #FFFF00);
      // - Draw Platform (only when in debug mode)
      if (debugMode) {
        for (Platform platform : platforms) {
          platform.drawPlatform();
          platform.drawCollisionBox();
        }
      }
      break; // XXX FOR NOW
    case "scene3":
      // Black fades out, arrive at Skytrain station by bus, student chases racoon into sewer
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
  boolean wasGrounded = player.grounded; // Don't move, must be before player update
  player.update();
  if (attacking && attackSarahAnimation.finished) {
    attacking = false;
    player.sprite = spriteBeforeAttacking;
  }
  if (!wasGrounded && player.grounded) {
    jumping = false;
    if (!attacking) {
      if (left || right) {
        player.sprite = runSarahAnimation;
        runSarahAnimation.reset();
      } else {
        player.sprite = idleSarahAnimation;
        idleSarahAnimation.reset();
      }
    }
  }
  player.drawCharacter();
  
  if (debugMode) {
    player.drawCollisionBox();
  }
  
  // Constant Sarah Gif
  if (frameCount % 12 == 0) {
    talkSarahCurrentFrame = (talkSarahCurrentFrame + 1) % talkSarahTotalFrames;
  }
  talkSarah = talkSarahFrames[talkSarahCurrentFrame];
  
  // DIALOGUE IS HERE, NOTHING ELSE SHOULD BE UNDERNEATH!!!
  dialogue(); // End!
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

void startJump() {
  if (!player.grounded) {
    return;
  }
  player.velocity.y = -jumpPower;
  jumping = true;
  player.sprite = jumpSarahAnimation;
  jumpSarahAnimation.reset();
  jumpSarahAnimation.playOnce();
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
  float playerTop = player.position.y - player.hitboxHeight/2;
  float playerBottom = player.position.y + player.hitboxHeight/2;
  boolean overlapsX = playerRight > doorX && playerLeft < doorX + doorW;
  boolean overlapsY = playerBottom > doorY && playerTop < doorY + doorH;
  boolean standingOnGround = player.grounded;
  return overlapsX && overlapsY && standingOnGround;
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
    spriteBeforeAttacking = player.sprite;
    player.sprite = attackSarahAnimation;
    attackSarahAnimation.reset();
    attackSarahAnimation.playOnce();
  }
}

// On key press
void keyPressed() {
  // Moving
  if (key == CODED) {
    if (keyCode == UP) startJump();
    if (keyCode == DOWN) currentDialogue += 1;
    if (keyCode == LEFT) {
      left = true; 
      if (!attacking && !jumping) {
        player.sprite = runSarahAnimation;
        runSarahAnimation.reset();
      }
    }
    if (keyCode == RIGHT) {
      right = true; 
      if (!attacking && !jumping) {
        player.sprite = runSarahAnimation;
        runSarahAnimation.reset();
      }
    }
  }
  if (key == 'a' || key == 'A') {
    left = true;
    if (!attacking && !jumping) {
      player.sprite = runSarahAnimation;
      runSarahAnimation.reset();
    }
  }
  if (key == 'd' || key == 'D') {
    right = true; 
    if (!attacking && !jumping) {
      player.sprite = runSarahAnimation;
      runSarahAnimation.reset();
    }
  }
  if (key == ' ' || key == 'w' || key == 'W') startJump();
    
  // Interaction
  if (key == ENTER || key == 'f' || key == 'F') {
    if (playerAtDoor) {
      enterDoor("scene2", 100, 380);
      playerAtDoor = false;
    }
  }
}

// On key release
void keyReleased() {
  // Slow Down
  if (key == CODED) {
    if (keyCode == LEFT) {
      left = false; 
      if (!attacking && !jumping) {
        player.sprite = idleSarahAnimation;
        idleSarahAnimation.reset();
      }
    }
    if (keyCode == RIGHT) {
      right = false; 
      if (!attacking && !jumping) {
        player.sprite = idleSarahAnimation;
        idleSarahAnimation.reset();
      }
    }
  }
  if (key == 'a' || key == 'A') {
    left = false; 
    if (!attacking && !jumping) {
      player.sprite = idleSarahAnimation;
      idleSarahAnimation.reset();
    }
  }
  if (key == 'd' || key == 'D') {
    right = false; 
    if (!attacking && !jumping) {
      player.sprite = idleSarahAnimation;
      idleSarahAnimation.reset();
    }
  }
}
