`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/18 20:32:21
// Design Name: 
// Module Name: divider
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


module divider(input clk,output reg div_clk );
//parameter N = 10;           //for simulation
 parameter N = 100_000_000;      // 1Hz的时钟,N=fclk/fclk_N   for implementation
    parameter delay=N/2 -1;
    reg [31:0] counter=0;             /* 计数器变量，通过计数实现分频。
                                   当计数器从0计数到(N/2-1)时，
                                   输出时钟翻转，计数器清零 */
     initial div_clk=0;                             
    always @(posedge clk)  begin    // 时钟上升沿
        counter=counter+1;      
             if(counter==delay)
             begin
             div_clk=!div_clk;
             counter=0;
       end
                       // 功能实现
    end          
endmodule
