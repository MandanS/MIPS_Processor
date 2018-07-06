`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MANDAN SHARMA
// 
// Create Date:    04:59:30 11/16/2017 
// Design Name: 
// Module Name:    PC_Register 
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
module PC_Register(
	 input wire clk,clr,PCs1,PCs0,stall0,
    input [31:0] INST,
    input [31:2] A,
    output [31:0] RA,
    output [31:0] PC
    );
	 wire [31:0] Y;
	 assign RA =((PC[31:2]+1'b1)<<2);

	 assign Y = ({PCs1,PCs0}==2'h0) ? RA :           						  32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;  //Next Add 4
	 assign Y = ({PCs1,PCs0}==2'h1) ? ({INST[15],INST[15],INST[15],INST[15],INST[15],INST[15],INST[15],INST[15],INST[15],INST[15],INST[15],INST[15],INST[15],INST[15],INST[15:0],2'h0} + PC) :  32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz; //Branch
	 assign Y = ({PCs1,PCs0}==2'h2) ? {PC[31:28],INST[25:0],PC[1:0]} :  32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;  // Jump
	 assign Y = ({PCs1,PCs0}==2'h3) ? { A[31:2] , 2'h0} :               32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;   // Jump Register
	 
	 
	Program_Register pr_register(clk, clr,stall0,Y,PC);

endmodule
