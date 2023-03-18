`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2022 05:32:58 AM
// Design Name: 
// Module Name: startdelay
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


module startdelay(
	input clk,
	output Starting
);

    parameter		DelayTime = 'd2500_0;
    
    
    reg[19:0]	timecount;
    
    assign Starting = (timecount == DelayTime) ? 1'b1 : 1'b0;
    
    always@(posedge clk)
    begin
        if(timecount < DelayTime)
            timecount <= timecount + 1'b1;
        else
            timecount <= timecount;
    end
    
endmodule
