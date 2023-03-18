`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2022 10:00:07 PM
// Design Name: 
// Module Name: btn_dis_shake
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


module btn_dis_shake(
	input clk,
	input ikey,
	output okey		
);

localparam S_IDLE='d0;
localparam S_DOWN='d1;
localparam S_DEALY='d2;
localparam S_UP='d3;
localparam S_DIS_SHAKE='d4;


localparam DIS_SHAKE='d6000;
localparam DELAY='d50000;

reg[3:0] state,next_state;

wire neg_key,pos_key;	
reg	key0,key1;			

reg[30:0] delay_cnt;

assign neg_key=key1&(~key0);
assign pos_key=(~key1)&key0;


assign okey=(state == S_DIS_SHAKE && delay_cnt == DIS_SHAKE) ? 1'b1:1'b0;


always@(posedge clk)
begin
	key0 <= ikey;
	key1 <= key0;
	state <= next_state;
end


always@(*)
begin
	case(state)
		S_IDLE:
			if(neg_key	==	1'b1)
				next_state <= S_DIS_SHAKE;
			else
				next_state <= S_IDLE;
		S_DIS_SHAKE:			
				if(delay_cnt == DIS_SHAKE)
					next_state <= S_DEALY;
				else if(pos_key == 1'b1)
					next_state <= S_IDLE;
				else
					next_state <= S_DIS_SHAKE;
		S_DEALY:			
			if(delay_cnt == DELAY	&& pos_key == 1'b1)
				next_state <= S_UP;
			else if( pos_key == 1'b1)
				next_state <= S_UP;
			else
				next_state <= S_DEALY;
		S_UP:
			next_state <= S_IDLE;
		default:	next_state <= S_IDLE;
	endcase
end


always@(posedge clk)
begin
    if(state != next_state)
		delay_cnt  <= 'd0;
	else if(state == S_DIS_SHAKE)
		delay_cnt <= delay_cnt + 1'b1;
	else if(state == S_DEALY && delay_cnt == DELAY)
		delay_cnt <= 'd0;
	else if(state == S_DEALY)
		delay_cnt <= delay_cnt + 1'b1;
	else
		delay_cnt <= 'd0;
end

endmodule 
