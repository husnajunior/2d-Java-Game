PImage displayImg; //background image used during gameplay

//declare variables that are use to control program flow
int play = 1, gameOver = 2, gameMode = 1, gameWin = 3;


boolean startGameScreen = true; //boolean for the start game screen

//Polymorphism array that is storing different types of enemies(Bee,Bug,Bomb)
//It allow all enemies to be updated and rendered using the Mega superclass
Mega[] enemyArray = new Mega[50]; 

//declaring object for hero and goal class
Goal goal; 
Hero hero;

void setup() { //Initialise window, load assets, create game objects and enemies
  size(600,600); //size of canvas
  
  //background image is loaded with its hight and width
  displayImg = loadImage("background.JPG"); 
  displayImg.resize(width, height); 
  
  //X,y postion of objects are defined
  goal = new Goal(30, 250);
  hero = new Hero(10, 20);  
  
  //function that load high score is called 
  loadHighScore();
  
  //This part of code is only related to an enemies
  //declared the two local variables only for bomb class to be appear ongoing in game and other one is bomb counter
  int maxBombs = enemyArray.length/10,  currentBombs = 0;
  
  //for loop for enemies
  for (int i = 0; i < enemyArray.length; i++) { 
     int enemySelect = (int)random(3); //Randomly selects which enemy type to create(Bee, Bug, or Bomb)
    if(enemySelect == 2 && currentBombs >= maxBombs) { //condition to run loop if enemy is bomb
      enemySelect = (int)random(2); //defined the enemy type that is needed
     }
     
     int x = width + i * 50; // create space horizontally between all enemy classes
     int y =  -(int)random(50, 600)*i*50; // create vertical space  between all enemy classes
     int speedX =  -int(random(1,2)); //generate random speed from x position for enemy classes
     int speedY =  int(random(1,2));  //generate random speed from y position for enemy classes
     
     //switch case condition for all enemies
     switch(enemySelect){
       case 0: //bee enemy object with its  position and speed values
       enemyArray[i] = new Bee(x, y, speedX, speedY, 0); 
       break;       
       case 1: //ant enemy object  with its position and speed values
       enemyArray[i] = new Bug(x, (int)random(500, 560), speedX, 0);
       break;
       case 2: //bomb enemy object with its position and speed values
       enemyArray[i] = new Bomb((int)random(0,600),30+i*30,speedY);
       currentBombs++; //bomb counter
       break;
}
  } 
}
void draw() { //Main game loop executed 60 times approximately per second
  if(startGameScreen) { //condition to run game if start screen condition is met 
    startScreen();
    return;
  }
  if (gameMode == play) { //condition to run game with its resources
   image(displayImg, 0, 0); //load image background
    goal.update(); //load goal object
    hero.update(); //load hero object
    for (int i = 0; i < enemyArray.length; i++) { //loop to process enemies in game
      if (enemyArray[i] != null) {
        enemyArray[i].update(); //load enemy array s object
      }
    }
    hero.enemyKill(enemyArray); //enemy-kill collision  called 
    hero.bombHit(enemyArray);  //bomb-hit collision  called 
    
    
    //boolean that is use to check if all active enemies (Bee and Bug) have been eliminated
    boolean allDead = true;
    for (int i = 0; i < enemyArray.length; i++) {
     if (enemyArray[i] instanceof Bee || enemyArray[i] instanceof Bug){ //only applied on bee and ant class
       if (enemyArray[i] != null) {
         allDead = false;
         break;
      }
    }
  }
    if (allDead) { //condition that checks if all enemy dead game is win
      gameMode = gameWin;
    }
    if(hero.lives<= 0) { //condition that checks if mouse click is out of lives, game is over
      gameMode = gameOver;
    }
    
    if(goal.crash(enemyArray)) { //condition that checks if bee and ant collide with goal, game is over
      gameMode = gameOver;
    }
  } 
  else if(gameMode == gameWin) { //Interface for game win
    saveHighScore(); //load highscore
    background(0,150,0); //load green background
    fill(255);  //text color white
    textSize(30); //text size
    text("Your Final Score: " + hero.score, width/3, height/2.5); //load final text with it's position
    text("Highest Score: " + hero.highScore, width/3, height/2); //load high score text with it's position
    text(";)--You Win!--;)", width/3, height/2); //load text to tell user, he/she won
  } 
  else if (gameMode == gameOver) { //Interface for game over
    background(150,0,0); //load red background
    fill(255);   //text color white
    textSize(50);  //text size
    text(";(--Game is over--;(", width/5, height/2); //load text to tell use, he/she lost
  }
}
void mouseClicked() { //system-defined mouseclick function
  hero.enemyKill(enemyArray); //applied only on bee and ant class
  hero.bombHit(enemyArray); //applied only on bomb class
}
void startScreen() { //user-defined function for screen that starts game
  background(0); //background color is black
  textSize(35); //text size is 35
  text("Press 'h' to start the game", width/5, height/2); //load text
}
void keyPressed() { //system defined function for key event
  if(startGameScreen) { //condition to start game
    if(key == 'h') { //nested condition to check if h key is pressed
      startGameScreen=false; //game will not be started
    }
  }
}
void loadHighScore() { //user defined function to load highscore in a file
  String[] data = loadStrings("highscore.txt"); //create file
  if (data != null && data.length > 0) { 
    hero.highScore = int(data[0]); //load highscore
  } else {
    hero.highScore = 0; 
  }
   hero.score = 0; //whenever game is start, score variable will set to 0
}

void saveHighScore() { //user defined function to save highscore
  if (hero.score > hero.highScore) { //condition to check scores are greater then highscore
    hero.highScore = hero.score; //save score into highscore
  }
  saveStrings("highscore.txt", new String[]{ str(hero.highScore) }); //save highscore into text file
}
