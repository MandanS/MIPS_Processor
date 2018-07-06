`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MANDAN SHARMA
// 
// Create Date:    13:49:23 12/02/2017 
// Design Name: 
// Module Name:    Ram 
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
module Ram(
		input wire clk,reset,dmen,dmwr,
		input wire [31:0] Ma,MD2,
		output wire [31:0] MDout,
		input wire [13:0] char_addr,
		output wire [15:0] char_data_out,
		input wire [7:0] key_data);
	 
	  
	 
	 
	 // Block Ram for display starting at address 0xB00
	 wire [31:0] disp_ram_out;
	 Display_Memory Display_Memory(.reset(reset),.data_in(MD2),.addr(Ma[15:2]),.char_addr(char_addr),.we(!(dmwr && (Ma[31:20] == 12'hb00))),.clk(clk),.data_out(/*disp_ram_out*/),.char_data_out(Tile_data));
	 
	 //keyboard register 0xA0000000
	 wire [31:0] Q_out;
	 Program_Register keyboard_register(.clk(clk),.reset(reset),.en(1'b0),.D(key_data),.Q(Q_out));
	 assign MDout = (Ma[31:16] == 16'hA000) ? Q_out : 32'bz;
	 
	 // Sram to store processor data starting at address 0x10000000
	  wire [31:0] Sram_out;
	 single_port_Sram single_port_Sram();
	 assign MDout = (Ma[31:16] == 16'h1000) ? Sram_out : 32'bz;
	
endmodule

