`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2022 12:28:10 AM
// Design Name: 
// Module Name: delay1ms
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


module delay( input origin_clk, output new_clk );
    reg new_clk_tmp;
    reg [9:0] cnt0,cnt1;
    initial begin
        cnt0=10'd0;
        cnt1=10'd0;
    end    
    always@(posedge origin_clk) begin
        cnt0 <= cnt0 + 1;
        if(cnt0==10'd1000) begin 
            cnt1 <= cnt1 + 1;
            cnt0 <= 10'd0;
        end
        if(cnt1==10'd50) begin 
            new_clk_tmp <= !new_clk_tmp;
            cnt1 <= 10'd0;
        end
    end
    assign new_clk=new_clk_tmp;
endmodule
