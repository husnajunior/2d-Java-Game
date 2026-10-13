class Bug extends Mega{ //declare bug (child) class
//Bog class constructor
  Bug(int x, int y,  int speedX, int frame){
   super(x, y, speedX, 0, frame); //fetching values from abstract (parent) class   
   frames = new PImage[2];  //image array
    for (int i = 0; i < frames.length; i++) {
      frames[i] = loadImage("ant" + (i+1) + ".png"); //load images from  file
      frames[i].resize(width/20,height/20); //size of images    
  }
  }
 @Override
  void move() { //making object move
    x +=  speedX;  //variable that determin speed of enemy and make it move
    
    if(x <-50) { //screen boundary condition
     x = width;
    }
  }
  }
