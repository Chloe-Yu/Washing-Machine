`timescale 1ns / 1ps
//lights are bound to led[7:0] from 0 to 7:on 0/start 1/clean 2 /rinse 3 /dehydrate 4 /water_in 5 /water_out 6 /alert 7
module change_lights(input[2:0] weight,input[1:0]state,
input [2:0] mode,
input clk,
output reg [6:0] lights,output reg alert);
parameter DELAY=1;
reg [5:0] c1,c2,c3,c4,c5,c6;
initial
begin
lights=0;
alert=0;
 c1=0;
 c2=0;
 c3=0;
 c4=0;
 c5=0;
 c6=0;
end

always@(posedge clk)
begin
#DELAY;//hopefully the state or mode change has completed
 case(state)
 2'b00:
begin
  lights=0;
  alert=0;
  c1=0;
  c2=0;
  c3=0;
  c4=0;
  c5=0;
  c6=0;
 end
 2'b01: 
    begin
     lights[0]=1;
     lights[1]=0;
     lights[2]=mode[2];
     lights[3]=mode[1];
     lights[4]=mode[0];
     lights[5]=0;
     lights[6]=0;
     c1=0;//so that when we pause change and then resume the program,we start again
     c2=0;
     c3=0;
     c4=0;
     c5=0;
     c6=0;
    end
 2'b10: 
begin
    lights[1:0]=2'b11;
    alert=0;
    case(mode)
       3'b111:
          if(c1<(weight))
          begin
            c1=c1+1;
            lights[5]=1;
            lights[2]=~lights[2];
          end
          else if(c1<(weight+9))
          begin
            c1=c1+1;
            lights[5]=0;
             lights[2]=~lights[2];
         end
           else if(c1<2*weight+9)
           begin
           c1=c1+1;
           lights[2]=0;
           lights[3]=~lights[3];
           lights[6]=1;
           end
          else if(c1<2*weight+12)
          begin
            c1=c1+1;
            lights[3]=~lights[3];
            lights[6]=0;
          end
          else if(c1<3*weight+12)
          begin
            c1=c1+1;
            lights[3]=~lights[3];
            lights[5]=1;
         end
          else if(c1<3*weight+18)
         begin
            c1=c1+1;
            lights[3]=~lights[3];
            lights[5]=0;
          end
           else if(c1<4*weight+18)
         begin
            c1=c1+1;
            lights[3]=0;
            lights[4]=~lights[4];
            lights[6]=1;
          end
          else if(c1<4*weight+21)
          begin
            c1=c1+1;
            lights[4]=~lights[4];
            lights[6]=0;
          end
          else
          begin
            lights[4]=0;
            alert=1;
          end
       3'b100:
        if(c2<weight)
      begin
         c2=c2+1;
         lights[5]=1;
         lights[2]=~lights[2];
      end
       else if(c2<(weight+9))
       begin
         c2=c2+1;
         lights[5]=0;
          lights[2]=~lights[2];
      end
       else
      begin
       lights[2]=0;
       alert=1;
       end
       3'b110:  
       if(c3<(weight))
                 begin
                   c3=c3+1;
                   lights[5]=1;
                   lights[2]=~lights[2];
                 end
        else if(c3<(weight+9))
                 begin
                   c3=c3+1;
                   lights[5]=0;
                    lights[2]=~lights[2];
                end
        else if(c3<2*weight+9)
                 begin
                  c3=c3+1;
                  lights[2]=0;
                  lights[3]=~lights[3];
                  lights[6]=1;
                  end
           else if(c3<2*weight+12)
                 begin
                   c3=c3+1;
                   lights[3]=~lights[3];
                   lights[6]=0;
                 end
          else if(c3<3*weight+12)
                 begin
                   c3=c3+1;
                   lights[3]=~lights[3];
                   lights[5]=1;
                end
          else if(c3<3*weight+18)
                 begin
                   c3=c3+1;
                   lights[3]=~lights[3];
                   lights[5]=0;
                 end
           else
                 begin
                   lights[3]=0;
                   alert=1;
                 end       
       3'b010:
         if(c4<weight)
                 begin
                 c4=c4+1;
                 lights[3]=~lights[3];
                 lights[6]=1;
                 end
                else if(c4<weight+3)
                begin
                  c4=c4+1;
                  lights[3]=~lights[3];
                  lights[6]=0;
                end
                else if(c4<2*weight+3)
                begin
                  c4=c4+1;
                  lights[3]=~lights[3];
                  lights[5]=1;
                end
                else if(c4<2*weight+9)
                begin
                  c4=c4+1;
                  lights[3]=~lights[3];
                  lights[5]=0;
                end
                 else 
                begin
                  lights[3]=0;
                  alert=1;
                end
       3'b011:
       if(c5<weight)
                        begin
                        c5=c5+1;
                        lights[3]=~lights[3];
                        lights[6]=1;
                        end
                       else if(c5<weight+3)
                       begin
                         c5=c5+1;
                         lights[3]=~lights[3];
                         lights[6]=0;
                       end
                       else if(c5<2*weight+3)
                       begin
                         c5=c5+1;
                         lights[3]=~lights[3];
                         lights[5]=1;
                       end
                       else if(c5<2*weight+9)
                       begin
                         c5=c5+1;
                         lights[3]=~lights[3];
                         lights[5]=0;
                       end
                        else if(c5<3*weight+9)
                                begin
                                  c5=c5+1;
                                  lights[3]=0;
                                  lights[4]=~lights[4];
                                  lights[6]=1;
                                end
                                else if(c5<3*weight+12)
                               begin
                                  c5=c5+1;
                                  lights[4]=~lights[4];
                                  lights[6]=0;
                                end
                                else
                                begin
                                  lights[4]=0;
                                  alert=1;
                                end
       3'b001:
        if(c6<weight)
                begin
                  c6=c6+1;
                  lights[4]=~lights[4];
                  lights[6]=1;
                end
        else if(c6<weight+3)
               begin
                  c6=c6+1;
                  lights[4]=~lights[4];
                  lights[6]=0;
                end
        else
                begin
                  lights[4]=0;
                  alert=1;
                end
       default: ;
    endcase
end
 2'b11://make the flashing lights on
 begin
 lights[1]=0;
 alert=0;
case(mode)
        3'b111:
            if(c1<(weight+9))
           begin
              lights[2]=1;
          end
           else if(c1<3*weight+18)
          begin    
             lights[3]=1;         
           end
           else if(c1<4*weight+21)
           begin             
             lights[4]=1;        
           end
 
        3'b100:
         if(c2<(weight+9))
        begin
           lights[2]=1;
       end

        3'b110:  
        if(c3<(weight+9))
                  begin   
                     lights[2]=1;
                 end
           else if(c3<3*weight+18)
                  begin              
                    lights[3]=1;    
                  end     
        3'b010:
          if(c4<2*weight+9)
                 begin               
                   lights[3]=1;  
                 end
                
        3'b011:

                         if(c5<2*weight+9)
                        begin                     
                          lights[3]=1;
                        end
                                 else if(c5<3*weight+12)
                                begin                                
                                   lights[4]=1;
                                 end
                                 
        3'b001:
          if(c6<weight+3)
                begin                
                   lights[4]=1;
                 end
        default: ;
    endcase
 
 end
 default:;
      
 endcase
 end
endmodule
