class Cards {
  PImage cardImage;
  int show = 0; // show back (0) or front (1) of the card
  int cardWidth = 300;
  int cardHeight = 300;
  int cardX = 0; // współrzędna x karty
  int cardY = 0;  // współrzędna y karty
  int faceValue = 0; //numer który, będzie potrzebny do rozmoznawania pary
  String[] cardName = {"img1_1.jpg", "img2.PNG", "img3.PNG", "img4.PNG"};
                        //"img2.jpg", "img3.jpg", "img6.png"};
  
Cards(int x, int y, int fv) {
    cardX = x;
    cardY = y;
    faceValue = fv;
  }
  
  void display() {
    cardImage = loadImage(cardName[show]);
    cardImage.resize(cardWidth,cardHeight);
    image(cardImage, cardX, cardY);
  }
  
  void displayFront(){
    show = faceValue;
  }
  
  void faceDown(){
    show = 0;
  }
  void matched() {
    image(cardImage, cardX, cardY);
  }
}
