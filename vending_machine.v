`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/30 22:33:26
// Design Name: 
// Module Name: vending_machine
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


module vending_machine(
    clk,
    rst,
    drink_type,
    coin_type,
    vend,
    change
    );

input           clk;
input           rst;
input           drink_type;
input   [1:0]   coin_type;


output          vend;
output  [1:0]   change;

/******** Define your registers here ********/
reg             vend;
reg     [1:0]   change;
reg     [2:0]   current_state;
reg     [2:0]   next_state;

// coin_type, change, state parameters
parameter [2:0] NO_COIN = 3'b000;    // No coin inserted
parameter [2:0] WON_050 = 3'b001;    // 50 Won coin inserted
parameter [2:0] WON_100 = 3'b010;    // 100 Won coin inserted
// only for state
parameter [2:0] WON_150 = 3'b011;    // 150 Won coin inserted
parameter [2:0] WON_200 = 3'b100;    // 200 Won coin inserted
parameter [2:0] WON_250 = 3'b101;    // 250 Won coin inserted
parameter [2:0] WON_300 = 3'b110;    // 300 Won coin inserted
parameter [2:0] WON_350 = 3'b111;    // 300 Won coin inserted

// drink_type parameters
parameter       COKE    = 1'b0;     // Coke     = 300 Won
parameter       SPRITE  = 1'b1;     // Sprite   = 250 Won


/******** Design your implementation here ********/
always @(posedge clk or negedge rst)
begin
    if(rst == 0) next_state = 3'b000;
    else if(drink_type == SPRITE && current_state == WON_250) begin
        next_state = NO_COIN;
        vend = 1'b1;
        change = NO_COIN;
    end 
    else if(drink_type == SPRITE && current_state == WON_300) begin
        next_state = NO_COIN;
        vend = 1'b1;
        change = WON_050;
    end 
    else if(drink_type == COKE && current_state == WON_300) begin
        next_state = NO_COIN;
        vend = 1'b1;
        change = NO_COIN;    
    end   
    else if(drink_type == COKE && current_state == WON_350) begin
        next_state = NO_COIN;
        vend = 1'b1;
        change = WON_050;    
    end 
 
    else
    begin
        case(current_state) 
            NO_COIN:
            begin
                if(coin_type == NO_COIN) begin
                   next_state = NO_COIN;            
                   vend = 1'b0;
                   change = NO_COIN;   
                end
                else if(coin_type == WON_050) begin
                   next_state = WON_050;          
                   vend = 1'b0;
                   change = NO_COIN;   
                end
                else begin
                   next_state = WON_100;         
                   vend = 1'b0;
                   change = NO_COIN;   
                end
           end
           
           WON_050:
           begin
               if(coin_type == NO_COIN) begin
                   next_state = WON_050;         
                   vend = 1'b0;
                   change = NO_COIN;   
               end
               else if(coin_type == WON_050) begin
                   next_state = WON_100;       
                   vend = 1'b0;
                   change = NO_COIN;   
               end
               else begin
                   next_state = WON_150;       
                   vend = 1'b0;
                   change = NO_COIN;   
               end
           end
           
           WON_100:
           begin
                if(coin_type == NO_COIN) begin
                   next_state = WON_100;              
                   vend = 1'b0;
                   change = NO_COIN;   
                end
                else if(coin_type == WON_050) begin
                   next_state = WON_150;         
                   vend = 1'b0;
                   change = NO_COIN;   
                end
                else begin
                   next_state = WON_200;            
                   vend = 1'b0;
                   change = NO_COIN;   
                end
           end
           
           WON_150:
           begin
                if(coin_type == NO_COIN) begin
                   next_state = WON_150;     
                   vend = 1'b0;
                   change = NO_COIN;   
                end
                else if(coin_type == WON_050) begin
                   next_state = WON_200;          
                   vend = 1'b0;
                   change = NO_COIN;   
                end
                else begin
                   next_state = WON_250;          
                   vend = 1'b0;
                   change = NO_COIN;   
                end
           end
           
           WON_200:
           begin
                if(coin_type == NO_COIN) begin
                   next_state = WON_200;        
                   vend = 1'b0;
                   change = NO_COIN;   
                end
                else if(coin_type == WON_050) begin
                   next_state = WON_250;       
                   vend = 1'b0;
                   change = NO_COIN;   
                end
                else begin
                   next_state = WON_300;        
                   vend = 1'b0;
                   change = NO_COIN;   
                end
           end

           WON_250:
           begin
                if(coin_type == NO_COIN) begin
                   next_state = WON_250;        
                   vend = 1'b0;
                   change = NO_COIN;   
                end
                else if(coin_type == WON_050) begin
                   next_state = WON_300;          
                   vend = 1'b0;
                   change = NO_COIN;   
                end
                else begin
                   next_state = WON_350;          
                   vend = 1'b0;
                   change = NO_COIN;   
                end
           end 
                                     
        endcase
   
    end
      current_state <= next_state;
end
endmodule
