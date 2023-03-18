`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2022 01:03:24 AM
// Design Name: 
// Module Name: map
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


module map(
	input clk,
	input vgaclk,
	input[10:0] xaddr,
	input[9:0] yaddr,
	input[9:0] dot1,
	input[9:0] dot2,
	input[9:0] dot3,
	input[9:0] dot4,
	input start,
	input TimeUp,
	output update,
	output ismap,
	output[11:0] map_color,
	output[13:0] score,
	output gameover
	/*
	output[9:0] Row0,
	output[9:0] Row1,
	output[9:0] Row2,
	output[9:0] Row3,
	output[9:0] Row4,
	output[9:0] Row5,
	output[9:0] Row6,
	output[9:0] Row7,
	output[9:0] Row8,
	output[9:0] Row9,
	output[9:0] Row10,
	output[9:0] Row11,
	output[9:0] Row12,
	output[9:0] Row13,
	output[9:0] Row14,
	output[9:0] Row15,
	output[9:0] Row16,
	output[9:0] Row17,
	output[9:0] Row18,
	output[9:0] Row19	*/
);

    parameter  x_start = 500;
    parameter  y_start = 130;
    parameter  block = 30;

   
    reg[9:0] Row[19:0];
     /*
    assign Row0=Row[0];
    assign Row1=Row[1];
    assign Row2=Row[2];
    assign Row3=Row[3];
    assign Row4=Row[4];
    assign Row5=Row[5];
    assign Row6=Row[6];
    assign Row7=Row[7];
    assign Row8=Row[8];
    assign Row9=Row[9];
    assign Row10=Row[10];
    assign Row11=Row[11];
    assign Row12=Row[12];
    assign Row13=Row[13];
    assign Row14=Row[14];
    assign Row15=Row[15];
    assign Row16=Row[16];
    assign Row17=Row[17];
    assign Row18=Row[18];
    assign Row19=Row[19]; 
    */
    reg update1,update2,update3,update4;    
    assign update = (update1||update2||update3||update4)&&(gameover==1'b0);
    
    reg[9:0] dot_reg1,dot_reg2,dot_reg3,dot_reg4;
    reg map_reg0,map_reg1,map_reg2,map_reg3,map_reg4,map_reg5,map_reg6,map_reg7,map_reg8,map_reg9,map_reg10,
        map_reg11,map_reg12,map_reg13,map_reg14,map_reg15,map_reg16,map_reg17,map_reg18,map_reg19;
    reg[13:0] score_reg;
    assign score=score_reg;
    
    reg game_over_reg=1'b1;
    assign gameover=game_over_reg;
    
    assign ismap=map_reg0||map_reg1||map_reg2||map_reg3||map_reg4||map_reg5||map_reg6||map_reg7||map_reg8||map_reg9||map_reg10
        ||map_reg11||map_reg12||map_reg13||map_reg14||map_reg15||map_reg16||map_reg17||map_reg18||map_reg19;
    assign map_color=12'h666;
    
    always@(posedge clk) begin
        if (start) game_over_reg<=1'b0;
        else if (Row[0][4]==1||Row[0][5]==1||Row[0][6]==1) game_over_reg<=1'b1;
        else game_over_reg<=game_over_reg;
    end
    
    always@(posedge clk) begin //Erase the rows and record scores
        if(start) begin
            Row[0] <= 10'b0000000000;
            Row[1] <= 10'b0000000000;
            Row[2] <= 10'b0000000000;
            Row[3] <= 10'b0000000000;
            Row[4] <= 10'b0000000000;
            Row[5] <= 10'b0000000000;
            Row[6] <= 10'b0000000000;
            Row[7] <= 10'b0000000000;
            Row[8] <= 10'b0000000000;
            Row[9] <= 10'b0000000000;
            Row[10] <= 10'b0000000000;
            Row[11] <= 10'b0000000000;
            Row[12] <= 10'b0000000000;
            Row[13] <= 10'b0000000000;
            Row[14] <= 10'b0000000000;
            Row[15] <= 10'b0000000000;
            Row[16] <= 10'b0000000000;
            Row[17] <= 10'b0000000000;
            Row[18] <= 10'b0000000000;
            Row[19] <= 10'b0000000000;
            score_reg<=14'd0;
        end
        else if(update) begin
            Row[dot_reg1[4:0]][dot_reg1[9:5]] = 1;
            Row[dot_reg2[4:0]][dot_reg2[9:5]] = 1;
            Row[dot_reg3[4:0]][dot_reg3[9:5]] = 1;
            Row[dot_reg4[4:0]][dot_reg4[9:5]] = 1;
        end
        else if(Row[19] == 10'b1111111111)
        begin
            Row[19] <= Row[18];
            Row[18] <= Row[17];
            Row[17] <= Row[16];
            Row[16] <= Row[15];
            Row[15] <= Row[14];
            Row[14] <= Row[13];
            Row[13] <= Row[12];
            Row[12] <= Row[11];
            Row[11] <= Row[10];
            Row[10] <= Row[9];
            Row[9] <= Row[8];
            Row[8] <= Row[7];
            Row[7] <= Row[6];
            Row[6] <= Row[5];
            Row[5] <= Row[4];
            Row[4] <= Row[3];
            Row[3] <= Row[2];
            Row[2] <= Row[1];
            Row[1] <= Row[0];
            score_reg<=score_reg+'d1;
        end
        else if(Row[18] == 10'b1111111111)
        begin
            Row[18] <= Row[17];
            Row[17] <= Row[16];
            Row[16] <= Row[15];
            Row[15] <= Row[14];
            Row[14] <= Row[13];
            Row[13] <= Row[12];
            Row[12] <= Row[11];
            Row[11] <= Row[10];
            Row[10] <= Row[9];
            Row[9] <= Row[8];
            Row[8] <= Row[7];
            Row[7] <= Row[6];
            Row[6] <= Row[5];
            Row[5] <= Row[4];
            Row[4] <= Row[3];
            Row[3] <= Row[2];
            Row[2] <= Row[1];
            Row[1] <= Row[0];
            score_reg<=score_reg+'d1;
        end
        else if(Row[17] == 10'b1111111111)
        begin
            Row[17] <= Row[16];
            Row[16] <= Row[15];
            Row[15] <= Row[14];
            Row[14] <= Row[13];
            Row[13] <= Row[12];
            Row[12] <= Row[11];
            Row[11] <= Row[10];
            Row[10] <= Row[9];
            Row[9] <= Row[8];
            Row[8] <= Row[7];
            Row[7] <= Row[6];
            Row[6] <= Row[5];
            Row[5] <= Row[4];
            Row[4] <= Row[3];
            Row[3] <= Row[2];
            Row[2] <= Row[1];
            Row[1] <= Row[0];
            score_reg<=score_reg+'d1;
        end
        else if(Row[16] == 10'b1111111111)
        begin
            Row[16] <= Row[15];
            Row[15] <= Row[14];
            Row[14] <= Row[13];
            Row[13] <= Row[12];
            Row[12] <= Row[11];
            Row[11] <= Row[10];
            Row[10] <= Row[9];
            Row[9] <= Row[8];
            Row[8] <= Row[7];
            Row[7] <= Row[6];
            Row[6] <= Row[5];
            Row[5] <= Row[4];
            Row[4] <= Row[3];
            Row[3] <= Row[2];
            Row[2] <= Row[1];
            Row[1] <= Row[0];
            score_reg<=score_reg+'d1;
        end
        else if(Row[15] == 10'b1111111111)
        begin
            Row[15] <= Row[14];
            Row[14] <= Row[13];
            Row[13] <= Row[12];
            Row[12] <= Row[11];
            Row[11] <= Row[10];
            Row[10] <= Row[9];
            Row[9] <= Row[8];
            Row[8] <= Row[7];
            Row[7] <= Row[6];
            Row[6] <= Row[5];
            Row[5] <= Row[4];
            Row[4] <= Row[3];
            Row[3] <= Row[2];
            Row[2] <= Row[1];
            Row[1] <= Row[0];
            score_reg<=score_reg+'d1;
        end
        else if(Row[14] == 10'b1111111111)
        begin
            Row[14] <= Row[13];
            Row[13] <= Row[12];
            Row[12] <= Row[11];
            Row[11] <= Row[10];
            Row[10] <= Row[9];
            Row[9] <= Row[8];
            Row[8] <= Row[7];
            Row[7] <= Row[6];
            Row[6] <= Row[5];
            Row[5] <= Row[4];
            Row[4] <= Row[3];
            Row[3] <= Row[2];
            Row[2] <= Row[1];
            Row[1] <= Row[0];
            score_reg<=score_reg+'d1;
        end
        else if(Row[13] == 10'b1111111111)
        begin
            Row[13] <= Row[12];
            Row[12] <= Row[11];
            Row[11] <= Row[10];
            Row[10] <= Row[9];
            Row[9] <= Row[8];
            Row[8] <= Row[7];
            Row[7] <= Row[6];
            Row[6] <= Row[5];
            Row[5] <= Row[4];
            Row[4] <= Row[3];
            Row[3] <= Row[2];
            Row[2] <= Row[1];
            Row[1] <= Row[0];
            score_reg<=score_reg+'d1;
        end
        else if(Row[12] == 10'b1111111111)
        begin
            Row[12] <= Row[11];
            Row[11] <= Row[10];
            Row[10] <= Row[9];
            Row[9] <= Row[8];
            Row[8] <= Row[7];
            Row[7] <= Row[6];
            Row[6] <= Row[5];
            Row[5] <= Row[4];
            Row[4] <= Row[3];
            Row[3] <= Row[2];
            Row[2] <= Row[1];
            Row[1] <= Row[0];
            score_reg<=score_reg+'d1;
        end
        else if(Row[11] == 10'b1111111111)
        begin
            Row[11] <= Row[10];
            Row[10] <= Row[9];
            Row[9] <= Row[8];
            Row[8] <= Row[7];
            Row[7] <= Row[6];
            Row[6] <= Row[5];
            Row[5] <= Row[4];
            Row[4] <= Row[3];
            Row[3] <= Row[2];
            Row[2] <= Row[1];
            Row[1] <= Row[0];
            score_reg<=score_reg+'d1;
        end
        else if(Row[10] == 10'b1111111111)
        begin
            Row[10] <= Row[9];
            Row[9] <= Row[8];
            Row[8] <= Row[7];
            Row[7] <= Row[6];
            Row[6] <= Row[5];
            Row[5] <= Row[4];
            Row[4] <= Row[3];
            Row[3] <= Row[2];
            Row[2] <= Row[1];
            Row[1] <= Row[0];
            score_reg<=score_reg+'d1;
        end
        else if(Row[9] == 10'b1111111111)
        begin
            Row[9] <= Row[8];
            Row[8] <= Row[7];
            Row[7] <= Row[6];
            Row[6] <= Row[5];
            Row[5] <= Row[4];
            Row[4] <= Row[3];
            Row[3] <= Row[2];
            Row[2] <= Row[1];
            Row[1] <= Row[0];
            score_reg<=score_reg+'d1;
        end
        else if(Row[8] == 10'b1111111111)
        begin
            Row[8] <= Row[7];
            Row[7] <= Row[6];
            Row[6] <= Row[5];
            Row[5] <= Row[4];
            Row[4] <= Row[3];
            Row[3] <= Row[2];
            Row[2] <= Row[1];
            Row[1] <= Row[0];
            score_reg<=score_reg+'d1;
        end
        else if(Row[7] == 10'b1111111111)
        begin
            Row[7] <= Row[6];
            Row[6] <= Row[5];
            Row[5] <= Row[4];
            Row[4] <= Row[3];
            Row[3] <= Row[2];
            Row[2] <= Row[1];
            Row[1] <= Row[0];
            score_reg<=score_reg+'d1;
        end
        else if(Row[6] == 10'b1111111111)
        begin
            Row[6] <= Row[5];
            Row[5] <= Row[4];
            Row[4] <= Row[3];
            Row[3] <= Row[2];
            Row[2] <= Row[1];
            Row[1] <= Row[0];
            score_reg<=score_reg+'d1;
        end
        else if(Row[5] == 10'b1111111111)
        begin
            Row[5] <= Row[4];
            Row[4] <= Row[3];
            Row[3] <= Row[2];
            Row[2] <= Row[1];
            Row[1] <= Row[0];
            score_reg<=score_reg+'d1;
        end
        else if(Row[4] == 10'b1111111111)
        begin
            Row[4] <= Row[3];
            Row[3] <= Row[2];
            Row[2] <= Row[1];
            Row[1] <= Row[0];
            score_reg<=score_reg+'d1;
        end
        else if(Row[3] == 10'b1111111111)
        begin
            Row[3] <= Row[2];
            Row[2] <= Row[1];
            Row[1] <= Row[0];
            score_reg<=score_reg+'d1;
        end
        else if(Row[2] == 10'b1111111111)
        begin
            Row[2] <= Row[1];
            Row[1] <= Row[0];
            score_reg<=score_reg+'d1;
        end
        else if(Row[1] == 10'b1111111111)
        begin
            Row[1] <= Row[0];
            score_reg<=score_reg+'d1;
        end
        else begin
            Row[0]  <= Row[0];
            Row[1]  <= Row[1];
            Row[2]  <= Row[2];
            Row[3]  <= Row[3];
            Row[4]  <= Row[4];
            Row[5]  <= Row[5];
            Row[6]  <= Row[6];
            Row[7]  <= Row[7];
            Row[8]  <= Row[8];
            Row[9]  <= Row[9];
            Row[10] <= Row[10];
            Row[11] <= Row[11];
            Row[12] <= Row[12];
            Row[13] <= Row[13];
            Row[14] <= Row[14];
            Row[15] <= Row[15];
            Row[16] <= Row[16];
            Row[17] <= Row[17];
            Row[18] <= Row[18];
            Row[19] <= Row[19];
            score_reg<=score_reg;
        end
    end
    
    always@(posedge clk) begin // Generate the update signal
        if(start)  update1<=1'b0;
        else if(TimeUp) begin 
            if(dot1[4:0]==19) update1<= 1;
            else if(Row[dot1[4:0]+1'b1][dot1[9:5]]==1'b1) update1<=1'b1;
            else update1<=1'b0;
        end
        else update1<=1'b0;
    end
    
    always@(posedge clk) begin 
        if(start)  update2<=1'b0;
        else if(TimeUp) begin 
            if(dot2[4:0]==19) update2<=1;
            else if(Row[dot2[4:0]+1'b1][dot2[9:5]]==1'b1) update2<=1'b1;
            else update2<=1'b0;
        end
        else update2<=1'b0;
    end
    
    always@(posedge clk) begin 
        if(start) update3<=1'b0;
        else if(TimeUp) begin 
            if(dot3[4:0]==19) update3<=1;
            else if(Row[dot3[4:0]+1'b1][dot3[9:5]]==1'b1) update3<=1'b1;
            else update3<=1'b0;
        end
        else update3<=1'b0;
    end
    always@(posedge clk) begin 
        if(start)  update4<=1'b0;
        else if(TimeUp) begin 
            if(dot4[4:0]==19) update4<=1;
            else if(Row[dot4[4:0]+1'b1][dot4[9:5]]==1'b1) update4<=1'b1;
            else update4<=1'b0;
        end
        else update4<=1'b0;
    end
    
    always@(posedge clk) begin //Update the state of the current blocks
        if(start) begin
            dot_reg1<='d0;
            dot_reg2<='d0;
            dot_reg3<='d0;
            dot_reg4<='d0;
        end
        else if(TimeUp) begin
            dot_reg1 <= dot1;
            dot_reg2 <= dot2;
            dot_reg3 <= dot3;
            dot_reg4 <= dot4;
        end
        else
        begin
            dot_reg1 <= dot_reg1;
            dot_reg2 <= dot_reg2;
            dot_reg3 <= dot_reg3;
            dot_reg4 <= dot_reg4;
        end
    end
    
    always@(posedge vgaclk) begin //Display the map blocks
        if(start) map_reg0 <= 0;
  
        else if(yaddr>y_start+1'b1 && yaddr<y_start+block-1'b1)
            if (Row[0][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg0<=1;
            else if (Row[0][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg0<=1;
            else if (Row[0][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg0<=1;
            else if (Row[0][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg0<=1;
            else if (Row[0][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg0<=1;
            else if (Row[0][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg0<=1;
            else if (Row[0][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg0<=1;
            else if (Row[0][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg0<=1;
            else if (Row[0][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg0<=1;
            else if (Row[0][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg0<=1;
            else map_reg0<=0;
        else
            map_reg0<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) map_reg1 <= 0;
        else if(yaddr>y_start+block*1+1'b1 && yaddr<y_start+block*2-1'b1)
            if (Row[1][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg1<=1;
            else if (Row[1][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg1<=1;
            else if (Row[1][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg1<=1;
            else if (Row[1][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg1<=1;
            else if (Row[1][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg1<=1;
            else if (Row[1][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg1<=1;
            else if (Row[1][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg1<=1;
            else if (Row[1][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg1<=1;
            else if (Row[1][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg1<=1;
            else if (Row[1][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg1<=1;
            else map_reg1<=0;
        else
            map_reg1<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) map_reg2 <= 0;
        else if(yaddr>y_start+block*2+1'b1 && yaddr<y_start+block*3-1'b1)
            if (Row[2][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg2<=1;
            else if (Row[2][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg2<=1;
            else if (Row[2][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg2<=1;
            else if (Row[2][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg2<=1;
            else if (Row[2][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg2<=1;
            else if (Row[2][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg2<=1;
            else if (Row[2][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg2<=1;
            else if (Row[2][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg2<=1;
            else if (Row[2][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg2<=1;
            else if (Row[2][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg2<=1;
            else map_reg2<=0;
        else
            map_reg2<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) map_reg3 <= 0;
        else if(yaddr>y_start+block*3+1'b1 && yaddr<y_start+block*4-1'b1)
            if (Row[3][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg3<=1;
            else if (Row[3][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg3<=1;
            else if (Row[3][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg3<=1;
            else if (Row[3][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg3<=1;
            else if (Row[3][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg3<=1;
            else if (Row[3][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg3<=1;
            else if (Row[3][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg3<=1;
            else if (Row[3][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg3<=1;
            else if (Row[3][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg3<=1;
            else if (Row[3][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg3<=1;
            else map_reg3<=0;
        else
            map_reg3<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) map_reg4 <= 0;
        else if(yaddr>y_start+block*4+1'b1 && yaddr<y_start+block*5-1'b1)
            if (Row[4][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg4<=1;
            else if (Row[4][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg4<=1;
            else if (Row[4][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg4<=1;
            else if (Row[4][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg4<=1;
            else if (Row[4][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg4<=1;
            else if (Row[4][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg4<=1;
            else if (Row[4][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg4<=1;
            else if (Row[4][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg4<=1;
            else if (Row[4][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg4<=1;
            else if (Row[4][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg4<=1;
            else map_reg4<=0;
        else
            map_reg4<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) map_reg5 <= 0;
        else if(yaddr>y_start+block*5+1'b1 && yaddr<y_start+block*6-1'b1)
            if (Row[5][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg5<=1;
            else if (Row[5][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg5<=1;
            else if (Row[5][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg5<=1;
            else if (Row[5][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg5<=1;
            else if (Row[5][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg5<=1;
            else if (Row[5][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg5<=1;
            else if (Row[5][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg5<=1;
            else if (Row[5][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg5<=1;
            else if (Row[5][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg5<=1;
            else if (Row[5][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg5<=1;
            else map_reg5<=0;
        else
            map_reg5<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) map_reg6 <= 0;
        else if(yaddr>y_start+block*6+1'b1 && yaddr<y_start+block*7-1'b1)
            if (Row[6][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg6<=1;
            else if (Row[6][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg6<=1;
            else if (Row[6][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg6<=1;
            else if (Row[6][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg6<=1;
            else if (Row[6][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg6<=1;
            else if (Row[6][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg6<=1;
            else if (Row[6][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg6<=1;
            else if (Row[6][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg6<=1;
            else if (Row[6][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg6<=1;
            else if (Row[6][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg6<=1;
            else map_reg6<=0;
        else
            map_reg6<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) map_reg7 <= 0;
        else if(yaddr>y_start+block*7+1'b1 && yaddr<y_start+block*8-1'b1)
            if (Row[7][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg7<=1;
            else if (Row[7][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg7<=1;
            else if (Row[7][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg7<=1;
            else if (Row[7][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg7<=1;
            else if (Row[7][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg7<=1;
            else if (Row[7][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg7<=1;
            else if (Row[7][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg7<=1;
            else if (Row[7][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg7<=1;
            else if (Row[7][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg7<=1;
            else if (Row[7][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg7<=1;
            else map_reg7<=0;
        else
            map_reg7<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) map_reg8 <= 0;
        else if(yaddr>y_start+block*8+1'b1 && yaddr<y_start+block*9-1'b1)
            if (Row[8][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg8<=1;
            else if (Row[8][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg8<=1;
            else if (Row[8][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg8<=1;
            else if (Row[8][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg8<=1;
            else if (Row[8][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg8<=1;
            else if (Row[8][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg8<=1;
            else if (Row[8][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg8<=1;
            else if (Row[8][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg8<=1;
            else if (Row[8][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg8<=1;
            else if (Row[8][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg8<=1;
            else map_reg8<=0;
        else
            map_reg8<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) map_reg9 <= 0;
        else if(yaddr>y_start+block*9+1'b1 && yaddr<y_start+block*10-1'b1)
            if (Row[9][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg9<=1;
            else if (Row[9][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg9<=1;
            else if (Row[9][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg9<=1;
            else if (Row[9][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg9<=1;
            else if (Row[9][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg9<=1;
            else if (Row[9][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg9<=1;
            else if (Row[9][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg9<=1;
            else if (Row[9][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg9<=1;
            else if (Row[9][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg9<=1;
            else if (Row[9][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg9<=1;
            else map_reg9<=0;
        else
            map_reg9<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) map_reg10 <= 0;
        else if(yaddr>y_start+block*10+1'b1 && yaddr<y_start+block*11-1'b1)
            if (Row[10][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg10<=1;
            else if (Row[10][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg10<=1;
            else if (Row[10][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg10<=1;
            else if (Row[10][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg10<=1;
            else if (Row[10][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg10<=1;
            else if (Row[10][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg10<=1;
            else if (Row[10][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg10<=1;
            else if (Row[10][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg10<=1;
            else if (Row[10][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg10<=1;
            else if (Row[10][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg10<=1;
            else map_reg10<=0;
        else
            map_reg10<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) map_reg11 <= 0;
        else if(yaddr>y_start+block*11+1'b1 && yaddr<y_start+block*12-1'b1)
            if (Row[11][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg11<=1;
            else if (Row[11][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg11<=1;
            else if (Row[11][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg11<=1;
            else if (Row[11][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg11<=1;
            else if (Row[11][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg11<=1;
            else if (Row[11][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg11<=1;
            else if (Row[11][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg11<=1;
            else if (Row[11][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg11<=1;
            else if (Row[11][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg11<=1;
            else if (Row[11][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg11<=1;
            else map_reg11<=0;
        else
            map_reg11<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) map_reg12 <= 0;
        else if(yaddr>y_start+block*12+1'b1 && yaddr<y_start+block*13-1'b1)
            if (Row[12][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg12<=1;
            else if (Row[12][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg12<=1;
            else if (Row[12][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg12<=1;
            else if (Row[12][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg12<=1;
            else if (Row[12][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg12<=1;
            else if (Row[12][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg12<=1;
            else if (Row[12][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg12<=1;
            else if (Row[12][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg12<=1;
            else if (Row[12][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg12<=1;
            else if (Row[12][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg12<=1;
            else map_reg12<=0;
        else
            map_reg12<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) map_reg13 <= 0;
        else if(yaddr>y_start+block*13+1'b1 && yaddr<y_start+block*14-1'b1)
            if (Row[13][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg13<=1;
            else if (Row[13][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg13<=1;
            else if (Row[13][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg13<=1;
            else if (Row[13][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg13<=1;
            else if (Row[13][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg13<=1;
            else if (Row[13][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg13<=1;
            else if (Row[13][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg13<=1;
            else if (Row[13][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg13<=1;
            else if (Row[13][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg13<=1;
            else if (Row[13][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg13<=1;
            else map_reg13<=0;
        else
            map_reg13<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) map_reg14 <= 0;
        else if(yaddr>y_start+block*14+1'b1 && yaddr<y_start+block*15-1'b1)
            if (Row[14][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg14<=1;
            else if (Row[14][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg14<=1;
            else if (Row[14][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg14<=1;
            else if (Row[14][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg14<=1;
            else if (Row[14][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg14<=1;
            else if (Row[14][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg14<=1;
            else if (Row[14][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg14<=1;
            else if (Row[14][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg14<=1;
            else if (Row[14][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg14<=1;
            else if (Row[14][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg14<=1;
            else map_reg14<=0;
        else
            map_reg14<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) map_reg15 <= 0;
        else if(yaddr>y_start+block*15+1'b1 && yaddr<y_start+block*16-1'b1)
            if (Row[15][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg15<=1;
            else if (Row[15][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg15<=1;
            else if (Row[15][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg15<=1;
            else if (Row[15][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg15<=1;
            else if (Row[15][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg15<=1;
            else if (Row[15][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg15<=1;
            else if (Row[15][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg15<=1;
            else if (Row[15][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg15<=1;
            else if (Row[15][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg15<=1;
            else if (Row[15][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg15<=1;
            else map_reg15<=0;
        else
            map_reg15<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) map_reg16 <= 0;
        else if(yaddr>y_start+block*16+1'b1 && yaddr<y_start+block*17-1'b1)
            if (Row[16][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg16<=1;
            else if (Row[16][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg16<=1;
            else if (Row[16][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg16<=1;
            else if (Row[16][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg16<=1;
            else if (Row[16][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg16<=1;
            else if (Row[16][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg16<=1;
            else if (Row[16][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg16<=1;
            else if (Row[16][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg16<=1;
            else if (Row[16][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg16<=1;
            else if (Row[16][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg16<=1;
            else map_reg16<=0;
        else
            map_reg16<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) map_reg17 <= 0;
        else if(yaddr>y_start+block*17+1'b1 && yaddr<y_start+block*18-1'b1)
            if (Row[17][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg17<=1;
            else if (Row[17][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg17<=1;
            else if (Row[17][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg17<=1;
            else if (Row[17][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg17<=1;
            else if (Row[17][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg17<=1;
            else if (Row[17][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg17<=1;
            else if (Row[17][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg17<=1;
            else if (Row[17][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg17<=1;
            else if (Row[17][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg17<=1;
            else if (Row[17][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg17<=1;
            else map_reg17<=0;
        else
            map_reg17<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) map_reg18 <= 0;
        else if(yaddr>y_start+block*18+1'b1 && yaddr<y_start+block*19-1'b1)
            if (Row[18][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg18<=1;
            else if (Row[18][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg18<=1;
            else if (Row[18][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg18<=1;
            else if (Row[18][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg18<=1;
            else if (Row[18][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg18<=1;
            else if (Row[18][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg18<=1;
            else if (Row[18][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg18<=1;
            else if (Row[18][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg18<=1;
            else if (Row[18][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg18<=1;
            else if (Row[18][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg18<=1;
            else map_reg18<=0;
        else
            map_reg18<=0;
    end
    
    always@(posedge vgaclk) begin
        if(start) map_reg19 <= 0;
        else if(yaddr>y_start+block*19+1'b1 && yaddr<y_start+block*20-1'b1)
            if (Row[19][0]==1&&xaddr>x_start+1'b1 && xaddr<x_start+block-1'b1)
                map_reg19<=1;
            else if (Row[19][1]==1&&xaddr>x_start+block+1'b1 && xaddr<x_start+block*2-1'b1)
                map_reg19<=1;
            else if (Row[19][2]==1&&xaddr>x_start+block*2+1'b1 && xaddr<x_start+block*3-1'b1)
                map_reg19<=1;
            else if (Row[19][3]==1&&xaddr>x_start+block*3+1'b1 && xaddr<x_start+block*4-1'b1)
                map_reg19<=1;
            else if (Row[19][4]==1&&xaddr>x_start+block*4+1'b1 && xaddr<x_start+block*5-1'b1)
                map_reg19<=1;
            else if (Row[19][5]==1&&xaddr>x_start+block*5+1'b1 && xaddr<x_start+block*6-1'b1)
                map_reg19<=1;
            else if (Row[19][6]==1&&xaddr>x_start+block*6+1'b1 && xaddr<x_start+block*7-1'b1)
                map_reg19<=1;
            else if (Row[19][7]==1&&xaddr>x_start+block*7+1'b1 && xaddr<x_start+block*8-1'b1)
                map_reg19<=1;
            else if (Row[19][8]==1&&xaddr>x_start+block*8+1'b1 && xaddr<x_start+block*9-1'b1)
                map_reg19<=1;
            else if (Row[19][9]==1&&xaddr>x_start+block*9+1'b1 && xaddr<x_start+block*10-1'b1)
                map_reg19<=1;
            else map_reg19<=0;
        else
            map_reg19<=0;
    end
endmodule
