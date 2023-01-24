class Cards {
  PImage cardImage;
  int show = 0; //zmienna okreslająca tył (0) lub przód (1) karty
  int cardWidth = 300;
  int cardHeight = 300;
  int cardX = 0; //współrzędna x karty
  int cardY = 0; //współrzędna y karty
  int Awers = 0; //przód karty
  //cardName - lista grafik do gry, pierwsza to awers karty
  String[] cardName = {"img1_1.jpg", "img2.PNG", "img3.PNG", "img4.PNG",
                          "img2.jpg", "img3.PNG", "img4.PNG"};
  
Cards(int x, int y, int awers) {
    cardX = x;
    cardY = y;
    Awers = awers ;
  }
  
//-------------- display() ----------------
//ładowanie kart, resize i rysowanie  
  void display() {
    cardImage = loadImage(cardName[show]);
    cardImage.resize(cardWidth,cardHeight);
    image(cardImage, cardX, cardY);
  }

//-------------- displayAwers() ----------------
//rysowanie awersu karty  
  void displayAwers(){
    show = Awers;
    display();
  }

//-------------- ObrocKarte() ----------------
//rysowanie rewersu karty ponownie po odsłonięciu
  void ObrocKarte(){
    show = 0;
  }
  
//-------------- Para() ---------------- 
//rysowanie karty na stałe po sparowaniu
  void Para() {
    image(cardImage, cardX, cardY);
  }
}
