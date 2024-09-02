#include <Servo.h> //includes the servo library
#include <Wire.h> 
#include <SoftwareSerial.h>

SoftwareSerial bluetooth(10, 11); // RX, TX
Servo myservo;

#define ir_enter 3
#define ir_back  7

int flag1=0, flag2=0; 
int Slot = 6;  

int data1, data2, data5, data6;
String message = "";
int ir1 = 2;
int ir2 = 5;
int ir5 = 9;
int ir6 = 12;

//no ir2 and ir3

void setup(){ 
  
bluetooth.begin(9600);
Serial.begin(9600);
pinMode(ir_enter, INPUT);
pinMode(ir_back, INPUT);

pinMode(ir1, INPUT);
pinMode(ir2, INPUT);
pinMode(ir5, INPUT);
pinMode(ir6, INPUT);

myservo.attach(6);
myservo.write(90);
Serial.println("Car Parking System"); 

}

void loop(){
  
  if(digitalRead (ir_enter) == LOW && flag1==0){
    if(Slot>0){
      flag1=1;
      if(flag2==0){
        myservo.write(180); 
        Slot = Slot-1;
        Serial.println(Slot);
       }
    }
    else{
    Serial.println(" Sorry Parking Full ");  
    }
  }
  
  if(digitalRead(ir_back) == LOW && flag2==0){
    flag2=1;
    if(flag1==0){
      myservo.write(180); 
      Slot = Slot+1;
      Serial.println(Slot);
      }
  }
  
  if(flag1==1 && flag2==1){
    delay (1000);
    myservo.write(90);
    flag1=0, flag2=0;
  }


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

  delay(1000);
}
