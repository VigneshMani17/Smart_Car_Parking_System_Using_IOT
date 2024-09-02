#include <SoftwareSerial.h>

SoftwareSerial bluetooth(10, 11); // RX, TX

int data1, data2, data5, data6;
String message = "";
int ir1 = 2;
int ir2 = 5;
int ir5 = 9;
int ir6 = 12;
  
void setup() {
  
pinMode(ir1, INPUT);
pinMode(ir2, INPUT);
pinMode(ir5, INPUT);
pinMode(ir6, INPUT);
  
  bluetooth.begin(9600);
  Serial.begin(9600);
  
}

void loop() {
   if(digitalRead(ir1) == LOW){
    data1 = 1;
  }
  if(digitalRead(ir1) == HIGH){
    data1 = 0;
  }
  if(digitalRead(ir2) == LOW){
    data2 = 1;
  }
  if(digitalRead(ir2) == HIGH){
    data2 = 0;
  }
  if(digitalRead(ir5) == LOW){
    data5 = 1;
  }
  if(digitalRead(ir5) == HIGH){
    data5 = 0;
  }
  if(digitalRead(ir6) == LOW){
    data6 = 1;
  }
  if(digitalRead(ir6) == HIGH){
    data6 = 0;
  }

  message = "0,";
  message+=String(data1);
  message+=",";
  message+=String(data2);
  message += ",";
  message+=String(data5);
  message += ",";
  message+=String(data6);

  bluetooth.println(message);
  Serial.println(message);

  delay(1000); // Adjust delay as needed
}
