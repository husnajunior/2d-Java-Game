abstract class Mega{ //Abstract superclass defining shared behaviour and properties for all enemies
//Enables polymorphism by allowing different enemy types to be treated
//Data members
  PImage[] frames; //declaring images array for animation variable
  PImage bombImg; //declaring single bomb image variable
  
  //declaring variables
  int x, y, speedX, speedY, frame, counter=10;
  
  //cnstructor
  Mega(int x, int y, int speedX, int speedY, int frame) {
    this.x = x;
    this.y = y;
    this.speedX = speedX;
    this.speedY = speedY;
    this.frame = frame;     
  }
  
 //methods
  void render() { //handles animation frame cycling and renders enemy sprite
   counter++;
   if(counter % 5 == 0) {
      frame= (frame + 1) % frames.length;   
   }
   image(frames[frame], x, y);
  }
  abstract void move(); // empty move method to make other classes behave differently
  void update() { //display class
    move();
    render();
  }
}
