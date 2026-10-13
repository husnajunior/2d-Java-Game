class Bee extends Mega{ //declare bee (child) class
//constructor
  Bee(int x, int y, int speedX, int speedY, int frame){
    super(x,y,speedX, speedY, frame); //fetching values from abstract (parent) class    
    
    frames = new PImage[6]; //image array
    for (int i = 0; i < frames.length; i++) {
      frames[i] = loadImage("bee" + (i+1) + ".png"); //load images from  file
      frames[i].resize(width/15,height/15);  //size of images    
  } 
  }
  @Override
  void move() { //making object move
    //variables that determin speed of enemy and make them move
    x += speedX; 
    y += speedY;
    
    //screen boundaries condition
    if(x <- 50 || y > height ) { 
      x = width;  //make enemy appear from top
      y = (int)random(0,10); //make bee appear on random y position
    }
  }
}
