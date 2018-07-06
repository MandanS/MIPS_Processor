`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mandan Sharma
// 
// Create Date:    04:54:06 11/16/2017 
// Design Name: 
// Module Name:    Control_Unit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Control_Unit(
    input clr,
    input clk,
    input [31:0] INST,
    output PCs1,
    output PCs0,
    output stall0,
    output stall1,
    output se,
    output [4:0] asel,
    output [4:0] bsel,
    output [5:0] csel,
    output df1,
    output df0,
    output bf1,
    output bf0,
    output af1,
    output af0,
    input neg,
    input eq,
    output stall2,
    output [5:0] func,
    output [4:0] shamt,
	 input stall,
    output stall3,
    output dmen,
    output dmwr,
    output retaddr,
    output load
    );
		
		reg [3:0] memPLA1,memPLA2;
		reg [4:0] CselPLA1,CselPLA2;
		reg [4:0] shamtPLA1;
		reg [5:0] funcPLA1;
		
		wire [3:0] memPLA0;
		wire [4:0] CselPLA0;
		wire [4:0] shamtPLA0;
		wire [5:0] funcPLA0;
		
	
		assign {stall3,stall2,stall1,stall0} = {~stall,~stall,~stall,~stall};
		assign asel = INST[25:21];
		assign bsel = INST[20:16];
	// Fwd PLA	
	
	Fwd_PLA F0(asel,bsel,CselPLA1,CselPLA2,imm,af0,af1,bf0,bf1,df0,df1);
	// Imm PLA
	
	assign imm = 	(INST[31:26]==6'b001XXX) ||
						(INST[31:26]==6'b10X011);
						
	assign se  = 	(INST[31:26]==6'b0010XX) ||
						(INST[31:26]==6'b10X011);
	
	// PC PLA
	
	assign PCs0 =  		({INST[31:26],INST[20],INST[16],neg,eq,INST[5:0]} == 16'b0001X0XXX1XXXXXX ) ||
								({INST[31:26],INST[20],INST[16],neg,eq,INST[5:0]} == 16'b000101XXX0XXXXXX ) ||
								({INST[31:26],INST[20],INST[16],neg,eq,INST[5:0]} == 16'b000110XX1XXXXXXX ) ||
								({INST[31:26],INST[20],INST[16],neg,eq,INST[5:0]} == 16'b000111XX00XXXXXX ) ||
								({INST[31:26],INST[20],INST[16],neg,eq,INST[5:0]} == 16'b000001X10XXXXXXX ) ||
								({INST[31:26],INST[20],INST[16],neg,eq,INST[5:0]} == 16'b000001X01XXXXXXX ) ||
								({INST[31:26],INST[20],INST[16],neg,eq,INST[5:0]} == 16'b000000XXXX00100X );
	
	assign PCs1 =  		({INST[31:26],INST[20],INST[16],neg,eq,INST[5:0]} == 16'b00001XXXXXXXXXXX ) ||
								({INST[31:26],INST[20],INST[16],neg,eq,INST[5:0]} == 16'b000000XXXX00100X );
	
	assign memPLA0[3] =  ({INST[31:26],INST[20],INST[16],neg,eq,INST[5:0]} == 16'b000000XXXX001001 ) ||
								({INST[31:26],INST[20],INST[16],neg,eq,INST[5:0]} == 16'b0000011XXXXXXXXX ) ||
								({INST[31:26],INST[20],INST[16],neg,eq,INST[5:0]} == 16'b000011XXXXXXXXXX );
	
	
	//func PLA
	assign funcPLA0[0] =	({INST[31:26],INST[5:0]} == 12'b000000XXXXX1) ||
								({INST[31:26],INST[5:0]} == 12'b001X01XXXXXX) ||
								({INST[31:26],INST[5:0]} == 12'b001011XXXXXX);
								
	assign funcPLA0[1] =	({INST[31:26],INST[5:0]} == 12'b000000XXXX1X) ||
								({INST[31:26],INST[5:0]} == 12'b00101XXXXXXX) ||
								({INST[31:26],INST[5:0]} == 12'b001110XXXXXX);
								
	assign funcPLA0[2] =	({INST[31:26],INST[5:0]} == 12'b000000XXX1XX) ||
								({INST[31:26],INST[5:0]} == 12'b00110XXXXXXX) ||
								({INST[31:26],INST[5:0]} == 12'b001110XXXXXX);
								
	assign funcPLA0[3] =	({INST[31:26],INST[5:0]} == 12'b000000XX1XXX) ||
								({INST[31:26],INST[5:0]} == 12'b00101XXXXXXX);
								
	assign funcPLA0[4] =	({INST[31:26],INST[5:0]} == 12'b000000X1XXXX);
	
	assign funcPLA0[5] =	({INST[31:26],INST[5:0]} == 12'b0000001XXXXX) ||
								({INST[31:26],INST[5:0]} == 12'b0010XXXXXXXX) ||
								({INST[31:26],INST[5:0]} == 12'b00110XXXXXXX) ||
								({INST[31:26],INST[5:0]} == 12'b001110XXXXXX) ||
								({INST[31:26],INST[5:0]} == 12'b10XXXXXXXXXX);
	
	//Shamt PLA
	
	assign shamtPLA0[0] =	({INST[31:26],INST[10:6]} == 11'b000000XXXX1);
	
	assign shamtPLA0[1] =	({INST[31:26],INST[10:6]} == 11'b000000XXX1X);
	
	assign shamtPLA0[2] =	({INST[31:26],INST[10:6]} == 11'b000000XX1XX);
	
	assign shamtPLA0[3] =	({INST[31:26],INST[10:6]} == 11'b000000X1XXX);
	
	assign shamtPLA0[4] =	({INST[31:26],INST[10:6]} == 11'b0000001XXXX) ||
									({INST[31:26],INST[10:6]} == 11'b001111XXXXX);
	
	//Csel PLA
	
	assign CselPLA0[0] = 	({INST[31:26],INST[20:11]} == 16'b000000XXXXXXXXX1) ||
									({INST[31:26],INST[20:11]} == 16'b0000011000XXXXXX) ||
									({INST[31:26],INST[20:11]} == 16'b000011XXXXXXXXXX) ||
									({INST[31:26],INST[20:11]} == 16'b001XXXXXXX1XXXXX) ||
									({INST[31:26],INST[20:11]} == 16'b100011XXXX1XXXXX);
									
	assign CselPLA0[1] = 	({INST[31:26],INST[20:11]} == 16'b000000XXXXXXXX1X) ||
									({INST[31:26],INST[20:11]} == 16'b0000011000XXXXXX) ||
									({INST[31:26],INST[20:11]} == 16'b000011XXXXXXXXXX) ||
									({INST[31:26],INST[20:11]} == 16'b001XXXXXX1XXXXXX) ||
									({INST[31:26],INST[20:11]} == 16'b100011XXX1XXXXXX);
									
	assign CselPLA0[2] = 	({INST[31:26],INST[20:11]} == 16'b000000XXXXXXX1XX) ||
									({INST[31:26],INST[20:11]} == 16'b0000011000XXXXXX) ||
									({INST[31:26],INST[20:11]} == 16'b000011XXXXXXXXXX) ||
									({INST[31:26],INST[20:11]} == 16'b001XXXXX1XXXXXXX) ||
									({INST[31:26],INST[20:11]} == 16'b100011XX1XXXXXXX);
									
	assign CselPLA0[3] = 	({INST[31:26],INST[20:11]} == 16'b000000XXXXXX1XXX) ||
									({INST[31:26],INST[20:11]} == 16'b0000011000XXXXXX) ||
									({INST[31:26],INST[20:11]} == 16'b000011XXXXXXXXXX) ||
									({INST[31:26],INST[20:11]} == 16'b001XXXX1XXXXXXXX) ||
									({INST[31:26],INST[20:11]} == 16'b100011X1XXXXXXXX);
									
	assign CselPLA0[4] = 	({INST[31:26],INST[20:11]} == 16'b000000XXXXX1XXXX) ||
									({INST[31:26],INST[20:11]} == 16'b0000011000XXXXXX) ||
									({INST[31:26],INST[20:11]} == 16'b000011XXXXXXXXXX) ||
									({INST[31:26],INST[20:11]} == 16'b001XXX1XXXXXXXXX) ||
									({INST[31:26],INST[20:11]} == 16'b1000111XXXXXXXXX);
	// mem PLA
	
	assign memPLA0[0] =	(INST[31:26] == 6'b1XXXXX);
	assign memPLA0[1] =	(INST[31:26] == 6'b1X1XXX);
	assign memPLA0[2] =	(INST[31:26] == 6'b1X0XXX);
	
	initial begin
						memPLA1 <= 4'h0;
						memPLA2 <= 4'h0;
						CselPLA1 <= 5'h0;
						CselPLA2 <= 5'h0;
						shamtPLA1 <= 5'h0;
						funcPLA1 <= 6'h0;
				end
	
	
	always@(posedge clk or posedge clr) 
	begin	
		if (clr)
			begin
				memPLA1 <= 4'h0;
				memPLA2 <= 4'h0;
				CselPLA1 <= 5'h0;
				CselPLA2 <= 5'h0;
				shamtPLA1 <= 5'h0;
				funcPLA1 <= 6'h0;
			end
		else if (~stall == 1'b1)
			begin
				memPLA1 <= memPLA1;
				memPLA2 <= memPLA2;
				CselPLA1 <= CselPLA1;
				CselPLA2 <= CselPLA2;
				shamtPLA1 <= shamtPLA1;
				funcPLA1 <= funcPLA1;
			end
		else
			begin
				memPLA1 <= memPLA0;
				memPLA2 <= memPLA1;
				CselPLA1 <= CselPLA0;
				CselPLA2 <= CselPLA1;
				shamtPLA1 <= shamtPLA0;
				funcPLA1 <= funcPLA0;
			end 
	end
	
	assign func = funcPLA1;
	assign shamt = shamtPLA1;
	assign csel = {~stall,CselPLA2};
	assign {retaddr,load,dmwr,dmen} = memPLA2;
	
endmodule



















