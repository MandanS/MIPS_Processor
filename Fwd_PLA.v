`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MANDAN SHARMA
// 
// Create Date:    23:00:52 11/17/2017 
// Design Name: 
// Module Name:    Fwd_PLA 
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
module Fwd_PLA(
    input [4:0] Asel,
    input [4:0] Bsel,
    input [4:0] Cm1,
    input [4:0] Cm2,
    input wire imm,
    output af0,
    output af1,
    output bf0,
    output bf1,
    output df0,
    output df1
    );
	 
	 // ForwardA PLA
	 wire [2:0]InA;
	 
	 assign InA[1:0] = {Asel == Cm1,Asel == Cm2};
	 nor(InA[2],Asel[4],Asel[3],Asel[2],Asel[1],Asel[0]);
	 
	 assign af1= InA == 3'b001;
	 assign af0= InA == 3'b01X;
	 
	 // ForwardB PLA
	 wire [3:0]InB;
	 
	 assign {InB[3],InB[1:0]}={imm,Bsel == Cm1,Bsel == Cm2};
	 nor(InB[2],Bsel[4],Bsel[3],Bsel[2],Bsel[1],Bsel[0]);
	 
	 assign bf0=   (InB == 4'b1XXX) ||
						(InB == 4'b001X);
						
	 assign bf1 =  (InB == 4'b1XXX) ||
						(InB == 4'b0001);
						
	 assign df0=    InB == 4'bX01X;
	 assign df1=    InB == 4'bX001;
	 
endmodule
