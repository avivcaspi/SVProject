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
{8'hDA, 8'hAD, 8'hCD, 8'hCD, 8'hA9, 8'hAD, 8'hA9, 8'hA9, 8'hAD, 8'hCD, 8'hD6, 8'hD1, 8'hCD, 8'hAD, 8'hA8, 8'hA8, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hAD, 8'hD6, 8'hAD, 8'hA9, 8'hA9, 8'h89, 8'hA9, 8'hA9, 8'hA9, 8'h89, 8'hA9, 8'hAD },
{8'hDA, 8'hAD, 8'hA9, 8'hA9, 8'hA8, 8'hA9, 8'hA8, 8'hA8, 8'hA9, 8'hAD, 8'hD1, 8'hD1, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'h88, 8'hA8, 8'hA8, 8'hA8, 8'hAD, 8'hD6, 8'hAD, 8'hA8, 8'hA8, 8'h88, 8'h88, 8'h84, 8'h88, 8'h84, 8'h88, 8'hA9 },
{8'hDA, 8'hAD, 8'hAD, 8'hA9, 8'hA9, 8'hA8, 8'hA9, 8'hA9, 8'hA9, 8'hCD, 8'hD5, 8'hD1, 8'hA9, 8'hA8, 8'h88, 8'hA8, 8'hA8, 8'h88, 8'hA8, 8'hA8, 8'hAD, 8'hD6, 8'hAD, 8'hA8, 8'hA8, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hA9 },
{8'hDA, 8'hCD, 8'hAD, 8'hAD, 8'hAD, 8'hA9, 8'hA9, 8'hA9, 8'hAD, 8'hCD, 8'hD6, 8'hD1, 8'hA9, 8'hA8, 8'hA8, 8'hA9, 8'hA9, 8'hA8, 8'h88, 8'h88, 8'hAD, 8'hD6, 8'hAD, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'h88, 8'h88, 8'h88, 8'hA9 },
{8'hFA, 8'hD6, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD5, 8'hD6, 8'hD6, 8'hD1, 8'hD1, 8'hD1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hD2, 8'hDA, 8'hD6, 8'hD1, 8'hD1, 8'hD1, 8'hD2, 8'hD2, 8'hB1, 8'hB1, 8'hB1, 8'hD2 },
{8'hD2, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hDA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD6, 8'hD6, 8'hD1, 8'hD1, 8'hB1 },
{8'hA8, 8'hA8, 8'hA9, 8'hA8, 8'hA9, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hAD, 8'hA9, 8'hA9, 8'hA8 },
{8'hA8, 8'h88, 8'hA8, 8'hA9, 8'hA9, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hA9, 8'hA8, 8'h88, 8'hA8 },
{8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hA9, 8'hA9, 8'hA8, 8'hA9 },
{8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hB1, 8'hDA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD6, 8'hB1, 8'hAD, 8'hAD, 8'hAD },
{8'hFB, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hDA, 8'hDA, 8'hFB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hDA, 8'hD6, 8'hD6, 8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA },
{8'hDA, 8'hAD, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA8, 8'hA9, 8'hA9, 8'hAD, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hAD, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h8D },
{8'hD6, 8'hAD, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hA9, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h64, 8'h64, 8'h89 },
{8'hD6, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hD2, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hA9, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h64, 8'h64, 8'h89 },
{8'hD6, 8'hAD, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hD2, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hA9, 8'h88, 8'h84, 8'h88, 8'h84, 8'h88, 8'h84, 8'h84, 8'h84, 8'hAD },
{8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hFB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFB, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD2, 8'hB1, 8'hB1, 8'hD6 },
{8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hAD, 8'hAD, 8'hAD, 8'hA9 },
{8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'hA9, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hA9, 8'hA8, 8'hA8, 8'hA8 },
{8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hAD, 8'hA8, 8'hA8, 8'hA8 },
{8'hA8, 8'hA8, 8'hA9, 8'hA9, 8'hA8, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hAD, 8'hA9, 8'hA9, 8'hA8 },
{8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hD6 },
{8'hDA, 8'hB1, 8'hB1, 8'hAD, 8'hB1, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hB1, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD6 },
{8'hD6, 8'hA8, 8'hA8, 8'h88, 8'h88, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hD2, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hA9, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h84, 8'h88, 8'hAD },
{8'hD6, 8'hA9, 8'h88, 8'h88, 8'h84, 8'h84, 8'h88, 8'h88, 8'h84, 8'h88, 8'hD1, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD6, 8'hA9, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h89 },
{8'hD6, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hD2, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD6, 8'hA8, 8'h88, 8'h84, 8'h84, 8'h84, 8'h88, 8'h84, 8'h84, 8'h88, 8'hAD },
{8'hDA, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hAD, 8'hAD, 8'h8D, 8'hAD, 8'h8D, 8'hAD, 8'h8D, 8'h8D, 8'hAD, 8'hB1 },
{8'hD6, 8'hD6, 8'hB2, 8'hD2, 8'hD6, 8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD2, 8'hD2, 8'hD6, 8'hDA, 8'hD6, 8'hD2, 8'hD2, 8'hD2, 8'hD2 },
{8'h88, 8'h88, 8'h88, 8'h88, 8'hA9, 8'hD1, 8'hAD, 8'hA9, 8'hA8, 8'h88, 8'h88, 8'h88, 8'hA8, 8'h88, 8'h88, 8'hAD, 8'hD1, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hD2, 8'hB1, 8'hA8, 8'hA8, 8'h88, 8'h88 },
{8'h88, 8'h88, 8'h88, 8'h88, 8'hA9, 8'hB1, 8'hAD, 8'h89, 8'h88, 8'h88, 8'h88, 8'h88, 8'h84, 8'h84, 8'h88, 8'hAD, 8'hB1, 8'h88, 8'h88, 8'h88, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h88, 8'hB1, 8'hAD, 8'hA8, 8'hA8, 8'h84, 8'h88 },
{8'hA8, 8'hA8, 8'h88, 8'h88, 8'hA9, 8'hB1, 8'hAD, 8'h88, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h88, 8'h88, 8'hAD, 8'hB1, 8'h88, 8'h88, 8'h88, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h88, 8'hB1, 8'hAD, 8'hA8, 8'hA8, 8'h88, 8'h84 },
{8'hA9, 8'h89, 8'h88, 8'h88, 8'hA9, 8'hD6, 8'hAD, 8'h89, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hAD, 8'hB2, 8'h89, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hD2, 8'hB1, 8'hAD, 8'hA9, 8'h88, 8'h88 },
{8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hFB, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hFB, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hFB, 8'hFB, 8'hFA, 8'hDA, 8'hDA, 8'hDA }
};

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors2 = {
{8'hDA, 8'hAD, 8'hCD, 8'hCD, 8'hA9, 8'hAD, 8'hA9, 8'hA9, 8'hAD, 8'hCD, 8'hD6, 8'hD1, 8'hCD, 8'hAD, 8'hA8, 8'hA8, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hAD, 8'hD6, 8'hAD, 8'hAD, 8'hA9, 8'h89, 8'hA9, 8'hA9, 8'hA9, 8'h89, 8'hA9, 8'hAD },
{8'hDA, 8'hAD, 8'hA9, 8'hA9, 8'hA8, 8'hA9, 8'hA8, 8'hA8, 8'hA9, 8'hAD, 8'hD6, 8'hD1, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'h88, 8'hA8, 8'hA8, 8'hA8, 8'hAD, 8'hD6, 8'hAD, 8'hA8, 8'hA8, 8'h88, 8'h88, 8'h84, 8'h88, 8'h84, 8'h88, 8'hA9 },
{8'hDA, 8'hAD, 8'hAD, 8'hA9, 8'hA9, 8'hA8, 8'hA9, 8'hA9, 8'hA9, 8'hCD, 8'hD6, 8'hD1, 8'hA9, 8'hA8, 8'h88, 8'hA8, 8'hA8, 8'h88, 8'hA8, 8'hA8, 8'hAD, 8'hD6, 8'hAD, 8'hA8, 8'hA8, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hA9 },
{8'hDA, 8'hCD, 8'hAD, 8'hAD, 8'hAD, 8'hA9, 8'hA9, 8'hA9, 8'hAD, 8'hCD, 8'hD6, 8'hD1, 8'hA9, 8'hA8, 8'hA8, 8'hA9, 8'hA9, 8'hA8, 8'h88, 8'h88, 8'hAD, 8'hD6, 8'hAD, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'h88, 8'h84, 8'h88, 8'hA9 },
{8'hFB, 8'hD6, 8'hD6, 8'hD2, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD6, 8'hDA, 8'hD6, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hD1, 8'hD6, 8'hDA, 8'hD6, 8'hD2, 8'hD2, 8'hD6, 8'hD2, 8'hD6, 8'hB2, 8'hB2, 8'hB1, 8'hD6 },
{8'hD6, 8'hD2, 8'hD6, 8'hD2, 8'hD2, 8'hDA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hD6, 8'hD6, 8'hD2, 8'hB2 },
{8'hA8, 8'hA8, 8'hA9, 8'hA8, 8'hA9, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hAD, 8'hA9, 8'hA9, 8'hA8 },
{8'hA8, 8'h88, 8'hA8, 8'hA8, 8'hA9, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hA9, 8'hA8, 8'h88, 8'hA8 },
{8'hA9, 8'hA8, 8'hA8, 8'h88, 8'hA9, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hA9, 8'hA8, 8'hA8, 8'hA9 },
{8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hB1, 8'hDA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD6, 8'hB1, 8'hAD, 8'hAD, 8'hAD },
{8'hFB, 8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hD6, 8'hDA, 8'hDA, 8'hDA, 8'hFB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA },
{8'hDA, 8'hAD, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA8, 8'hA9, 8'hA9, 8'hAD, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hAD, 8'h89, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h8D },
{8'hD6, 8'hAD, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hA9, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h64, 8'h64, 8'h89 },
{8'hD6, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hD2, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hA9, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h64, 8'h64, 8'h89 },
{8'hD6, 8'hAD, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFA, 8'hA9, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h84, 8'h84, 8'h84, 8'hAD },
{8'hFA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hFF, 8'hFB, 8'hFB, 8'hFB, 8'hFF, 8'hFF, 8'hFB, 8'hFB, 8'hFB, 8'hFB, 8'hFB, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD2, 8'hB2, 8'hB2, 8'hD6 },
{8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hD6, 8'hD1, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hD1, 8'hD6, 8'hAD, 8'hAD, 8'hA9, 8'h89, 8'hA9, 8'h89, 8'hA9, 8'h8D, 8'h8D, 8'hD6, 8'hD1, 8'hAD, 8'hAD, 8'hAD, 8'hA9 },
{8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'hD6, 8'hCD, 8'hA9, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'h88, 8'hA8, 8'hA8, 8'hAD, 8'hD6, 8'hA9, 8'h88, 8'h88, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h88, 8'hD2, 8'hD1, 8'hA9, 8'hA8, 8'hA8, 8'hA8 },
{8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'hD6, 8'hAD, 8'hA9, 8'hA8, 8'hA8, 8'h88, 8'hA8, 8'hA8, 8'h88, 8'hA8, 8'hAD, 8'hD6, 8'hA9, 8'h88, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h64, 8'h84, 8'hB1, 8'hD1, 8'hAD, 8'hA8, 8'hA8, 8'hA8 },
{8'hA8, 8'hA8, 8'hA9, 8'hA9, 8'hA9, 8'hD6, 8'hAD, 8'hA8, 8'hA9, 8'hA8, 8'h88, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hAD, 8'hD2, 8'hA9, 8'hA8, 8'h84, 8'h84, 8'h88, 8'h88, 8'h84, 8'h84, 8'h88, 8'hB1, 8'hD1, 8'hAD, 8'hA9, 8'hA9, 8'hA8 },
{8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD2, 8'hD2, 8'hD1, 8'hD1, 8'hD1, 8'hD6, 8'hDA, 8'hD2, 8'hB1, 8'hB1, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hDA, 8'hFA, 8'hD6, 8'hD6, 8'hD6, 8'hD6 },
{8'hDA, 8'hB1, 8'hB1, 8'hAD, 8'hB1, 8'hAD, 8'hB1, 8'hB1, 8'hB1, 8'hD1, 8'hD6, 8'hD6, 8'hB1, 8'hAD, 8'hB1, 8'hAD, 8'hB1, 8'hB1, 8'hAD, 8'hAD, 8'hB1, 8'hDA, 8'hD2, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD6 },
{8'hD6, 8'hA8, 8'hA8, 8'h88, 8'h88, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hD2, 8'hD1, 8'hA8, 8'hA8, 8'h88, 8'h88, 8'h88, 8'h88, 8'h84, 8'h88, 8'hA9, 8'hD6, 8'hA9, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h84, 8'h88, 8'hAD },
{8'hD6, 8'hA9, 8'h88, 8'h88, 8'h84, 8'h84, 8'h88, 8'h88, 8'h84, 8'h88, 8'hD1, 8'hD1, 8'hA8, 8'hA8, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hA9, 8'hD2, 8'hA9, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h8D },
{8'hD6, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hB1, 8'hB1, 8'hA8, 8'hA8, 8'h88, 8'h88, 8'hA8, 8'h88, 8'h88, 8'h88, 8'hA9, 8'hD6, 8'hA9, 8'h88, 8'h84, 8'h84, 8'h84, 8'h88, 8'h84, 8'h84, 8'h88, 8'hAD },
{8'hDA, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hB1, 8'hAD, 8'hAD, 8'hD6, 8'hD6, 8'hB1, 8'hAD, 8'hAD, 8'hB1, 8'hB1, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hD6, 8'hAD, 8'hAD, 8'h8D, 8'hAD, 8'h8D, 8'hAD, 8'h8D, 8'h8D, 8'hAD, 8'hB1 },
{8'hD6, 8'hD6, 8'hB2, 8'hD2, 8'hD6, 8'hDB, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hD6, 8'hD2, 8'hB2, 8'hD6, 8'hD2 },
{8'h88, 8'h88, 8'h88, 8'h88, 8'hA9, 8'hD2, 8'hAD, 8'hA9, 8'hA8, 8'h88, 8'h88, 8'h88, 8'hA8, 8'h88, 8'h88, 8'hAD, 8'hD2, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hD2, 8'hB1, 8'hA8, 8'hA8, 8'h88, 8'h88 },
{8'h88, 8'h88, 8'h88, 8'h88, 8'hA9, 8'hB1, 8'hAD, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h84, 8'h84, 8'h88, 8'hAD, 8'hB1, 8'h88, 8'h88, 8'h88, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h88, 8'hB2, 8'hB1, 8'hA8, 8'hA8, 8'h84, 8'h88 },
{8'hA8, 8'hA8, 8'h88, 8'h88, 8'hA9, 8'hD2, 8'hAD, 8'h88, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h88, 8'h88, 8'hAD, 8'hB1, 8'h88, 8'h88, 8'h88, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h88, 8'hB2, 8'hAD, 8'hA8, 8'hA8, 8'h88, 8'h84 },
{8'hA9, 8'h89, 8'h88, 8'h88, 8'hA9, 8'hD6, 8'hAD, 8'h89, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hAD, 8'hD2, 8'h89, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hD6, 8'hB1, 8'hAD, 8'hA9, 8'h88, 8'h88 },
{8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hFF, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hFB, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hFF, 8'hFB, 8'hFA, 8'hDA, 8'hDA, 8'hDA }
};

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors3 = {
{8'hD6, 8'hAD, 8'hCD, 8'hCD, 8'hA9, 8'hAD, 8'hA9, 8'hA9, 8'hAD, 8'hCD, 8'hD5, 8'hD1, 8'hCD, 8'hAD, 8'hA8, 8'hA8, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hAD, 8'hD6, 8'hAD, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'h89, 8'hA9, 8'hAD },
{8'hD6, 8'hAD, 8'hA9, 8'hA9, 8'hA8, 8'hA9, 8'hA8, 8'hA8, 8'hA9, 8'hAD, 8'hD1, 8'hD1, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'h88, 8'hA8, 8'hA8, 8'hA8, 8'hAD, 8'hD6, 8'hAD, 8'hA8, 8'hA8, 8'h88, 8'h88, 8'h84, 8'h88, 8'h84, 8'h88, 8'hA9 },
{8'hD6, 8'hAD, 8'hAD, 8'hA9, 8'hA9, 8'hA8, 8'hA9, 8'hA8, 8'hA9, 8'hCD, 8'hD1, 8'hD1, 8'hA9, 8'hA8, 8'h88, 8'hA8, 8'hA8, 8'h88, 8'hA8, 8'hA8, 8'hAD, 8'hD6, 8'hAD, 8'hA8, 8'hA8, 8'hA8, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hA9 },
{8'hD6, 8'hCD, 8'hAD, 8'hAD, 8'hAD, 8'hA9, 8'hA9, 8'hAD, 8'hAD, 8'hCD, 8'hD1, 8'hD1, 8'hA9, 8'hA8, 8'hA8, 8'hA9, 8'hA9, 8'hA8, 8'h88, 8'h88, 8'hAD, 8'hD6, 8'hAD, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'h88, 8'h88, 8'h88, 8'hA9 },
{8'hFA, 8'hD5, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD6, 8'hD6, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hB1, 8'hD1, 8'hD1, 8'hFA, 8'hD5, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hD1 },
{8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD6, 8'hD6, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD6, 8'hD6, 8'hD1, 8'hD1, 8'hD1, 8'hB1, 8'hD1, 8'hD1, 8'hB1, 8'hB1, 8'hD1, 8'hD6, 8'hD6, 8'hD1, 8'hD1, 8'hD1, 8'hB1 },
{8'hA8, 8'hA8, 8'hA9, 8'hA8, 8'hAD, 8'hD5, 8'hD1, 8'hCD, 8'hAD, 8'hAD, 8'hA9, 8'hA9, 8'hAD, 8'hA9, 8'hA9, 8'hD1, 8'hD1, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hD1, 8'hD1, 8'hAD, 8'hA9, 8'hA9, 8'hA8 },
{8'hA8, 8'h88, 8'hA8, 8'hA8, 8'hA9, 8'hD1, 8'hAD, 8'hAD, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hCD, 8'hD1, 8'hA9, 8'h88, 8'h88, 8'hA8, 8'h88, 8'hA8, 8'hA8, 8'h88, 8'h88, 8'hD1, 8'hD1, 8'hA9, 8'hA8, 8'h88, 8'hA8 },
{8'hA9, 8'hA8, 8'hA8, 8'h88, 8'hA9, 8'hD1, 8'hD1, 8'hCD, 8'hAD, 8'hAD, 8'hAD, 8'hCD, 8'hAD, 8'hAD, 8'hAD, 8'hD1, 8'hD1, 8'hA9, 8'hA8, 8'h88, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'hD1, 8'hD1, 8'hA9, 8'hA9, 8'hA8, 8'hA9 },
{8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hD1, 8'hD6, 8'hD5, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hCD, 8'hD1, 8'hD1, 8'hD6, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hD6, 8'hD5, 8'hD1, 8'hAD, 8'hAD, 8'hAD },
{8'hFA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hFA, 8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hFA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6 },
{8'hD6, 8'hAD, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hAD, 8'hD1, 8'hD1, 8'hAD, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hAD, 8'hD6, 8'hAD, 8'h89, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h8D },
{8'hD6, 8'hAD, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'hD1, 8'hD1, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'hA9, 8'hD1, 8'hA9, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h64, 8'h64, 8'h89 },
{8'hD6, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'hD1, 8'hD1, 8'hAD, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'hD1, 8'hA9, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h64, 8'h64, 8'h89 },
{8'hD6, 8'hAD, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hD1, 8'hD1, 8'hAD, 8'hAD, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hAD, 8'hD6, 8'hAD, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h84, 8'h84, 8'h84, 8'hA9 },
{8'hFA, 8'hD6, 8'hD5, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hFA, 8'hFA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hD6, 8'hD1, 8'hD1, 8'hD1, 8'hD6, 8'hD6, 8'hD1, 8'hD1, 8'hD1, 8'hD1 },
{8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hD6, 8'hD1, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hD1, 8'hD6, 8'hAD, 8'hAD, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hD2, 8'hD1, 8'hAD, 8'hAD, 8'hAD, 8'hA9 },
{8'hA9, 8'hA8, 8'hA8, 8'hA9, 8'hA9, 8'hD1, 8'hCD, 8'hA9, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'h88, 8'hA8, 8'hA9, 8'hAD, 8'hD1, 8'hA9, 8'h88, 8'h88, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h88, 8'hD1, 8'hD1, 8'hA9, 8'hA8, 8'hA8, 8'hA8 },
{8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'hD1, 8'hAD, 8'hA9, 8'hA8, 8'hA8, 8'h88, 8'hA8, 8'hA8, 8'h88, 8'hA8, 8'hAD, 8'hD1, 8'hA9, 8'h88, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h64, 8'h84, 8'hB1, 8'hD1, 8'hAD, 8'hA8, 8'hA8, 8'hA8 },
{8'hA8, 8'hA8, 8'hA9, 8'hA9, 8'hA9, 8'hD1, 8'hAD, 8'hA9, 8'hA9, 8'hA8, 8'h88, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hCD, 8'hD1, 8'hA9, 8'hA8, 8'h84, 8'h84, 8'h88, 8'h88, 8'h84, 8'h84, 8'h88, 8'hB1, 8'hD1, 8'hAD, 8'hA9, 8'hA9, 8'hA8 },
{8'hD6, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD6, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD6, 8'hD6, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD6, 8'hFA, 8'hD6, 8'hD6, 8'hD1, 8'hD1 },
{8'hDA, 8'hB1, 8'hD1, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hD1, 8'hD6, 8'hD5, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hB1, 8'hD6, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hAD, 8'hAD, 8'hAD, 8'hD1 },
{8'hD6, 8'hA9, 8'hA8, 8'h88, 8'h88, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hD1, 8'hD1, 8'hA8, 8'hA8, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hA9, 8'hD1, 8'hA9, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h84, 8'h88, 8'hAD },
{8'hD6, 8'hA9, 8'h88, 8'h88, 8'h84, 8'h84, 8'h88, 8'h88, 8'h84, 8'h88, 8'hD1, 8'hCD, 8'hA9, 8'hA8, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hA9, 8'hD1, 8'hA9, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h89 },
{8'hD6, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hD1, 8'hAD, 8'hA8, 8'hA8, 8'h88, 8'h88, 8'hA9, 8'h88, 8'h88, 8'h88, 8'hA9, 8'hD1, 8'hA9, 8'h88, 8'h84, 8'h84, 8'h88, 8'h88, 8'h84, 8'h84, 8'h88, 8'hAD },
{8'hD6, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hD6, 8'hD1, 8'hB1, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hD6, 8'hAD, 8'hAD, 8'h89, 8'hAD, 8'h89, 8'hAD, 8'hA9, 8'h89, 8'hAD, 8'hB1 },
{8'hD1, 8'hD1, 8'hB1, 8'hD1, 8'hD1, 8'hD6, 8'hD6, 8'hD5, 8'hD6, 8'hD2, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD2, 8'hD6, 8'hDA, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD6, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD6, 8'hD6, 8'hD1, 8'hD1, 8'hD1, 8'hD1 },
{8'h88, 8'h88, 8'h88, 8'h88, 8'hA9, 8'hD1, 8'hAD, 8'hA9, 8'hA9, 8'h88, 8'h88, 8'h88, 8'hA8, 8'h88, 8'h88, 8'hAD, 8'hD1, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hD1, 8'hAD, 8'hA9, 8'hA8, 8'h88, 8'h88 },
{8'h88, 8'h88, 8'h88, 8'h88, 8'hA9, 8'hD1, 8'hAD, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h84, 8'h84, 8'h88, 8'hAD, 8'hB1, 8'h88, 8'h88, 8'h88, 8'h88, 8'h84, 8'h84, 8'h64, 8'h84, 8'h88, 8'hB1, 8'hCD, 8'hA8, 8'hA8, 8'h84, 8'h88 },
{8'hA8, 8'hA8, 8'h88, 8'h88, 8'hA9, 8'hD1, 8'hAD, 8'h88, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h88, 8'h88, 8'hAD, 8'hB1, 8'h88, 8'h88, 8'h88, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h88, 8'hB1, 8'hAD, 8'hA8, 8'hA8, 8'h88, 8'h84 },
{8'hA9, 8'h89, 8'h88, 8'h88, 8'hA9, 8'hD1, 8'hAD, 8'h89, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hAD, 8'hD1, 8'h89, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h89, 8'hD1, 8'hB1, 8'hAD, 8'hA9, 8'h88, 8'h88 },
{8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hFA, 8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hFA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hFA, 8'hFA, 8'hFA, 8'hD6, 8'hDA, 8'hDA }
};

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors4 = {
{8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1F, 8'h1F, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h1A, 8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h1A, 8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h16, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1A, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1F, 8'h1A, 8'h1A, 8'h1B, 8'h1F, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1F, 8'h1F, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1F, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1F, 8'h1F, 8'h1A, 8'h16, 8'h1F, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h16, 8'h16, 8'h1F, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h16, 8'h16, 8'h1F, 8'h1F, 8'h16, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h1A, 8'h1B, 8'h1F, 8'h1A, 8'h1A },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h1F, 8'h1F, 8'h16, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h1A },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1F, 8'h1F, 8'h16, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h16 },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h16, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h16 },
{8'h1A, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h16, 8'h16, 8'h1F, 8'h1F, 8'h1A, 8'h16, 8'h1F, 8'h1F, 8'h1A, 8'h16 },
{8'h1A, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h1F, 8'h1F, 8'h1A, 8'h16, 8'h1F, 8'h1F, 8'h1A, 8'h16 },
{8'h1A, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h16, 8'h16, 8'h1F, 8'h1F, 8'h1A, 8'h16 },
{8'h1A, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h16, 8'h16, 8'h1F, 8'h1F, 8'h16, 8'h16 },
{8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h16, 8'h16, 8'h1F, 8'h1F, 8'h16, 8'h16 },
{8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h1F, 8'h1F, 8'h16, 8'h16 },
{8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1F, 8'h1F, 8'h16, 8'h16 },
{8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h16, 8'h16 },
{8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h16, 8'h16 },
{8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16 }
};

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors5 = {
{8'hC4, 8'hC5, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hA4, 8'hA4, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC5, 8'hC4, 8'hA4, 8'hA4, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hA4, 8'hA4 },
{8'hC4, 8'hA4, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hA4, 8'hA4, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC4, 8'hA4, 8'hA4, 8'hA4, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC4, 8'hA4 },
{8'hC4, 8'hA4, 8'hF6, 8'hF6, 8'hFB, 8'hFB, 8'hFB, 8'hFB, 8'hF2, 8'hED, 8'hED, 8'hF2, 8'hF6, 8'hF6, 8'hF6, 8'hF6, 8'hF6, 8'hF6, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hED, 8'hF6, 8'hF6, 8'hF6, 8'hF6, 8'hC9, 8'hC5 },
{8'hC4, 8'hC4, 8'hF6, 8'hFB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hFA, 8'hFB, 8'hFB, 8'hFB, 8'hFB, 8'hFA, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hFA, 8'hFB, 8'hFB, 8'hF6, 8'hC9, 8'hC9 },
{8'hC9, 8'hC9, 8'hFB, 8'hFF, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF6, 8'hF6, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hE9, 8'hED, 8'hF2, 8'hFA, 8'hF6, 8'hC9, 8'hC9 },
{8'hC9, 8'hC9, 8'hFB, 8'hFF, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hFA, 8'hFA, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hFA, 8'hF6, 8'hC9, 8'hC9 },
{8'hC9, 8'hC9, 8'hFB, 8'hFF, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF6, 8'hF6, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hA4, 8'hA4 },
{8'hC9, 8'hC9, 8'hFB, 8'hFF, 8'hED, 8'hED, 8'hED, 8'hED, 8'hFA, 8'hFA, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hED, 8'hA4, 8'hA0 },
{8'hC9, 8'hC9, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hA4, 8'hA4 },
{8'hC9, 8'hC9, 8'hED, 8'hF2, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hED, 8'hC4, 8'hA4 },
{8'hC5, 8'hC4, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hC9, 8'hC9, 8'hA4, 8'hA4 },
{8'hC4, 8'hC4, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hC9, 8'hC5, 8'hA4, 8'hA4 },
{8'hC9, 8'hC9, 8'hF6, 8'hFA, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hA4, 8'hA0 },
{8'hC9, 8'hC9, 8'hF6, 8'hFB, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hA4, 8'hA4 },
{8'hC9, 8'hC9, 8'hF6, 8'hFB, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hA4, 8'hC4 },
{8'hC9, 8'hC9, 8'hF6, 8'hFA, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hC9, 8'hA4, 8'hC4 },
{8'hC9, 8'hC9, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hC9, 8'hE9, 8'hED, 8'hE9, 8'hA4, 8'hC4 },
{8'hC9, 8'hC9, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hA4, 8'hC4 },
{8'hC5, 8'hC4, 8'hED, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hA4, 8'hA4 },
{8'hC4, 8'hA4, 8'hED, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hA4, 8'hA4 },
{8'hC4, 8'hA4, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hA0, 8'hA4 },
{8'hC4, 8'hA4, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hA0, 8'hA4 },
{8'hC4, 8'hA4, 8'hC9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hA0, 8'hA4 },
{8'hC4, 8'hA4, 8'hC9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hA4, 8'hA4 },
{8'hA4, 8'hA0, 8'hC9, 8'hE9, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hED, 8'hE9, 8'hA4, 8'hC4 },
{8'hA4, 8'hA0, 8'hC9, 8'hE9, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hC4, 8'hC5 },
{8'hA4, 8'hA0, 8'hC5, 8'hC9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hC9, 8'hE9, 8'hED, 8'hED, 8'hC9, 8'hC9 },
{8'hA4, 8'hA0, 8'hC9, 8'hC9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hC9, 8'hC9 },
{8'hA9, 8'hA0, 8'hC9, 8'hE9, 8'hC9, 8'hC9, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hED, 8'hC9, 8'hC9 },
{8'hC9, 8'hA0, 8'hC9, 8'hC9, 8'hC9, 8'hC5, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hED, 8'hC9, 8'hC9 },
{8'hC9, 8'hA0, 8'hA0, 8'hA0, 8'hA0, 8'hA0, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA0, 8'hA0, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hC4, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9 },
{8'hCD, 8'hC9, 8'hC9, 8'hC9, 8'hA4, 8'hA4, 8'hC4, 8'hC4, 8'hC4, 8'hC4, 8'hC4, 8'hC4, 8'hC4, 8'hC4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hC4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hC4, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9 }
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
			3'b100: RGBout <= object_colors4[offsetY][offsetX];
			3'b101: RGBout <= object_colors5[offsetY][offsetX];		
			endcase
		else 
			RGBout <= TRANSPARENT_ENCODING ; // force color to transparent so it will not be displayed 
	end 
end

//======--------------------------------------------------------------------------------------------------------------=
// decide if to draw the pixel or not 
assign drawingRequest = (RGBout != TRANSPARENT_ENCODING ) ? 1'b1 : 1'b0 ; // get optional transparent command from the bitmpap   

endmodule