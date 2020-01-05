

module	personBitMap	(	
					input	logic	clk,
					input	logic	resetN,
					input logic	[10:0] offsetX,// offset from top left  position 
					input logic	[10:0] offsetY,
					input	logic	InsideRectangle, //input that the pixel is within a bracket 

					output	logic	drawingRequest, //output that the pixel should be dispalyed 
					output	logic	[7:0] RGBout  //rgb value from the bitmap 
);

parameter logic [2:0] personNum = 0;
localparam logic [7:0] TRANSPARENT_ENCODING = 8'h00 ;// RGB value in the bitmap representing a transparent pixel 

localparam  int OBJECT_HEIGHT_Y = 25;
localparam  int OBJECT_WIDTH_X = 25;

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors1 = {
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h6D, 8'h92, 8'h6D, 8'h6D, 8'h92, 8'h6D, 8'h6D, 8'h92, 8'h6D, 8'h8D, 8'h6D, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h6D, 8'h6D, 8'h6D, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h6D, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h92, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h92, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h6D, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h92, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h91, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h49, 8'h49, 8'h49, 8'h49, 8'h8D, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'h91, 8'h49, 8'h49, 8'h49, 8'h49, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h49, 8'h91, 8'hD6, 8'hD6, 8'hD6, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hD6, 8'hD6, 8'h91, 8'h49, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'hD6, 8'hFA, 8'hFA, 8'hFA, 8'hB2, 8'h49, 8'h49, 8'hB2, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hB2, 8'h49, 8'h49, 8'h91, 8'hFA, 8'hFA, 8'hFA, 8'hD6, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h91, 8'h25, 8'h25, 8'h91, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h91, 8'h25, 8'h25, 8'h6D, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h6D, 8'hB2, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h91, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hB6, 8'h6D, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h49, 8'hB2, 8'hFA, 8'hFA, 8'hB6, 8'h6D, 8'h6D, 8'h8D, 8'hD2, 8'hD2, 8'hD2, 8'hD2, 8'hD2, 8'h8D, 8'h69, 8'h6D, 8'hB1, 8'hFA, 8'hFA, 8'hB2, 8'h49, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h49, 8'hB2, 8'hFA, 8'hFA, 8'hB2, 8'h69, 8'h6D, 8'hB1, 8'hF6, 8'hD6, 8'hD6, 8'hF6, 8'hF6, 8'hB1, 8'h6D, 8'h69, 8'h91, 8'hFA, 8'hFA, 8'hB2, 8'h49, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h49, 8'hB2, 8'hFA, 8'hFA, 8'hB2, 8'h69, 8'h6D, 8'h6D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h6D, 8'h6D, 8'h6D, 8'h91, 8'hFA, 8'hFA, 8'hB2, 8'h49, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hFA, 8'hFA, 8'hD6, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'hD6, 8'hD6, 8'hFA, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h92, 8'h69, 8'h6D, 8'h6D, 8'h6D, 8'h69, 8'h92, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hFA, 8'hD6, 8'h6D, 8'h6D, 8'h6D, 8'hB6, 8'hFA, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h49, 8'h91, 8'hFA, 8'hD6, 8'hD6, 8'hD6, 8'hFA, 8'hB2, 8'h49, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h45, 8'h49, 8'h49, 8'h45, 8'h49, 8'h49, 8'h45, 8'h49, 8'h20, 8'h6D, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'h6E, 8'h00, 8'h45, 8'h45, 8'h49, 8'h49, 8'h45, 8'h49, 8'h49, 8'h45 },
{8'h20, 8'h20, 8'h00, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h6E, 8'hBB, 8'h9B, 8'h9B, 8'h9B, 8'hBB, 8'h6E, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h00, 8'h20, 8'h20 },
{8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h6E, 8'hBB, 8'h9B, 8'h9B, 8'h9B, 8'hBB, 8'h6E, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20 },
{8'h20, 8'h24, 8'h00, 8'h69, 8'h00, 8'h20, 8'h20, 8'h20, 8'h20, 8'h6D, 8'hBB, 8'h9B, 8'h9B, 8'h9B, 8'hBB, 8'h6E, 8'h20, 8'h20, 8'h20, 8'h20, 8'h00, 8'h69, 8'h00, 8'h24, 8'h20 },
{8'h20, 8'h24, 8'h00, 8'h6D, 8'h00, 8'h20, 8'h20, 8'h20, 8'h20, 8'h24, 8'h49, 8'h97, 8'hBB, 8'h9B, 8'h49, 8'h24, 8'h20, 8'h20, 8'h20, 8'h20, 8'h00, 8'h6D, 8'h00, 8'h44, 8'h20 },
{8'h20, 8'h24, 8'h00, 8'h6D, 8'h00, 8'h20, 8'h20, 8'h20, 8'h20, 8'h24, 8'h25, 8'h97, 8'hBB, 8'h9B, 8'h49, 8'h24, 8'h20, 8'h20, 8'h20, 8'h20, 8'h00, 8'h6D, 8'h00, 8'h24, 8'h20 },
{8'h20, 8'h24, 8'h00, 8'h6D, 8'h00, 8'h20, 8'h20, 8'h20, 8'h20, 8'h24, 8'h25, 8'h97, 8'hBB, 8'h9B, 8'h49, 8'h24, 8'h20, 8'h20, 8'h20, 8'h20, 8'h00, 8'h6D, 8'h00, 8'h24, 8'h20 }
};

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors2 = {
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h91, 8'h92, 8'h92, 8'hB2, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h91, 8'h69, 8'h48, 8'h48, 8'h48, 8'h48, 8'h8D, 8'h91, 8'h92, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h91, 8'h91, 8'h8D, 8'h48, 8'h68, 8'h68, 8'h68, 8'h68, 8'h68, 8'h48, 8'h48, 8'h68, 8'h8D, 8'h91, 8'h91, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h68, 8'h48, 8'h48, 8'h68, 8'h68, 8'h68, 8'h68, 8'h68, 8'h68, 8'h68, 8'h68, 8'h68, 8'h48, 8'h48, 8'h68, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h8D, 8'h68, 8'h48, 8'h48, 8'h48, 8'h48, 8'h48, 8'h48, 8'h48, 8'h48, 8'h48, 8'h48, 8'h48, 8'h48, 8'h48, 8'h68, 8'h8D, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h91, 8'h69, 8'h44, 8'h48, 8'h8D, 8'hB6, 8'hB6, 8'hB6, 8'hB5, 8'hB6, 8'hB6, 8'hB5, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'h8D, 8'h48, 8'h44, 8'h69, 8'h91, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h44, 8'h91, 8'hD6, 8'hB6, 8'hDA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hDA, 8'hB6, 8'hD6, 8'h8D, 8'h48, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'hD5, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hD6, 8'hB6, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hB6, 8'h93, 8'h93, 8'hD6, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hB6, 8'h93, 8'h93, 8'hB6, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hB3, 8'h6F, 8'h6F, 8'hB7, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hB3, 8'h6F, 8'h6F, 8'hB3, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'hB1, 8'hB1, 8'hFA, 8'hDA, 8'hD6, 8'hD6, 8'hDA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hDA, 8'hD6, 8'hD6, 8'hDA, 8'hFA, 8'hB1, 8'hB6, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h91, 8'h69, 8'h8D, 8'hD6, 8'hFA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFA, 8'hD6, 8'h8D, 8'h68, 8'hB2, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h91, 8'h69, 8'h69, 8'h8D, 8'hB1, 8'hB1, 8'hDA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD6, 8'hB1, 8'hB1, 8'h8D, 8'h69, 8'h68, 8'hB2, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h91, 8'h68, 8'h69, 8'h69, 8'h69, 8'h68, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'h68, 8'h69, 8'h69, 8'h69, 8'h68, 8'hB2, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h69, 8'h69, 8'h69, 8'h69, 8'h69, 8'h68, 8'h68, 8'h68, 8'h68, 8'h68, 8'h69, 8'h69, 8'h69, 8'h69, 8'h69, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hFA, 8'hCE, 8'hCA, 8'hCE, 8'hDA, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hDB, 8'hD6, 8'hA1, 8'hA1, 8'hA1, 8'hD6, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h4A, 8'h4A, 8'h4A, 8'h4A, 8'h4A, 8'h4A, 8'h4A, 8'h4A, 8'h4A, 8'hB6, 8'hFF, 8'hD6, 8'hCA, 8'hA1, 8'hFB, 8'h92, 8'h4A, 8'h4A, 8'h4A, 8'h4A, 8'h4A, 8'h4A, 8'h4A, 8'h4A, 8'h4A },
{8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h92, 8'hFF, 8'h103, 8'hCE, 8'hA1, 8'hFF, 8'h6E, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01 },
{8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h92, 8'hFF, 8'hCE, 8'hC5, 8'hC1, 8'hFF, 8'h6E, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01 },
{8'h01, 8'h25, 8'h00, 8'h25, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h92, 8'hFF, 8'hC1, 8'hA1, 8'hC5, 8'hFF, 8'h6E, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h4A, 8'h00, 8'h01, 8'h01 },
{8'h01, 8'h25, 8'h00, 8'h4A, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h92, 8'hFF, 8'hA5, 8'hA1, 8'hC5, 8'hFF, 8'h6E, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h6E, 8'h00, 8'h01, 8'h01 },
{8'h01, 8'h25, 8'h00, 8'h4A, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h92, 8'hFF, 8'hC5, 8'hA1, 8'hC5, 8'hFF, 8'h6E, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h6E, 8'h00, 8'h01, 8'h01 },
{8'h01, 8'h25, 8'h00, 8'h4A, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h25, 8'h49, 8'h21, 8'h45, 8'h69, 8'h49, 8'h25, 8'h01, 8'h01, 8'h01, 8'h01, 8'h01, 8'h6E, 8'h00, 8'h01, 8'h01 }
};

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors3 = {
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h6D, 8'h6D, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h92, 8'h49, 8'h20, 8'h20, 8'h24, 8'h6D, 8'h69, 8'h92, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h49, 8'h69, 8'h69, 8'h69, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h20, 8'h24, 8'h49, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h49, 8'h49, 8'h49, 8'h20, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h49, 8'h92, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h6D, 8'h49, 8'h20, 8'h20, 8'h20, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h6D, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h45, 8'h20, 8'h24, 8'h91, 8'hB6, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'h45, 8'h20, 8'h20, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h25, 8'h69, 8'hB6, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hD6, 8'h8D, 8'h20, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'hD6, 8'hD6, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hDA, 8'hB1, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hB2, 8'h69, 8'h69, 8'h91, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hB6, 8'h69, 8'h69, 8'h8D, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hB6, 8'h2D, 8'h31, 8'h96, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hB6, 8'h2D, 8'h51, 8'h71, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h69, 8'hB1, 8'hFA, 8'hFA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hFA, 8'hFA, 8'hB6, 8'h49, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h24, 8'h8D, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hB1, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'hDA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h69, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB6, 8'h91, 8'h69, 8'hD6, 8'hFA, 8'hFA, 8'hFA, 8'hDA, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hD6, 8'hD6, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hDA, 8'hD6, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hDA, 8'hAE, 8'h8A, 8'h8A, 8'hD6, 8'hFB, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hDA, 8'h86, 8'h62, 8'h62, 8'hD6, 8'hDB, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h69, 8'h69, 8'h69, 8'h69, 8'h69, 8'h69, 8'h69, 8'h69, 8'h49, 8'h92, 8'hFF, 8'h8A, 8'h8A, 8'hFF, 8'hFF, 8'hFF, 8'h69, 8'h69, 8'h69, 8'h69, 8'h69, 8'h69, 8'h69, 8'h69, 8'h69 },
{8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h20, 8'h8D, 8'hFF, 8'h8A, 8'h8A, 8'hFF, 8'hFF, 8'hFF, 8'h20, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24 },
{8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h8D, 8'hFF, 8'h8A, 8'h66, 8'h8A, 8'hFF, 8'hFF, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24 },
{8'h24, 8'h44, 8'hFF, 8'h8D, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h8D, 8'hFF, 8'h8A, 8'h62, 8'h62, 8'hFF, 8'hFF, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h69, 8'h00, 8'h49, 8'h24 },
{8'h24, 8'h44, 8'h00, 8'h00, 8'h20, 8'h24, 8'h24, 8'h24, 8'h24, 8'h8D, 8'hFF, 8'h8A, 8'h62, 8'h62, 8'hFF, 8'hFF, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h69, 8'h00, 8'h69, 8'h24 },
{8'h24, 8'h44, 8'h00, 8'h00, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h8D, 8'hFF, 8'h8A, 8'h62, 8'h62, 8'hFF, 8'hFF, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h69, 8'h00, 8'h69, 8'h24 },
{8'h24, 8'h44, 8'h00, 8'h00, 8'h20, 8'h24, 8'h24, 8'h24, 8'h24, 8'h44, 8'h48, 8'h44, 8'h45, 8'h69, 8'h49, 8'h44, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h69, 8'h00, 8'h69, 8'h24 }
};

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors4 = {
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h92, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h92, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h6D, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h92, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h49, 8'h49, 8'h49, 8'h91, 8'h91, 8'h91, 8'h91, 8'h91, 8'h91, 8'h91, 8'h91, 8'h91, 8'h91, 8'h91, 8'h91, 8'h91, 8'h91, 8'h91, 8'h69, 8'h49, 8'h6D, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h49, 8'h6D, 8'h91, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h91, 8'h6D, 8'h49, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h91, 8'h91, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h91, 8'h91, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h91, 8'h91, 8'hB1, 8'hB1, 8'h6D, 8'h49, 8'h49, 8'h6D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h6D, 8'h49, 8'h49, 8'h6D, 8'hB1, 8'hB1, 8'h91, 8'h91, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h6D, 8'h29, 8'h29, 8'h6D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h6D, 8'h29, 8'h29, 8'h6D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'hB6, 8'hB1, 8'hB1, 8'h91, 8'h91, 8'h91, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'h91, 8'h91, 8'h91, 8'hB1, 8'hB1, 8'hB6, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'hD6, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hFB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD6, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'hD6, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD6, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'hD6, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD6, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hB2, 8'hB1, 8'hB1, 8'hB6, 8'hB2, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB2, 8'hB6, 8'hB1, 8'hB1, 8'hB2, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hD6, 8'hB1, 8'hB1, 8'hB1, 8'h91, 8'hB1, 8'hD6, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hFB, 8'hDA, 8'h71, 8'h6D, 8'h71, 8'hD6, 8'hFB, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hDB, 8'hDA, 8'h71, 8'h4D, 8'h6D, 8'hDA, 8'hDB, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'hB6, 8'hDB, 8'h71, 8'h6D, 8'h6D, 8'hDA, 8'hB6, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D, 8'h6D },
{8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'hB6, 8'hFF, 8'hFF, 8'hB6, 8'h6D, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49 },
{8'h49, 8'h49, 8'h6D, 8'h6D, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'hB6, 8'hFF, 8'hFF, 8'hB6, 8'h6D, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h6D, 8'h6D, 8'h49, 8'h49 },
{8'h49, 8'h6D, 8'h00, 8'h92, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'hB6, 8'hFF, 8'h71, 8'h6D, 8'h6D, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h92, 8'h00, 8'h6D, 8'h49 },
{8'h49, 8'h6D, 8'h00, 8'h92, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'hB6, 8'hFF, 8'h71, 8'h4D, 8'h6D, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h92, 8'h00, 8'h6D, 8'h49 },
{8'h49, 8'h6D, 8'h00, 8'h92, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'hB6, 8'hFF, 8'h71, 8'h4D, 8'h6D, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h92, 8'h00, 8'h6D, 8'h49 },
{8'h49, 8'h6D, 8'h00, 8'h92, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'hB6, 8'hFF, 8'h71, 8'h4D, 8'h6D, 8'hFF, 8'hB6, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'h92, 8'h00, 8'h6D, 8'h49 }
};

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors5 = {
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h6D, 8'h6D, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h92, 8'h49, 8'h20, 8'h20, 8'h24, 8'h6D, 8'h69, 8'h92, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h49, 8'h69, 8'h69, 8'h69, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h20, 8'h24, 8'h49, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h49, 8'h49, 8'h49, 8'h20, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h49, 8'h92, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h6D, 8'h49, 8'h20, 8'h20, 8'h20, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h6D, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h45, 8'h20, 8'h24, 8'h91, 8'hB6, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'hB2, 8'h45, 8'h20, 8'h20, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h25, 8'h69, 8'hB6, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hD6, 8'h8D, 8'h20, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'hD6, 8'hD6, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hDA, 8'hB1, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hB2, 8'h69, 8'h69, 8'h91, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hB6, 8'h69, 8'h69, 8'h8D, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hB6, 8'h2D, 8'h31, 8'h96, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hB6, 8'h2D, 8'h51, 8'h71, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h69, 8'hB1, 8'hFA, 8'hFA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hFA, 8'hFA, 8'hB6, 8'h49, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h24, 8'h8D, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hB1, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'hDA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h69, 8'h8D, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB6, 8'h91, 8'h69, 8'hD6, 8'hFA, 8'hFA, 8'hFA, 8'hDA, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hD6, 8'hD6, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hDA, 8'hD6, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hDA, 8'hAE, 8'h8A, 8'h8A, 8'hD6, 8'hFB, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hDA, 8'h86, 8'h62, 8'h62, 8'hD6, 8'hDB, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00 },
{8'h69, 8'h69, 8'h69, 8'h69, 8'h69, 8'h69, 8'h69, 8'h69, 8'h49, 8'h92, 8'hFF, 8'h8A, 8'h8A, 8'hFF, 8'hFF, 8'hFF, 8'h69, 8'h69, 8'h69, 8'h69, 8'h69, 8'h69, 8'h69, 8'h69, 8'h69 },
{8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h20, 8'h8D, 8'hFF, 8'h8A, 8'h8A, 8'hFF, 8'hFF, 8'hFF, 8'h20, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24 },
{8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h8D, 8'hFF, 8'h8A, 8'h66, 8'h8A, 8'hFF, 8'hFF, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24 },
{8'h24, 8'h44, 8'h00, 8'h8D, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h8D, 8'hFF, 8'h8A, 8'h62, 8'h62, 8'hFF, 8'hFF, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h69, 8'h00, 8'h49, 8'h24 },
{8'h24, 8'h44, 8'h00, 8'h00, 8'h20, 8'h24, 8'h24, 8'h24, 8'h24, 8'h8D, 8'hFF, 8'h8A, 8'h62, 8'h62, 8'hFF, 8'hFF, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h69, 8'h00, 8'h69, 8'h24 },
{8'h24, 8'h44, 8'h00, 8'h00, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h8D, 8'hFF, 8'h8A, 8'h62, 8'h62, 8'hFF, 8'hFF, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h69, 8'h00, 8'h69, 8'h24 },
{8'h24, 8'h44, 8'h00, 8'h00, 8'h20, 8'h24, 8'h24, 8'h24, 8'h24, 8'h44, 8'h48, 8'h44, 8'h45, 8'h69, 8'h49, 8'h44, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h69, 8'h00, 8'h69, 8'h24 }
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
			case(personNum)
			3'b000 : RGBout <= object_colors1[offsetY][offsetX];	//get RGB from the colors table  
			3'b001 : RGBout <= object_colors2[offsetY][offsetX];	//get RGB from the colors table
			3'b010 : RGBout <= object_colors3[offsetY][offsetX];	//get RGB from the colors table  
			3'b011 : RGBout <= object_colors4[offsetY][offsetX];	//get RGB from the colors table  
			3'b100 : RGBout <= object_colors5[offsetY][offsetX];	//get RGB from the colors table  
			endcase		
		else 
			RGBout <= TRANSPARENT_ENCODING ; // force color to transparent so it will not be displayed 
	end 
end

//======--------------------------------------------------------------------------------------------------------------=
// decide if to draw the pixel or not 
assign drawingRequest = (RGBout != TRANSPARENT_ENCODING ) ? 1'b1 : 1'b0 ; // get optional transparent command from the bitmpap   

endmodule