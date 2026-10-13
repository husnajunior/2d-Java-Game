class Hero { //Represents the player controlled by mouse input
//Handles scoring, lives animations and collision interactions
  
 //Data members
  PImage[] frames, explosion; //declaraing arrays of images for mouse click player and enemy kill explosion
  PImage clash; //declaring image variable for bomb animation
  
  //declaring variables 
  int x, y, score, highScore, frame, lives= 5, explode;
  
  boolean clickUsed = false; //boolean to make sure enemy killed 1 at a time

  //constructor
  Hero(int x, int y) {
    this.x = x;
    this.y = y;
    this.lives = 5; //variable with its values for player chances

//This part of code will load images from file that will create animation and a single image 
    frames = new PImage[15]; 
    for (int i = 0; i < frames.length; i++) {
      frames[i] = loadImage("b" + (i + 1) + ".png");
      frames[i].resize(width / 10, height / 10);
    }
    explosion = new PImage[5];
    for (int i = 0; i < explosion.length; i++) {
      explosion[i] = loadImage("explosion" + (i + 1) + ".png");
      explosion[i].resize(width/10, height/10);
    }
    clash = loadImage("clash.PNG");
    clash.resize(width/8,height/8);
  }
  //methods
  void display() { //store all the resources to display
    image(frames[frame], x, y);
    frame = (frame + 1) % frames.length;
    explode = (explode + 1) % explosion.length;
    fill(255);
    textSize(20);
    text("Lives: "+ lives, 10,50);
    text("Score: " + score, 10, 80);
    text("High Score: " + highScore, 10, 110);
  }

  void mouseClicked() { //mouseclicked function
    x = constrain(mouseX, 100, width - 50); //make cursor move at x position around screen within boudaries
    y = constrain(mouseY, 20, height - 50); //make cursor move at y position around screen within boudaries   
    
  }

  void update() { //display class
    display();
    mouseClicked();
  }
 //collision code of enemy abstract class  with hero class
  boolean enemyKill(Mega[] boom) {
    if (!mousePressed) { //condition to make sure mouse is pressed
    clickUsed = false;
      return false;
    }
    if(clickUsed) { //condition for enemy kill check
      return false;
    }
 //collision code that detects mouse click collision with Bee or Bug enemies
 //It removes an enemy, plays explosion animation and increase score
    for (int i = 0; i < boom.length; i++) {
      if (boom[i] != null) { //ensure enemy abstract class isn't empty
        if (boom[i] instanceof Bee || boom[i] instanceof Bug) { //only applied on bug and bee
          if (dist(mouseX, mouseY, boom[i].x, boom[i].y) < 50) { //distance applied 
            boom[i] = null; //enemy removed from array so it is no longer updated or rendered
            int points = int(random(50, 4000)); //generate random points
            score += points; //store points in score variable
            image(explosion[explode],x,y); //load image as an animation in collision while enemy is hit by mouse
            clickUsed = true; //kill enemy 1 by 1
            return true; 
          }
        }
      }
    }
    return false;
  }
  //second collision code that detects collision between player and bomb enemies
  //Reduces player lives and removes the bomb from the game
    boolean bombHit(Mega[] bombs) {
    for (int i = 0; i < bombs.length; i++) {
      if (bombs[i] != null && bombs[i] instanceof Bomb) { //only apply  on bomb class
        if (dist(mouseX, mouseY, bombs[i].x, bombs[i].y) < 50) { //distance applied
          image(clash,x,y); //load image if hero click bomb
          lives--;  //decrement lives by 1      
          bombs[i] = null; //garabage collector  
          return true;
        }
      }
    }
    return false;
  }
}
