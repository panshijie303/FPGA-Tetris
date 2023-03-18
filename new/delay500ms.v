`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2022 11:08:24 AM
// Design Name: 
// Module Name: delay500ms
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


module delay500ms(
    input clk100m,
    output clk2
    );
    
    reg [29:0] count;
    reg reg_clk;
    
    assign clk2 = reg_clk; 
   
    always @ (posedge clk100m) begin
        count<=count+1;
        if (count==20000000) begin
            count <= 0;
            reg_clk <= ~reg_clk;
        end
    end
    
endmodule
