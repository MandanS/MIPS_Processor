`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MANDAN SHARMA
// 
// Create Date:    23:17:14 12/05/2017 
// Design Name: 
// Module Name:    Display_Memory 
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
module Display_Memory(
    input wire reset,
		input wire [15:0] data_in,
		input wire [13:0] addr,char_addr,
		input wire we,
		input wire clk,
		output reg [15:0] data_out,char_data_out
 );

	reg [15:0] ram[(2**13)-1:0];
	
//	initial begin
//	        $readmemb("ram_data.txt",ram);
//	end
	
	always@(posedge clk /*or negedge reset*/) 
	begin
	        if (reset)
	                ram[addr] = 16'h0;
	        else begin
	                if (~we) begin
	                        ram[addr] = data_in;
									//data_out = ram[addr];
									end
	                //else
	                       // data_out = ram[addr];		
	        end 
		char_data_out = ram[char_addr];
	end 
endmodule
