`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MANDAN SHARMA
// 
// Create Date:    18:56:13 12/05/2017 
// Design Name: 
// Module Name:    Register_File 
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
module Register_File
		#(
			parameter 	B = 32, // number of bits
							W = 5 // number of address bits
		)
		(
			input wire clk,
			input wire wr_en,
			input wire [W-1:0] w_addr , r_addr , r_addr2,
			input wire [B-1:0] w_data,
			output wire [B-1:0] r_data,r_data2
		);
		// signal declaration
		reg [B-1:0] array_reg [2**W-1:0] ;
		// body
		// write operation 
		always @(posedge clk)
			if (wr_en & w_addr != 5'h0) begin
				array_reg [w_addr] <= w_data;
				array_reg [5'h0] <= 32'h0;
				end
		// read operation
		assign r_data = array_reg [r_addr] ;
		assign r_data2 = array_reg [r_addr2] ;

endmodule
