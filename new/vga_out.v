`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2022 06:38:40 PM
// Design Name: 
// Module Name: vga_out
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


module vga_out(
    input clk, 
    output hsync,  
    output vsync,
    output [10:0] curr_x,
    output [9:0] curr_y
    );
    
    reg [10:0] hcount;
    reg [9:0] vcount;
    reg hsyn;
    reg vsyn;
    reg [10:0] reg_x;
    reg [9:0] reg_y;
    
    assign hsync=hsyn;
    assign vsync=vsyn;
    assign curr_x=reg_x;
    assign curr_y=reg_y;

    
    always @ (posedge clk) begin
        if (hcount == 1679) hcount <= 0;
        else hcount <= hcount+1;
        if (hcount < 136) hsyn <= 0;
        else hsyn <= 1;   
    end 
    
    always @ (posedge clk) begin
        if (hcount == 1679) vcount <= vcount+1;
        else if (vcount == 827) vcount <= 0;
        if (vcount <= 2) vsyn <= 0;
        else vsyn <= 1;
    end
    
    always @ (posedge clk) begin
        if (hcount >= 336 && hcount <= 1615) reg_x <= reg_x+1;
        else reg_x <= 0;
    end
    
    always @ (posedge clk) begin
        if (hcount == 1679) begin
            if (vcount >= 27 && vcount <= 826) reg_y <= reg_y+1;
            else reg_y <= 0;
       end
    end   

    

endmodule



