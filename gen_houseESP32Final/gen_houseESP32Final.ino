#include <Wire.h>
#include <WiFi.h>
#include <sntp.h>
#include <time.h>
#include <IOXhop_FirebaseESP32.h>
#include "DHT.h"
#include <ESP32Servo.h>
#include <LiquidCrystal_I2C.h>

/* Task Handler */
TaskHandle_t Task1;
TaskHandle_t Task2;
TaskHandle_t Task3;

/* PINS */
const int dht_pin = 5;
#define DHTTYPE DHT11
DHT dht(dht_pin, DHTTYPE);

const int ldr_pin = 4;
const int flame_pin = 15;
const int doorsensor_pin = 17;
const int doorlock_pin = 14;
const int led1_pin = 27;
const int led2_pin = 26;
const int fan_pin = 25;
const int pump_pin = 33;
const int servo_pin = 32;
Servo gateS;

/* NTP LCD */
const char* ntpServer1 = "pool.ntp.org";
const long gmtOffset_sec = 25200;
const int daylightOffset_sec = 3600;

/* Database */
// Connection
#define FIREBASE_HOST "https://genhousedb-default-rtdb.asia-southeast1.firebasedatabase.app/"
#define FIREBASE_AUTH "qhkYi9MrdQfBzqT2dsgDSZ9UChTRBU4TYx2AKSOE"
#define WIFI_SSID "Violet Corner"
#define WIFI_PASSWORD "ambatron"

/* NTP Function */
void printLocalTime() {
  struct tm timeinfo;
  if (!getLocalTime(&timeinfo)) {
    Serial.println("No Time available");
    return;
  }

  LiquidCrystal_I2C lcd(0x27, 16, 2);
  lcd.init();
  lcd.backlight();
  lcd.clear();
  lcd.print(&timeinfo, "%d %B %Y"); // date-month-year
  lcd.setCursor(0, 1);
  lcd.print(&timeinfo, "%H:%M"); // day-hour-minute-second
}

void timeavailable(struct timeval *t) {
  Serial.println("Got time adjustment from NTP!");
  printLocalTime();
}

void setup() {
  Serial.begin(115200);
  Serial.println("DHT11 test!");
  dht.begin();
  gateS.attach(servo_pin);

  // NTP
  sntp_set_time_sync_notification_cb(timeavailable);
  configTime(gmtOffset_sec, daylightOffset_sec, ntpServer1);

  // Connect to Internet and Database
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to ");
  Serial.print(WIFI_SSID);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println();
  Serial.print("Connected, IP address: ");
  Serial.println(WiFi.localIP());
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);

  // Identification pin
  pinMode(ldr_pin, INPUT);
  pinMode(flame_pin, INPUT);
  pinMode(doorsensor_pin, INPUT);
  pinMode(doorlock_pin, OUTPUT);
  pinMode(led1_pin, OUTPUT);
  pinMode(led2_pin, OUTPUT);
  pinMode(fan_pin, OUTPUT);
  pinMode(pump_pin, OUTPUT);

  xTaskCreatePinnedToCore(TaskSensors, "TaskSensors", 10000, NULL, 1, &Task1, 0);
  xTaskCreatePinnedToCore(TaskActuators, "TaskActuators", 10000, NULL, 1, &Task2, 1);
}

void loop() {
  printLocalTime();
}

void TaskSensors(void *pvParameters) {
  for (;;) {
    float h = dht.readHumidity();
    float t = dht.readTemperature();
    int ldr = digitalRead(ldr_pin);
    int flame = digitalRead(flame_pin);
    int doorstate = digitalRead(doorsensor_pin);

    const char* day_status = (ldr == LOW) ? "BRIGHT" : "DARK";
    const char* fire_status = (flame == HIGH) ? "DETECTED" : "UNDETECTED";
    const char* door_status = (doorstate == HIGH) ? "OPEN" : "CLOSE";

    if (!isnan(h) && !isnan(t)) {
      Firebase.setFloat("genkey1/suhu", t);
      Firebase.setFloat("genkey1/kelembaban", h);
    }

    Firebase.setString("genkey1/day", day_status);
    Firebase.setString("genkey1/fire", fire_status);
    Firebase.setString("genkey1/door", door_status);
    Serial.println("Sensor Data Updated");

    vTaskDelay(pdMS_TO_TICKS(10));
  }
}

void TaskActuators(void *pvParameters) {
  for (;;) {
    String led1_status = Firebase.getString("/genkey1/led1");
    digitalWrite(led1_pin, (led1_status == "ON") ? LOW : HIGH);

    String fire_status = Firebase.getString("/genkey1/fire");
    digitalWrite(flame_pin, (fire_status == "DETECTED") ? LOW : HIGH);

    String led2_status = Firebase.getString("/genkey1/led2");
    digitalWrite(led2_pin, (led2_status == "ON") ? LOW : HIGH);

    String fan_status = Firebase.getString("/genkey1/fan");
    digitalWrite(fan_pin, (fan_status == "ON") ? LOW : HIGH);

    String servo_status = Firebase.getString("/genkey1/gate");
    gateS.write((servo_status == "OPEN") ? 90 : 0);

    String solenoid_status = Firebase.getString("/genkey1/doorlock");
    digitalWrite(doorlock_pin, (solenoid_status == "LOCK") ? LOW : HIGH);

  }

  vTaskDelay(pdMS_TO_TICKS(10));
}
