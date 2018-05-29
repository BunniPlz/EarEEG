

//////////////////////////////////////////////////////////////
//
// This class creates and manages the messaging to the Hex Bug
//
// Created: Chip Audette, May-June 2014
//
///////////////////////////////////////////////////////////////

class HexBug {
      
   private int wait_millis = 5;
   private boolean fireBetweenMoves = false;
  
  //create inner class to wrap up a "command"
  class Command {
    private String command_str;
    private String name;
    private int counter;
    private Serial serial_h;
    public boolean printReceivedCommand = false;
    public int ID;
    
    Command(Serial _serial_h, String _str, String _name, int _ID) {
      serial_h = _serial_h;
      command_str = _str;
      name =_name;
      counter = 0;
      ID = _ID;
    }
    
    public int issue() {
      counter++;
      if (printReceivedCommand) println("HexBug: Command: " + name + " (" + counter + ")");
      if (serial_h != null) serial_h.write(command_str);
      
      println("issue executed: command sent:" + command_str);
      
  //ADDED START
      
      if ( hexBug_serial.available() > 0) 
        {  // If data is available,
          val = hexBug_serial.readStringUntil('\n');         // read it and store it in val
        } 
      if ( val != null)
        {
          println("Arduino is receiving command for: " + val); //print it out in the console
        }
        
  //ADDED END
  
      return ID;
    }
  } //close definition of class Command
    
  private Command command_fire, command_forward, command_reverse, command_left, command_right; 
  private int prev_command = -1;
  
  //Constructor, pass in an already-opened serial port
  HexBug(Serial serialPort) {
    int ID = 0;
    command_fire = new Command(serialPort,"|","Fire!",ID++);
    command_left = new Command(serialPort,"{","LFT",ID++);
    command_right = new Command(serialPort,"}","RGT",ID++);
    command_forward = new Command(serialPort,"P","FWD",ID++);
    command_reverse = new Command(serialPort,"R","RVS",ID++);
    //command_shutdown = new Command(serialPort,"H","All",ID++);
  }
 
  /* Start kp
  public void fire() {
    prev_command = command_fire.issue();
  }
  public void forward() {
 //   if (fireBetweenMoves & (prev_command != command_forward.ID)) {
 //     prev_command = command_fire.issue();  //issue a FIRE command on a transition
//      waitMilliseconds(wait_millis);
 //   }
    prev_command = command_forward.issue();
  }
  public void left() {
 //   if (fireBetweenMoves & (prev_command != command_left.ID)) {
 //    prev_command = command_fire.issue();  //issue a FIRE command on a transition
//      waitMilliseconds(wait_millis);
//    }
    prev_command = command_left.issue();
  }
  public void right() {
 //   if (fireBetweenMoves & (prev_command != command_right.ID)) {
 //    prev_command = command_fire.issue();  //issue a FIRE command on a transition
//      waitMilliseconds(wait_millis);
//    }
    prev_command = command_right.issue();
  }
  
  public void waitMilliseconds(int dt_millis) {
      int start_time = millis();
      int t = millis();
      while (t-start_time < dt_millis) {
        t = millis();
      }
  }

}
Done kp*/

public void fire() {
    prev_command = command_fire.issue();
  }
  public void forward() {
    if (prev_command != command_forward.ID) prev_command = command_fire.issue();  //issue a FIRE command on a transition
    prev_command = command_forward.issue();
  }
  public void reverse() {
    if (prev_command != command_reverse.ID) prev_command = command_fire.issue();  //issue a FIRE command on a transition
    prev_command = command_reverse.issue();
  }
  public void left() {
    if (prev_command != command_left.ID) prev_command = command_fire.issue();  //issue a FIRE command on a transition
    prev_command = command_left.issue();
  }
  public void right() {
    if (prev_command != command_right.ID) prev_command = command_fire.issue();  //issue a FIRE command on a transition
    prev_command = command_right.issue();
  }
  
public void waitMilliseconds(int dt_millis) {
      int start_time = millis();
      int t = millis();
      while (t-start_time < dt_millis) {
        t = millis();
      }
  }
}