`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MANDAN SHARMA
// 
// Create Date:    02:47:36 11/16/2017 
// Design Name: 
// Module Name:    Program_Register 
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
module Program_Register(
				input wire clk,	
				input wire reset,
				input wire en,
				input wire [31:0]D,
				output reg [31:0]Q
		 );


	//always@(posedge clk or negedge reset) begin

	always@(posedge clk or posedge reset) 
	begin	
		if (reset)
			Q <= 32'h0;
		else if (en == 1'b1)
			Q <= Q;
		else
			Q <= D; 
	end

endmodule
