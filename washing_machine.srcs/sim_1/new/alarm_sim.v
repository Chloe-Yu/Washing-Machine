`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/25 08:00:22
// Design Name: 
// Module Name: alarm_sim
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


module alarm_sim(

    );
    reg change,start,on,alert,clk,div_clk;
    reg[1:0] state;
    wire finished,alarm,off,beg;
    alarm  ala(change,start,on,alert,clk,div_clk,state,finished,alarm,off,beg);
    initial
    fork
    state<=2'b00;
    change<=0;
    start<=0;
    alert<=0;
    on<=0;
    clk=0;
    div_clk=0;
    #1 change<=1;
    #3 change<=0;
    #5 start<=1;
    #7 start<=0;
    #11 on<=1;
    
    
    #11 state<=2'b01;
  
    
     #60 change<=1;
     #72 change<=0;
     
     #90 start<=1;
     #90 state<=2'b10;
     
         #100 on<=0;
         #100 state<=2'b00;
         #110 on<=1;
        #110 state<=2'b01;
        
        
   #130 change<=1;
   #140 change<=0;
          
         #155 start<=0;
         #155 state<=2'b11;
          
         #180 start<=1;
          #180 state=2'b10;
          
          #200 start<=0;
          #200 state<=2'b11;
 
          #230 change<=1;
          #230 state<=2'b01;
          #241 change<=0;
         
         
          #290 state=2'b10;
          
           #300 alert<=1;
           #311 alert<=0;
      
          
              #600 on<=0;
              #600 state=2'b00;
              
              
    join
     
     always
     #2 clk<=~clk;
     
     always
     #6 div_clk<=~div_clk;
endmodule
