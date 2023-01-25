class Confetti{
float x = random(width);
float y = random(-100, -50);
float yspeed = random(30,70);
int s = int(random(25, 80));
PImage confsushi;
  void fall() {
    y = y + yspeed; 
  }
  
  void show() {
   confsushi = loadImage("sushi.png");
   confsushi.resize(s, s);
   image(confsushi, x, y);
  }
}
