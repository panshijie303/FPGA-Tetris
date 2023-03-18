`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2022 06:47:27 PM
// Design Name: 
// Module Name: generate_blocks
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


module generate_blocks(
    input clk,
    input vgaclk,
    input[10:0] xaddr,
    input[9:0] yaddr,
    input update,
    input start,
    input gameover,
    output isblocks,
    output [11:0] blocks_color,
	output[2:0]	Index,
	output[9:0]	dot1,
	output[9:0]	dot2,
	output[9:0]	dot3,
	output[9:0]	dot4
    );
    
    parameter  x_start = 800;
    parameter  y_start = 150;
    parameter  block = 30;
    
    wire[2:0] rand;
    wire clk_rdm;
    
    random7 rdm7(.clk(clk),.update(update),.start(start),.gameover(gameover),.Index(rand));
    
    reg[9:0] dot_reg1;
    reg[9:0] dot_reg2;
    reg[9:0] dot_reg3;
    reg[9:0] dot_reg4;
    assign    dot1 = dot_reg1;
    assign    dot2 = dot_reg2;
    assign    dot3 = dot_reg3;
    assign    dot4 = dot_reg4;
    
    reg[11:0] color;
    
    reg isblock1;
    reg isblock2;
    reg isblock3;
    reg isblock4;
    assign isblocks = isblock1||isblock2||isblock3||isblock4;
    assign blocks_color = color;
    
    reg[2:0] Index_reg;
    assign Index = Index_reg;
    
    always@(posedge clk) begin //New blocks positions
        if (start) begin
            dot_reg1 <= {5'd0,5'd0};
            dot_reg2 <= {5'd0,5'd0};
            dot_reg3 <= {5'd0,5'd0};
            dot_reg4 <= {5'd0,5'd0};
            color <= 12'h000;
        end
        else if (gameover) begin
            dot_reg1 <= dot_reg1;
            dot_reg2 <= dot_reg2;
            dot_reg3 <= dot_reg3;
            dot_reg4 <= dot_reg4;
            color <= color;
        end
        else if(rand == 0) begin //|
            dot_reg1 <= {5'd5,5'd0};
            dot_reg2 <= {5'd5,5'd1};
            dot_reg3 <= {5'd5,5'd2};
            dot_reg4 <= {5'd5,5'd3};
            color <= 12'h488; 
        end
        else if(rand == 1) begin //o
            dot_reg1 <= {5'd4,5'd0};
            dot_reg2 <= {5'd5,5'd0};
		    dot_reg3 <= {5'd4,5'd1};
		    dot_reg4 <= {5'd5,5'd1};
            color <= 12'h848; 
        end
        else if(rand == 2) begin //T
            dot_reg1 <= {5'd5,5'd0};
		    dot_reg2 <= {5'd4,5'd1};
		    dot_reg3 <= {5'd5,5'd1};
		    dot_reg4 <= {5'd6,5'd1};
            color <= 12'h884; 
        end
        else if(rand == 3) begin //z
            dot_reg1 <= {5'd4,5'd0};
		    dot_reg2 <= {5'd5,5'd0};
		    dot_reg3 <= {5'd5,5'd1};
		    dot_reg4 <= {5'd6,5'd1};
            color <= 12'h448; 
        end
        else if(rand == 4) begin //~z
            dot_reg1 <= {5'd5,5'd0};
		    dot_reg2 <= {5'd6,5'd0};
            dot_reg3 <= {5'd4,5'd1};
            dot_reg4 <= {5'd5,5'd1};
            color <= 12'h484; 
        end
        else if(rand == 5) begin //L
            dot_reg1 <= {5'd6,5'd0};
            dot_reg2 <= {5'd4,5'd1};
            dot_reg3 <= {5'd5,5'd1};
            dot_reg4 <= {5'd6,5'd1};
            color <= 12'h844; 
        end
        else if(rand == 6) begin //~L
            dot_reg1 <= {5'd4,5'd0};
            dot_reg2 <= {5'd4,5'd1};
            dot_reg3 <= {5'd5,5'd1};
            dot_reg4 <= {5'd6,5'd1};
            color <= 12'h088; 
        end
        else begin
            dot_reg1 <= {5'd5,5'd0};
            dot_reg2 <= {5'd5,5'd1};
            dot_reg3 <= {5'd5,5'd2};
            dot_reg4 <= {5'd5,5'd3};
            color <= 12'h488; 
        end
	end
    
    always@(posedge vgaclk) begin
        if (start) isblock1<=0;
	    else if((xaddr >= (block*dot_reg1[9:5]+x_start+1))  && (xaddr < (block*(dot_reg1[9:5]+1)+x_start-1)))
		    if((yaddr >= (block*dot_reg1[4:0]+y_start+1))  && (yaddr < (block*(dot_reg1[4:0]+1)+y_start-1)))
			    isblock1<=1;
		    else
			    isblock1<=0;
	    else
		    isblock1<=0;
    end   
    
    always@(posedge vgaclk) begin //Display New blocks
	    if (start) isblock2<=0;
	    else if((xaddr >= (block*dot_reg2[9:5]+x_start+1))  && (xaddr < (block*(dot_reg2[9:5]+1)+x_start-1)))
		    if((yaddr >= (block*dot_reg2[4:0]+y_start+1))  && (yaddr < (block*(dot_reg2[4:0]+1)+y_start-1)))
			    isblock2<=1;
		    else
			    isblock2<=0;
	    else
		    isblock2<=0;
    end

    always@(posedge vgaclk) begin
	    if (start) isblock3<=0;
	    else if((xaddr >= (block*dot_reg3[9:5]+x_start+1))  && (xaddr < (block*(dot_reg3[9:5]+1)+x_start-1)))
		    if((yaddr >= (block*dot_reg3[4:0]+y_start+1))  && (yaddr < (block*(dot_reg3[4:0]+1)+y_start-1)))
			    isblock3<= 1;
		    else
			    isblock3<=0;
	    else
		    isblock3<=0;
    end    
    
    always@(posedge vgaclk) begin
	    if (start) isblock4<=0;
	    else if((xaddr >= (block*dot_reg4[9:5]+x_start+1))  && (xaddr < (block*(dot_reg4[9:5]+1)+x_start-1)))
		    if((yaddr >= (block*dot_reg4[4:0]+y_start+1))  && (yaddr < (block*(dot_reg4[4:0]+1)+y_start-1)))
			    isblock4<=1;
		    else
			    isblock4<=0;
	    else
		    isblock4<=0;
    end    
    
    always@(posedge clk) begin
        if(start) Index_reg <= 0;
        else if(update == 1)
            Index_reg <= rand;
        else
            Index_reg <= Index_reg;
    end
    
endmodule
