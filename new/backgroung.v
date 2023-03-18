`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2022 06:12:26 PM
// Design Name: 
// Module Name: backgroung
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


module backgroung(
    input clk,
    input[10:0] xaddr,
    input[9:0] yaddr,
    output iswall,
    output [11:0] wall_color
    );

    parameter  x_start = 470;
    parameter  y_start = 100;
    parameter  block = 30;
    
    reg reg_wall;
    assign iswall = reg_wall;
    assign wall_color = 12'h333;
    
    always@(posedge clk) begin //Display background boundarys
        if ((yaddr >= y_start && yaddr < y_start+block)||(yaddr >= y_start+21*block && yaddr < y_start+22*block))
            if (xaddr >= x_start && xaddr < x_start+12*block) reg_wall=1;
            else reg_wall<=0;
        else if (yaddr >= y_start+block && yaddr < y_start+21*block)
            if ((xaddr >= x_start && xaddr < x_start+block)||(xaddr >= x_start+11*block && xaddr < x_start+12*block))
                reg_wall<=1;
            else reg_wall<=0;
        else reg_wall<=0;   
    end
endmodule
