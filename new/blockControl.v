`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2022 12:52:55 AM
// Design Name: 
// Module Name: blockControl
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


module blockControl(
    input clk,
    input vgaclk,
	input[10:0]	xaddr,
	input[9:0] yaddr,
	input[2:0] Index,
	input[9:0] NextDot1,
	input[9:0] NextDot2,
	input[9:0] NextDot3,
	input[9:0] NextDot4,
	input[11:0] NextColor,
	output[9:0]	CurrDot1,
    output[9:0] CurrDot2,
	output[9:0] CurrDot3,
	output[9:0] CurrDot4,
	/*input[9:0] Row0,
	input[9:0] Row1,
	input[9:0] Row2,
	input[9:0] Row3,
	input[9:0] Row4,
	input[9:0] Row5,
	input[9:0] Row6,
	input[9:0] Row7,
	input[9:0] Row8,
	input[9:0] Row9,
	input[9:0] Row10,
	input[9:0] Row11,
	input[9:0] Row12,
	input[9:0] Row13,
	input[9:0] Row14,
	input[9:0] Row15,
	input[9:0] Row16,
	input[9:0] Row17,
	input[9:0] Row18,
	input[9:0] Row19,*/
	input left,
	input right,
	input down,
	input turn,
	input start,
	input update,
	input TimeUp,
	input gameover,
	output isblocks,
	output[11:0] CurrentColor
    );
    
    parameter  x_start = 500;
    parameter  y_start = 130;
    parameter  block = 30;
    
    reg[9:0] dot_reg1,dot_reg2,dot_reg3,dot_reg4;
    
    
    assign CurrDot1 = dot_reg1;
    assign CurrDot2 = dot_reg2;
    assign CurrDot3 = dot_reg3;
    assign CurrDot4 = dot_reg4;
    
    reg	blocks0; //|
    //reg blocks1; //o
    reg[1:0] blocks2;//T
    reg	blocks3;//z
    reg	blocks4;//~z
    reg[1:0] blocks5;//L
    reg[1:0] blocks6;//~L
    
    reg isblocks1,isblocks2,isblocks3,isblocks4;
    assign isblocks=isblocks1||isblocks2||isblocks3||isblocks4;
    
    reg[11:0] color_reg;
    
    /*
    reg[9:0] Row[19:0];
    always@(posedge clk) begin
        Row[0]<=Row0;
        Row[1]<=Row1;
        Row[2]<=Row2;
        Row[3]<=Row3;
        Row[4]<=Row4;
        Row[5]<=Row5;
        Row[6]<=Row6;
        Row[7]<=Row7;
        Row[8]<=Row8;
        Row[9]<=Row9;
        Row[10]<=Row10;
        Row[11]<=Row11;
        Row[12]<=Row12;
        Row[13]<=Row13;
        Row[14]<=Row14;
        Row[15]<=Row15;
        Row[16]<=Row16;
        Row[17]<=Row17;
        Row[18]<=Row18;
        Row[19]<=Row19;
    end
    */
    
    always@(posedge clk) begin //Update Spin State
        if(Index == 0 && turn == 1)
            blocks0 <= blocks0 + 1;
        else if(Index == 0 && update == 0)
            blocks0 <= blocks0;
        else
            blocks0 <= 0;
    end
    
    always@(posedge clk) begin
        if(Index == 2 && turn == 1)
            blocks2 <= blocks2 + 1;
        else if(Index == 2 && update == 0)
            blocks2 <= blocks2;
        else
            blocks2 <= 0;
    end
    
        always@(posedge clk) begin
        if(Index == 3 && turn == 1)
            blocks3 <= blocks3 + 1;
        else if(Index == 3 && update == 0)
            blocks3 <= blocks3;
        else
            blocks3 <= 0;
    end
    
        always@(posedge clk) begin
        if(Index == 4 && turn == 1)
            blocks4 <= blocks4 + 1;
        else if(Index == 4 && update == 0)
            blocks4 <= blocks4;
        else
            blocks4 <= 0;
    end
    
        always@(posedge clk) begin
        if(Index == 5 && turn == 1)
            blocks5 <= blocks5 + 1;
        else if(Index == 5 && update == 0)
            blocks5 <= blocks5;
        else
            blocks5 <= 0;
    end
    
        always@(posedge clk) begin
        if(Index == 6 && turn == 1)
            blocks6 <= blocks6 + 1;
        else if(Index == 6 && update == 0)
            blocks6 <= blocks6;
        else
            blocks6 <= 0;
    end
    
    always@(posedge clk) begin //Update Move State
        if(start) dot_reg1 <= NextDot1;
        else if(update) dot_reg1 <= NextDot1;
        else if(down) 
            
            dot_reg1[4:0] <= dot_reg1[4:0]+1'b1;	
            
        else if(TimeUp) dot_reg1[4:0] <= dot_reg1[4:0]+1'b1;	
        else if(left)  
            if(dot_reg1[9:5] == 0 || dot_reg2[9:5] == 0 || dot_reg3[9:5] == 0 || dot_reg4[9:5] == 0)
                dot_reg1[9:5] <= dot_reg1[9:5];
            /*else if((dot_reg1[9:5]-1!=dot_reg2[9:5])&&(dot_reg1[9:5]-1!=dot_reg3[9:5])&&(dot_reg1[9:5]-1!=dot_reg4[9:5])
              &&((Row[dot_reg1[4:0]][dot_reg1[9:5]-1]==1)||(Row[dot_reg2[4:0]][dot_reg2[9:5]-1]==1)
              ||(Row[dot_reg3[4:0]][dot_reg3[9:5]-1]==1)||(Row[dot_reg4[4:0]][dot_reg4[9:5]-1]==1)))
                dot_reg1[9:5] <= dot_reg1[9:5];*/
            else
                dot_reg1[9:5] <= dot_reg1[9:5]-1;
        else if(right) 
            if(dot_reg1[9:5] == 9 || dot_reg2[9:5] == 9 || dot_reg3[9:5] == 9 || dot_reg4[9:5] == 9)
                dot_reg1[9:5] <= dot_reg1[9:5];
            /*else if((dot_reg1[9:5]+1!=dot_reg2[9:5])&&(dot_reg1[9:5]+1!=dot_reg3[9:5])&&(dot_reg1[9:5]+1!=dot_reg4[9:5])
              &&((Row[dot_reg1[4:0]][dot_reg1[9:5]+1]==1)||(Row[dot_reg2[4:0]][dot_reg2[9:5]+1]==1)
              ||(Row[dot_reg3[4:0]][dot_reg3[9:5]+1]==1)||(Row[dot_reg4[4:0]][dot_reg4[9:5]+1]==1)))
                dot_reg1[9:5] <= dot_reg1[9:5];*/
            else
                dot_reg1[9:5] <= dot_reg1[9:5]+1;
        else if(turn)
            if(Index==0) begin
                if(blocks0==0) begin
                    dot_reg1[9:5] <= dot_reg1[9:5]+2;
                    dot_reg1[4:0] <= dot_reg1[4:0]+2;
                end
                else begin
                    dot_reg1[9:5] <= dot_reg1[9:5]-2;
                    dot_reg1[4:0] <= dot_reg1[4:0]-2;
                end
            end
            else if(Index==2) begin
                if(blocks2==0) begin
                    dot_reg1[9:5] <= dot_reg1[9:5]+1;
                    dot_reg1[4:0] <= dot_reg1[4:0]+1;
                end
                else if(blocks2==1) begin
                    dot_reg1[9:5] <= dot_reg1[9:5]-1;
                    dot_reg1[4:0] <= dot_reg1[4:0]+1;		
                end
                else if(blocks2==2) begin
                    dot_reg1[9:5]<=dot_reg1[9:5]-1;
                    dot_reg1[4:0]<=dot_reg1[4:0]-1;		
                end
                else begin
                    dot_reg1[9:5] <= dot_reg1[9:5]+1;
                    dot_reg1[4:0] <= dot_reg1[4:0]-1;		
                end
            end
            else if(Index==3) begin
                if(blocks3==0) begin
                    dot_reg1[9:5] <= dot_reg1[9:5]+1;
                    dot_reg1[4:0] <= dot_reg1[4:0]-1;
                end
                else begin
                    dot_reg1[9:5] <= dot_reg1[9:5]-1;
                    dot_reg1[4:0] <= dot_reg1[4:0]+1;
                end
            end
            else if(Index==4) begin
                if(blocks4==0) begin
                    dot_reg1[9:5] <= dot_reg1[9:5]+1;
                    dot_reg1[4:0] <= dot_reg1[4:0]+1;
                end
                else begin
                    dot_reg1[9:5] <= dot_reg1[9:5]-1;
                    dot_reg1[4:0] <= dot_reg1[4:0]-1;
                end
            end
            else if(Index==5) begin
                if(blocks5==0) begin
                    dot_reg1[9:5] <= dot_reg1[9:5]+1;
                    dot_reg1[4:0] <= dot_reg1[4:0]+1;
                end
                else if(blocks5==1) begin
                    dot_reg1[9:5] <= dot_reg1[9:5]-1;
                    dot_reg1[4:0] <= dot_reg1[4:0]+1;
                end
                else if(blocks5==2) begin
                    dot_reg1[9:5] <= dot_reg1[9:5]-1;
                    dot_reg1[4:0] <= dot_reg1[4:0]-1;
                end
                else begin
                    dot_reg1[9:5] <= dot_reg1[9:5]+1;
                    dot_reg1[4:0] <= dot_reg1[4:0]-1;
                end
            end
            else if(Index==6) begin
                if(blocks6==0) begin
                    dot_reg1[9:5] <= dot_reg1[9:5]+1;
                    dot_reg1[4:0] <= dot_reg1[4:0]+1;
                end
                else if(blocks6==1) begin
                    dot_reg1[9:5] <= dot_reg1[9:5]-1;
                    dot_reg1[4:0] <= dot_reg1[4:0]+1;
                end
                else if(blocks6==2) begin
                    dot_reg1[9:5] <= dot_reg1[9:5]-1;
                    dot_reg1[4:0] <= dot_reg1[4:0]-1;
                end
                else begin
                    dot_reg1[9:5] <= dot_reg1[9:5]+1;
                    dot_reg1[4:0] <= dot_reg1[4:0]-1;
                end
            end
        else
            dot_reg1 <= dot_reg1;
    end
    
    
    
    always@(posedge clk) begin
        if(start) dot_reg2 <= NextDot2;
        else if(update) dot_reg2 <= NextDot2;
        else if(down) dot_reg2[4:0] <= dot_reg2[4:0]+1'b1;	
        else if(TimeUp) dot_reg2[4:0] <= dot_reg2[4:0]+1'b1;
        else if(left)
            if(dot_reg1[9:5]==0||dot_reg2[9:5]==0||dot_reg3[9:5]==0||dot_reg4[9:5]==0)
                dot_reg2[9:5] <= dot_reg2[9:5];
            /*else if((dot_reg2[9:5]-1!=dot_reg1[9:5])&&(dot_reg2[9:5]-1!=dot_reg3[9:5])&&(dot_reg2[9:5]-1!=dot_reg4[9:5])
              &&((Row[dot_reg1[4:0]][dot_reg1[9:5]-1]==1)||(Row[dot_reg2[4:0]][dot_reg2[9:5]-1]==1)
              ||(Row[dot_reg3[4:0]][dot_reg3[9:5]-1]==1)||(Row[dot_reg4[4:0]][dot_reg4[9:5]-1]==1)))
                dot_reg2[9:5] <= dot_reg2[9:5];*/
            else
                dot_reg2[9:5] <= dot_reg2[9:5]-1;
        else if(right)
            if(dot_reg1[9:5]==9||dot_reg2[9:5]==9||dot_reg3[9:5]==9||dot_reg4[9:5]==9)
                dot_reg2[9:5] <= dot_reg2[9:5];
            /*else if((dot_reg2[9:5]+1!=dot_reg1[9:5])&&(dot_reg2[9:5]+1!=dot_reg3[9:5])&&(dot_reg2[9:5]+1!=dot_reg4[9:5])
              &&((Row[dot_reg1[4:0]][dot_reg1[9:5]+1]==1)||(Row[dot_reg2[4:0]][dot_reg2[9:5]+1]==1)
              ||(Row[dot_reg3[4:0]][dot_reg3[9:5]+1]==1)||(Row[dot_reg4[4:0]][dot_reg4[9:5]+1]==1)))
                dot_reg2[9:5] <= dot_reg2[9:5];*/
            else
                dot_reg2[9:5] <= dot_reg2[9:5]+1;
        else if(turn)
            if(Index==0) begin
                if(blocks0==0) begin
                    dot_reg2[9:5] <= dot_reg2[9:5]+1;
                    dot_reg2[4:0] <= dot_reg2[4:0]+1;
                end
                else begin
                    dot_reg2[9:5] <= dot_reg2[9:5]-1;
                    dot_reg2[4:0] <= dot_reg2[4:0]-1;
                end
            end
            else if(Index==2) begin
                if(blocks2==0) begin
                    dot_reg2[9:5] <= dot_reg2[9:5]+1;
                    dot_reg2[4:0] <= dot_reg2[4:0]-1;
                end
                else if(blocks2==1) begin
                    dot_reg2[9:5] <= dot_reg2[9:5]+1;
                    dot_reg2[4:0] <= dot_reg2[4:0]+1;		
                end
                else if(blocks2==2) begin
                    dot_reg2[9:5] <= dot_reg2[9:5]-1;
                    dot_reg2[4:0] <= dot_reg2[4:0]+1;		
                end
                else begin
                    dot_reg2[9:5] <= dot_reg2[9:5]-1;
                    dot_reg2[4:0] <= dot_reg2[4:0]-1;		
                end
            end
            else if(Index==3) begin
                if(blocks3==0) begin
                    dot_reg2[9:5] <= dot_reg2[9:5];
                    dot_reg2[4:0] <= dot_reg2[4:0];
                end
                else begin
                    dot_reg2[9:5] <= dot_reg2[9:5];
                    dot_reg2[4:0] <= dot_reg2[4:0];
                end
            end
            else if(Index==4) begin
                if(blocks4==0) begin
                    dot_reg2[9:5] <= dot_reg2[9:5];
                    dot_reg2[4:0] <= dot_reg2[4:0]+2;
                end
                else begin
                    dot_reg2[9:5] <= dot_reg2[9:5];
                    dot_reg2[4:0] <= dot_reg2[4:0]-2;
                end
            end
            else if(Index==5) begin
                if(blocks5==0) begin
                    dot_reg2[9:5] <= dot_reg2[9:5]+2;
                    dot_reg2[4:0] <= dot_reg2[4:0]-2;
                end
                else if(blocks5==1) begin
                    dot_reg2[9:5] <= dot_reg2[9:5]+2;
                    dot_reg2[4:0] <= dot_reg2[4:0]+2;
                end
                else if(blocks5==2) begin
                    dot_reg2[9:5] <= dot_reg2[9:5]-2;
                    dot_reg2[4:0] <= dot_reg2[4:0]+2;
                end
                else begin
                    dot_reg2[9:5] <= dot_reg2[9:5]-2;
                    dot_reg2[4:0] <= dot_reg2[4:0]-2;
                end
            end
        else
            dot_reg2 <= dot_reg2;
    end
    
    
    always@(posedge clk) begin
        if(start) dot_reg3 <= NextDot3;
        else if(update) dot_reg3 <= NextDot3;
        else if(down) dot_reg3[4:0] <= dot_reg3[4:0]+1'b1;	
        else if(TimeUp) dot_reg3[4:0] <= dot_reg3[4:0]+1'b1;
        else if(left)
            if(dot_reg1[9:5]==0||dot_reg2[9:5]==0||dot_reg3[9:5]==0||dot_reg4[9:5]==0)
                dot_reg3[9:5] <= dot_reg3[9:5];
            /*else if((dot_reg3[9:5]-1!=dot_reg1[9:5])&&(dot_reg3[9:5]-1!=dot_reg2[9:5])&&(dot_reg3[9:5]-1!=dot_reg4[9:5])
              &&((Row[dot_reg1[4:0]][dot_reg1[9:5]-1]==1)||(Row[dot_reg2[4:0]][dot_reg2[9:5]-1]==1)
              ||(Row[dot_reg3[4:0]][dot_reg3[9:5]-1]==1)||(Row[dot_reg4[4:0]][dot_reg4[9:5]-1]==1)))
                dot_reg3[9:5] <= dot_reg3[9:5];*/
            else
                dot_reg3[9:5] <= dot_reg3[9:5]-1;
        else if(right)
            if(dot_reg1[9:5]==9||dot_reg2[9:5]==9||dot_reg3[9:5]==9||dot_reg4[9:5]==9)
                dot_reg3[9:5] <= dot_reg3[9:5];
            /*else if((dot_reg3[9:5]+1!=dot_reg1[9:5])&&(dot_reg3[9:5]+1!=dot_reg2[9:5])&&(dot_reg3[9:5]+1!=dot_reg4[9:5])
              &&((Row[dot_reg1[4:0]][dot_reg1[9:5]+1]==1)||(Row[dot_reg2[4:0]][dot_reg2[9:5]+1]==1)
              ||(Row[dot_reg3[4:0]][dot_reg3[9:5]+1]==1)||(Row[dot_reg4[4:0]][dot_reg4[9:5]+1]==1)))
                dot_reg3[9:5] <= dot_reg3[9:5];*/
            else
                dot_reg3[9:5] <= dot_reg3[9:5]+1;
        else if(turn)
            if(Index==0) begin
                if(blocks0==0) begin
                    dot_reg3[9:5] <= dot_reg3[9:5];
                    dot_reg3[4:0] <= dot_reg3[4:0];
                end
                else begin
                    dot_reg3[9:5] <= dot_reg3[9:5];
                    dot_reg3[4:0] <= dot_reg3[4:0];
                end
            end
            else if(Index==3) begin
                if(blocks3==0) begin
                    dot_reg3[9:5] <= dot_reg3[9:5]-1;
                    dot_reg3[4:0] <= dot_reg3[4:0]-1;
                end
                else begin
                    dot_reg3[9:5] <= dot_reg3[9:5]+1;
                    dot_reg3[4:0] <= dot_reg3[4:0]+1;
                end
            end
            else if(Index==4) begin
                if(blocks4==0) begin
                    dot_reg3[9:5] <= dot_reg3[9:5]+1;
                    dot_reg3[4:0] <= dot_reg3[4:0]-1;
                end
                else begin
                    dot_reg3[9:5] <= dot_reg3[9:5]-1;
                    dot_reg3[4:0] <= dot_reg3[4:0]+1;
                end
            end
            else if(Index==5) begin
                if(blocks5==0) begin
                    dot_reg3[9:5] <= dot_reg3[9:5]+1;
                    dot_reg3[4:0] <= dot_reg3[4:0]-1;
                end
                else if(blocks5==1) begin
                    dot_reg3[9:5] <= dot_reg3[9:5]+1;
                    dot_reg3[4:0] <= dot_reg3[4:0]+1;
                end
                else if(blocks5==2) begin
                    dot_reg3[9:5] <= dot_reg3[9:5]-1;
                    dot_reg3[4:0] <= dot_reg3[4:0]+1;
                end
                else begin
                    dot_reg3[9:5] <= dot_reg3[9:5]-1;
                    dot_reg3[4:0] <= dot_reg3[4:0]-1;
                end
            end
            else if(Index==6) begin
                if(blocks6==0) begin
                    dot_reg3[9:5] <= dot_reg3[9:5]-1;
                    dot_reg3[4:0] <= dot_reg3[4:0]+1;
                end
                else if(blocks6==1) begin
                    dot_reg3[9:5] <= dot_reg3[9:5]-1;
                    dot_reg3[4:0] <= dot_reg3[4:0]-1;
                end
                else if(blocks6==2) begin
                    dot_reg3[9:5] <= dot_reg3[9:5]+1;
                    dot_reg3[4:0] <= dot_reg3[4:0]-1;
                end
                else begin
                    dot_reg3[9:5] <= dot_reg3[9:5]+1;
                    dot_reg3[4:0] <= dot_reg3[4:0]+1;
                end
            end
        else
            dot_reg3 <= dot_reg3;
    end
    
    
    always@(posedge clk) begin
        if(start) dot_reg4 <= NextDot4;
        else if(update) dot_reg4 <= NextDot4;
        else if(down) dot_reg4[4:0] <= dot_reg4[4:0]+1'b1;	
        else if(TimeUp) dot_reg4[4:0] <= dot_reg4[4:0]+1'b1;
        else if(left)
            if(dot_reg1[9:5]==0||dot_reg2[9:5]==0||dot_reg3[9:5]==0||dot_reg4[9:5]==0)
                dot_reg4[9:5] <= dot_reg4[9:5];
            /*else if((dot_reg4[9:5]-1!=dot_reg1[9:5])&&(dot_reg4[9:5]-1!=dot_reg2[9:5])&&(dot_reg4[9:5]-1!=dot_reg3[9:5])
              &&((Row[dot_reg1[4:0]][dot_reg1[9:5]-1]==1)||(Row[dot_reg2[4:0]][dot_reg2[9:5]-1]==1)
              ||(Row[dot_reg3[4:0]][dot_reg3[9:5]-1]==1)||(Row[dot_reg4[4:0]][dot_reg4[9:5]-1]==1)))
                dot_reg4[9:5] <= dot_reg4[9:5];*/
            else
                dot_reg4[9:5] <= dot_reg4[9:5]-1;
        else if(right)
            if(dot_reg1[9:5]==9||dot_reg2[9:5]==9||dot_reg3[9:5]==9||dot_reg4[9:5]==9)
                dot_reg4[9:5] <= dot_reg4[9:5];
            /*else if((dot_reg4[9:5]+1!=dot_reg1[9:5])&&(dot_reg4[9:5]+1!=dot_reg2[9:5])&&(dot_reg4[9:5]+1!=dot_reg3[9:5])
              &&((Row[dot_reg1[4:0]][dot_reg1[9:5]+1]==1)||(Row[dot_reg2[4:0]][dot_reg2[9:5]+1]==1)
              ||(Row[dot_reg3[4:0]][dot_reg3[9:5]+1]==1)||(Row[dot_reg4[4:0]][dot_reg4[9:5]+1]==1)))
                dot_reg4[9:5] <= dot_reg4[9:5];*/
            else
                dot_reg4[9:5] <= dot_reg4[9:5]+1;
        else if(turn)
            if(Index==0) begin
                if(blocks0==0) begin
                    dot_reg4[9:5] <= dot_reg4[9:5]-1;
                    dot_reg4[4:0] <= dot_reg4[4:0]-1;
                end 
                else begin
                    dot_reg4[9:5] <= dot_reg4[9:5]+1;
                    dot_reg4[4:0] <= dot_reg4[4:0]+1;
                end
            end
            else if(Index==2) begin
                if(blocks2==0) begin
                    dot_reg4[9:5] <= dot_reg4[9:5]-1;
                    dot_reg4[4:0] <= dot_reg4[4:0]+1;
                end
                else if(blocks2==1) begin
                    dot_reg4[9:5] <= dot_reg4[9:5]-1;
                    dot_reg4[4:0] <= dot_reg4[4:0]-1;		
                end
                else if(blocks2==2) begin
                    dot_reg4[9:5] <= dot_reg4[9:5]+1;
                    dot_reg4[4:0] <= dot_reg4[4:0]-1;		
                end
                else begin
                    dot_reg4[9:5] <= dot_reg4[9:5]+1;
                    dot_reg4[4:0] <= dot_reg4[4:0]+1;		
                end
            end
            else if(Index==3) begin
                if(blocks3==0) begin
                    dot_reg4[9:5] <= dot_reg4[9:5]-2;
                    dot_reg4[4:0] <= dot_reg4[4:0];
                end
                else begin
                    dot_reg4[9:5] <= dot_reg4[9:5]+2;
                    dot_reg4[4:0] <= dot_reg4[4:0];
                end
            end
            else if(Index==4) begin
                if(blocks4==0) begin
                    dot_reg4[9:5] <= dot_reg4[9:5];
                    dot_reg4[4:0] <= dot_reg4[4:0];
                end
                else begin
                    dot_reg4[9:5] <= dot_reg4[9:5];
                    dot_reg4[4:0] <= dot_reg4[4:0];
                end
            end
            else if(Index==6) begin
                if(blocks6==0) begin
                    dot_reg4[9:5] <= dot_reg4[9:5]-2;
                    dot_reg4[4:0] <= dot_reg4[4:0]+2;
                end
                else if(blocks6==1) begin
                    dot_reg4[9:5] <= dot_reg4[9:5]-2;
                    dot_reg4[4:0] <= dot_reg4[4:0]-2;
                end
                else if(blocks6== 2) begin
                    dot_reg4[9:5] <= dot_reg4[9:5]+2;
                    dot_reg4[4:0] <= dot_reg4[4:0]-2;
                end
                else begin
                    dot_reg4[9:5] <= dot_reg4[9:5]+2;
                    dot_reg4[4:0] <= dot_reg4[4:0]+2;
                end
            end	 
        else
            dot_reg4 <= dot_reg4;
    end
    
    always@(posedge clk) begin  //Display color update
        if(start) color_reg<=NextColor;
        else if(update) color_reg<=NextColor;
        else color_reg<=color_reg;
    end
    assign CurrentColor = color_reg;	

    always@(posedge vgaclk) begin //Display blocks
        if(start) isblocks1<=0;
        else if(gameover) isblocks1<=0;
        else if(xaddr > (block*dot_reg1[9:5]+x_start+1)  && xaddr < (block*dot_reg1[9:5]+x_start+block-1))
            if(yaddr > (block*dot_reg1[4:0]+y_start+1) && yaddr < (block*dot_reg1[4:0]+y_start+block-1))
                isblocks1<=1;
            else
                isblocks1<=0;
        else
            isblocks1<=0;
    
    end
    
    always@(posedge vgaclk) begin
        if(start) isblocks2<=0;
        else if(gameover) isblocks2<=0;
        else if(xaddr > (block*dot_reg2[9:5]+x_start+1)  && xaddr < (block*dot_reg2[9:5]+x_start+block-1))
            if(yaddr > (block*dot_reg2[4:0]+y_start+1) && yaddr < (block*dot_reg2[4:0]+y_start+block-1))
                isblocks2<=1;
            else
                isblocks2<=0;
        else
            isblocks2<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) isblocks3<=0;
        else if(gameover) isblocks3<=0;
        else if(xaddr > (block*dot_reg3[9:5]+x_start+1)  && xaddr < (block*dot_reg3[9:5]+x_start+block-1))
            if(yaddr > (block*dot_reg3[4:0]+y_start+1) && yaddr < (block*dot_reg3[4:0]+y_start+block-1))
                isblocks3<=1;
            else
                isblocks3<=0;
        else
            isblocks3<=0;   
    end
    
    always@(posedge vgaclk) begin
        if(start) isblocks4<=0;
        else if(gameover) isblocks4<=0;
        else if(xaddr > (block*dot_reg4[9:5]+x_start+1)  && xaddr < (block*dot_reg4[9:5]+x_start+block-1))
            if(yaddr > (block*dot_reg4[4:0]+y_start+1) && yaddr < (block*dot_reg4[4:0]+y_start+block-1))
                isblocks4<=1;
            else
                isblocks4<=0;
        else
            isblocks4<=0;
    end
    
endmodule
