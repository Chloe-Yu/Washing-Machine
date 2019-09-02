`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/19 09:16:08
// Design Name: 
// Module Name: alert
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alarm(input change,start,on,alert,clk,div_clk,
input[1:0]state,
output reg finished,alarm,output off,show_beg//off show_beg only for sim
    );
reg  last_change,beg,last_on,last_start,last_alert;
reg [1:0] last_state;
reg [4:0]counter,last_counter;
//wire off;//only for imp
assign show_beg=beg;//only for sim
flash fl( beg,clk, state,off);

    initial
    fork
    finished<=0;
    alarm<=0;
    last_change<=0;
    last_on<=0;
    last_start<=0;
    last_alert<=0;
    last_state<=2'b00;
    counter<=0;
    last_counter<=0;
    beg<=0;
    join
    
 // always@(posedge div_clk) //for imple
  always@(posedge clk)

  begin
   if(on==1 && last_state==2'b00) //reset finished when it starts again
   begin
   finished=0;
   beg=1;
   counter=0;
   end
  else if(last_on==0 && on==1) beg=1;
  else if( state!=2'b00 && last_start==0 && start==1)//don't respond to other buttons when it's off
  begin   
    beg=1;
  end
  else if( state!=2'b00 && last_change==0 && change==1 && state!=2'b10)//only can change when paused or selecting mode.
    begin
    beg=1;
  end
  else if(on==1 && last_alert==0 && alert==1 && state==2'b10)// flash 9 times
   begin
     counter=16;
     last_counter=counter;  
     beg=1;
   end
else if(counter!=0)
      begin
      last_counter=counter;
         counter=counter-1; 
         if(counter%2==0) beg=1; else beg=0;         
     end
else if(last_counter!=0 && counter==0)//9 alarms over
    begin
    finished=1;
    last_counter=0;
    beg=0;
    end
else
begin
    beg=0;
end
 last_change=change;
   last_on=on;
   last_start=start;
   last_alert=alert;
   last_state=state;
end

 //set alarm with signal off and beg
always@(posedge clk)
#1
if(off==1||state==2'b00)
  alarm=0;
 else if (beg==1)
  alarm=1;
endmodule


//recieves beg and then begin to count ,when time's up send signal off
//basically a counter
module flash(input beg,clk,input[1:0] state,output reg off);
//parameter N = 6;  //for implemetation
    parameter N = 4;
parameter delay=N/2 -1;
reg [31:0] counter=0;             
 reg last;
 initial last=0;               
  initial
   begin
   last=0;
  counter=0;
  off=0;
  end                   
  
always @(posedge clk) 
 begin
if(last==1 && beg==1) off=1;else    //for sim
if(state==2'b00) counter=0;
else #1
 if(beg==1)
  begin
    counter=counter+1;    
    off=0;  
         if(counter==delay)
         begin
         off=1;//time's up 
         counter=0;
         end
  end
  else if(beg==0)
     off=0;
     
    last=beg;
end   
endmodule
