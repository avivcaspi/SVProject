
module	brickBitMap	(	
					input	logic	clk,
					input	logic	resetN,
					input logic	[10:0] offsetX,// offset from top left  position 
					input logic	[10:0] offsetY,
					input	logic	InsideRectangle, //input that the pixel is within a bracket 
					input logic [2:0] brickNum,	//brick number determine the bitmap

					output	logic	drawingRequest, //output that the pixel should be dispalyed 
					output	logic	[7:0] RGBout  //rgb value from the bitmap 
);


localparam logic [7:0] TRANSPARENT_ENCODING = 8'hFF ;// RGB value in the bitmap representing a transparent pixel 

localparam  int OBJECT_HEIGHT_Y = 32;
localparam  int OBJECT_WIDTH_X = 32;

const logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] brick1 = {
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
{8'hA8, 8'hA8, 8'hA9, 8'hA9, 8'hA8, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hAD, 8'hA9, 8'hA9, 8'hA8 },
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

const logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] brick2 = {
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
{8'hFA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hFB, 8'hFB, 8'hFB, 8'hFB, 8'hFB, 8'hFB, 8'hFB, 8'hFB, 8'hFB, 8'hFB, 8'hFB, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD2, 8'hB2, 8'hB2, 8'hD6 },
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

const logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] brick3 = {
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

const logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] brick4 = {
{8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D },
{8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h6D, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h6D, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h6D, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h6D, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h6D, 8'h6D, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h6D, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'h92, 8'h6D, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'h92, 8'h92, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h92, 8'h92, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h92, 8'h92, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h92, 8'h92, 8'h6D, 8'h6D, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h92, 8'h92, 8'h6D, 8'h6D, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h92 },
{8'h6D, 8'h6D, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h6D, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h6D }
};

const logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] brick5 = {
{8'h29, 8'h52, 8'h32, 8'h32, 8'h56, 8'h52, 8'h56, 8'h56, 8'h52, 8'h32, 8'h2A, 8'h2E, 8'h32, 8'h52, 8'h57, 8'h57, 8'h56, 8'h56, 8'h56, 8'h56, 8'h52, 8'h29, 8'h52, 8'h56, 8'h56, 8'h76, 8'h56, 8'h56, 8'h56, 8'h76, 8'h56, 8'h52 },
{8'h29, 8'h52, 8'h56, 8'h56, 8'h57, 8'h56, 8'h57, 8'h57, 8'h56, 8'h52, 8'h2E, 8'h2E, 8'h56, 8'h57, 8'h57, 8'h57, 8'h77, 8'h57, 8'h57, 8'h57, 8'h52, 8'h29, 8'h52, 8'h57, 8'h57, 8'h77, 8'h77, 8'h7B, 8'h77, 8'h7B, 8'h77, 8'h56 },
{8'h29, 8'h52, 8'h52, 8'h56, 8'h56, 8'h57, 8'h56, 8'h56, 8'h56, 8'h32, 8'h2E, 8'h2E, 8'h56, 8'h57, 8'h77, 8'h57, 8'h57, 8'h77, 8'h57, 8'h57, 8'h52, 8'h29, 8'h52, 8'h57, 8'h57, 8'h57, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h56 },
{8'h29, 8'h32, 8'h52, 8'h52, 8'h52, 8'h56, 8'h56, 8'h52, 8'h52, 8'h32, 8'h2E, 8'h2E, 8'h56, 8'h57, 8'h57, 8'h56, 8'h56, 8'h57, 8'h77, 8'h77, 8'h52, 8'h29, 8'h52, 8'h56, 8'h57, 8'h57, 8'h57, 8'h56, 8'h77, 8'h77, 8'h77, 8'h56 },
{8'h05, 8'h2A, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h29, 8'h29, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h4E, 8'h4E, 8'h2E, 8'h2E, 8'h05, 8'h2A, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h4E, 8'h4E, 8'h2E },
{8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h29, 8'h29, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h29, 8'h29, 8'h2E, 8'h2E, 8'h2E, 8'h4E, 8'h2E, 8'h2E, 8'h4E, 8'h4E, 8'h2E, 8'h29, 8'h29, 8'h2E, 8'h2E, 8'h2E, 8'h4E },
{8'h57, 8'h57, 8'h56, 8'h57, 8'h52, 8'h2A, 8'h2E, 8'h32, 8'h52, 8'h52, 8'h56, 8'h52, 8'h52, 8'h56, 8'h56, 8'h2E, 8'h2E, 8'h56, 8'h56, 8'h57, 8'h57, 8'h57, 8'h57, 8'h57, 8'h57, 8'h57, 8'h2E, 8'h2E, 8'h52, 8'h56, 8'h56, 8'h57 },
{8'h57, 8'h77, 8'h57, 8'h57, 8'h56, 8'h2E, 8'h52, 8'h52, 8'h56, 8'h56, 8'h56, 8'h56, 8'h56, 8'h56, 8'h56, 8'h32, 8'h2E, 8'h56, 8'h77, 8'h77, 8'h57, 8'h77, 8'h57, 8'h57, 8'h77, 8'h77, 8'h2E, 8'h2E, 8'h56, 8'h57, 8'h77, 8'h57 },
{8'h56, 8'h57, 8'h57, 8'h77, 8'h56, 8'h2E, 8'h2E, 8'h32, 8'h52, 8'h52, 8'h52, 8'h32, 8'h52, 8'h52, 8'h52, 8'h2E, 8'h2E, 8'h56, 8'h57, 8'h77, 8'h57, 8'h57, 8'h57, 8'h57, 8'h57, 8'h56, 8'h2E, 8'h2E, 8'h56, 8'h56, 8'h57, 8'h56 },
{8'h52, 8'h52, 8'h52, 8'h52, 8'h2E, 8'h29, 8'h2A, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h32, 8'h2E, 8'h2E, 8'h29, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h29, 8'h2A, 8'h2E, 8'h52, 8'h52, 8'h52 },
{8'h05, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h05, 8'h25, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h25, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29 },
{8'h29, 8'h52, 8'h56, 8'h56, 8'h56, 8'h56, 8'h56, 8'h56, 8'h56, 8'h52, 8'h2E, 8'h2E, 8'h52, 8'h56, 8'h56, 8'h56, 8'h56, 8'h56, 8'h56, 8'h56, 8'h52, 8'h29, 8'h52, 8'h76, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h72 },
{8'h29, 8'h52, 8'h56, 8'h57, 8'h57, 8'h57, 8'h57, 8'h57, 8'h57, 8'h56, 8'h2E, 8'h2E, 8'h56, 8'h57, 8'h57, 8'h57, 8'h57, 8'h57, 8'h57, 8'h56, 8'h56, 8'h2E, 8'h56, 8'h77, 8'h7B, 8'h7B, 8'h7B, 8'h7B, 8'h7B, 8'h9B, 8'h9B, 8'h76 },
{8'h29, 8'h56, 8'h57, 8'h57, 8'h57, 8'h56, 8'h57, 8'h57, 8'h57, 8'h56, 8'h2E, 8'h2E, 8'h52, 8'h56, 8'h57, 8'h57, 8'h57, 8'h57, 8'h57, 8'h57, 8'h56, 8'h2E, 8'h56, 8'h7B, 8'h7B, 8'h7B, 8'h7B, 8'h7B, 8'h7B, 8'h9B, 8'h9B, 8'h76 },
{8'h29, 8'h52, 8'h56, 8'h56, 8'h56, 8'h56, 8'h56, 8'h56, 8'h56, 8'h56, 8'h2E, 8'h2E, 8'h52, 8'h52, 8'h56, 8'h56, 8'h56, 8'h56, 8'h56, 8'h56, 8'h52, 8'h29, 8'h52, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h7B, 8'h7B, 8'h7B, 8'h56 },
{8'h25, 8'h29, 8'h2E, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h25, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h25, 8'h29, 8'h2E, 8'h2E, 8'h2E, 8'h29, 8'h2D, 8'h2E, 8'h4E, 8'h4E, 8'h2E },
{8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h29, 8'h2E, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h2E, 8'h29, 8'h52, 8'h52, 8'h56, 8'h56, 8'h56, 8'h76, 8'h56, 8'h56, 8'h56, 8'h2D, 8'h2E, 8'h52, 8'h52, 8'h52, 8'h56 },
{8'h56, 8'h57, 8'h57, 8'h56, 8'h56, 8'h2E, 8'h32, 8'h56, 8'h56, 8'h56, 8'h57, 8'h57, 8'h77, 8'h57, 8'h56, 8'h52, 8'h2E, 8'h56, 8'h77, 8'h77, 8'h77, 8'h7B, 8'h7B, 8'h7B, 8'h7B, 8'h77, 8'h2E, 8'h2E, 8'h56, 8'h57, 8'h57, 8'h57 },
{8'h57, 8'h57, 8'h57, 8'h57, 8'h56, 8'h2E, 8'h52, 8'h56, 8'h57, 8'h57, 8'h77, 8'h57, 8'h57, 8'h77, 8'h57, 8'h52, 8'h2E, 8'h56, 8'h77, 8'h7B, 8'h7B, 8'h7B, 8'h7B, 8'h7B, 8'h9B, 8'h7B, 8'h4E, 8'h2E, 8'h52, 8'h57, 8'h57, 8'h57 },
{8'h57, 8'h57, 8'h56, 8'h56, 8'h56, 8'h2E, 8'h52, 8'h56, 8'h56, 8'h57, 8'h77, 8'h57, 8'h57, 8'h57, 8'h56, 8'h52, 8'h2E, 8'h56, 8'h57, 8'h7B, 8'h7B, 8'h77, 8'h77, 8'h7B, 8'h7B, 8'h77, 8'h4E, 8'h2E, 8'h52, 8'h56, 8'h56, 8'h57 },
{8'h29, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h29, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h29, 8'h29, 8'h2E, 8'h4E, 8'h4E, 8'h4E, 8'h4E, 8'h4E, 8'h4E, 8'h4E, 8'h4E, 8'h29, 8'h05, 8'h29, 8'h29, 8'h2E, 8'h2E },
{8'h25, 8'h4E, 8'h4E, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h2E, 8'h29, 8'h2E, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h4E, 8'h29, 8'h2E, 8'h4E, 8'h4E, 8'h4E, 8'h4E, 8'h52, 8'h52, 8'h52, 8'h4E, 8'h2E },
{8'h29, 8'h56, 8'h57, 8'h77, 8'h77, 8'h57, 8'h57, 8'h57, 8'h57, 8'h57, 8'h2E, 8'h2E, 8'h57, 8'h57, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h56, 8'h2E, 8'h56, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h7B, 8'h77, 8'h52 },
{8'h29, 8'h56, 8'h77, 8'h77, 8'h7B, 8'h7B, 8'h77, 8'h77, 8'h7B, 8'h77, 8'h2E, 8'h32, 8'h56, 8'h57, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h56, 8'h2E, 8'h56, 8'h7B, 8'h7B, 8'h7B, 8'h7B, 8'h7B, 8'h7B, 8'h7B, 8'h7B, 8'h76 },
{8'h29, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h4E, 8'h52, 8'h56, 8'h57, 8'h77, 8'h77, 8'h56, 8'h77, 8'h77, 8'h77, 8'h56, 8'h2E, 8'h56, 8'h77, 8'h7B, 8'h7B, 8'h77, 8'h77, 8'h7B, 8'h7B, 8'h77, 8'h52 },
{8'h29, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h29, 8'h2E, 8'h4E, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h52, 8'h29, 8'h52, 8'h52, 8'h76, 8'h52, 8'h72, 8'h52, 8'h76, 8'h76, 8'h52, 8'h4E },
{8'h2E, 8'h2E, 8'h4E, 8'h2E, 8'h2E, 8'h29, 8'h29, 8'h2A, 8'h29, 8'h2D, 8'h29, 8'h29, 8'h29, 8'h29, 8'h2D, 8'h29, 8'h25, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h29, 8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h29, 8'h29, 8'h2E, 8'h2E, 8'h2E, 8'h2E },
{8'h77, 8'h77, 8'h77, 8'h77, 8'h56, 8'h2E, 8'h52, 8'h56, 8'h56, 8'h77, 8'h77, 8'h77, 8'h57, 8'h77, 8'h77, 8'h52, 8'h2E, 8'h77, 8'h77, 8'h77, 8'h77, 8'h76, 8'h77, 8'h77, 8'h77, 8'h77, 8'h2E, 8'h52, 8'h56, 8'h57, 8'h77, 8'h77 },
{8'h77, 8'h77, 8'h77, 8'h77, 8'h56, 8'h2E, 8'h52, 8'h76, 8'h77, 8'h77, 8'h77, 8'h77, 8'h7B, 8'h7B, 8'h77, 8'h52, 8'h4E, 8'h77, 8'h77, 8'h77, 8'h77, 8'h7B, 8'h7B, 8'h9B, 8'h7B, 8'h77, 8'h4E, 8'h32, 8'h57, 8'h57, 8'h7B, 8'h77 },
{8'h57, 8'h57, 8'h77, 8'h77, 8'h56, 8'h2E, 8'h52, 8'h77, 8'h77, 8'h7B, 8'h7B, 8'h7B, 8'h7B, 8'h77, 8'h77, 8'h52, 8'h4E, 8'h77, 8'h77, 8'h77, 8'h77, 8'h7B, 8'h7B, 8'h7B, 8'h7B, 8'h77, 8'h4E, 8'h52, 8'h57, 8'h57, 8'h77, 8'h7B },
{8'h56, 8'h76, 8'h77, 8'h77, 8'h56, 8'h2E, 8'h52, 8'h76, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h52, 8'h2E, 8'h76, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h77, 8'h76, 8'h2E, 8'h4E, 8'h52, 8'h56, 8'h77, 8'h77 },
{8'h25, 8'h29, 8'h29, 8'h29, 8'h25, 8'h05, 8'h25, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h25, 8'h05, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h29, 8'h25, 8'h05, 8'h05, 8'h05, 8'h29, 8'h25, 8'h25 }
};

logic [0:4][0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] bricks = {brick1, brick2, brick3, brick4, brick5};

// pipeline (ff) to get the pixel color from the array 	 

//======--------------------------------------------------------------------------------------------------------------=
always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
		RGBout <=	8'h00;
	end
	else begin
		if (InsideRectangle == 1'b1 )  // inside an external bracket 
			RGBout <= bricks[brickNum - 1][offsetY][offsetX];
		else 
			RGBout <= TRANSPARENT_ENCODING ; // force color to transparent so it will not be displayed 
	end 
end

//======--------------------------------------------------------------------------------------------------------------=
// decide if to draw the pixel or not 
assign drawingRequest = (RGBout != TRANSPARENT_ENCODING ) ? 1'b1 : 1'b0 ; // get optional transparent command from the bitmpap   

endmodule