
module	tankBitMap	(	
					input	logic	clk,
					input	logic	resetN,
					input logic	[10:0] offsetX,// offset from top left  position 
					input logic	[10:0] offsetY,
					input	logic	InsideRectangle, //input that the pixel is within a bracket 
					input logic tankNum, 	//determine which tank to show
					input logic tankShield,	// determine if the tank has shield or not

					output	logic	drawingRequest, //output that the pixel should be dispalyed 
					output	logic	[7:0] RGBout  //rgb value from the bitmap 
);

localparam logic [7:0] TRANSPARENT_ENCODING = 8'hFF ;// RGB value in the bitmap representing a transparent pixel 

localparam  int OBJECT_HEIGHT_Y = 25;
localparam  int OBJECT_WIDTH_X = 25;

logic [0:OBJECT_HEIGHT_Y-1] [0:OBJECT_WIDTH_X-1] [8-1:0] tank1 = {
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

logic [0:OBJECT_HEIGHT_Y-1] [0:OBJECT_WIDTH_X-1] [8-1:0] tank1Shield = {
{8'hBE, 8'hBA, 8'h24, 8'h49, 8'hBE, 8'h96, 8'h24, 8'h4D, 8'hDF, 8'h96, 8'h24, 8'h6D, 8'hDF, 8'h71, 8'h04, 8'h92, 8'hDF, 8'h6D, 8'h24, 8'h96, 8'hBE, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hBE, 8'h9A, 8'h00, 8'h24, 8'hBE, 8'h96, 8'h00, 8'h29, 8'hBE, 8'h72, 8'h00, 8'h4D, 8'hBF, 8'h71, 8'h01, 8'h71, 8'hBF, 8'h49, 8'h00, 8'h96, 8'hBE, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h2D, 8'h29, 8'h00, 8'h04, 8'h2D, 8'h09, 8'h00, 8'h04, 8'h2D, 8'h09, 8'h00, 8'h04, 8'h2D, 8'h04, 8'h00, 8'h09, 8'h2D, 8'h04, 8'h00, 8'h09, 8'h2D, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h09, 8'h09, 8'h24, 8'h24, 8'h0D, 8'h09, 8'h24, 8'h24, 8'h0D, 8'h09, 8'h24, 8'h28, 8'h0D, 8'h29, 8'h24, 8'h29, 8'h0D, 8'h24, 8'h24, 8'h09, 8'h09, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h09, 8'h2D, 8'hBA, 8'hBE, 8'hBE, 8'hBE, 8'hBA, 8'hBA, 8'hBE, 8'hBA, 8'hBA, 8'hBA, 8'hBE, 8'hBA, 8'hBA, 8'hBA, 8'hBE, 8'hBA, 8'hBE, 8'h2D, 8'h09, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h29, 8'h2D, 8'hBA, 8'hBA, 8'h9A, 8'hBA, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBA, 8'hBA, 8'hBE, 8'h51, 8'h09, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h09, 8'h2D, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h2D, 8'h51, 8'h9A, 8'h9A, 8'h9A, 8'h9A, 8'h9A, 8'h9A, 8'h9A, 8'hBA, 8'hBE, 8'hBA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hBA, 8'hBE, 8'hDF, 8'h9A, 8'h09, 8'h09, 8'h09, 8'h09, 8'h09, 8'h09, 8'h09, 8'h72, 8'hDF, 8'h4D, 8'h01, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hBA, 8'hBE, 8'h9A, 8'h76, 8'h51, 8'h51, 8'h51, 8'h51, 8'h51, 8'h2D, 8'h09, 8'h51, 8'h9A, 8'h4D, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hBE, 8'hBA, 8'h09, 8'h2D, 8'hBE, 8'hBE, 8'hDF, 8'hDF, 8'hDF, 8'h76, 8'h09, 8'h09, 8'h09, 8'h04, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h76, 8'h76, 8'h09, 8'h2D, 8'hBE, 8'hBA, 8'h76, 8'h76, 8'h76, 8'h4D, 8'h04, 8'h09, 8'h09, 8'h2D, 8'h4D, 8'hB6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h09, 8'h09, 8'h09, 8'h2D, 8'hDF, 8'h9A, 8'h09, 8'h09, 8'h09, 8'h04, 8'h00, 8'h04, 8'h09, 8'h76, 8'hE3, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE },
{8'hFF, 8'hFF, 8'h09, 8'h09, 8'h09, 8'h2D, 8'h76, 8'h51, 8'h04, 8'h04, 8'h04, 8'h04, 8'h00, 8'h04, 8'h09, 8'h4D, 8'h71, 8'hBA, 8'hDF, 8'hDF, 8'hDF, 8'hDF, 8'hDF, 8'hDF, 8'hDF },
{8'hFF, 8'hFF, 8'h09, 8'h09, 8'h09, 8'h09, 8'h09, 8'h04, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h09, 8'h09, 8'h04, 8'h04, 8'h09, 8'h09, 8'h04, 8'h04, 8'h04, 8'h04, 8'h04, 8'h09, 8'h09, 8'h04, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h09, 8'h09, 8'h00, 8'h04, 8'h09, 8'h09, 8'h09, 8'h09, 8'h09, 8'h09, 8'h09, 8'h09, 8'h09, 8'h04, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h00, 8'h00, 8'h04, 8'h04, 8'h04, 8'h04, 8'h04, 8'h04, 8'h04, 8'h04, 8'h04, 8'h4D, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hDF, 8'hBA, 8'h49, 8'h29, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h24, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hBE, 8'hBA, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h2D, 8'h2D, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h04, 8'h09, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h09, 8'h09, 8'h00, 8'h04, 8'h09, 8'h09, 8'h00, 8'h04, 8'h09, 8'h08, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h08, 8'h09, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h09, 8'h09, 8'h00, 8'h04, 8'h09, 8'h09, 8'h00, 8'h04, 8'h09, 8'h08, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h08, 8'h09, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h09, 8'h09, 8'h00, 8'h04, 8'h09, 8'h09, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h08, 8'h09, 8'hFF, 8'hFF, 8'hFF, 8'hFF }
};

//enemy tank bitmap
logic [0:OBJECT_HEIGHT_Y-1] [0:OBJECT_WIDTH_X-1] [8-1:0] tank2 = {
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

logic [0:OBJECT_HEIGHT_Y-1] [0:OBJECT_WIDTH_X-1] [8-1:0] tank2Shield = {
{8'hFA, 8'h6D, 8'h00, 8'hB6, 8'h91, 8'h00, 8'hB6, 8'hB6, 8'h00, 8'h91, 8'hDA, 8'h00, 8'h6D, 8'hDA, 8'h04, 8'h49, 8'hFA, 8'hCC, 8'hD1, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFA, 8'h6D, 8'h00, 8'hB5, 8'h91, 8'h00, 8'hB1, 8'hB1, 8'h00, 8'h8D, 8'hD6, 8'h00, 8'h6D, 8'hD6, 8'h04, 8'h49, 8'hFA, 8'hAC, 8'hAD, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hEC, 8'h68, 8'h00, 8'hA8, 8'h88, 8'h00, 8'hA8, 8'hA8, 8'h00, 8'h88, 8'hCC, 8'h00, 8'h64, 8'hCC, 8'h00, 8'h44, 8'hCC, 8'h20, 8'h49, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hEC, 8'h88, 8'h24, 8'hCC, 8'hA8, 8'h24, 8'hA8, 8'hA8, 8'h24, 8'h88, 8'hCC, 8'h24, 8'h88, 8'hCC, 8'h44, 8'h68, 8'hD1, 8'h24, 8'h49, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hCC, 8'hD1, 8'hDA, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hD1, 8'hDA, 8'h24, 8'h29, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hD1, 8'hD5, 8'hDA, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD5, 8'hDA, 8'h6D, 8'h6D, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hDA, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hDA, 8'hDA, 8'hDA, 8'hD5, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hDA, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hD1, 8'hDA, 8'hDA, 8'hD5, 8'hCC, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hD1, 8'hCC, 8'hCC, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hCC, 8'hD1, 8'hD5, 8'hD5, 8'hD1, 8'hCC, 8'h91, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hC8, 8'hCC, 8'hD1, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hEC, 8'hEC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'h20, 8'h25, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hCC, 8'hCC, 8'hD1, 8'hDA, 8'hD5, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'h68, 8'hA8, 8'hEC, 8'hD1, 8'hD1, 8'hD1, 8'h6D, 8'h91, 8'hFF, 8'hFB, 8'hFB, 8'hFB, 8'hFB, 8'hFB },
{8'hFF, 8'hFF, 8'hCC, 8'hCC, 8'hD1, 8'hDA, 8'hF1, 8'hEC, 8'hEC, 8'hEC, 8'hC8, 8'h00, 8'h64, 8'hEC, 8'hDA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA },
{8'hFF, 8'hFF, 8'hCC, 8'hCC, 8'hCC, 8'hD1, 8'h88, 8'h64, 8'h64, 8'h64, 8'h44, 8'h00, 8'h64, 8'hEC, 8'hD1, 8'hB1, 8'h6D, 8'h6D, 8'h91, 8'hFF, 8'hFB, 8'hFB, 8'hFB, 8'hFB, 8'hFB },
{8'hFF, 8'hFF, 8'hEC, 8'hCC, 8'hCC, 8'hCC, 8'h24, 8'h01, 8'h00, 8'h01, 8'h00, 8'h01, 8'h64, 8'hEC, 8'hEC, 8'h88, 8'h01, 8'h01, 8'h29, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h44, 8'hCC, 8'hEC, 8'hCC, 8'h88, 8'h68, 8'h88, 8'h88, 8'h88, 8'h88, 8'h64, 8'h44, 8'h44, 8'h24, 8'h00, 8'h6D, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h00, 8'hA8, 8'hEC, 8'hEC, 8'hEC, 8'hEC, 8'hEC, 8'hEC, 8'hEC, 8'hEC, 8'h64, 8'h01, 8'h00, 8'h00, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h00, 8'h44, 8'h44, 8'h44, 8'h44, 8'h44, 8'h44, 8'h44, 8'h44, 8'h44, 8'h24, 8'h00, 8'h00, 8'h00, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFA, 8'h91, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hAD, 8'hF6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFA, 8'h6D, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hA8, 8'hD1, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF0, 8'h68, 8'h00, 8'h88, 8'h68, 8'h00, 8'h88, 8'h88, 8'h00, 8'h64, 8'h88, 8'h00, 8'h44, 8'hA8, 8'h00, 8'h44, 8'hA8, 8'h44, 8'h69, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hEC, 8'h68, 8'h00, 8'hC8, 8'h88, 8'h00, 8'hA8, 8'hA8, 8'h00, 8'h88, 8'hCC, 8'h00, 8'h64, 8'hCC, 8'h00, 8'h44, 8'hEC, 8'h20, 8'h29, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hEC, 8'h68, 8'h00, 8'hA8, 8'h88, 8'h00, 8'hA8, 8'hA8, 8'h00, 8'h88, 8'hCC, 8'h00, 8'h64, 8'hCC, 8'h00, 8'h44, 8'hEC, 8'h20, 8'h49, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hEC, 8'h68, 8'h00, 8'hA8, 8'h88, 8'h00, 8'hA8, 8'hA8, 8'h00, 8'h88, 8'hCC, 8'h00, 8'h64, 8'hCC, 8'h00, 8'h44, 8'hCC, 8'h20, 8'h49, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF }
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
			1'b0 : begin // tank1 
						if(tankShield ) // tank1 with shield
							RGBout <= tank1Shield[offsetY][offsetX];
						else
							RGBout <= tank1[offsetY][offsetX];	//get RGB from the colors table  
					end
			1'b1 :begin // tank1
						if(tankShield) //tank 2 with shield
							RGBout <= tank2Shield[offsetY][offsetX];
						else
							RGBout <= tank2[offsetY][offsetX];	//get RGB from the colors table  
					end
			endcase		
		else 
			RGBout <= TRANSPARENT_ENCODING ; // force color to transparent so it will not be displayed 
	end 
end

//======--------------------------------------------------------------------------------------------------------------=
// decide if to draw the pixel or not 
assign drawingRequest = (RGBout != TRANSPARENT_ENCODING ) ? 1'b1 : 1'b0 ; // get optional transparent command from the bitmpap   

endmodule