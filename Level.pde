class Level {

  /*
PImage: these are the variables that will be used to load images for the ground,
   vertical and horizontal spikes
   
   float: these are the variables that define the position and speed of ellipses
   across a few of the levels
   */

  PImage ground, spikes, spikesL, spikesR;
  float eliPosY1 = 0, eliPosY2 = 800, speedY1 = 8, speedY2 = 12, eliPosY3 = 200, speedY3 = 1, eliPosY4 = 560, eliPosY5 = 625, speedY4 = 1, speedY5 = 2;
  float platformX = 370, speedPlatX = 2;

  void level0() {
    fill(255, 0, 0);
    stroke(150, 0, 0);
    rect(300, 350, 200, 60);
    rect(300, 450, 200, 60);
    fill(255, 255, 255);
    noStroke();
    textSize(40);
    text("PLAY", 350, 395); 
    textSize(25);
    text("INSTRUCTIONS", 312, 490);
  }

  void level1() {
    player.display();
    fill(153, 102, 0); // fill the rectangle with colour
    stroke(0, 153, 26); // set colour of rectangle
    strokeWeight(4); // set strokeWeight of rectangle to 4
    rect(-5, 755, 300, 50); // draw a rectangle under position where the game starts
    display(390, 680);
    display(520, 560);
    displayMulX(587, 450, 200);
    displaySpikes(level.spikes, 635, 420);
  }

  void level2() {
    displayMulX(-25, 440, 150);
    displayMulX(200, 440, 250);
    displayMulX(540, 440, 250);
    displaySpikes(level.spikes, 295, 410);
    displaySpikes(level.spikes, 389, 410);
    movingCircles();
  }

  void level3() {
    displayMulX(-25, 440, 200);
    displayMulY(350, 150, 500);
    displayMulX(111, 623, 200);
    displaySpikes(level.spikes, 159, 593);
    displaySpikesMul(level.spikesL, 317, 150, 450);
    movingPlatform();
    movingCircles2();
    display(600, 623);
    displayMulX(635, 550, 150);
    displaySpikes(level.spikes, 683, 520);
  }

  void level4() {
    displayMulX(-25, 336, 150);
    displayMulY(240, 286, 450);
    displayMulY(430, 286, 350);
    displaySpikes(level.spikes, 238, 307);
    displaySpikesMul(level.spikesR, 272, 288, 450);
    displaySpikesMul(level.spikesL, 399, 287, 350);
    displayMulX(190, 758, 400);
    displaySpikes(level.spikes, 520, 728);
    display(656, 630);
    display(540, 490);
    display(656, 360);
    display(540, 220);
    displayMulX(632, 140, 150);
    movingCircles3();
    displaySpikes(level.spikes, 429, 306);
  }

  void level5() {
    fill(255, 255, 255);
    background(0);
    textSize(30);
    text("Thank you for playing", width/2-150, 50);
    textSize(40);
    text("Congratulations", width/2-140, 200);
    text("You have completed the game", width/2-300, 320);
    textSize(25);
    text("Press SPACE if you wish to play again", width/2-220, 600);
    text("If you wish to quit, press ENTER", width/2-190, 700);
  }

  /*
The display function. This function is used to display a SINGLE ground block
   whenever this function is called, it requires for two parameters to be entered
   (blockPosX and blockPosY) and it will draw the block at these coordinates
   */

  void display(int blockPosX, int blockPosY) { 
    image(ground, blockPosX, blockPosY); // draw the ground block with the parameters that were given when function was called
  }


  /*
The displayMul function. This function is used to display MULTIPLE ground blocks
   whenever this function is called, it requires for three parameters to be entered
   (mulblockPosX, mulblockPosY and numBlocks). When these parameters are given,
   this function will draw multiple blocks using a for loop. The starting position
   of the blocks and how many blocks to be drawn are to be provided when function is called
   */

  void displayMulX(int mulblockPosX, int mulblockPosY, int numBlocks) {
    for (int i = 50; i < numBlocks; i+=47) { // each block is 50px wide, depending on the number of blocks, it will draw a block every 47 X positions
      image(ground, mulblockPosX+i, mulblockPosY); // draw the multiple blocks by adding i to each position (+47)
    }
  }

  void displayMulY(int mulblockPosX, int mulblockPosY, int numBlocks) {
    for (int i = 50; i < numBlocks; i+=47) { // each block is 50px wide, depending on the number of blocks, it will draw a block every 47 X positions
      image(ground, mulblockPosX, mulblockPosY+i); // draw the multiple blocks by adding i to each position (+47)
    }
  }

  /*
The displaySpikes function. This function is used to display spikes
   whenever this function is called, it requires for three parameters to be entered
   (spikeName, spikePosX and spikePosY). SpikeName is a String because I have 
   different types of spikes that I want to use in this game (vertical and horizontal)
   */

  void displaySpikes(PImage spikeName, int spikePosX, int spikePosY) {
    image(spikeName, spikePosX, spikePosY); // // draw the spike at the coordinates that were provided when function was called
  }

  void displaySpikesMul(PImage spikeName, int spikesPosX, int spikesPosY, int numSpikes) {
    for (int i = 50; i < numSpikes; i+=47) { // each block is 50px wide, depending on the number of blocks, it will draw a block every 47 X positions
      image(spikeName, spikesPosX, spikesPosY+i); // draw the multiple blocks by adding i to each position (+47)
    }
  }

  /*
The movingCircles function. This function is used to display and animate the ellipses
   that are found on the second level. 
   */

  void movingCircles() {
    fill(0, 255, 0); // fill the circles with green colour 
    noStroke();
    ellipse(180, eliPosY1, 50, 50); // draw the first ellipse at x of 180, y of 0 (provided when declared)
    fill(255, 0, 0);
    ellipse(498, eliPosY2, 50, 50); // draw the second ellipse at x of 498 and y of 800 (provided when declared)

    eliPosY1 += speedY1; // add speed to positionY so ellipse can move
    eliPosY2 -= speedY2; // add speed to positionY so ellipse can move

    if (eliPosY1 > height) { // if the first ellipse reaches maximum height (800), reverse it
      speedY1 = -8;
    } else if (eliPosY1 < 0) { // if the first ellipse reaches 0 or below, reverse it back again
      speedY1 = 8;
    } 
    if (eliPosY2 > height) { // if the second ellipse reaches maximum height (800), reverse it
      speedY2 = 12;
    } else if (eliPosY2 < 0) { // if the second ellipse reaches 0 or below, reverse it back again
      speedY2 = -12;
    }

    /*
If the player collides with one of the ellipses, they fail and the reset function is called
     (the game is restarted)
     */

    if (player.positionX > 130 && player.positionX < 230 && player.positionY-18 > eliPosY1-50 && player.positionY+18 < eliPosY1+50 && state == 2
      || player.positionX > 448 && player.positionX < 548 && player.positionY-18 > eliPosY2-50 && player.positionY+18 < eliPosY2+50 && state == 2) {
      reset();
    }
  }

  /*
The movingCircles2 function. This function is used to display and animate the ellipse
   that is found on the third level. 
   */

  void movingCircles2() {
    fill(0, 0, 255);
    noStroke();
    ellipse(eliPosY3, 740, 20, 20);

    eliPosY3 -= speedY3;

    if (eliPosY3 > 780) {
      speedY3 = 1;
    } else if (eliPosY3 < 20) {
      speedY3 = -1;
    }

    /*
If the player collides with the ellipse, they fail and the reset function is called
     (the game is restarted)
     */

    if (player.positionX-18 > eliPosY3-20 && player.positionX+18 < eliPosY3+20 && player.positionY >= 740 && player.positionY < 760 && state == 3) {
      reset();
    }
  }

  /*
The movingCircles3 function. This function is used to display and animate the ellipses
   that are found on the fourth level. 
   */

  void movingCircles3() {
    fill(0, 255, 0);
    noStroke();
    ellipse(eliPosY4, 590, 20, 20);
    fill(0, 0, 255);
    ellipse(eliPosY5, 320, 20, 20);

    eliPosY4 -= speedY4;
    eliPosY5 += speedY5;

    if (eliPosY4 > 780) {
      speedY4 = 1;
    } else if (eliPosY4 < 500) {
      speedY4 = -1;
    } else if (eliPosY5 > 780) {
      speedY5 = -2;
    } else if (eliPosY5 < 500) {
      speedY5 = 2;
    }

    /*
If the player collides with the ellipse, they fail and the reset function is called
     (the game is restarted)
     */

    if (player.positionX-18 > eliPosY4-20 && player.positionX+18 < eliPosY4+20 && player.positionY >= 570 && player.positionY < 610 && state == 4
      || player.positionX-18 > eliPosY5-20 && player.positionX+18 < eliPosY5+20 && player.positionY >= 300 && player.positionY < 340 && state == 4) {
      reset();
    }
  }

  /*
The movingPlatform function. This function is used to display and animate the platform
   that is found on the third level. 
   */

  void movingPlatform() {
    fill(255, 0, 0);
    noStroke();
    rect(platformX, 770, 100, 10);

    platformX += speedPlatX;

    if (platformX > 600) {
      speedPlatX = -2;
    } else if (platformX < 20) {
      speedPlatX = 2;
    }

    /*
If statements to detect when the player is on the platform and also when 
     the player is off the platform (the player would fall)
     */

    if (player.positionX > platformX && player.positionX < platformX + 100 && player.positionY+18 > 770) {
      player.positionY = 755;
      player.jumping = false;
      player.falling = false;
    } else if (player.positionX > platformX-6 && player.positionX < platformX && player.positionY == 755 && state == 3 || player.positionX > platformX+100 && player.positionX < platformX+107 && player.positionY == 755 && state == 3) {
      player.falling = true;
    }
  }
}

