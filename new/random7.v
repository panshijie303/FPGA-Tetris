`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2022 11:48:20 PM
// Design Name: 
// Module Name: random7
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

// random number range 0-6
module random7(
    input clk,
	input update,
	input start,
	input gameover,
	output[2:0]	Index
);

reg[3:0] rand;

assign Index=rand;

always@(posedge clk) begin
    if (start) rand<=0;
    else if(gameover) rand<=rand;
    else if(update) rand <= rand+1;
    else rand<=rand;
end

endmodule
