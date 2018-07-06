`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MANDAN SHARMA
// 
// Create Date:    19:28:16 12/05/2017 
// Design Name: 
// Module Name:    clock_gen 
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
module clock_gen(
   input wire clkin,
	output reg [0:0]count,
	input wire reset
    );

	// FILL CODE HERE to implement an 1-bit counter
	always@(posedge clkin) begin
		if(count == 1'h1)
			count <= 1'b0;
		else if(reset==1)
				count<=1'h0;
		else
			count <= count + 1'b1;
	end


endmodule
