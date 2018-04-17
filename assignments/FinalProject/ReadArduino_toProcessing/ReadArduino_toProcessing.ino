/*
Kyle Gapulan
 CART353
 Prof. R. Khaled
 April 10 2018
 
 Full Prototype (Arduino Portion, requires Processing Sketch to work)
 
 */

//Uncomment these if we want to detect values from two different analog pins
//int AnalogPin0 = A0; //Declare an integer variable, hooked up to analog pin 0
//int AnalogPin1 = A1; //Declare an integer variable, hooked up to analog pin 1

int inPin = 0;            // Use input pin 0 to listen to energy fields 
int val = 0;           // Make a variable where we store the info we receive from pin 0
int pin11 = 13;         // This is the output that sends electricity to the LED (if we want LED output)

void setup() {
  Serial.begin(9600); //Begin Serial Communication with a baud rate of 9600
}

void loop() {
   //New variables are declared to store the readings of the respective pins
  //int Value1 = analogRead(AnalogPin0);
  //int Value2 = analogRead(AnalogPin1);

  val = analogRead(inPin);                    // reads in the values from analog 5 and
                                                                   //assigns them to val
  if(val >= 1){
    
    val = constrain(val, 1, 700);               // mess with these values                                       
    val = map(val, 1, 400, 1, 255);        // to change the response distance of the device. 
    analogWrite(11, val);                    // *note also messing with the resistor should change the sensitivity 
                                             // analogWrite(pin11, val); just tuns on the led with the intensity of the variable val  
 tone(3,val*50, (255 - val));            // the "tone" function creates a musical tone. You have to give it a pin, a frequency, and a duration in milliseconds
                                             // if you want to hear sound as well as see the LED, connect a piezo speaker, and connect the red wire to pin 3 and black to GND
  
  /*The Serial.print() function does not execute a "return" or a space
      Also, the "," character is essential for parsing the values,
      The comma is not necessary after the last variable.*/
  
  Serial.print(val, DEC); 
  //Serial.print(",");
  //Serial.print(Value2, DEC);
  Serial.println();
  delay(500); // Read the value every 500 frames (will be removed later)
}
}
