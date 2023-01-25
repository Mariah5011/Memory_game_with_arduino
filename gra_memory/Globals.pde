//-------------- importowanie bibliotek ----------------
import processing.serial.*;
import processing.sound.*;

//-------------- zmienne globalne ----------------
//x,y - współrzędne kart w tablicy
//awers - lista jaki obrazek jest w każdym miescu planszy
//  np. [1 2 3
//       1 2 3]
//cardUp - lista dwuelementowa lokalizacji kart, które sa obrócone względem lokalizacji na planszy 
//      [0 1 2
//       3 4 5]
//clicked - lista zawierająca informacje o obróceniu kart' potrzeba do tego, żeby nie poswolić na zebranie pary przez klinięcie dwa zary tego samego obrazka
//      [false true false
//      false false true]

int liczbaKart = 6;

int[] x = new int[liczbaKart];
int[] y = new int[liczbaKart];
int[] awers = new int[liczbaKart];
int[] cardUp = new int[2]; 
boolean[] clicked = new boolean[liczbaKart]; 
int flipped = 0; // określa, ile kart jest już obróconych 
int win = 0; //określa ile par już zebrano
int tableWidth = 300;
int tableHeight = 300;
int inBuffer; //zawiera informacje z Arduino
// uzaleznic odsłanianie kart od inBuffer, ktory przyjmuje wartosci guzikow tak :
// 1  2  3
// 4  5  6

PImage bg;
PImage chopsticks;
PFont myFont;
PImage sushi; 
PImage tlo;
PImage onigiri;
SoundFile music;
String text;

Serial myPort;
Button start;
Button exit;
Cards[] myCard = new Cards[liczbaKart];
Confetti[] conf = new Confetti[50]; 
int scrmode = 1;
