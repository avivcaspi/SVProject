//-- Alex Grinshpun Apr 2017
//-- Dudy Nov 13 2017
// System-Verilog Alex Grinshpun May 2018
// New coding convention dudy December 2018
// New bitmap dudy NOvember 2019
// (c) Technion IIT, Department of Electrical Engineering 2019 



module	brickBitMap	(	
					input	logic	clk,
					input	logic	resetN,
					input logic	[10:0] offsetX,// offset from top left  position 
					input logic	[10:0] offsetY,
					input	logic	InsideRectangle, //input that the pixel is within a bracket 
					input logic [2:0] brickNum,

					output	logic	drawingRequest, //output that the pixel should be dispalyed 
					output	logic	[7:0] RGBout  //rgb value from the bitmap 
);
// generating a smiley bitmap 

localparam logic [7:0] TRANSPARENT_ENCODING = 8'hFF ;// RGB value in the bitmap representing a transparent pixel 

localparam  int OBJECT_HEIGHT_Y = 32;
localparam  int OBJECT_WIDTH_X = 32;

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors1 = {
{8'hD5, 8'hD6, 8'hB1, 8'h8D, 8'hB1, 8'hB1, 8'hD5, 8'hD6, 8'hD6, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'h8D, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'h91, 8'h69, 8'h69, 8'hD5, 8'hD6, 8'hB5, 8'h8D, 8'hD5, 8'hD5, 8'hD5 },
{8'hD5, 8'hD6, 8'hD5, 8'h91, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hB1, 8'h91, 8'hD5, 8'hD6, 8'hB1, 8'h69, 8'h69, 8'h69, 8'hB1, 8'hB1, 8'h8D, 8'h6D, 8'h6D, 8'h91, 8'h8D, 8'h8D, 8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'hD5, 8'hD5, 8'hD5 },
{8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD5, 8'h8D, 8'hD6, 8'hB1, 8'h8D, 8'h69, 8'hB1, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h6D, 8'hD5, 8'hDA, 8'hD5, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hB1 },
{8'hD5, 8'hD5, 8'hD6, 8'h91, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'h69, 8'h8D, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hD5, 8'hD6, 8'hB5, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'h8D },
{8'hD5, 8'hD5, 8'hD6, 8'hB1, 8'h8D, 8'hB1, 8'h91, 8'hB1, 8'hD5, 8'hD6, 8'h8D, 8'hB1, 8'hD6, 8'hD5, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hB5, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'h8D, 8'h8D },
{8'hB5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hD5, 8'hD5, 8'hB5, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hB5, 8'h8D, 8'h8D, 8'hD5, 8'hD5, 8'hB5, 8'h69, 8'h91, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hB1, 8'h6D },
{8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'h6D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'hD5, 8'hB1, 8'h8D, 8'h8D, 8'h91, 8'h8D, 8'hB1, 8'hD5, 8'hB1, 8'h8D, 8'h91, 8'h8D, 8'hB1, 8'hD6, 8'hD5, 8'hD6, 8'h6D },
{8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'hB1, 8'hD6, 8'hD5, 8'h91, 8'hB1, 8'h8D, 8'hB5, 8'hD6, 8'hB5, 8'h69, 8'h8D, 8'hB1, 8'hB1, 8'h6D },
{8'h8D, 8'h8D, 8'h8D, 8'hB1, 8'hB5, 8'h8D, 8'hD5, 8'hB1, 8'h69, 8'h6D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h69, 8'h8D, 8'hB5, 8'hD5, 8'hD6, 8'hD6, 8'hD5, 8'hD6, 8'h8D, 8'h8D, 8'hD5, 8'hD5, 8'hDA, 8'h91, 8'hB1, 8'hB5, 8'h8D, 8'h6D },
{8'hB1, 8'h6D, 8'hB1, 8'hD5, 8'hD5, 8'h6D, 8'h8D, 8'h8D, 8'hB1, 8'h6D, 8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'h6D, 8'h8D, 8'hD5, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'h8D, 8'h8D, 8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'hD5, 8'hDA, 8'hD6, 8'h8D },
{8'hD5, 8'h8D, 8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'h8D, 8'hB1, 8'hD5, 8'hB1, 8'h6D, 8'hD5, 8'hD5, 8'h8D, 8'hB5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'h91, 8'hD6, 8'hD6, 8'hD6, 8'h8D },
{8'hD5, 8'h8D, 8'hD5, 8'hD5, 8'hD6, 8'h91, 8'hB1, 8'hD1, 8'hD5, 8'hB1, 8'h8D, 8'hB5, 8'hB1, 8'hB1, 8'hD6, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB5, 8'h69, 8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hD6, 8'hD6, 8'hD6, 8'h8D },
{8'hD6, 8'h8D, 8'hB1, 8'hD5, 8'hD6, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'h8D, 8'h8D, 8'h8D, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'h8D, 8'hB1, 8'h8D, 8'hB1, 8'hB1, 8'h8D, 8'hD5, 8'hD6, 8'hD6, 8'hB5, 8'h8D },
{8'hD5, 8'h91, 8'h8D, 8'hD5, 8'hD6, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD6, 8'hB1, 8'h69, 8'hB1, 8'hD5, 8'hD5, 8'h8D, 8'h69, 8'h8D, 8'h8D, 8'h69, 8'h8D, 8'hD5, 8'hFA, 8'h8D, 8'h8D, 8'h8D, 8'h69, 8'h8D, 8'hD5, 8'hD6, 8'hB1, 8'hB1 },
{8'hD5, 8'hD5, 8'h8D, 8'hB5, 8'hD5, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'h8D, 8'hD5, 8'hB1, 8'h6D, 8'hB1, 8'h8D, 8'h8D, 8'hB1, 8'hD5, 8'hD6, 8'hFA, 8'h8D, 8'hB1, 8'hDA, 8'hD5, 8'h6D, 8'h8D, 8'hB1, 8'h8D, 8'hB1 },
{8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'hB1, 8'h8D, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hB1, 8'h8D, 8'h6D, 8'h8D, 8'hD5, 8'hD5, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'hB1, 8'h8D, 8'hB1 },
{8'hD5, 8'hD6, 8'hB1, 8'h69, 8'h8D, 8'h8D, 8'h69, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hDA, 8'hD5, 8'h8D, 8'h8D, 8'hD5, 8'hD5, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hB1, 8'hB1 },
{8'hD5, 8'hB1, 8'h8D, 8'hB1, 8'hD6, 8'hD5, 8'h8D, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hFA, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h91, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1 },
{8'h8D, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'h69, 8'hB1, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hD6, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'h69, 8'h69, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1 },
{8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hFA, 8'h91, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'h69, 8'h8D, 8'hD5, 8'hB1, 8'h6D, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hB1 },
{8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hDA, 8'hD6, 8'h6D, 8'hB1, 8'hB1, 8'hD5, 8'hD6, 8'hD6, 8'h6D, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'h91, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'h8D },
{8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hDA, 8'hB1, 8'h6D, 8'h8D, 8'hD5, 8'hD5, 8'h8D, 8'h8D, 8'h8D, 8'hB1, 8'hB1, 8'hD5, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'h8D, 8'h8D, 8'hB1, 8'hB1, 8'h8D, 8'h8D },
{8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hB1, 8'hD6, 8'h6D, 8'h8D, 8'h8D, 8'h8D, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'h6D, 8'h8D, 8'hB1, 8'hB1, 8'hB1 },
{8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'hD6, 8'h8D, 8'h8D, 8'h8D, 8'hB1, 8'hD6, 8'hB1, 8'h8D, 8'hB1, 8'h69, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD6 },
{8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD6, 8'h8D, 8'hB1, 8'hD6, 8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'h69, 8'h8D, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'h6D, 8'hB1, 8'hD5, 8'hD6, 8'hD5, 8'hD5, 8'hD6 },
{8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hB5, 8'hB1, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hB1, 8'h49, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hD5, 8'hD6 },
{8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hB5, 8'h69, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB5, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hD5 },
{8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'hD1, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'h69, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h6D, 8'hB1, 8'hB5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hB5 },
{8'h6D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'h6D, 8'h8D, 8'h8D, 8'h91, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'h91, 8'h8D, 8'hD5, 8'hD6, 8'hD5, 8'hD6, 8'hD6, 8'hD5 },
{8'h8D, 8'h69, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hD5, 8'hD6 },
{8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5 },
{8'hD5, 8'hB1, 8'h69, 8'h8D, 8'hD5, 8'hB1, 8'h6D, 8'hD5, 8'hD5, 8'hB1, 8'hD5, 8'hD6, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'h8D, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'h69, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D }
};

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors2 = {
{8'hB1, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'h8D, 8'h8D, 8'h91, 8'hB1, 8'hB1, 8'h8D, 8'hB1, 8'hAD, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'hB1, 8'hD5, 8'hD1, 8'hB1, 8'hD1 },
{8'hB1, 8'hD5, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hAD, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hD1, 8'hD1 },
{8'hB1, 8'hD5, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hD1, 8'hD5 },
{8'hB1, 8'hD5, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hD5, 8'hD1 },
{8'hB1, 8'hD5, 8'hB1, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hD1, 8'hD1, 8'hB1 },
{8'hB1, 8'hB1, 8'hD1, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1 },
{8'hAD, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'h8D, 8'h8D, 8'h8D, 8'hB1, 8'hAD, 8'h8D, 8'h8D, 8'hB1, 8'hB1, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hD5, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hD5, 8'hD1, 8'hD5, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hB1, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hAD, 8'h8D, 8'hAD, 8'hAD, 8'hB1, 8'hAD, 8'hAD, 8'hB1, 8'hAD, 8'h8D, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD1, 8'hD5, 8'hB1 },
{8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'hB1, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'hB1, 8'hAD, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hB1, 8'hD5, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hB1, 8'hD5, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hD5, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hD5, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hD1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hAD, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hAD },
{8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hAD, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'hAD, 8'h8D },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD1, 8'hB1, 8'hD1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h8D },
{8'hB1, 8'hB1, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD1, 8'hD5, 8'hB1, 8'hD5, 8'hD1, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h8D },
{8'hD1, 8'hD1, 8'hD5, 8'hAD, 8'hAD, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hD5, 8'hD5, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD1, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hAD, 8'hAD, 8'hAD, 8'h8D, 8'hB1, 8'h8D },
{8'hB1, 8'h8D, 8'h8D, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hD1, 8'hD1, 8'hD1, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD1, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hAD, 8'hAD, 8'hAD, 8'h8D, 8'hB1, 8'h8D },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hD5, 8'hD5, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hAD },
{8'h8D, 8'h8D, 8'hB1, 8'hB1, 8'hAD, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'h8D, 8'hAD, 8'h8D, 8'h8D, 8'hAD, 8'h8D, 8'h8D, 8'hAD, 8'h8D },
{8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'hAD, 8'hB1, 8'hD5, 8'hD5, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'hB1, 8'hB1, 8'hAD },
{8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hAD, 8'hAD, 8'hAD, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hB1, 8'hD5, 8'hB1, 8'hD5, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hD1, 8'hD1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'hD1, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 }
};

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors3 = {
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1 },
{8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1 },
{8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1 },
{8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hD5, 8'hD5, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'hB1, 8'hD5, 8'hB1, 8'hD1, 8'hD1, 8'hD1, 8'hB1, 8'hD1, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hD1, 8'hD5, 8'hB1, 8'hD1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1 },
{8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5 }
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
			case (brickNum)
			3'b001: RGBout <= object_colors1[offsetY][offsetX];	//get RGB from the colors table  
			3'b010: RGBout <= object_colors2[offsetY][offsetX];	//get RGB from the colors table  
			3'b011: RGBout <= object_colors3[offsetY][offsetX];	//get RGB from the colors table  
			endcase
		else 
			RGBout <= TRANSPARENT_ENCODING ; // force color to transparent so it will not be displayed 
	end 
end

//======--------------------------------------------------------------------------------------------------------------=
// decide if to draw the pixel or not 
assign drawingRequest = (RGBout != TRANSPARENT_ENCODING ) ? 1'b1 : 1'b0 ; // get optional transparent command from the bitmpap   

endmodule