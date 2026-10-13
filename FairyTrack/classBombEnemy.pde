class Bomb extends Mega { //declare bomb (child) class
 //bomb constructor
  Bomb(int x, int y, int speedY) {
    super(x, y, 0, speedY, 0); //fetching values from abstract (parent) class   
    bombImg = loadImage("bomb.PNG"); //load image
    bombImg.resize(width/15, height/15); //size of image
  }

  @Override
  void move() { //making object move
    y += speedY; 
    x += int(random(-2, 3));  
 
  //screen boundaries conditions
    if (y > height + 50) { //make bomb appear vertically everywhere including create distance between it by 50
      y = -(int)random(50, 300); //random horizontol position
      x = (int)random(50, width - 50); //random vertical position
      speedY = (int)random(3, 8); //random vertical speed
    }
  }

  @Override
  void update() { //display the class
    move();
    image(bombImg, x, y);
  }
}
