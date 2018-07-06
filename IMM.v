`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MANDAN SHARMA
// 
// Create Date:    02:53:20 11/16/2017 
// Design Name: 
// Module Name:    IMM 
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
module IMM(
    input [15:0] INST,
    input se,
    output [31:0] B
    );

	wire sign;
	and(sign,se,INST[15]);
	assign B = {sign,sign,sign,sign,sign,sign,sign,sign,sign,sign,sign,sign,sign,sign,sign,sign,INST};

endmodule
