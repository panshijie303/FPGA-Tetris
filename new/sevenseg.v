`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2022 12:22:38 AM
// Design Name: 
// Module Name: sevenseg
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

module sevenseg(input [3:0] num, 
                output a,b,c,d,e,f,g );
    reg [6:0]  d_out;
    always @ *
        case(num)
            4'h0: d_out = 7'b0000001;
            4'h1: d_out = 7'b1001111;
            4'h2: d_out = 7'b0010010;
            4'h3: d_out = 7'b0000110;
            4'h4: d_out = 7'b1001100;
            4'h5: d_out = 7'b0100100;
            4'h6: d_out = 7'b0100000;
            4'h7: d_out = 7'b0001111;
            4'h8: d_out = 7'b0000000;
            4'h9: d_out = 7'b0000100;
            4'hA: d_out = 7'b0001000;
            4'hb: d_out = 7'b1100000;
            4'hC: d_out = 7'b0110001;
            4'hd: d_out = 7'b1000010;
            4'hE: d_out = 7'b0110000;
            4'hF: d_out = 7'b0111000;
        endcase 
    assign a = d_out[6]; 
    assign b = d_out[5];
    assign c = d_out[4];
    assign d = d_out[3];
    assign e = d_out[2];
    assign f = d_out[1];
    assign g = d_out[0];         
endmodule
