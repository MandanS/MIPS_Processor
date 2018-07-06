`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MANDAN SHARMA
// 
// Create Date:    18:52:39 12/05/2017 
// Design Name: 
// Module Name:    Chip 
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
module Chip(
	input wire clk,reset,
	input wire [31:0] MDout, previnst,
	output wire dmen,dmwr,
	output wire [31:0] PC, Ma,  MD2,B1,
	output wire [4:0] shamt
    );
	wire eq;
	wire [31:0] A,B,C,D,A0,B0,A1/*,B1*/,INST,RA,MD0,MD1,RA1,RA2,Bimm;
	wire [4:0] asel,bsel;//,shamt;
	wire [5:0] csel,func;

	// Control Unit
Control_Unit CU(
    .clr(reset),.clk(clk),.INST(INST),.PCs1(PCs1),.PCs0(PCs0),.stall0(stall0),.stall1(stall1),.se(se),.asel(asel),.bsel(bsel),.csel(csel),.df1(df1),.df0(df0),.bf1(bf1),.bf0(bf0),.af1(af1),
	 .af0(af0),.neg( A0[31] ),.eq(eq),.stall2(stall2),.func(func),.shamt(shamt),.stall(1'b1),.stall3(stall3),.dmen(dmen),.dmwr(dmwr),.retaddr(retaddr),.load(load));

	//PC
PC_Register PCr(.clk(clk),.clr(reset),.PCs1(PCs1),.PCs0(PCs0),.stall0(stall0),.INST(INST),.A(A[31:2]),.RA(RA),.PC(PC));

////////////////////////////////////////////STAGE 1///////////////////////////////////////////////////////////////////

	//PMEM
	//   PC  --> previnst off chip


	// PC Register
Program_Register PCReg(.clk(clk),.reset(reset),.en(stall1),.D(previnst),.Q(INST));

////////////////////////////////////////////STAGE 2///////////////////////////////////////////////////////////////////

	//IMM
IMM IMM(.INST(INST[15:0]),.se(se),.B(Bimm));

	// Muxes
MUX af(.A(A),.B(D),.C(C),.D(32'h0),.Y(A0),.sel({af1,af0}));
MUX bf(.A(B),.B(D),.C(C),.D(Bimm),.Y(B0),.sel({bf1,bf0}));
MUX df(.A(B),.B(D),.C(C),.D(32'h0),.Y(MD0),.sel({df1,df0}));

	// Equality Detector
	assign	eq = A0 == B0;

////////////////////////////////////////////STAGE 3///////////////////////////////////////////////////////////////////

	// Registers
Register RegRA(.clk(clk),.en(stall2),.D(RA),.Q(RA1));
Register RegA(.clk(clk),.en(stall2),.D(A0),.Q(A1));
Register RegB(.clk(clk),.en(stall2),.D(B0),.Q(B1));
Register RegD(.clk(clk),.en(stall2),.D(MD0),.Q(MD1));

	// ALU
ALU ALU(.func(func),.shamt(shamt),.A(A1),.B(B1),.D(D));

////////////////////////////////////////////STAGE 4///////////////////////////////////////////////////////////////////

	// Registers 
Register RegRA1(.clk(clk),.en(stall3),.D(RA1),.Q(RA2));
Register RegALU(.clk(clk),.en(stall3),.D(D),.Q(Ma));
Register RegD1(.clk(clk),.en(stall3),.D(MD1),.Q(MD2));
	// Mux Out
MUX MuxOut(.A(Ma),.B(MDout),.C(RA2),.D(32'h0),.Y(C),.sel({retaddr,load}));
////////////////////////////////////////////STAGE 5///////////////////////////////////////////////////////////////////
	// Reg File
Register_File Reg_File(.clk(clk),.wr_en(~csel[5]),.w_addr(csel[4:0]) ,.r_addr(asel) ,.r_addr2(bsel),.w_data(C),.r_data(A),.r_data2(B));

endmodule
