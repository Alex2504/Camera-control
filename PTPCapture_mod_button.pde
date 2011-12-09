#include <inttypes.h>
#include <avr/pgmspace.h>

#include <avrpins.h>
#include <max3421e.h>
#include <usbhost.h>
#include <usb_ch9.h>
#include <Usb.h>
#include <usbhub.h>
#include <address.h>

#include <printhex.h>
#include <message.h>
#include <hexdump.h>
#include <parsetools.h>

#include <ptp.h>

const int buttonPin = 2;
int buttonState = 0; 


class CamStateHandlers : public PTPStateHandlers
{
      enum CamStates { stInitial, stDisconnected, stConnected };
      CamStates stateConnected;
    
public:
      CamStateHandlers() : stateConnected(stInitial) {};
      
      virtual void OnDeviceDisconnectedState(PTP *ptp);
      virtual void OnDeviceInitializedState(PTP *ptp);
} CamStates;

USB      Usb;
USBHub   Hub1(&Usb);
PTP      Ptp(&Usb, &CamStates);

void CamStateHandlers::OnDeviceDisconnectedState(PTP *ptp)
{
   
}

void CamStateHandlers::OnDeviceInitializedState(PTP *ptp)
{
         ptp->CaptureImage();   
      
       }  
         
        
          
void setup() 
{
    Serial.begin( 115200 );
    Serial.println("Start");
    pinMode(buttonPin, INPUT); 


    if (Usb.Init() == -1)
        Serial.println("OSC did not start.");
      
  
    
}

void loop() 
{
    
 if (buttonState == HIGH) Usb.Task();
  
   
}

