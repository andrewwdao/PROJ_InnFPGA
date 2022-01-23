void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  Serial2.begin(9600);
  
}

void loop() {
  // put your main code here, to run repeatedly:
  while (Serial2.available())
  {
    Serial.print((char)Serial2.read());
  }

}
