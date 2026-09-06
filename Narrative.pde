// Untitled Raccoon Game - Narrative
// By: Team Raccoon
// On: September 5, 2026

// THIS IS WHERE WE WILL EDIT DIALOGUE
void dialogue() {
  if (!dialogueActive) return; 
  if (currentDialogue >= table.getRowCount()) return;

  TableRow currentRow = table.getRow(currentDialogue);
  String dialogueScene = currentRow.getString("scene");

  if (dialogueScene.equals(currentScreen)) {
    String currentVoice = currentRow.getString("voice_id");
    String currentImage = currentRow.getString("image"); 
    String currentName = currentRow.getString("name");
    String currentBody = currentRow.getString("body");
  
    if (currentDialogue != lastDialogue) {
      lastDialogue = currentDialogue;
      dialogueStartTime = millis();
    }
  
    PImage portraitToDraw = portraits.get(currentImage);
    textBox(portraitToDraw, currentName, currentBody);
  }
}

void textBox(PImage image, String name, String body) {
  int elapsedTime = millis() - dialogueStartTime;
  int charactersToShow = int((elapsedTime/float(1000)) * charsPerSecond);
  charactersToShow = constrain(charactersToShow, 0, body.length());
  String visibleBody = body.substring(0, charactersToShow);
  pushMatrix();
  rectMode(CORNER);
  fill(#161616);
  stroke(255);
  strokeWeight(5);
  rect(100, 2*height/3, width - 200, height/3 - 20);
  popMatrix();
  pushMatrix();
  translate(100, 2*height/3);
  if (image != null) image(image, 0, 0, 200, 200);
  if (debugMode) {
    noFill();
    strokeWeight(1);
    stroke(#FF0000);
    rect(4, 24, 200, 200);
  }
  noStroke();
  fill(255);
  textFont(font);
  textSize(64);
  text(name, 194, 60);
  textSize(32);
  text(visibleBody, 196, 72, 2*width/3, 2*height/3);
  if (debugMode) {
    noFill();
    strokeWeight(1);
    stroke(#FF0000);
    rect(196, 72, 2 * width / 3 + 32, height / 4 - 40);
  }
  noStroke();
  popMatrix();
  downAnimation.display(1130, 651, false, 64);
  downAnimation.update();
}
