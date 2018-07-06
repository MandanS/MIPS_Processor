`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MANDAN SHARMA
// 
// Create Date:    19:15:54 11/22/2017 
// Design Name: 
// Module Name:    data_receiving 
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
module data_receiving(
	
	inout wire K_clk,K_dat,
	input wire reset,
	output wire [7:0] d_out
	
    );
	reg [32:0] code;
	
	
	always@ (negedge K_clk or posedge reset) begin
		if(reset == 1'b1)
			code = 33'b0;
		else begin
			code = code << 1; 
			code[0] = K_dat;
		end
	end 
	assign d_out[7:0] = code[31:24];
	

endmodule
