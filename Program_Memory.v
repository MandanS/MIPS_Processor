`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MANDAN SHARMA
// 
// Create Date:    22:40:19 12/05/2017 
// Design Name: 
// Module Name:    Program_Memory 
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
module Program_Memory(
		input wire [29:0] addr,
		input wire clk,
		output reg [31:0] data_out
 );

	reg [31:0] ram[31:0];
	
	initial begin
	        $readmemh("ram_data.txt",ram);
	end
	
	always@(posedge clk ) begin
	        data_out = ram[addr];
	end


endmodule
