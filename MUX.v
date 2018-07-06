`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MANDAN SHARMA
// 
// Create Date:    04:17:17 11/16/2017 
// Design Name: 
// Module Name:    MUX 
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
module MUX(
    input wire [31:0] A,
    input wire [31:0] B,
    input wire [31:0] C,
    input wire [31:0] D,
    output wire[31:0] Y,
	 input wire [1:0] sel
    );
	
	 assign Y = (sel==2'h0) ? A :  32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz; 
	 assign Y = (sel==2'h1) ? B :  32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz; 
	 assign Y = (sel==2'h2) ? C :  32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;  
	 assign Y = (sel==2'h3) ? D :  32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;   
	 
endmodule
