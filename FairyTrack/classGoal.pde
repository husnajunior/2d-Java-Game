class Goal { //Respresents the target area that enemies must not reach.
  //Collision with an enemy triggers game over.
  //data members
  PImage goalImg; //declaring globalvariable for goal image
  int x, y; //declaring global variable

  //constructor
  Goal(int x, int y) {
    this.x = x;
    this.y = y;
    goalImg = loadImage("goal.png"); //load image
    goalImg.resize(width/3, height/2); //size of image
  }
 
 //methods
  void update() { //display the class
    image(goalImg, x, y);
  }
  
 //check the collision between the goal and enemy objects
 //Returns truee if any Bee or Bug recheas the goal area
  boolean crash(Mega[] enemyCrash) {
    for (int i = 0; i < enemyCrash.length; i++) { 
      if (enemyCrash[i] != null) { 
        // only Bee or Bug trigger collision
        if (enemyCrash[i] instanceof Bee || enemyCrash[i] instanceof Bug) {

          if (dist(this.x+100, this.y+100, enemyCrash[i].x+15, enemyCrash[i].y+15) < 115) { //bee condition for collision
            return true;
          }
          if(dist(this.x+120, this.y+300, enemyCrash[i].x+15, enemyCrash[i].y+15) <20){ //bug condition for collision
            return true;
          } 
        }
      }
    }
    return false;
}
 
}
