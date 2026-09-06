// Untitled Raccoon Game - Narrative
// By: Team Raccoon
// On: September 5, 2026

// THIS IS WHERE WE WILL EDIT DIALOGUE
void dialogue() {
  // Restart the typewriter effect when the dialogue changes
  if (currentDialogue != lastDialogue) {
    lastDialogue = currentDialogue;
    dialogueStartTime = millis();
  }

  switch (currentDialogue) {
    case 1:
      textBox(
        talkSarah,
        "Sarah",
        "What the fuck? Why am I in a video game??!"
      );
      break;

    case 2:
      textBox(
        talkSarah,
        "Sarah",
        "Fuck it's first day of university I'm gonna be late..."
      );
      break;
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
  image(image, 0, 0, 200, 200);
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
