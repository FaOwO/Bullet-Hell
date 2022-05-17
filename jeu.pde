import processing.serial.*;

char c;
String chaineRecup;
String [] dataTrie;
int redperso = 320;
int bluepersoX = 0;
int bluepersoY = 0;
PImage tank;
PImage vaisseau;


void setup()
{
  size(640,960);
  tank = loadImage("RedPlayer.png");
  vaisseau = loadImage("BluePlayer.png");
  
  list_des_ports=Serial.list();
  
  NomDuPort = Serial.list()[indice_port];
  ArduinoSerialPort = new Serial(this, NomDuPort, serialSpeed);
}

void draw()
{
  background(3,34,76);
  image(tank,redperso,850);
  image(vaisseau, bluepersoX, bluepersoY);
}

void keyPressed()
{
  if (key == CODED) {
    if (keyCode == LEFT) {
      redperso -= 5;}
    if (keyCode == RIGHT) {
      redperso += 5;}
  }
}

void serialEvent(Serial ArduinoSerialPort)
{
  c = char(ArduinoSerialPort.read());
  if (c != '#' && c != '@'){
    chaineRecup += c;
  }
  dataTrie = split(chaineRecup, ";");
  bluepersoX = int(dataTrie[0]);
  bluepersoY = int(dataTrie[1]);
}
