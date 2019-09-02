`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/18 10:20:48
// Design Name: 
// Module Name: main
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
/*
clk is bound to clock
power,change,start are bound to sw[0] [1] [2],change activates by edge, on start depend on voltage
weight is bound to sw[4][3] reprenting four states of weights
lights are bound to led[7:0] from 0 to 7:on/start/clean/rinse/dehydrate/water_in/water_out/alert
total_h,total_l correspond to the 7-segment display signal of total time
section_h,sectionl_l correspond to the 7-segment display signal of section time
water_h,water_l correspond to the 7-segment display signal of water level
*/

module main(input pow_b,clk,start,change,input[1:0] weight,output [7:0]lights,
output [7:0] code,output [7:0] seg_sel,output[1:0] show_state,output[2:0] mode,output div_clk// div_clk mode is only for simulation
 );


wire [5:0]total_time,section_time;
wire finished;
//wire div_clk;  //used only for implementation
reg [1:0]state;
reg on;
wire alert,div_seg;
//wire[2:0]mode; //used only for implementation
reg change_when_pause;
reg power;
assign show_state=state;

select_mode sel(change,clk,state, mode);
divider d1(clk,div_clk);
display disp(state,total_time,section_time,weight+1,clk,code,seg_sel);
time_to_display timer(change,mode,weight+1,state,clk,div_clk,total_time,section_time);
alarm ala(change,start,on,alert,clk,div_clk,state,finished,lights[7]);
change_lights cl(weight+1,state,mode,div_clk,lights[6:0],alert);

initial
fork
 state=0;
 power=0;
 change_when_pause=0;
 on=0;
join
 
 
 always@(posedge div_clk)
//signal power and finished coleectively control signal on
 case(state)
 2'b00:
 begin
 if(pow_b) on=1;
 end
 2'b01:
 begin
 if(pow_b) on=0;
 end
 2'b10:
 begin
 if(pow_b||finished) on=0;
 end
 2'b11:
 begin
   if(pow_b) on=0;
 end
default:
begin
on=0;
end
endcase


always@(posedge div_clk)
#1
case(state)
2'b00:if(on)   state=2'b01;//off
2'b01:if(!on)  state=2'b00;//select mode
else if(start) state=2'b10;
2'b10:if(!on)  state=2'b00;//run the program
else if(start) state=2'b11;
2'b11:if(!on)  state=2'b00;//pause mode
else if(change) state=2'b01;
else if(start) state=2'b10;
default:state=2'b00;
endcase

endmodule