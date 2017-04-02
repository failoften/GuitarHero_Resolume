

import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

ControlIO control;
ControlDevice stick;

int layerNum;
int clipNum;

public void setup() {
  size(200, 200);
  
  colorMode(RGB);
  background(0);
  
  // Initialise the ControlIO
  control = ControlIO.getInstance(this);
  // Find a device that matches the configuration file
  stick = control.getMatchedDevice("guitarhero");
  if (stick == null) {
    println("No suitable device configured");
    System.exit(-1); // End the program NOW!
  }
  
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 7001);

  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("127.0.0.1", 7000); 


  /* print your osc properties */
  //println(properties.toString());
}

public void draw() {
  // Start drawing now
  background(0);
  
  if (stick.getButton("START").pressed()) {
    beatTap(6,9);
    delay(1000);
    beatTap(6,8);
  }
  else if (stick.getButton("STRUMUP").pressed()) {
    beatTap(6,7);
    delay(420);
    beatTap(6,8);
  }
  else if (stick.getButton("LEFT").pressed()) {
    
  }
  else if (stick.getButton("RIGHT").pressed()) {
    
  }
  else if (stick.getButton("STRUM").pressed()) {
    beatTap(6,7);
    delay(420);
    beatTap(6,8);

  }
  else if (stick.getButton("YELLOW").pressed()) {
    beatTap(6,6);
    delay(420);
    beatTap(6,8);
  }
  else if (stick.getButton("ORANGE").pressed()) {
    beatTap(6,5);
    delay(420);
    beatTap(6,8);
  }
  else if (stick.getButton("BLUE").pressed()) {
    beatTap(6,4);
    delay(420);
    beatTap(6,8);
  }
  else if (stick.getButton("RED").pressed()) {
    beatTap(6,3);
    delay(420);
    beatTap(6,8);
  }
  else if (stick.getButton("GREEN").pressed()) {
    beatTap(6,2);
    delay(420);
    beatTap(6,8);
  }
  else if (stick.getButton("POWER").pressed()) {
    beatTap(6,1);
    delay(2000);
    beatTap(6,8);
  } 
  
  stick.getSlider("WHAMMY").getValue();
  stick.getSlider("GUITAR").getValue();
  stick.getSlider("STRUTS").getValue();
  
}


void beatTap(int layerNum,int clipNum) {
  // create OSC message
  OscMessage myMessage = new OscMessage("/layer"+layerNum+"/clip"+clipNum+"/connect");

  myMessage.add(1); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
  
  myMessage.add(0); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
}