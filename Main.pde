// Untitled Raccoon Game
// By: Team Raccoon
// On: September 4, 2026

// Hello judges. Please note, we are not like the other youngsters oh no no no. 
// As you may have noticed... We coded everything by hand. No pre-built game engine!
// We hope you are swayed by our narrative, one of the themes of this game jam!
// Anymeow, in this game, you play as a brand-new SFU student who hates her life.
// Oh but watch out for the raccoons, they tend to love to steal your UPass~!!

// Imports
import java.util.HashMap;
import processing.sound.*;

// Debug Mode
final boolean debugMode = false; // TO SET FALSE WHEN PUBLISHING

// Main Variables
Player player;
BasicEnemy richard;
ArrayList<Platform> platforms = new ArrayList<Platform>();
ArrayList<Particle> particles = new ArrayList<Particle>();
HashMap<String, PImage> portraits = new HashMap<String, PImage>();
Table table;

// Sound Variables
// - Sarah
SoundFile sfxJump;
// - Music
SoundFile musMercury;
// - General
SoundFile sfxClick, sfxExplosion, sfxInteract, sfxKingType, sfxStep, sfxType;
// - Enemies
SoundFile sfxBombThrow, sfxKingDie, sfxKingGroan, sfxKingLaugh, sfxKingOof;
SoundFile sfxRichardDie, sfxRichardLaugh, sfxRichardOof;

// - Animation
// -- Sarah
AnimatedSprite idleSarahAnimation;
AnimatedSprite jumpSarahAnimation;
AnimatedSprite runSarahAnimation;
AnimatedSprite attackSarahAnimation;
AnimatedSprite spriteBeforeAttacking; // For Sarah only
AnimatedSprite talkSarahAnimation;
// -- Richard
AnimatedSprite idleRichardAnimation;
AnimatedSprite runRichardAnimation;
// -- Misc
AnimatedSprite fAnimation; // F key
AnimatedSprite downAnimation; // Arrow Down key
AnimatedSprite projectileBombAnimation; // Da bomb

// Change Varibales
String currentScreen = "title";
int jumpPower = 16;
float runSpeed = 2.15;
boolean attacking = false;
boolean jumping = false;
boolean running = false;
int sfxStepTime = 0;
int bossMusic = 0;

// Dialogue Variables
int currentDialogue = 0;
int lastDialogue = -1;
int dialogueStartTime = 0;
int charsPerSecond = 35;
boolean dialogueActive = true;

// Key Variables
boolean left = false;
boolean right = false;

// Player Image Variables
PImage[] playerSarahIdle = new PImage[4];
PImage[] playerSarahJump = new PImage[4];
PImage[] playerSarahRun = new PImage[6];
PImage[] playerSarahAttack = new PImage[6];
PImage[] playerRichardIdle = new PImage[2];
PImage[] playerRichardRun = new PImage[4];

// Talk Image Variables
// - Sarah
int talkSarahTotalFrames = 2;
PImage[] talkSarahFrames = new PImage[talkSarahTotalFrames];
int talkSarahCurrentFrame = 0;
PImage talkSarah, talkSarahMad;
// - Others
PImage talkRichard, talkRichardMad;
PImage kingFatHead, kingFatBellay, kingFatArms; // Just his head talks, thankfully...

// Other Image Varibles
PImage tree, upass;
PImage bgScene1_Room;
PImage bgScene2_BusOut, bgScene2_BusIn, bgScene2_BusStop;
PImage bgScene3_City, bgScene3_Skytrain, bgScene3_Throneroom;
PImage bgScene3_SewerEntrance, bgScene3_SewerCave;
PImage bgScene4_BusLoop;
PImage bgScene5_AQEntrance, bgScene5_UnderHackathon, bgScene5_WMC, bgScene5_Concourse;
PImage bgScene6_LectureHall;
PImage[] projectileBomb = new PImage[2];
PImage[] key_f = new PImage[2];
PImage[] key_down = new PImage[2];

// Text Variables
PFont font;
int currentText = 0;

// Scene Doors
boolean playerAtDoor = false;
// - Scene 1
final float doorX = 227;
final float doorY = 284;
final float doorW = 92;
final float doorH = 132;
// - Scene 2
PImage bus;
float busX;
float busY;
float busTargetX;
float busSpeed = 8;
int busState = 0;
float busSceneOpacity = 255;
float busFadeSpeed = 5;
int raccoonMess = 0; 

// Setup
void setup() {
  // Setup Screen
  size(1280, 720, P2D);
  surface.setLocation(displayWidth/2 - width/2, displayHeight/2 - height/2);
  surface.setTitle("Untitle Racoon Game");
  surface.setResizable(false);
  frameRate(60);
  smooth();
  
  // Setup Text Stuff
  font = createFont("Determination.ttf", 128);
  table = loadTable("dialogue.csv", "header");
  if (debugMode) println(table.getRowCount() + " total rows in table");
  for (TableRow row : table.rows()) {
    String voice_id = row.getString("voice_id");
    String image = row.getString("image");
    String name = row.getString("name");
    String body = row.getString("body");
    if (debugMode) println(name + " says " + body + " with an image of " + image + " and Voice ID of " + voice_id);
  }
  
  // Setup Player
  // - Sarah
  // -- Idle
  for (int i = 0; i < playerSarahIdle.length; i++) playerSarahIdle[i] = loadImage("sarah/playerSarahIdle_"+i+".png");
  idleSarahAnimation = new AnimatedSprite(playerSarahIdle, 300);
  // -- Jump
  for (int i = 0; i < playerSarahJump.length; i++) playerSarahJump[i] = loadImage("sarah/playerSarahJump_"+i+".png");
  jumpSarahAnimation = new AnimatedSprite(playerSarahJump, 150);
  // -- Run
  for (int i = 0; i < playerSarahRun.length; i++) playerSarahRun[i] = loadImage("sarah/playerSarahRun_"+i+".png");
  runSarahAnimation = new AnimatedSprite(playerSarahRun, 100);
  // -- Attack
  for (int i = 0; i < playerSarahAttack.length; i++) playerSarahAttack[i] = loadImage("sarah/playerSarahAttack_"+i+".png");
  attackSarahAnimation = new AnimatedSprite(playerSarahAttack, 50);
  // - Richard
  // -- Idle
  for (int i = 0; i < playerRichardIdle.length; i++) playerRichardIdle[i] = loadImage("richard/playerRichardIdle_"+i+".png");
  idleRichardAnimation = new AnimatedSprite(playerRichardIdle, 300);
  // -- Run
  for (int i = 0; i < playerRichardRun.length; i++) playerRichardRun[i] = loadImage("richard/playerRichardRun_"+i+".png");
  runRichardAnimation = new AnimatedSprite(playerRichardRun, 100);
  
  // Setup Talk Images
  // - Sarah
  for (int i = 0; i < talkSarahTotalFrames; i++) {
    talkSarahFrames[i] = loadImage("sarah/talkSarah_" + i + ".png");
  }
  talkSarah = talkSarahFrames[0];
  talkSarahMad = loadImage("sarah/talkSarah_Mad.png");
  portraits.put("talkSarah", talkSarah);
  portraits.put("talkSarahMad", talkSarahMad);
  // - Richard
  talkRichard = loadImage("richard/talkRichard.png");
  talkRichardMad = loadImage("richard/talkRichard_Mad.png");
  // - King Fat
  kingFatHead = loadImage("kingfat/King_fatty_fat_head.png");
  kingFatBellay = loadImage("kingfat/King_fatty_fat_bellay.png");
  kingFatArms = loadImage("kingfat/King_fatty_fat_arms.png");

  // Setup Player Location
  // - Sarah
  PVector playerStart = new PVector(1080, 560);
  player = new Player(playerStart, new PVector(0, 0), 100, 64, 186, playerSarahIdle, 100);
  player.sprite = idleSarahAnimation;
  // - Richard
  richard = new BasicEnemy(new PVector(400, 350), new PVector(0, 0), 10, 100, 100);
  
  // Setup Scene Images
  tree = loadImage("bg/evil_tree_of_pure_evil_mueheheh.png");
  upass = loadImage("projectiles/upass.png"); // Projectile cuz it gets thrown to the player at the end
  bgScene1_Room = loadImage("bg/bgScene1_Room.png");
  bgScene2_BusOut = loadImage("bg/bgScene2_BusOut.png");
  bgScene2_BusIn = loadImage("bg/bgScene2_BusIn.png");
  bgScene2_BusStop = loadImage("bg/bgScene2_BusStop.png");
  bgScene3_City = loadImage("bg/bgScene3_City.png");
  bgScene3_Skytrain = loadImage("bg/bgScene3_Skytrain.png");
  bgScene3_Throneroom = loadImage("bg/bgScene3_Throneroom.png");
  bgScene3_SewerEntrance = loadImage("bg/bgScene3_sewerenterence.png");
  bgScene3_SewerCave = loadImage("bg/bgScene3_City.png");
  bgScene4_BusLoop = loadImage("bg/bgScene4_BusLoop.png");
  bgScene5_AQEntrance = loadImage("bg/bgScene5_AQEntrance.png");
  bgScene5_Concourse = loadImage("bg/bgScene5_Concourse.png");
  bgScene5_UnderHackathon = loadImage("bg/bgScene5_UnderHackathon.png");
  bgScene5_WMC = loadImage("bg/bgScene5_WMC.png");
  bgScene6_LectureHall = loadImage("bg/bgScene6_lecturehall.png");
  // - Bus
  bus = bgScene2_BusOut;
  busX = -800; 
  busY = 300;
  busTargetX = 450; 
  
  // Setup Projectiles Images
  for (int i = 0; i < projectileBomb.length; i++) projectileBomb[i] = loadImage("projectiles/bomb_"+i+".png");
  projectileBombAnimation = new AnimatedSprite(projectileBomb, 100);
  
  // Setup Keyboard Images
  // - F
  for (int i = 0; i < key_f.length; i++) key_f[i] = loadImage("key/keyboard_f_"+i+".png");
  fAnimation = new AnimatedSprite(key_f, 300);
  // - Arrow Down
  for (int i = 0; i < key_down.length; i++) key_down[i] = loadImage("key/keyboard_arrow_down_"+i+".png");
  downAnimation = new AnimatedSprite(key_down, 300);
  
  // Setup Sound
  sfxJump = new SoundFile(this, "sfx/Sarah/Sarah Jump.wav");
  musMercury = new SoundFile(this, "sfx/Music/Mercury.mp3");
  musMercury.amp(0.5);
  sfxClick = new SoundFile(this, "sfx/General/Click.mp3");
  sfxExplosion = new SoundFile(this, "sfx/General/Explosion.mp3");
  sfxInteract = new SoundFile(this, "sfx/General/interact.wav");
  sfxKingType = new SoundFile(this, "sfx/General/King Typewriter.wav");
  sfxStep = new SoundFile(this, "sfx/General/Stepping.wav");
  sfxType = new SoundFile(this, "sfx/General/Typewriter.mp3");
  sfxBombThrow = new SoundFile(this, "sfx/Enemies/Bomb Throw.wav");
  sfxKingDie = new SoundFile(this, "sfx/Enemies/King Die.wav");
  sfxKingGroan = new SoundFile(this, "sfx/Enemies/King groan.wav");
  sfxKingLaugh = new SoundFile(this, "sfx/Enemies/King Laugh.wav");
  sfxKingOof = new SoundFile(this, "sfx/Enemies/King oof.wav");
  sfxRichardDie = new SoundFile(this, "sfx/Enemies/Richard Die.wav");
  sfxRichardLaugh = new SoundFile(this, "sfx/Enemies/Richard Laugh.wav");
  sfxRichardOof = new SoundFile(this, "sfx/Enemies/Richard oof.wav");
}

void draw() {
  background(255); // Default
  // Main code starts here
  switch (currentScreen) {
    case "title":
      background(bgScene5_UnderHackathon);
      // Title screen with play button, keep it simple, this is a single runthrough

      // Title
      pushMatrix();
      fill(255);
      // Particles
      if (frameCount % 3 == 0) {
        particles.add(new Particle(random(width), height));
      }
      for (int i = particles.size() - 1; i >= 0; i--) {
        Particle p = particles.get(i);
        p.update();
        p.display();
        if (p.isDead()) {
          particles.remove(i);
        }
      }
      
      // Text
      fill(255);
      textFont(font);
      textSize(72);
      text("Untitled Raccoon Game", 60, 510);
      fill(200);
      textSize(32);
      text("click anywhere to start", 60, 550);
      popMatrix();
      
      // Platform
      platforms.clear();
      // - Make Platform (addPlatform(x, y, w, h, color);
      addPlatform(0, 565, 1280, 64, 0, #8D00FF);
      // - Draw Platform (only when in debug mode)
      if (debugMode) {
        for (Platform platform : platforms) {
          platform.drawPlatform();
          platform.drawCollisionBox();
        }
      }
      
      // Player (always at bottom)
      playerMove();
      break;
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
      
      // Player (always at bottom)
      playerMove();
      break;
    case "scene2":
      background(0);
      if (busState != 2) image(bgScene2_BusStop, 0, 0);
      //else image(bgScene3_Skytrain, 0, 0);
      // At bus stop, racoon steals UPass, so player takes the bus, fade to black
      // Gameplay: moving character WASD
  
       // Platform
      platforms.clear();
      // - Make Platform (addPlatform(x, y, w, h, color);
      addPlatform(-100, 460, 1480, 100, 0, #FFFF00);
      // - Draw Platform (only when in debug mode)
      if (debugMode) {
        fill(#00FF00);
        rectMode(CORNER);
        rect(busX, busY, bus.width, bus.height);
        for (Platform platform : platforms) {
          platform.drawPlatform();
          platform.drawCollisionBox();
        }
      }
      
      // Bus
      if (busState < 3) {
        tint(255, 255); 
        image(bgScene2_BusStop, 0, 0);
      } else if (busState == 3) {
        tint(255, busSceneOpacity); 
        image(bgScene3_Skytrain, 0, 0);
        currentScreen = "scene3";
        dialogueActive = false;
      }
      if (busState == 0) {
        if (busX < busTargetX) {
          busX += busSpeed;
        } else {
          busX = busTargetX;
          busState = 1;
        }
      }
      if (busState == 1) {
        fAnimation.display(busTargetX+bus.width/2, busY-35, false, 64);
        fAnimation.update();
      }
      if (busState == 2) {
        busX += busSpeed;
        busSceneOpacity -= busFadeSpeed;
        if (busSceneOpacity <= 0) {
          busSceneOpacity = 0;
          busState = 3;
        }
      }
      if (busState == 3) {
        busSceneOpacity += busFadeSpeed;
        if (busSceneOpacity >= 255) {
          busSceneOpacity = 255;
        }
      }
      if (busState < 3) {
        tint(255, busSceneOpacity); 
        image(bus, busX, busY);
      }
      noTint(); 
      
      // Player
      tint(255, 255); 
      playerMove();
      break;
    case "scene3":
      background(bgScene3_Skytrain);
      // Black fades out, arrive at Skytrain station by bus, student chases racoon into sewer
      // Gameplay: platformer, defeat racoon, get back UPass
      switch (raccoonMess) {
        case 0:
          dialogueActive = true;
          
          // Platform
          platforms.clear();
          
          // - Make Platform (addPlatform(x, y, w, h, color);
          addPlatform(0, 450, 1280, 64, 0, #F7A707);
          // - Draw Platform (only when in debug mode)
          if (debugMode) {
            for (Platform platform : platforms) {
              platform.drawPlatform();
              platform.drawCollisionBox();
            }
          }
        case 1:
          image(bgScene3_City,0,0);
          
          // Platform
          platforms.clear();
          
          // - Make Platform (addPlatform(x, y, w, h, color);
          addPlatform(0, 450, 1280, 64, 0, color(150));
          addPlatform(80, 370, 180, 24, 0, color(150));
          addPlatform(340, 300, 180, 24, 0, color(150));
          addPlatform(620, 370, 180, 24, 0, color(150));
          addPlatform(880, 290, 180, 24, 0, color(150));
          addPlatform(1110, 370, 120, 24, 0, color(150)); // Last
          // - Draw Platform (only when in debug mode)
          if (debugMode) {
            for (Platform platform : platforms) {
              platform.drawPlatform();
              platform.drawCollisionBox();
            }
          }
          break;
        case 2:
          image(bgScene3_SewerEntrance, 0, 0);
          
          // Platform
          platforms.clear();
          
          // - Make Platform (addPlatform(x, y, w, h, color);
          addPlatform(0, 450, 1280, 64, 0, color(150));
          addPlatform(60, 360, 140, 24, 0, color(150)); // First
          addPlatform(250, 270, 140, 24, 0, color(150));
          addPlatform(440, 350, 140, 24, 0, color(150));
          addPlatform(630, 240, 140, 24, 0, color(150));
          addPlatform(820, 330, 140, 24, 0, color(150));
          addPlatform(1010, 220, 140, 24, 0, color(150));
          addPlatform(1170, 350, 80, 24, 0, color(150)); // Last
          break;
        case 3:
          image(bgScene3_SewerCave, 0, 0);
          
          // Platform
          platforms.clear();
          
          // - Make Platform (addPlatform(x, y, w, h, color);
          // Ground
          addPlatform(0, 450, 1280, 64, 0, color(150));
          addPlatform(100, 350, 220, 24, -8, color(150)); // First
          addPlatform(390, 280, 180, 24, 8, color(150));
          addPlatform(640, 350, 220, 24, -8, color(150));
          addPlatform(930, 270, 180, 24, 8, color(150));
          addPlatform(1150, 350, 100, 24, -8, color(150)); // Last
          break;
        case 4:
          image(bgScene3_Throneroom, 0, 0);
          
          // Platform
          platforms.clear();
          
          // - Make Platform (addPlatform(x, y, w, h, color);
          // Ground
          addPlatform(0, 600, 1280, 64, 0, color(150));
          
          // Boss Fight
          if (bossMusic == 0) {
            musMercury.play();
            bossMusic++;
          }
          image(kingFatArms, 905, 309);
          image(kingFatBellay, 929, 316);
          image(kingFatArms, 969, 331);
          image(kingFatHead, 925, 289);
          break;
        case 5:
          raccoonMess = 4;
          break;
      }
      if ((raccoonMess != 4) || (debugMode)) {
        for (Platform platform : platforms) {
          platform.drawPlatform();
          platform.drawCollisionBox();
        }
      }
       
      // Player (always at bottom)
      playerMove();
      break;
    case "scene4":
      musMercury.stop();
      background(bgScene4_BusLoop);
      // Student finally arrives on campus, lost, ask student for direction
      // Gameplay: moving character WASD
      
      // Platform
      platforms.clear();
      // - Make Platform (addPlatform(x, y, w, h, color);
      addPlatform(0, 450, 1280, 64, 0, #00FF00);
      // - Draw Platform (only when in debug mode)
      if (debugMode) {
        for (Platform platform : platforms) {
          platform.drawPlatform();
          platform.drawCollisionBox();
        }
      }
      
      // Player (always at bottom)
      playerMove();
      break;
    case "scene5":
      background(bgScene5_AQEntrance);
      // Student needs to get to class on time
      // Gameplay: platformer (copy pasted), to class
      
      // Platform
      platforms.clear();
      // - Make Platform (addPlatform(x, y, w, h, color);
      addPlatform(0, 450, 1280, 64, 0, #FF00FF);
      // - Draw Platform (only when in debug mode)
      if (debugMode) {
        for (Platform platform : platforms) {
          platform.drawPlatform();
          platform.drawCollisionBox();
        }
      }
      
      // Player (always at bottom)
      playerMove();
      break;
    case "scene6":
      background(bgScene6_LectureHall);
      // Arrive at classroom in AQ, but the racoon is there
      // Gameplay: Mostly moving character WASD + story wrapup
      
      // Platform
      platforms.clear();
      // - Make Platform (addPlatform(x, y, w, h, color);
      addPlatform(0, 450, 1280, 64, 0, #00FFFF);
      // - Draw Platform (only when in debug mode)
      if (debugMode) {
        for (Platform platform : platforms) {
          platform.drawPlatform();
          platform.drawCollisionBox();
        }
      }
      
      // Player (always at bottom)
      playerMove();
      break;
  }
  
  // Constant Sarah Gif
  if (frameCount % 12 == 0) {
    talkSarahCurrentFrame = (talkSarahCurrentFrame + 1) % talkSarahTotalFrames;
  }
  talkSarah = talkSarahFrames[talkSarahCurrentFrame];
  
  // DIALOGUE IS HERE, NOTHING ELSE SHOULD BE UNDERNEATH!!!
  dialogue(); // End!
}

void playerMove() {
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
  
  if (running) {
    int interval = int(random(400, 1000));
    if (millis() - sfxStepTime >= interval) {
      sfxStep.play();
      sfxStepTime = millis();
    }
  }
}

void startJump() {
  if (!player.grounded) {
    return;
  }
  player.velocity.y = -jumpPower;
  jumping = true;
  sfxJump.play();
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
  
  // Start the next scene dialogue if applicable
  for (int i = 0; i < table.getRowCount(); i++) {
    if (table.getRow(i).getString("scene").equals(nextScreen)) {
      currentDialogue = i;
      dialogueActive = true;
      break;
    }
  }
}

// On mouse press
void mousePressed() {
  // Debugging
  if (debugMode) println("Mouse pressed: " + mouseX + ", " + mouseY);
  
  // Title Screen
  if (currentScreen == "title") {
    currentScreen = "scene1";
    dialogueActive = true;
    return;
  }
  
  // Attacking
  if (!attacking) {
    attacking = true;
    spriteBeforeAttacking = player.sprite;
    player.sprite = attackSarahAnimation;
    attackSarahAnimation.reset();
    attackSarahAnimation.playOnce();
    player.swingBag();
    return;
  }
}

// On key press
void keyPressed() {
  // Moving
  if (key == CODED) {
    if (keyCode == UP) startJump();
    if (keyCode == DOWN) {
      if ((currentScreen != "title") && (dialogueActive) && (currentDialogue < table.getRowCount() - 1)) {
        sfxType.play();
        TableRow nextRow = table.getRow(currentDialogue + 1);
        String nextRowScene = nextRow.getString("scene");
        if (nextRowScene.equals(currentScreen)) {
          currentDialogue += 1;
          return;  
        } else { // End of scene
          dialogueActive = false; 
          if (debugMode) println("End of dialogue for " + currentScreen);
          return;
        }
      } else { // End of CSV
        dialogueActive = false;
        if (debugMode) println("End of CSV and dialogue for " + currentScreen);
        return;
      }
    }
    if (keyCode == LEFT) {
      left = true; 
      if (!attacking && !jumping) {
        player.sprite = runSarahAnimation;
        runSarahAnimation.reset();
        running = true;
      }
    }
    if (keyCode == RIGHT) {
      right = true; 
      if (!attacking && !jumping) {
        player.sprite = runSarahAnimation;
        runSarahAnimation.reset();
        running = true;
      }
    }
  }
  if (key == 'n') raccoonMess++;
  if (key == 'a' || key == 'A') {
    left = true;
    if (!attacking && !jumping) {
      player.sprite = runSarahAnimation;
      runSarahAnimation.reset();
      running = true;
    }
  }
  if (key == 'd' || key == 'D') {
    right = true; 
    if (!attacking && !jumping) {
      player.sprite = runSarahAnimation;
      runSarahAnimation.reset();
      running = true;
    }
  }
  if (key == ' ' || key == 'w' || key == 'W') startJump();
    
  // Interaction
  if (key == ENTER || key == 'f' || key == 'F') {
    if (playerAtDoor) {
      enterDoor("scene2", 100, 380);
      playerAtDoor = false;
    }
    if (busState == 1) {
      busState = 2;
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
        running = false;
      }
    }
    if (keyCode == RIGHT) {
      right = false; 
      if (!attacking && !jumping) {
        player.sprite = idleSarahAnimation;
        idleSarahAnimation.reset();
        running = false;
      }
    }
  }
  if (key == 'a' || key == 'A') {
    left = false; 
    if (!attacking && !jumping) {
      player.sprite = idleSarahAnimation;
      idleSarahAnimation.reset();
      running = false;
    }
  }
  if (key == 'd' || key == 'D') {
    right = false; 
    if (!attacking && !jumping) {
      player.sprite = idleSarahAnimation;
      idleSarahAnimation.reset();
      running = false;
    }
  }
}
