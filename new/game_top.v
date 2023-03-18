`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2022 01:07:24 AM
// Design Name: 
// Module Name: game_top
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


module game_top(
    input clk100MHz,
    input BTNC,
    input BTNU,
    input BTND,
    input BTNL,
    input BTNR,
    output [3:0] pix_r,    
    output [3:0] pix_g,  
    output [3:0] pix_b,
    output vga_hs,  
    output vga_vs,
    output a, b, c, d, e, f, g,
    output [7:0] an
    );
    
    wire pixclk,reset,locked;
    wire clk2Hz;
    
    reg [3:0] reg_r;
    reg [3:0] reg_g;
    reg [3:0] reg_b;
    assign pix_r=reg_r;
    assign pix_g=reg_g;
    assign pix_b=reg_b;
    
    wire [10:0] wire_x;
    wire [9:0] wire_y;
    
    wire iswall,isNblocks,isCblocks,ismap,isBTN;
    wire[11:0] wall_color,blocks_color,Cblocks_color,map_color,BTN_color;
    wire[2:0] index;
    wire update,pulse,gameover;
    wire[9:0] nextdot1,nextdot2,nextdot3,nextdot4;
    wire[9:0] currdot1,currdot2,currdot3,currdot4;
    wire left,right,down,turn,start;
    
    
	wire[9:0] Row0,Row1,Row2,Row3,Row4,Row5,Row6,Row7,Row8,Row9,Row10,Row11,Row12,Row13,Row14,Row15,Row16,Row17,Row18,Row19;
	wire[13:0] score;
    
    vga_out vga_o(.clk(pixclk), .hsync(vga_hs), .vsync(vga_vs),
                  .curr_x(wire_x), .curr_y(wire_y));
    score(.rst(start), .clk(clk100MHz), .score(score),.a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g),.an(an));
    
    btn_dis_shake btn_BTNL(.clk(clk100MHz),.ikey(BTNL),.okey(left));
    btn_dis_shake btn_BTNR(.clk(clk100MHz),.ikey(BTNR),.okey(right));
    btn_dis_shake btn_BTND(.clk(clk100MHz),.ikey(BTND),.okey(down));
    btn_dis_shake btn_BTNC(.clk(clk100MHz),.ikey(BTNC),.okey(start));
    btn_dis_shake btn_BTNU(.clk(clk100MHz),.ikey(BTNU),.okey(turn));
   
    TIME timeup500ms(.clk100M(clk100MHz),.clk_1s(pulse));
    
    blockControl(.clk(clk100MHz),.vgaclk(pixclk),.xaddr(wire_x),.yaddr(wire_y),.Index(index),.NextDot1(nextdot1),.NextDot2(nextdot2),.NextDot3(nextdot3),.NextDot4(nextdot4),
	  .NextColor(blocks_color),.CurrDot1(currdot1),.CurrDot2(currdot2),.CurrDot3(currdot3),.CurrDot4(currdot4),/*.Row0(Row0),.Row1(Row1),.Row2(Row2),.Row3(Row3),
	  .Row4(Row4),.Row5(Row5),.Row6(Row6),.Row7(Row7),.Row8(Row8),.Row9(Row9),.Row10(Row10),.Row11(Row11),.Row12(Row12),.Row13(Row13),
	  .Row14(Row14),.Row15(Row15),.Row16(Row16),.Row17(Row17),.Row18(Row18),.Row19(Row19),*/.left(left),.right(right),.down(down),.turn(turn),.start(BTNC),.update(update),.TimeUp(pulse),
	  .gameover(gameover),.isblocks(isCblocks),.CurrentColor(Cblocks_color));
    
    backgroung BG(.clk(pixclk),.xaddr(wire_x),.yaddr(wire_y),.iswall(iswall),.wall_color(wall_color));
    
    generate_blocks new_blocks(.clk(clk100MHz),.vgaclk(pixclk),.xaddr(wire_x),.yaddr(wire_y),.update(update),.start(start),.gameover(gameover),
    .isblocks(isNblocks),.blocks_color(blocks_color),.Index(index),.dot1(nextdot1),.dot2(nextdot2),.dot3(nextdot3),.dot4(nextdot4));
    
    map(.clk(clk100MHz),.vgaclk(pixclk),.xaddr(wire_x),.yaddr(wire_y),.dot1(currdot1),.dot2(currdot2),.dot3(currdot3),.dot4(currdot4),
	  .start(start),.TimeUp(pulse),.update(update),.ismap(ismap),.map_color(map_color),.score(score),.gameover(gameover)/*,.Row0(Row0),.Row1(Row1),.Row2(Row2),.Row3(Row3),
	  .Row4(Row4),.Row5(Row5),.Row6(Row6),.Row7(Row7),.Row8(Row8),.Row9(Row9),.Row10(Row10),.Row11(Row11),.Row12(Row12),.Row13(Row13),
	  .Row14(Row14),.Row15(Row15),.Row16(Row16),.Row17(Row17),.Row18(Row18),.Row19(Row19)*/);

    startBTN(.clk(pixclk),.rst(start),.xaddr(wire_x),.yaddr(wire_y),.gameover(gameover),.BTN_color(BTN_color),.isBTN(isBTN));
    
    always @ (posedge pixclk) begin
        if (isBTN) begin
            reg_r <= BTN_color[11:8];
            reg_g <= BTN_color[7:4];
            reg_b <= BTN_color[3:0];   
        end 
        else if (ismap) begin
            reg_r <= map_color[11:8];
            reg_g <= map_color[7:4];
            reg_b <= map_color[3:0];   
        end 
        else if (iswall) begin
            reg_r <= wall_color[11:8];
            reg_g <= wall_color[7:4];
            reg_b <= wall_color[3:0];   
        end
        else if (isCblocks) begin
            reg_r <= Cblocks_color[11:8];
            reg_g <= Cblocks_color[7:4];
            reg_b <= Cblocks_color[3:0];   
        end 
        else if (isNblocks) begin
            reg_r <= blocks_color[11:8];
            reg_g <= blocks_color[7:4];
            reg_b <= blocks_color[3:0];   
        end 
        else begin
            reg_r <= 4'h0;
            reg_g <= 4'h0;
            reg_b <= 4'h0;  
        end   
    end
    
    
    
    
    clk_wiz_0 instance_name(
    // Clock out ports
    .clk_out1(pixclk),     // output clk_out1
    // Status and control signals
    .reset(reset), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk100MHz));      // input clk_in1
    
endmodule
