`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2022 12:28:53 AM
// Design Name: 
// Module Name: score
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

module score(input  rst, clk, 
    input[13:0] score,
    output a, b, c, d, e, f, g,
    output [7:0] an
    );
    wire clk_100HZ;
    reg[3:0] dig2,dig1,dig0;
    
    always @(posedge clk) begin //Get the single digit numbers
        dig0 <= score%'d10;
        dig1 <= (score/'d10)%'d10;
        dig2 <= (score/'d100)%'d10;
    end
    
    delay delay1ms(.origin_clk(clk), .new_clk(clk_100HZ));
    //Display scores on LEDs
    multidigit multidigit0( .dig2(dig2), .dig1(dig1), .dig0(dig0),
        .clk(clk_100HZ), .rst(rst),.a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g),.an(an));
    
    
endmodule
