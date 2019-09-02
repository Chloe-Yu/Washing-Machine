`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/24 17:59:01
// Design Name: 
// Module Name: sim_main
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


module sim_main(

    );
    reg power,clk,start,change;
    reg[1:0] weight;
    wire[7:0]lights, code, seg_sel;
    wire[1:0] state;
    wire[2:0] mode;
    wire div_clk;
    main m(power,clk,start,change, weight,lights,code,seg_sel,state ,mode,div_clk);
//start with prolonging the interval
    initial
    begin
    //2'b00
    clk=1;
    power=0;
    start=0;
    change=0;
    weight=2;
    change=#3 1;
    change=#10 0;
    
  /*power= #7 1;
    power= #10 0;
    //2'b01
    change=#10 1;
    change=#10 0;
    
    change=#10 1;
    change=#10 0;
    
    start=#10 1;
    start=#11 0;
    //2'b10
    change=#10 1;
    change=#10 0;
   
    start=#10 1;
    start=#11 0;
    //2'b11
    start=#10 1;
    start=#11 0;
    //2'b10
    start=#10 1;
    start=#16 0;
    //2'b11
    change=#10 1;
    change=#11 0;
    //2'b01
    start=#10 1;
    start=#11 0;*/
    //2'b10
    
    end
    always
    # 2 clk=~clk;
    
    
    

endmodule
