class Player {

  PImage [] imgs; // An array where my sprite images for the player will be loaded
  int picNumber, maxPics; // picNumber and maxPics will be used along with array so I can circle through images
  float positionX, positionY, velocityX = 5, velocityY = 0, gravity = 0.7; // track position of the player, as well as variables to allow player to jump  
  boolean moveRight = false, moveLeft = false, jumping = false, falling = false; // variables to detect when certain action is happening (moving left, right, jumping or falling)


  /*
Constructor to define the character's position, starting picture number of the array and the maximum number of pictures in the array
   these parameters are given in setup when a new object is created
   */

  Player(int _picNumber, int _maxPics, float _positionX, float _positionY) { 
    picNumber = _picNumber; // assign value of _picNumber to a new variable picNumber for this class
    maxPics = _maxPics; // assign value of _maxPics to a new variable maxPics for this class
    positionX = _positionX; // assign value of _positionX to a new variable positionX for this class
    positionY = _positionY; // assign value of _positionY to a new variable positionY for this class

    /*
Load all of the images that will be used to animate the character into an array
     all images that include the word "move", including an increasing number from 0 (i) and have an ending of ".png"
     are added into the array
     move4.png was loaded into 4th position of the array seperately because it will be used as jump animation
     */

    imgs = new PImage[maxPics]; // create a new array with maximum number of images
    for (int i = 0; i < maxPics; ++i) { 
      imgs[i] = loadImage("move" + i + ".png");
      imgs[4] = loadImage("move4.png");
      imgs[i].resize(30, 30); // resize all of the images in the array into 30 x 30
    }
  }

  /*
The display function. This function is used to select the images that will be used for animation
   whenever a player jumps or is falling, the 4th image from the array will be used.
   Whenever the player is moving left or right, the images in the array will be cycled
   through, giving the illusion of animation. If the player is not doing another (moving or jumping),
   the 0 position image in the array will be set
   */

  void display() {
    positionX = constrain(positionX, 0, width+20); // constrain so player cannot go outside window boundaries on first level (to the left)
    positionY = constrain(positionY, 0, height+31); // constrain so player cannot go outside window boundaries on first level (to the left)
    imageMode(CENTER);

    if (moveLeft == true || moveRight == true) {
      if (frameCount % 10 == 0) {
        picNumber = (picNumber + 1) % 4;
      }
    } else if (jumping == true || falling == true) {
      picNumber = 4;
    } else {
      picNumber = 0;
    }
  }

  /*
The moveSprite function. This function is used to control situations when the 
   sprite is moving. 
   */

  void moveSprite() {

    /*
The following part of the function mirrors the image whenever the played is moving a certain direction
     for example, if the player is moving right, the character will be made to turn right
     and vice versa when moving left
     */

    if (moveLeft == true) {
      pushMatrix();
      scale(-1, 1);
      image(imgs[picNumber], -positionX, positionY);
      popMatrix();
    } else {
      image(imgs[picNumber], positionX, positionY);
    }

    if (moveLeft == true) {
      positionX -= velocityX;
    } else if (moveRight == true) {
      positionX += velocityX;
    }

    if (positionY > 830) { // If the player falls off the map, reset the game
      state = 1;
      reset();
    }

    /*
The following IF statements are used to detect when the player has
     collided with one of the spikes on the different levels. 
     If that's the case, the game is restarted
     */

    if (positionX+18 > 615 && positionX-18 < 657 && positionY == 413 && state == 1
      || positionX+18 > 275 && positionX-18 < 317 && positionY == 402 && state == 2
      || positionX+18 > 369 && positionX-18 < 411 && positionY == 402 && state == 2
      || positionX > 314 && positionX < 348 && positionY > 181 && positionY < 599 && state == 3
      || positionX > 138 && positionX < 181 && positionY == 585 && state == 3
      || positionX > 663 && positionX < 705 && positionY == 512 && state == 3
      || positionX > 217 && positionX < 262 && positionY > 305 && positionY < 319 && state == 4
      || positionX > 263 && positionX < 277 && positionY > 319 && positionY < 737 && state == 4
      || positionX > 395 && positionX < 410 && positionY > 318 && positionY < 642 && state == 4
      || positionX > 500 && positionX < 542 && positionY == 721 && state == 4
      || positionX > 409 && positionX < 451 && positionY > 304 && positionY < 317 && state == 4) {
      reset();
    }
    if (positionX > 800 && state == 1) { // If the player goes over the window boundaries of first level, they advance to second level
      state = 2;
      positionX = 0;
      positionY = 402;
    } else if (state == 2 && positionX < 0) { // If player goes backwards (under 0) in second level, it goes back to level 1
      state = 1;
      positionX = 799;
      positionY = 413;
    } else if (positionX > 800 && state == 2) { // If the player goes over the window boundaries of second level, they advance to third level
      state = 3;
      positionX = 0;
      positionY = 402;
    } else if (state == 3 && positionX < 0) { // If player goes backwards (under 0) in third level, it goes back to level 2
      state = 2;
      positionX = 800;
      positionY = 402;
    } else if (state == 3 && positionX > 800) { // If player goes over the window boundaries of third level, they advance to fourth level
      state = 4;
      positionX = 0;
      positionY = 300;
    } else if (state == 4 && positionX < 0) { // If player goes backwards (under 0) in fourth level, it goes back to level 3
      state = 3;
      positionX = 800;
      positionY = 512;
    } else if (state == 4 && positionX > 800) { // If player goes over the window boundaries of fourth level, they advance to fifth stage (ending)
      state = 5;
    }

    /*
If statements to detect when the player falls off one of the blocks
     If that's the case, the player falls to the ground and the game is restarted
     when the player hits the ground
     */
    if (positionX-18 > 298 && positionX-18 < 304 && positionY > 739 && positionY < 745 && jumping == false && state == 1
      || positionX+18 > 360 && positionX+18 < 366 && positionY > 644 && positionY < 650 && jumping == false && state == 1
      || positionX-18 > 413 && positionX-18 < 419 && positionY > 644 && positionY < 650 && jumping == false && state == 1
      || positionX+18 > 490 && positionX+18 < 496 && positionY > 523 && positionY < 529 && jumping == false && state == 1
      || positionX-18 > 544 && positionX-18 < 550 && positionY > 523 && positionY < 529 && jumping == false && state == 1
      || positionX-18 > 143 && positionX-18 < 149 && positionY > 401 && positionY < 407 && jumping == false && state == 2
      || positionX+18 > 220 && positionX+18 < 226 && positionY > 401 && positionY < 407 && jumping == false && state == 2
      || positionX-18 > 462 && positionX-18 < 468 && positionY > 401 && positionY < 407 && jumping == false && state == 2
      || positionX+18 > 560 && positionX+18 < 566 && positionY > 401 && positionY < 407 && jumping == false && state == 2
      || positionX-18 > 190 && positionX-18 < 196 && positionY > 401 && positionY < 407 && jumping == false && state == 3
      || positionX+18 > 570 && positionX+18 < 576 && positionY > 584 && positionY < 590 && jumping == false && state == 3
      || positionX-18 > 624 && positionX-18 < 630 && positionY > 584 && positionY < 590 && jumping == false && state == 3
      || positionX+18 > 655 && positionX+18 < 661 && positionY > 509 && positionY < 515 && jumping == false && state == 3
      || positionX-18 > 143 && positionX-18 < 149 && positionY > 299 && positionY < 305 && jumping == false && state == 4
      || positionX-18 > 593 && positionX-18 < 599 && positionY > 720 && positionY < 726 && jumping == false && state == 4
      || positionX+18 > 626 && positionX+18 < 632 && positionY > 592 && positionY < 598 && jumping == false && state == 4
      || positionX-18 > 680 && positionX-18 < 686 && positionY > 592 && positionY < 598 && jumping == false && state == 4
      || positionX+18 > 510 && positionX+18 < 516 && positionY > 452 && positionY < 458 && jumping == false && state == 4
      || positionX-18 > 564 && positionX-18 < 570 && positionY > 452 && positionY < 458 && jumping == false && state == 4
      || positionX+18 > 626 && positionX+18 < 632 && positionY > 322 && positionY < 328 && jumping == false && state == 4
      || positionX-18 > 680 && positionX-18 < 686 && positionY > 322 && positionY < 328 && jumping == false && state == 4
      || positionX+18 > 510 && positionX+18 < 516 && positionY > 182 && positionY < 188 && jumping == false && state == 4
      || positionX-18 > 564 && positionX-18 < 570 && positionY > 182 && positionY < 188 && jumping == false && state == 4
      || positionX+18 > 653 && positionX+18 < 659 && positionY > 99 && positionY < 104 && jumping == false && state == 4) {
      falling = true;
    }

    /*
If the player is jumping or falling, increase or
     decrease the gravity and velocity
     so the character actually jumps, also setting boolean
     variables whilst jumping and falling
     */

    if (jumping == true) {
      positionY -= velocityY;
      velocityY -= gravity;
      if (velocityY <= 0) {
        jumping = false;
        falling = true;
      }
    } else if (falling == true) {
      positionY += velocityY;
      velocityY += gravity;
    }
  }

  /*
The falling function. This function is called whenever the player
   does not jump on one of the blocks meaning they will fall to the
   ground and fail the level. The parameters of the boundaries are passed
   on whenever the function is called
   */

  void falling(int GRTPosX, int LESPosX, int GRTPosY, int LESPosY, int curState, int newPosX) {
    if (positionX > GRTPosX && positionX < LESPosX && positionY > GRTPosY && positionY < LESPosY && state == curState) {
      positionY = newPosX;
      falling = false;
    }
  }

  void falling2(int GRTPosX, int LESPosX, int GRTPosY, int LESPosY, int curState, int newPosX) {
    if (positionX > GRTPosX && positionX < LESPosX && positionY > GRTPosY && positionY < LESPosY && state == curState) {
      positionY = newPosX;
      jumping = false;
      falling = true;
    }
  }

  void falling3(int GRTPosX, int LESPosX, int GRTPosY, int LESPosY, int curState, int newPosX) {
    if (positionX > GRTPosX && positionX < LESPosX && positionY > GRTPosY && positionY < LESPosY && state == curState) {
      positionX = newPosX;
      jumping = false;
      falling = true;
    }
  }

  /*
  These are the boundaries of the different blocks
   on each level. It's to make sure that if the 
   player jumps on one of the blocks, they stay on that
   block instead of falling.
   */
  void jumpBoundaries() {
    player.falling(-10, 300, 755, 800, 1, 740);
    player.falling(366, 414, 650, 700, 1, 645); 
    player.falling(497, 544, 539, 584, 1, 524); 
    player.falling(613, 820, 428, 473, 1, 413); 
    player.falling(0, 143, 418, 464, 2, 402); 
    player.falling(226, 462, 418, 464, 2, 402); 
    player.falling(566, 820, 418, 464, 2, 402); 
    player.falling(0, 190, 417, 456, 3, 402);
    player.falling2(0, 190, 457, 464, 3, 495);
    player.falling(137, 374, 601, 634, 3, 585);
    player.falling2(137, 374, 635, 648, 3, 682);
    player.falling(576, 623, 601, 634, 3, 585);
    player.falling2(577, 624, 635, 648, 3, 682);
    player.falling(661, 820, 528, 575, 3, 512);
    player.falling(0, 143, 315, 360, 4, 300);
    player.falling3(198, 262, 320, 783, 4, 198);
    player.falling(216, 593, 738, 783, 4, 721);
    player.falling2(411, 454, 630, 643, 4, 661);
    player.falling3(445, 473, 315, 643, 4, 472);
    player.falling(632, 680, 608, 655, 4, 593);
    player.falling(516, 564, 468, 515, 4, 453);
    player.falling(632, 680, 338, 385, 4, 323);
    player.falling(516, 564, 199, 247, 4, 183);
    player.falling(658, 820, 117, 167, 4, 100);
  }
}

/*
The keyPressed function to detect when the arrow keys are pressed
 When they are pressed, certain boolean variables are changed
 */

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if (player.jumping == false && player.falling == false) { 
        player.jumping = true;
        player.velocityY = 15;
      }
    } else if (keyCode == RIGHT) {
      player.moveRight = true;
    } else if (keyCode == LEFT) {
      player.moveLeft = true;
    }
  }
  if (keyCode == ' ' && state == 5) {
    reset();
  } else if (keyCode == ENTER && state == 5) {
    exit();
  }
}

/*
The keyReleased function to detect whenever a key is released
 so the boolean variables are only toggled whilst the key is pressed
 */

void keyReleased() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      player.moveLeft = false;
    } else if (keyCode == RIGHT) {
      player.moveRight = false;
    }
  }
}

