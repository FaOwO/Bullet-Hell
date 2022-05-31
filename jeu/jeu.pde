import processing.serial.*;


int largeur = 640;
int hauteur = 960;

String val;
String [] dataTrie;
String []list_des_ports;

int redperso = largeur/2;
int bluepersoX = largeur/2;
int bluepersoY = hauteur/2;

int long_list_port;
int indice_port=0;

PImage tank;
PImage vaisseau;
PImage redBullet;
PImage blueBullet;

Serial port;
int lf = 10;
int timerRedB = 0;
int timerBlueB = 0;

int timerRedH = 0;
int timerBlueH = 0;

int lifeBlue = 3;
int lifeRed = 3;

Boolean leftred = false;
Boolean rightred = false;

Boolean leftblue = false;
Boolean rightblue = false;
Boolean upblue = false;
Boolean downblue = false;

Boolean rbullet = false;
Boolean bbullet = false;
Boolean canShootRed = true;
Boolean canShootBlue = true;
Boolean canHitBlue = true;
Boolean canHitRed = true;

int vitesse = 5;
int vitesseBullet = 7;
int timerbeforeshoot = 300;
int invincibilite = 500;

ArrayList<RedBullet> listRedBullet = new ArrayList<RedBullet>();
ArrayList<BlueBullet> listBlueBullet = new ArrayList<BlueBullet>();


class RedBullet {
  int xpos, ypos;
  RedBullet (int X) {
    xpos = X;
    ypos = 930;
  }
  void update(){
    ypos-= vitesseBullet;
    
  }
}

class BlueBullet {
  int xpos, ypos;
  BlueBullet(int X, int Y) {
    xpos = X;
    ypos = Y;
  }
  void update(){
    ypos+= vitesseBullet;
  }
}

void setup()
{
  size(640,960);
  tank = loadImage("RedPlayer.png");
  vaisseau = loadImage("BluePlayer.png");
  redBullet = loadImage("RedBullet.png");
  blueBullet = loadImage("BlueBullet.png");
  list_des_ports=Serial.list();
  long_list_port = list_des_ports.length;
  if (long_list_port>0){
  if (long_list_port>1) {
  indice_port=1;
  }
  String nomDuPort = Serial.list()[indice_port];
  port = new Serial(this, nomDuPort, 9600);
  port.bufferUntil(lf);}
}

void draw()
{
  background(3,34,76);
  fill(0,128,0);
  rect(0,950,640,960);
  
  
  if (leftred){
    if (redperso >= 0) redperso -= vitesse;
  }
  
  if (rightred){
    if (redperso <= largeur - 38) redperso += vitesse;
  }
  
  image(tank,redperso,930);
  
  
  
  if (leftblue){
    if (bluepersoX >= 0) bluepersoX -= vitesse;
  }
  
  if (rightblue){
    if (bluepersoX <= largeur - 28) bluepersoX += vitesse;
  }
  
  if (upblue){
    if (bluepersoY <= hauteur - 250) bluepersoY += vitesse;
  }
  
  if (downblue){
    if (bluepersoY >= 0) bluepersoY -= vitesse;
  }
  if (bbullet && canShootBlue){
    listBlueBullet.add(new BlueBullet(bluepersoX+12,bluepersoY+26));
    canShootBlue = false;
    timerBlueB = millis();
    }
    
  if (rbullet && canShootRed){
    listRedBullet.add(new RedBullet(redperso+16));
    canShootRed = false;
    timerRedB = millis();
    }
    
  if (canShootRed == false){
    if (timerRedB + timerbeforeshoot < millis()){
      canShootRed = true;}
  }
  
  if (canShootBlue == false){
    if (timerBlueB + timerbeforeshoot < millis()){
      canShootBlue = true;}
  }
  if (canHitBlue == false){
    if (timerBlueH + invincibilite < millis()){
      canHitBlue = true;}
  }
  if (canHitRed == false){
    if (timerRedH + invincibilite < millis()){
      canHitRed = true;}
  }
  image(vaisseau, bluepersoX, bluepersoY);
  
  if (listRedBullet != null){
  for (int i = 0; i < listRedBullet.size(); i++){
    listRedBullet.get(i).update();
    image(redBullet,listRedBullet.get(i).xpos,listRedBullet.get(i).ypos);
    
    if (((bluepersoX < listRedBullet.get(i).xpos + 3) && (listRedBullet.get(i).xpos + 3 < bluepersoX + 28)) && 
      ((bluepersoY < listRedBullet.get(i).ypos) &&(listRedBullet.get(i).ypos < bluepersoY + 26)) && canHitBlue){
      lifeBlue -= 1;
      canHitBlue = false;
      timerBlueH = millis();
      print(lifeBlue);
      }
      
    if(listRedBullet.get(i).ypos < 0){
      listRedBullet.remove(i);
      }
    }
  }
  if (listBlueBullet != null){
  for (int i = 0; i < listBlueBullet.size(); i++){
    listBlueBullet.get(i).update();
    image(blueBullet,listBlueBullet.get(i).xpos,listBlueBullet.get(i).ypos);
    
        if (((redperso < listBlueBullet.get(i).xpos + 2) && (listBlueBullet.get(i).xpos + 2 < redperso + 38)) && 
      ((hauteur - 28 < listBlueBullet.get(i).ypos) &&(listBlueBullet.get(i).ypos < hauteur)) && canHitRed){
      lifeRed -= 1;
      canHitRed = false;
      timerRedH = millis();
      print(lifeRed);
      }
      
    if(listBlueBullet.get(i).ypos > hauteur){
      listBlueBullet.remove(i);
      }
    }
  }
}
void keyPressed()
{
  if (key == CODED) {
    if (keyCode == LEFT) {
      leftred = true;}
      
    if (keyCode == RIGHT) {
      rightred = true;}
  }  
  if (key == ENTER) {
    rbullet = true;}
  if (key == ' '){
    bbullet = true;}
  if (key == 'Q'|| key == 'q'){
    leftblue = true;}
  if (key == 'Z'|| key == 'z'){
    downblue = true;}
  if (key == 'S'|| key == 's'){
    upblue = true;}
  if (key == 'D'|| key == 'd'){
    rightblue = true;}
}

void keyReleased(){
  if (key == CODED){
    if (keyCode == LEFT){
      leftred = false;
    }
    
    if (keyCode == RIGHT){
      rightred = false;
    }
  }
  if (key == 'Q'|| key == 'q'){
    leftblue = false;}
  if (key == 'Z'|| key == 'z'){
    downblue = false;}
  if (key == 'S'|| key == 's'){
    upblue = false;}
  if (key == 'D'|| key == 'd'){
    rightblue = false;}
  if (key == ' '){
    bbullet = false;}
  if (key == ENTER) {
    rbullet = false;}
 
}
void serialEvent(Serial port){
  val = port.readStringUntil('\n');
  if (val.length() >= 1){
  dataTrie = split(val, ";");
  
  if (int(dataTrie[0]) >= 20){
    leftblue = true;
  } else leftblue = false;
  
  if (int(dataTrie[0]) <= -20){
    rightblue = true;
  } else rightblue = false;
  
  if (int(dataTrie[1]) >= 20){
  upblue = true;
  } else upblue = false;
  
  if (int(dataTrie[1]) <= -20){
  downblue = true;
  } else downblue = false;
  
  if (int(dataTrie[2]) == 0 || int(dataTrie[3]) == 0){
    bbullet = true;
  }else bbullet = false;
  }
}