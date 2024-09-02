void setup() {
  pinMode(3, INPUT);
  pinMode(12, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  if(digitalRead(3) == LOW){
    Serial.println("on");
    digitalWrite(12,HIGH);
    delay(1000);  
  }
  else{
    digitalWrite(12,LOW);
    Serial.println("off");
    delay(1000);
  }

}
