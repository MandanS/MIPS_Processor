`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MANDAN SHARMA
// 
// Create Date:    13:24:03 12/02/2017 
// Design Name: 
// Module Name:    Motherboard 
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

module Motherboard(
	input wire clk, reset,
	inout wire PS2KeyboardClk,PS2KeyboardData,
	output wire Hsync, Vsync, 
	output wire [2:0] vgaRed,
	output wire [2:0] vgaGreen,
	output wire [1:0] vgaBlue
/////////////////////////////////////////////////////Testing Purpose Only //////////////////////////////////////////////
	,output wire [7:0] Sseg,
	output wire [3:0] AN,
	output wire [7:0] Led,
	input wire [3:0] sw
	,input wire Manual_clock
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    );

	//Clock generation clk = 100 Mhz count[0] = 50 Mhz ......
	wire [0:0]count;
//	clock_gen clock_gen(.clkin(clk),.count(count),.reset());
	assign count[0]=Manual_clock;
	
	// Display Unit
	wire video_on;
	wire [9:0] pixel_x,pixel_y;
	wire [13:0] char_addr;
	wire [15:0] char_data;
	vga_sync vga_sync(.clk(count[0]), .reset(reset),
		.hsync(Hsync) , .vsync(Vsync) , .video_on(video_on), 
		.pixel_x(pixel_x), .pixel_y(pixel_y));
	Tile_generator Tile_gen(.clk(count[0]),.pixel_x(pixel_x),.pixel_y(pixel_y),.addr_b(char_addr),.din_b(16'hE041),.Red(vgaRed),.Green(vgaGreen),.Blue(vgaBlue),.video_on(video_on));
	
	
	// Keyboard Unit
	wire [7:0] key_data;
	data_receiving data_receiving (PS2KeyboardClk,PS2KeyboardData,reset, key_data);  
	
	// Processing Unit
	wire dmen,dmwr;
	wire [31:0] MDout,previnst,PC,Ma,MD2,B1;
	Chip Processor(.clk(count[0]),.reset(reset),.MDout(MDout),.previnst(previnst),.PC(PC),.Ma(Ma),.MD2(MD2),.dmen(dmen),.dmwr(dmwr),.B1(B1));
	
	
	// Memory Unit
	Ram Ram(.clk(count[0]), .reset(reset),.dmen(dmen),.dmwr(dmwr),.Ma(Ma),.MD2(MD2),.MDout(MDout),.char_addr(/*char_addr*/14'h0),.char_data_out(char_data),.key_data(key_data));
	
	// Pmem
	Program_Memory Program_Memory(.clk(count[0]),.addr(PC[31:2]),.data_out(previnst));

	
/////////////////////////////////////////////////////Testing Purpose Only //////////////////////////////////////////////
	reg [15:0] testprobe;
	initial 
		testprobe = 16'h0;
	always @(sw,clk)
		case (sw)
			4'h0 : testprobe = previnst[15:0];
			4'h1 : testprobe = previnst[31:16];
			4'h2 : testprobe = MD2[15:0];
			4'h3 : testprobe = MD2[31:16];
			4'h4 : testprobe = Ma[15:0];
			4'h5 : testprobe = Ma[31:16];
			4'h6 : testprobe = PC[15:0];
			4'h7 : testprobe = PC[31:16];
			4'h8 : testprobe = char_data;
			4'h9 : testprobe = {11'h0,dmen,3'h0,dmwr};
			4'hA : testprobe = B1[15:0];
			4'hB : testprobe = B1[31:16];
		endcase
	clock_gen_testing instage3 (clk,reset,AN);
	keyboard_to_Sseg instance2 (testprobe[15:0],AN, Sseg);
	assign Led = previnst[7:0];
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
endmodule
