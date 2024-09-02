#include <Servo.h>

Servo myservo;


void setup() {
  pinMode(3, INPUT);
  pinMode(7,INPUT);

  myservo.attach(6);
  myservo.write(90);

  
}

void loop() {
  if(digitalRead(3) == 0 || digitalRead(7) ==0 ){
    myservo.write(180);
  }
  else{
    myservo.write(90);
  }

}
