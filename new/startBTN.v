`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2022 02:23:50 AM
// Design Name: 
// Module Name: startBTN
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


module startBTN(
    input clk,
    input rst,
    input[10:0] xaddr,
    input[9:0] yaddr,
    input gameover,
    output[11:0] BTN_color,
    output isBTN
    );
    
    parameter x_start=447;
    parameter y_start=308;
    parameter x_size=400;
    parameter y_size=130;
    
    reg BTN_reg;
    assign isBTN=BTN_reg;
    
    reg[15:0] addra;
    always @(posedge clk) begin //Display the Start sprite
        if(rst) begin
            addra<='d0;
            BTN_reg<=1'b0;
        end
        else if(gameover) begin
            if((xaddr>=x_start&&xaddr<x_start+x_size)&&(yaddr>=y_start&&yaddr<y_start+y_size)) begin
                addra<=(yaddr-y_start)*x_size+xaddr-x_start;
                BTN_reg<=1'b1;
            end
            else begin
                addra<='d0;
                BTN_reg<=1'b0;
            end
        end
        else begin
            addra<='d0;
            BTN_reg<=1'b0;
        end
    end
    
    startpic startpicture(
  .clka(clk),    // input wire clka
  .addra(addra),  // input wire [15 : 0] addra
  .douta(BTN_color)  // output wire [11 : 0] douta
);
endmodule
