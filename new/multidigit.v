`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2022 12:22:59 AM
// Design Name: 
// Module Name: multidigit
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


module multidigit(input [3:0] dig2, dig1, dig0,
    input  clk, rst,
    output a, b, c, d, e, f, g,
    output [7:0] an);
    
    reg [2:0] sel;
    reg [7:0] en;
    reg [3:0] dig;
    always @(posedge clk) begin
        if(rst) begin 
            en <= 8'b00000000;
            dig <= 4'b0000;
        end
        else case (sel)
            3'd0: begin en<=8'b11111110; dig<=dig0; end
            3'd1: begin en<=8'b11111101; dig<=dig1; end
            3'd2: begin en<=8'b11111011; dig<=dig2; end
        endcase
    end
    assign an = en; 
    sevenseg sevenseg0(.num(dig),.a(a),.b(b),.c(c),.d(d),.e(e),.f(f),.g(g) );
    
    always @(posedge clk) begin
        if(rst) begin
            sel <= 3'b000;
        end
        else if(sel==3'd2) sel <= 3'd0;
        else sel <= sel + 1'b1;
    end 
                                         
endmodule
