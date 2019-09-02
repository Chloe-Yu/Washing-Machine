`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/18 11:36:21
// Design Name: 
// Module Name: disp_time
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
module time_to_display(input change,input[2:0] mode,input[2:0]weight,state,input clk,div_clk,
output reg [5:0]total_time,section_time
    );
    //calculate total time and section time
    reg [3:0]cleaning_time,dehydrating_time;
    reg [4:0]rinsing_time;
    reg flag1,flag2,flag3,flag4,flag5,flag6,flag7,flag8;
    initial
    begin
    total_time=0;
    section_time=0;
    flag1=1;
    flag2=1;
    flag3=1;
    flag4=1;
    flag5=1;
    flag6=1;
    flag7=1;
    flag8=1;
    end
    
 always@(posedge div_clk)
 #3  case(state)
      2'b00://initialize
      fork
      total_time=0;
      section_time=0;
      //change time according to weight
      cleaning_time=weight+9;
      rinsing_time=weight+6+weight+3;
      dehydrating_time=weight+3;
      flag1=1;
      flag2=1;
      flag3=1;
      flag4=1;
      flag5=1;
      flag6=1;
      flag7=1;
      flag8=1;
      join
      2'b01:
      begin//still able to change weight
      cleaning_time=weight+9;
      rinsing_time=weight+6+weight+3;
      dehydrating_time=weight+3;
      flag1=1;
      flag2=1;
      flag3=1;
      flag4=1;
      flag5=1;
      flag6=1;
      flag7=1;
      flag8=1;
    case(mode)//calculate initial time according to mode
     3'b111:
     fork
     total_time=cleaning_time+rinsing_time+dehydrating_time;   
     section_time=cleaning_time;
     join
     3'b100:
     fork
     total_time=cleaning_time;
     section_time=cleaning_time;
     join   
     3'b110:
     fork
     total_time=cleaning_time+rinsing_time;
     section_time=cleaning_time;
     join
     3'b010:
     fork
     total_time=rinsing_time;
     section_time=rinsing_time;
     join
     3'b011:
     fork
     total_time=rinsing_time+dehydrating_time;
     section_time=rinsing_time;
     join
     3'b001:
     fork
     total_time=dehydrating_time;
     section_time=dehydrating_time;
     join
    default: 
    fork
    total_time=0;
    section_time=0;
    join
    endcase
   end
     2'b10://time decreases with every clock signal
 begin
 
     case(mode)
     3'b111:  
      if((section_time!=0)&&flag1)
      fork
      total_time=total_time-1;
      section_time=section_time-1;
      join
      else if((section_time==0)&&flag2)
      fork
      flag1=0;
      section_time=rinsing_time;
      flag2=0;
      join
      else if((section_time!=0)&&flag3)
      fork
      total_time=total_time-1;
      section_time=section_time-1;
      join
      else if((section_time==0)&&flag4)
      fork
      flag3=0;
      section_time=dehydrating_time;
      flag4=0;
      join
      else if(section_time!=0)
      fork
      total_time=total_time-1;
      section_time=section_time-1;
      join
      else
      fork
      total_time=0;
      section_time=0;
      join
      3'b100,3'b010,3'b001:
        if((section_time!=0))
          fork
          total_time=total_time-1;
          section_time=section_time-1;
          join
          else 
          fork
                total_time=0;
                section_time=0;
          join
      3'b110:
        if((section_time!=0)&&flag5)
          fork
          total_time=total_time-1;
          section_time=section_time-1;
          join
          else if((section_time==0)&&flag6)
          fork
          flag5=0;
          section_time=rinsing_time;
          flag6=0;
          join
          else if(section_time!=0)
          fork
          total_time=total_time-1;
          section_time=section_time-1;
          join
          else
          fork
                total_time=0;
                section_time=0;
          join
      3'b011:
        if((section_time!=0)&&flag7)
        fork
        total_time=total_time-1;
        section_time=section_time-1;
        join
        else if((section_time==0)&&flag8)
        fork
        flag7=0;
        section_time=dehydrating_time;
      
        flag8=0;
        join
        else if(section_time!=0)
        fork
        total_time=total_time-1;
        section_time=section_time-1;
        join
        else
        fork
              total_time=0;
              section_time=0;
        join
      default:;
      endcase
    end
     2'b11: ;//do nothing
    default:
    fork
    total_time=0;
    section_time=0;
    join
    endcase

endmodule



module display(input [1:0]state,input[5:0]total,section,input[2:0]weight,input clk,output reg [7:0] code,seg_sel);
//七端显示管 10进制变高低位，再分别显示
wire div_seg;
reg [3:0] cur;
reg[2:0] counter;
div d2( clk, div_seg );

initial
fork
counter<=0;
seg_sel<=8'b11111111;
cur<=0;
code=8'b11000000;
join

always@(posedge div_seg)
//counter circle from 1 to 6
begin
 if(counter!=6)
 counter=counter+1;
 else
 counter=1;
 
 if(state==2'b00) seg_sel=8'b11111111;
 else
case(counter)//each value of counter corresponds to a different place to display
3'b001:fork cur=total%10;seg_sel=8'b11111110;join
3'b010:fork cur=total/10;seg_sel=8'b11111101;join
3'b011:fork cur=section%10;seg_sel=8'b11111011;join
3'b100:fork cur=section/10;seg_sel=8'b11110111;join
3'b101:fork cur=weight;seg_sel=8'b11101111;join
3'b110:fork cur=0;seg_sel=8'b11011111;join
endcase
//change it to 7-seg code
case(cur)
4'b0000:
code=8'b11000000;
4'b0001:
code=8'b11111001;
4'b0010:
code=8'b10100100;
4'b0011:
code=8'b10110000;
4'b0100:
code=8'b10011001;
4'b0101:
code=8'b10010010;
4'b0110:
code=8'b10000010;
4'b0111:
code=8'b11111000;
4'b1000:
code=8'b10000000;
4'b1001:
code=8'b10011000;
default:;
endcase

end

endmodule


module div(input clk,output reg div_clk );

    parameter N = 100_000;      // 显示的最佳频率
    parameter delay=N/2 -1;
    reg [31:0] counter=0;             /* 计数器变量，通过计数实现分频。
                                   当计数器从0计数到(N/2-1)时，
                                   输出时钟翻转，计数器清零 */
    initial div_clk=1;
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
