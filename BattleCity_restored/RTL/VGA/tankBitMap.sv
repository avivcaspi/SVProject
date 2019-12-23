//-- Alex Grinshpun Apr 2017
//-- Dudy Nov 13 2017
// System-Verilog Alex Grinshpun May 2018
// New coding convention dudy December 2018
// New bitmap dudy NOvember 2019
// (c) Technion IIT, Department of Electrical Engineering 2019 



module	tankBitMap	(	
					input	logic	clk,
					input	logic	resetN,
					input logic	[10:0] offsetX,// offset from top left  position 
					input logic	[10:0] offsetY,
					input	logic	InsideRectangle, //input that the pixel is within a bracket 
					input logic tankNum, 

					output	logic	drawingRequest, //output that the pixel should be dispalyed 
					output	logic	[7:0] RGBout  //rgb value from the bitmap 
);
// generating a smiley bitmap 

localparam logic [7:0] TRANSPARENT_ENCODING = 8'hFF ;// RGB value in the bitmap representing a transparent pixel 

localparam  int OBJECT_HEIGHT_Y = 25;
localparam  int OBJECT_WIDTH_X = 25;

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors1 = {
{8'hBE, 8'hBA, 8'h2C, 8'h4D, 8'hBE, 8'h9A, 8'h2C, 8'h51, 8'hBF, 8'h96, 8'h28, 8'h71, 8'hBF, 8'h75, 8'h28, 8'h76, 8'hBF, 8'h51, 8'h28, 8'h9A, 8'hBE, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hBE, 8'h9A, 8'h08, 8'h2C, 8'hBE, 8'h9A, 8'h08, 8'h2D, 8'hBE, 8'h76, 8'h08, 8'h51, 8'hBF, 8'h51, 8'h08, 8'h75, 8'hBF, 8'h51, 8'h08, 8'h76, 8'hBE, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h31, 8'h31, 8'h08, 8'h08, 8'h31, 8'h11, 8'h08, 8'h0C, 8'h31, 8'h11, 8'h08, 8'h0C, 8'h31, 8'h0C, 8'h08, 8'h0C, 8'h31, 8'h0C, 8'h08, 8'h11, 8'h31, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h11, 8'h11, 8'h0C, 8'h0C, 8'h11, 8'h11, 8'h2C, 8'h0C, 8'h11, 8'h11, 8'h2C, 8'h0C, 8'h11, 8'h0D, 8'h2C, 8'h11, 8'h11, 8'h0C, 8'h2C, 8'h11, 8'h11, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h11, 8'h11, 8'h9A, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'h35, 8'h10, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h31, 8'h31, 8'hBE, 8'hBE, 8'h9A, 8'h9E, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'h55, 8'h11, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h11, 8'h35, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hDF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h31, 8'h55, 8'h9A, 8'h9A, 8'h9A, 8'h9A, 8'h9A, 8'h9A, 8'h9A, 8'h9E, 8'hBE, 8'hBA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hBE, 8'hBE, 8'hBF, 8'h9A, 8'h11, 8'h11, 8'h11, 8'h11, 8'h11, 8'h11, 8'h11, 8'h76, 8'hBF, 8'h51, 8'h24, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hBE, 8'hBE, 8'h9A, 8'h7A, 8'h55, 8'h55, 8'h55, 8'h55, 8'h55, 8'h31, 8'h11, 8'h55, 8'h9A, 8'h51, 8'h08, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hBE, 8'h9E, 8'h11, 8'h35, 8'hBE, 8'hBE, 8'hBF, 8'hBF, 8'hBF, 8'h7A, 8'h11, 8'h11, 8'h11, 8'h0C, 8'h08, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h7A, 8'h76, 8'h11, 8'h35, 8'hBE, 8'h9E, 8'h7A, 8'h7A, 8'h7A, 8'h55, 8'h0C, 8'h11, 8'h11, 8'h31, 8'h51, 8'hBA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h11, 8'h11, 8'h11, 8'h35, 8'hBF, 8'h9A, 8'h11, 8'h11, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h7A, 8'hBF, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE },
{8'hFF, 8'hFF, 8'h11, 8'h11, 8'h11, 8'h31, 8'h7A, 8'h55, 8'h0C, 8'h0C, 8'h0C, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h31, 8'h75, 8'hBA, 8'hDF, 8'hDF, 8'hDF, 8'hDF, 8'hDF, 8'hDF, 8'hDF },
{8'hFF, 8'hFF, 8'h11, 8'h11, 8'h11, 8'h11, 8'h11, 8'h0C, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h11, 8'h11, 8'h0C, 8'h0C, 8'h11, 8'h11, 8'h0C, 8'h0C, 8'h0C, 8'h0C, 8'h0C, 8'h11, 8'h11, 8'h0C, 8'h08, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h11, 8'h10, 8'h08, 8'h0C, 8'h11, 8'h11, 8'h11, 8'h11, 8'h11, 8'h11, 8'h11, 8'h11, 8'h11, 8'h0C, 8'h08, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h08, 8'h08, 8'h0C, 8'h0C, 8'h0C, 8'h0C, 8'h0C, 8'h0C, 8'h0C, 8'h0C, 8'h0C, 8'h51, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h96, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hBF, 8'hBE, 8'h51, 8'h2D, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h2C, 8'h51, 8'h51, 8'h51, 8'h4D, 8'h51, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hBE, 8'h9A, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h35, 8'h31, 8'h08, 8'h08, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h11, 8'h11, 8'h08, 8'h08, 8'h11, 8'h11, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h11, 8'h11, 8'h08, 8'h08, 8'h11, 8'h11, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h11, 8'h11, 8'h08, 8'h08, 8'h11, 8'h11, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'hFF, 8'hFF, 8'hFF, 8'hFF }
};

//enemy tank bitmap
logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors2 = {
{8'hFE, 8'hB5, 8'h4C, 8'hD9, 8'hB5, 8'h4C, 8'hD9, 8'hD9, 8'h4C, 8'hB5, 8'hDA, 8'h6C, 8'hB5, 8'hFA, 8'h6C, 8'h91, 8'hFE, 8'hF4, 8'hF5, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF9, 8'hB5, 8'h4C, 8'hD9, 8'hD5, 8'h4C, 8'hD5, 8'hD9, 8'h4C, 8'hB5, 8'hD9, 8'h6C, 8'hB5, 8'hF9, 8'h6C, 8'h90, 8'hF9, 8'hD4, 8'hD5, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF4, 8'hB0, 8'h4C, 8'hD4, 8'hB0, 8'h4C, 8'hD0, 8'hD0, 8'h4C, 8'hB0, 8'hD4, 8'h4C, 8'hB0, 8'hF4, 8'h6C, 8'h90, 8'hF4, 8'h6C, 8'h91, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF4, 8'hB0, 8'h70, 8'hD4, 8'hD0, 8'h6C, 8'hD0, 8'hD0, 8'h6C, 8'hD0, 8'hF4, 8'h8C, 8'hB0, 8'hF4, 8'h8C, 8'hB0, 8'hF4, 8'h6C, 8'h91, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF4, 8'hF9, 8'hFE, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF5, 8'hFE, 8'h6C, 8'h91, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF5, 8'hF9, 8'hFE, 8'hF5, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF9, 8'hFE, 8'h91, 8'hB5, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFA, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFA, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hFE, 8'hFE, 8'hF9, 8'hF9, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFA, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF9, 8'hFE, 8'hFE, 8'hF9, 8'hF4, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hF9, 8'hF4, 8'hF4, 8'hF5, 8'hF5, 8'hF5, 8'hF5, 8'hF5, 8'hF5, 8'hF4, 8'hF4, 8'hF9, 8'hF9, 8'hF5, 8'hF4, 8'hB5, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hF4, 8'hF4, 8'hF5, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFA, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'h6C, 8'h71, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hF4, 8'hF4, 8'hF5, 8'hFE, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF5, 8'hB0, 8'hD0, 8'hF4, 8'hF5, 8'hF9, 8'hF9, 8'hB5, 8'hB5, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE },
{8'hFF, 8'hFF, 8'hF4, 8'hF4, 8'hF5, 8'hFE, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hD4, 8'h4C, 8'hB0, 8'hF4, 8'hFA, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9 },
{8'hFF, 8'hFF, 8'hF4, 8'hF4, 8'hF4, 8'hF9, 8'hB0, 8'h90, 8'hB0, 8'hB0, 8'h90, 8'h4C, 8'hB0, 8'hF4, 8'hF9, 8'hD5, 8'h95, 8'h91, 8'hB5, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE },
{8'hFF, 8'hFF, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'h6C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'hB0, 8'hF4, 8'hF4, 8'hB0, 8'h4C, 8'h4C, 8'h71, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h90, 8'hD4, 8'hF4, 8'hF4, 8'hD0, 8'hB0, 8'hB0, 8'hB0, 8'hB0, 8'hB0, 8'hB0, 8'h90, 8'h90, 8'h8C, 8'h4C, 8'hB5, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h4C, 8'hD4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hB0, 8'h4C, 8'h4C, 8'h4C, 8'h6C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h4C, 8'h8C, 8'h90, 8'h90, 8'h90, 8'h90, 8'h90, 8'h90, 8'h90, 8'h90, 8'h6C, 8'h4C, 8'h6C, 8'h6C, 8'h6C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFE, 8'hB5, 8'h4C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'hD5, 8'hF9, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFE, 8'hB5, 8'h4C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'hD0, 8'hF5, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF4, 8'hB0, 8'h4C, 8'hB0, 8'hB0, 8'h4C, 8'hB0, 8'hB0, 8'h4C, 8'hB0, 8'hD0, 8'h6C, 8'h90, 8'hD0, 8'h6C, 8'h8C, 8'hD0, 8'h8C, 8'h91, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF4, 8'hB0, 8'h4C, 8'hD4, 8'hD0, 8'h4C, 8'hD0, 8'hD0, 8'h4C, 8'hB0, 8'hF4, 8'h6C, 8'hB0, 8'hF4, 8'h6C, 8'h90, 8'hF4, 8'h6C, 8'h91, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF4, 8'hB0, 8'h4C, 8'hD4, 8'hD0, 8'h4C, 8'hD0, 8'hD0, 8'h4C, 8'hB0, 8'hD4, 8'h6C, 8'hB0, 8'hF4, 8'h6C, 8'h90, 8'hF4, 8'h6C, 8'h91, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF4, 8'hB0, 8'h4C, 8'hD4, 8'hB0, 8'h4C, 8'hD0, 8'hD0, 8'h4C, 8'hB0, 8'hD4, 8'h6C, 8'hB0, 8'hF4, 8'h6C, 8'h90, 8'hF4, 8'h6C, 8'h91, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF }
};

// pipeline (ff) to get the pixel color from the array 	 

//======--------------------------------------------------------------------------------------------------------------=
always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
		RGBout <=	8'h00;
	end
	else begin
		if (InsideRectangle == 1'b1 )  // inside an external bracket 
			case(tankNum)
			1'b0 : RGBout <= object_colors1[offsetY][offsetX];	//get RGB from the colors table  
			1'b1 : RGBout <= object_colors2[offsetY][offsetX];	//get RGB from the colors table
			endcase		
		else 
			RGBout <= TRANSPARENT_ENCODING ; // force color to transparent so it will not be displayed 
	end 
end

//======--------------------------------------------------------------------------------------------------------------=
// decide if to draw the pixel or not 
assign drawingRequest = (RGBout != TRANSPARENT_ENCODING ) ? 1'b1 : 1'b0 ; // get optional transparent command from the bitmpap   

endmodule