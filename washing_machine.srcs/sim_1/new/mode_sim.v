`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/24 21:01:36
// Design Name: 
// Module Name: mode_sim
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


module mode_sim(

    );
    reg [1:0] state;
    reg change,clk;
    wire [2:0]  mode; 
    select_mode  sm(change,clk, state,mode );
    
    initial
    begin
    clk=0;
    change=0;
    state=2'b00;
    change=#2 1;
    change=#2 0;
    
    state=#2 2'b01;
    
    change=#2 1;
    change=#2 0;
    
    change=#2 1;
    change=#2 0;
    
    change=#2 1;
    change=#2 0; 
      
      
    change=#2 1;
    change=#2 0; 
     
    change=#2 1;
    change=#2 0; 
     
    change=#2 1;
    change=#2 0; 
     
    change=#2 1;
    change=#2 0;  
     
    state=#2 2'b10;
     
    change=#2 1;
    change=#2 0;  
       
    state=#2 2'b11;    
    change=#2 1;
    change=#2 0; 
       
    change=#2 1;
    change=#2 0;
       
    change=#2 1;
    change=#2 0;
       
    change=#2 1;
    change=#2 0; 
              
    change=#2 1;
    change=#2 0; 
        
    change=#2 1;
    change=#2 0; 
        
    change=#2 1;
    change=#2 0; 
     
    end
  
    always #1 clk=~clk;
   // always #5 clk_div=~clk_div;
    
    
endmodule
