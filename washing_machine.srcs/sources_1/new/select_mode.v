`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/18 10:46:50
// Design Name: 
// Module Name: select_mode
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

module select_mode//select the running mode of the washing machine

(
input change,clk,
input[1:0] state,
output reg [2:0] mode
    );
  reg last;
  
   initial
   fork
    mode<=3'b111;
    last<=0;
   join
    
 always@( posedge clk)
      case(state)
      2'b00: mode=3'b111;//off
      2'b01,2'b11://select or pause
      begin
        if(last==0&&change==1)
        case(mode)
         3'b111:mode=3'b100;
         3'b100:mode=3'b110;
         3'b110:mode=3'b010;
         3'b010:mode=3'b011;
         3'b011:mode=3'b001;
         3'b001:mode=3'b111;
         default:mode=3'b111;
         endcase
          last=change;
         end
      2'b10:;//when change while running do nothing
      default:mode=3'b111;
      endcase

endmodule
