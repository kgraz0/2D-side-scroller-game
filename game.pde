/*
 Sources can be found in sources.txt file in the directory of this project
*/

Player player; // reference to a class 
Level level; // reference to a class 
int state = 0; // the current state the game is in, will change accordingly
PImage backgroundImg; // variable for the background image

void setup() {
  size(800, 800); // set the size of the window to 800 x 800
  player = new Player(0, 5, 100, 740); // create a new class object, and give it parameters, see Player class
  level = new Level(); // create a new class object
  backgroundImg = loadImage("backgroundImage.jpg"); // load an image to a variable
  level.ground = loadImage("ground.png"); // load an image to a variable
  level.ground.resize(50, 50); // resize 'ground' variable image to 50 x 50
  level.spikes = loadImage("spikes.png"); // load an image to a variable
  level.spikesL = loadImage("spikesL.png"); // load an image to a variable
  level.spikesR = loadImage("spikesR.png"); // load an image to a variable
}

void draw() {
  background(backgroundImg); // set the background to the image I loaded previously
  if (state >= 1) {
    player.display(); // call chooseImage function from class 'Player'
    player.moveSprite(); // call moveSprite function from class 'Player'
  }
  state(); // call the state function
  player.jumpBoundaries(); // cal jumpBoundaries function from Player class
}

/*
The state function. This function will draw the whole level depending on which level the user is currently on.
 Depending on which level the user is on, it will call the level function so the level can be loaded for the user.
 */

void state() {
  if (state == -1) {
    instructions();
  } else if (state == 0) {
    level.level0();
  } else if (state == 1) {
    level.level1();
  } else if (state == 2) {
    level.level2();
  } else if (state == 3) {
    level.level3();
  } else if (state == 4) {
    level.level4();
  } else if (state == 5) {
    level.level5();
  }
}

/*
The reset function. This function will reset the whole game back to its normal settings (starting point.
 This function is used whenever the player fails and will get reset back to the starting point
 */

void reset() {
  state = 1;
  setup();
}

/*
  Instructions function, this function is called when the user presses to see
 instructions on the main screen
 */
void instructions() {
  fill(255, 255, 255);
  textSize(24);
  text("Use arrow keys to control the character", 160, 200);
  text("Get to the other side of the level", 200, 400);
  text("to advance to the next level", 220, 430);
  text("There are 4 levels in total, get to the end", 165, 600);
  text("of the last level win the game", 220, 630);
  fill(255, 0, 0);
  stroke(150, 0, 0);
  rect(300, 700, 200, 60);
  fill(255, 255, 255);
  noStroke();
  textSize(40);
  text("BACK", 350, 745);
}


void mousePressed() {
  if (mouseX > 300 && mouseX < 500 && mouseY > 350 && mouseY < 410 && state == 0) {
    state = 1;
  } else if (mouseX > 300 && mouseX < 500 && mouseY > 450 && mouseY < 510 && state == 0) {
    state = -1;
  } else if (mouseX > 300 && mouseX < 500 && mouseY > 700 && mouseY < 760 && state == -1) {
    state = 0;
  }
}

