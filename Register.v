`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MANDAN SHARMA
// 
// Create Date:    04:23:43 11/16/2017 
// Design Name: 
// Module Name:    Register 
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
module Register(
				input wire clk,	
				input wire en,
				input wire [31:0]D,
				output reg [31:0]Q
		 );


	//always@(posedge clk or negedge reset) begin

	always@(posedge clk or posedge en) 
	begin	
		if (en == 1'b1)
			Q <= Q;
		else
			Q <= D; 
	end

endmodule
