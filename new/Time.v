`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2022 05:48:44 AM
// Design Name: 
// Module Name: Time
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

// A Pulse every 500ms
module TIME(
	input clk100M,
	output reg clk_1s
);

    reg[31:0] cnt;
    parameter cnt1s = 'd50_000_000;
    
    always@(posedge clk100M)
    begin
        if(cnt>=cnt1s)
            cnt<=0;
        else
            cnt<=cnt+1;
    end
    
    
    always@(posedge clk100M)
    begin
        if(cnt>=cnt1s)
            clk_1s<=1;
        else
            clk_1s<=0;
    end

endmodule 
