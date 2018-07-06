`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MANDAN SHARMA
// 
// Create Date:    21:04:27 11/20/2017 
// Design Name: 
// Module Name:    keyboard_to_Sseg 
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
module keyboard_to_Sseg(
	input wire [15:0] data_in,
	input wire [3:0] AN,
   output reg [7:0] Sseg_from_BCD
    );
	 
	
	 reg [3:0] digit;
	 
	 always@(data_in,AN) begin
		if (AN == 4'hE )
		   digit = data_in[3:0];
		else if (AN == 4'hD)
		   digit = data_in[7:4];
		else if (AN == 4'hB)
		   digit = data_in[11:8];
		else if (AN == 4'h7)
		   digit = data_in[15:12];
		else
			digit = 4'h0;    // default case in case structure
	 end
	
	 always@(digit) begin
			case (digit)
				
				4'h0 : Sseg_from_BCD = 8'h03; //0
            4'h1 : Sseg_from_BCD = 8'h9F; //1
            4'h2 : Sseg_from_BCD = 8'h25; //2
            4'h3 : Sseg_from_BCD = 8'h0D; //3
            4'h4 : Sseg_from_BCD = 8'h99; //4
            4'h5 : Sseg_from_BCD = 8'h49; //5
            4'h6 : Sseg_from_BCD = 8'h41; //6
            4'h7 : Sseg_from_BCD = 8'h1F; //7
            4'h8 : Sseg_from_BCD = 8'h01; //8
            4'h9 : Sseg_from_BCD = 8'h19; //9
				4'hA : Sseg_from_BCD = 8'h11; //10
				4'hB : Sseg_from_BCD = 8'hC1; //11
				4'hC : Sseg_from_BCD = 8'h63; //12
				4'hD : Sseg_from_BCD = 8'h85; //13
				4'hE : Sseg_from_BCD = 8'h61; //14
				4'hF : Sseg_from_BCD = 8'h71; //15
					default : Sseg_from_BCD = 8'hFF;
			endcase
	 end
	 
	

	



endmodule
