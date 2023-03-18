`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2022 03:30:24 AM
// Design Name: 
// Module Name: timeup
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


module timeup(
    input clk100m,
    output timeup
    );
    
    reg [29:0] count;
    reg timeup_reg;
    
    assign timeup = timeup_reg; 
   
    always @ (posedge clk100m) begin
        count<=count+1;
        timeup_reg<=0;
        if (count==50000000) begin
            count <= 0;
            timeup_reg<=1;
        end
    end
    
endmodule
