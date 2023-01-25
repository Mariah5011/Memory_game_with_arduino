/* 
Button parameters:
  vector position
  width of button
  height of button
  color of button
  text displayed 
*/
class Button {
  PVector Pos = new PVector(0,0);
  float Width = 0;
  float Height = 0;
  color Colour;
  String Text;
  Boolean Pressed = false;
  Boolean Clicked = false;
  Boolean Over = false;
  color Highlight;
  
  //Konstruktor tworzenia przycisku
  Button(int x, int y, int w, int h, String t, int r, int g, int b)
  {
    Pos.x = x;
    Pos.y = y;
    Width = w;
    Height = h;
    Colour = color(r, g, b);
    Text = t;
  }
  
  //zczytuje info czy button kliknięty, czy nie
  void update()   //draw() funkcion
  {
     if(mousePressed == true && mouseButton == LEFT && Pressed == false)
     {
       Pressed = true;
       if(mouseX >= Pos.x && mouseX <= Pos.x+Width && mouseY >= Pos.y && mouseY <= Pos.y+Height)
       {
         Clicked = true;
       }
     } else
   {
     Clicked = false;
     Pressed = false;
   }
  }
  
  
// rendorowanie przycisku na ekranie
  void render()       //draw() function 
  {
    fill(Colour);
    stroke(224, 86, 59);
    strokeWeight(2);
    rect(Pos.x, Pos.y, Width, Height, 3);
    
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(20);
    textFont(myFont);
    text(Text, Pos.x + (Width/2), Pos.y +(Height/2)- 5);
  }
  
// sprawdza, czy button kliknięty
  boolean isClicked() 
  {
    return Clicked;
  }
} 
