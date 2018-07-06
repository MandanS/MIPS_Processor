`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MANDAN SHARMA
// 
// Create Date:    04:27:43 11/16/2017 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [5:0] func,
    input [4:0] shamt,
    input [31:0] A,
    input [31:0] B,
    output [31:0] D
    );
	 wire C32;
	 wire [31:0] adderOut,SLT;
	 
	 //Adder
		assign {C32,adderOut} = func[1] == 1'b1 ? (A + (~B + 1'b1)) : (A + B);
	 
	 
	 // Set Less than
	 
	assign SLT =  (({func[0],A[31],B[31],C32} ==	4'bx000) ||
						({func[0],A[31],B[31],C32} ==	4'b010x) ||
						({func[0],A[31],B[31],C32} ==	4'b101x) ||
						({func[0],A[31],B[31],C32} ==	4'bx110)) == 1'b1 ? 32'h1 :  32'h0 ; 
	 
	
	
	assign D = func == 	6'h00 ?  A<<shamt    : 32'bz;
	//assign D = func ==	6'h01 ?  ?  ;
	assign D = func == 6'h02  ? A>>shamt      : 32'bz;
	assign D = func == 6'h03  ? A>>>shamt     : 32'bz;
	assign D = func == 6'h04  ? A<<B[4:0]     : 32'bz;
	//assign D = func		6'h05 ? : ;
	assign D = func == 6'h06  ? A>>B[4:0]     : 32'bz;
	assign D = func == 6'h07  ? A>>>B[4:0]    : 32'bz;


	assign D = func == 6'b1000xx  ? adderOut  : 32'bz;
	assign D = func == 6'h24  ?   A & B       : 32'bz;
	assign D = func == 6'h25  ?   A | B       : 32'bz;
	assign D = func == 6'h26  ?   A ^ B       : 32'bz;
	assign D = func == 6'h27  ? ~(A | B)      : 32'bz;
	assign D = func == 6'b1010xx ? SLT        : 32'bz;

		
endmodule
