`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mandan Sharma
// 
// Create Date:    23:18:01 12/05/2017 
// Design Name: 
// Module Name:    single_port_Sram 
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
module single_port_Sram(
    );

sram_ctrl ram0(
		.clk(clk), .reset(reset),
		// to/from main system 
		.mem(1'b1),.rw(dmwr),
		.addr(addr), 
		.data_f2s(), 
		.ready(),
		.data_s2f_r() ,.data_s2f_ur() , // to/from sram chip
		.ad(),	
		.we_n(), .oe_n(),
		// sram chip a
		.dio_a(),
		.ce_a_n(), .ub_a_n(), .lb_a_n()
    );
	 
sram_ctrl ram1(
		.clk(clk), .reset(),
		// to/from main system 
		.mem(), .rw(),
		.addr(), 
		.data_f2s(), 
		.ready(),
		.data_s2f_r() , .data_s2f_ur() , // to/from sram chip
		.ad(),	
		.we_n(), .oe_n(),
		// sram chip a
		.dio_a(),
		.ce_a_n(), .ub_a_n(), .lb_a_n()
    );

endmodule
