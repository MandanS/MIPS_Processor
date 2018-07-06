`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MANDAN SHARMA
// 
// Create Date:    21:34:47 12/05/2017 
// Design Name: 
// Module Name:    clock_gen_testing 
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
module clock_gen_testing(
   input wire clkin,
	input wire reset,

	output wire [3:0] AN
    );

    reg [17:0] count;
	 
	 always@(negedge clkin or posedge reset) begin
		
		if(reset == 1'b1 | count == 18'hFFFFF)
			count	<=	18'b0;
		else	
			count <= count + 1'b1;
	end
	
	assign AN[0] = ~(count[16] && count[17]);
	assign AN[1] = ~count[16] || count[17];
	assign AN[2] = count[16] || count[17];
   assign AN[3] = count[16] || ~count[17]; 


endmodule
