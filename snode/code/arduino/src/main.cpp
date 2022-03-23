/*
 * Comments
 */

#include <Arduino.h>
#include <pinouts.h>

#include <DS18B20.h>
#include <Wire.h>    // I2C library
#include "ccs811.h"  // CCS811 library
// light sensor
// soil humidity sensor
#include <cJSON.h>

#define DEVICE_ID       2
#define BLINK_INTERVAL  500  //ms
#define UPDATE_INTERVAL 3000 //ms
#define DEBUG_BAUDRATE  115200
#define RS485_BAUDRATE  9600

uint64_t led_millis, main_millis;
CCS811 ccs811(VOC_SENSOR_WAKE_PIN);
DS18B20 ds(TEMP_SENSOR_PIN);

float temp_val = 0;
uint16_t eco2_val, etvoc_val, errstat, raw;
uint16_t soil_adc_val = 0;
uint16_t light_adc_val = 0;

void update_data(void); // MAIN thread
char *create_message(float, uint16_t, uint16_t, uint16_t, uint16_t);

void setup() {
  Serial.begin(DEBUG_BAUDRATE);
  // --------------------------------- INDICATOR LED
  pinMode(BUILTIN_LED,OUTPUT);
  digitalWrite(LED_BUILTIN, HIGH);
  // --------------------------------- SOIL MOISTURE AND LIGHT SENSOR
  pinMode(SOIL_MOISTURE_PIN,INPUT);
  pinMode(LIGHT_SENSOR_PIN,INPUT);
  // --------------------------------- CCS811 VOC SENSOR
  Wire.begin(); // Enable I2C
  // Enable CCS811
  ccs811.set_i2cdelay(50); // Needed for ESP8266 because it doesn't handle I2C clock stretch correctly
  bool ok= ccs811.begin(); if( !ok ) Serial.println("setup: CCS811 begin FAILED");
  // Start measuring
  ok= ccs811.start(CCS811_MODE_1SEC); if(!ok) Serial.println("setup: CCS811 start FAILED");

  // --------------------------------- DS18B20 don't need further initialization

  // --------------------------------- RS485 through UART
  Serial2.begin(RS485_BAUDRATE);
  Serial2.println("Slave ready to communicate");

  // --------------------------------- Enter ready state
  Serial.println("Slave ready");
  led_millis = millis();
  main_millis = millis();
}

void loop()
{
  // --------------------------------- LED interval
  if ((millis()-led_millis)>BLINK_INTERVAL)  
  {
    digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN)); // toggle
    led_millis = millis();
  }
  
  // --------------------------------- Main Task interval
  if ((millis()-main_millis)>UPDATE_INTERVAL) 
  {
    update_data();
    main_millis = millis();
  }

}

void update_data(void)
{
  // --------------------------------- SOIL MOISTURE AND LIGHT
  soil_adc_val = analogRead(SOIL_MOISTURE_PIN);
  light_adc_val = analogRead(LIGHT_SENSOR_PIN);
  // --------------------------------- CCS811 VOC SENSOR
  ccs811.read(&eco2_val,&etvoc_val,&errstat,&raw); 
  // Print measurement results based on status
  if( errstat==CCS811_ERRSTAT_OK ) {} else if( errstat==CCS811_ERRSTAT_OK_NODATA ) { // waiting for (new) data
  } else if( errstat & CCS811_ERRSTAT_I2CFAIL ) { 
    Serial.println("CCS811: I2C error");
  } else {
    Serial.print("CCS811: errstat="); Serial.print(errstat,HEX); 
    Serial.print("="); Serial.println( ccs811.errstat_str(errstat) );
  }

  // --------------------------------- DS18B20 Temperature SENSOR
  while (ds.selectNext()) {temp_val = ds.getTempC();}
  
  // --------------------------------- RS485 send out through UART
  char* msg = create_message(temp_val,soil_adc_val,light_adc_val,eco2_val,etvoc_val);
  Serial.println(msg);
  Serial2.println(msg);
  free(msg);

  // ========= must have for timer lib
  // return true; 
}
//NOTE: Returns a heap allocated string, you are required to free it after use.
char *create_message(float temp, uint16_t soil, uint16_t light, uint16_t co2, uint16_t voc) //with helpers
{
    char *string = NULL;

    cJSON *message = cJSON_CreateObject();
    if ((cJSON_AddNumberToObject(message, "id", DEVICE_ID) == NULL)       ||
        (cJSON_AddNumberToObject(message, "temp", temp) == NULL)  ||
        (cJSON_AddNumberToObject(message, "soil", soil) == NULL)  ||
        (cJSON_AddNumberToObject(message, "ligh", light) == NULL) ||
        (cJSON_AddNumberToObject(message, "eco2", co2) == NULL)   ||
        (cJSON_AddNumberToObject(message, "evoc", voc) == NULL)
       ) {goto end;}

    string = cJSON_Print(message);
    if (string == NULL) {fprintf(stderr, "Failed to print message.\n");}
end:
    cJSON_Delete(message);
    return string;
}