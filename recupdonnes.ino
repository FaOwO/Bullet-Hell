#include <Esplora.h>

void setup() {
  // put your setup code here, to run once:

}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.print(Esplora.readJoystickX());
  Serial.print(";");
  Serial.print(Esplora.readJoystickY());
  Serial.print(";");
  Serial.print(Esplora.readButton(2));
  Serial.print(";");
  Serial.print(Esplora.readButton(3));
  Serial.print(";");
  Serial.println();  
}
