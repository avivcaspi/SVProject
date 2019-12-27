

module	electionBitMap	(	
					input	logic	clk,
					input	logic	resetN,
					input logic	[10:0] offsetX,// offset from top left  position 
					input logic	[10:0] offsetY,
					input	logic	InsideRectangle, //input that the pixel is within a bracket 

					output	logic	drawingRequest, //output that the pixel should be dispalyed 
					output	logic	[7:0] RGBout  //rgb value from the bitmap 
);

localparam logic [7:0] TRANSPARENT_ENCODING = 8'hFF ;// RGB value in the bitmap representing a transparent pixel 

localparam  int OBJECT_HEIGHT_Y = 32;
localparam  int OBJECT_WIDTH_X = 32;

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors = {
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h72, 8'h72, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'h92, 8'h92, 8'h92, 8'h92, 8'hB6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h92, 8'hB7, 8'hBB, 8'hDB, 8'hDB, 8'hBB, 8'hB7, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'hBB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hBB, 8'hB6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB7, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hB7, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hB6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB7, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hB7, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h92, 8'h96, 8'h96, 8'h92, 8'h96, 8'h96, 8'h96, 8'h96, 8'h92, 8'h96, 8'h96, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'hB7, 8'hB7, 8'hB7, 8'hB7, 8'hB7, 8'hB7, 8'hB7, 8'hB7, 8'hB7, 8'hB7, 8'hB6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'hB6, 8'h92, 8'hB7, 8'h92, 8'hB6, 8'h92, 8'h92, 8'hB6, 8'h92, 8'hB7, 8'h92, 8'hB6, 8'hB6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB6, 8'hB7, 8'h92, 8'hB7, 8'h92, 8'hB7, 8'h96, 8'h96, 8'hB7, 8'h92, 8'hB7, 8'h92, 8'hB7, 8'hB6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB7, 8'hB6, 8'hB7, 8'hB6, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'hB6, 8'hB7, 8'hB6, 8'hB7, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hB7, 8'hB7, 8'hB6, 8'h92, 8'h92, 8'h92, 8'h92, 8'h96, 8'h92, 8'hB6, 8'h92, 8'h96, 8'h92, 8'h96, 8'h96, 8'h92, 8'h96, 8'h92, 8'hB6, 8'h92, 8'h96, 8'h92, 8'h92, 8'h92, 8'h92, 8'hB6, 8'hB7, 8'hB7, 8'hFF, 8'hFF },
{8'hFF, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'hB6, 8'hB6, 8'h92, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'hB6, 8'h92, 8'hB6, 8'hB6, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF },
{8'hFF, 8'hB7, 8'hB6, 8'h92, 8'h96, 8'h92, 8'hB6, 8'h92, 8'hB7, 8'hB7, 8'hB6, 8'hB6, 8'hB7, 8'hDB, 8'hB6, 8'hB7, 8'hB7, 8'hB6, 8'hDB, 8'hB7, 8'hB6, 8'hB6, 8'hB7, 8'hB7, 8'h92, 8'hB6, 8'h92, 8'h96, 8'h92, 8'hB6, 8'hB7, 8'hFF },
{8'hFF, 8'hFF, 8'h96, 8'h72, 8'h92, 8'hB6, 8'hB7, 8'hB7, 8'hB7, 8'h92, 8'h92, 8'h92, 8'h92, 8'hB7, 8'h92, 8'h92, 8'h92, 8'h92, 8'hB7, 8'h92, 8'h92, 8'h92, 8'h92, 8'hB7, 8'hB7, 8'hB7, 8'hB6, 8'h92, 8'h72, 8'h96, 8'hFF, 8'hFF },
{8'hFF, 8'hB7, 8'h96, 8'h92, 8'h92, 8'hB6, 8'hB7, 8'hB7, 8'hB7, 8'h97, 8'h97, 8'h97, 8'h97, 8'hB7, 8'h72, 8'h92, 8'h72, 8'h72, 8'hB7, 8'h97, 8'h97, 8'h97, 8'h97, 8'hB7, 8'hB7, 8'hB7, 8'hB6, 8'h92, 8'h92, 8'h96, 8'hB7, 8'hFF },
{8'hFF, 8'hB7, 8'h96, 8'h72, 8'h92, 8'hB6, 8'hB7, 8'hB7, 8'hB7, 8'h92, 8'h72, 8'h92, 8'h92, 8'hB7, 8'h97, 8'h97, 8'h97, 8'h97, 8'hB7, 8'h92, 8'h72, 8'h92, 8'h92, 8'hB7, 8'hB7, 8'hB7, 8'hB6, 8'h92, 8'h72, 8'h96, 8'hB7, 8'hFF },
{8'hFF, 8'hB7, 8'h96, 8'h96, 8'h96, 8'hB6, 8'hB7, 8'hB7, 8'hB7, 8'h97, 8'h97, 8'h97, 8'h97, 8'hB7, 8'h97, 8'h97, 8'h97, 8'h97, 8'hB7, 8'h97, 8'h97, 8'h97, 8'h97, 8'hB7, 8'hB7, 8'hB7, 8'hB6, 8'h96, 8'h96, 8'h96, 8'hB7, 8'hFF },
{8'hFF, 8'hB7, 8'h96, 8'h72, 8'h92, 8'hB6, 8'hB7, 8'hB7, 8'hB7, 8'h92, 8'h72, 8'h72, 8'h92, 8'hB7, 8'h97, 8'h97, 8'h97, 8'h97, 8'hB7, 8'h92, 8'h72, 8'h72, 8'h92, 8'hB7, 8'hB7, 8'hB7, 8'hB6, 8'h92, 8'h72, 8'h92, 8'hB7, 8'hFF },
{8'hFF, 8'hB7, 8'h96, 8'h72, 8'h92, 8'hB6, 8'hB7, 8'hB7, 8'hB7, 8'h97, 8'h97, 8'h97, 8'h97, 8'hB7, 8'h97, 8'h97, 8'h97, 8'h97, 8'hB7, 8'h97, 8'h97, 8'h97, 8'h97, 8'hB7, 8'hB7, 8'hB7, 8'hB6, 8'h92, 8'h72, 8'h96, 8'hB7, 8'hFF },
{8'hFF, 8'hB7, 8'h92, 8'h72, 8'h72, 8'h92, 8'hB7, 8'hB7, 8'hB6, 8'h92, 8'h92, 8'h92, 8'h92, 8'hB6, 8'h92, 8'h92, 8'h92, 8'h92, 8'hB6, 8'h92, 8'h92, 8'h92, 8'h92, 8'hB6, 8'hB7, 8'hB7, 8'h92, 8'h72, 8'h72, 8'h92, 8'hB7, 8'hFF },
{8'hFF, 8'hFF, 8'h92, 8'h96, 8'h92, 8'h92, 8'hB6, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'hB6, 8'h92, 8'h92, 8'h96, 8'h92, 8'hFF, 8'hFF },
{8'hFF, 8'h92, 8'hB7, 8'hB7, 8'hB7, 8'h92, 8'hB6, 8'hB6, 8'h92, 8'hB7, 8'hB7, 8'hB7, 8'hB7, 8'hB6, 8'h92, 8'h92, 8'h92, 8'h92, 8'hB6, 8'hB7, 8'hB7, 8'hB7, 8'hB7, 8'h92, 8'hB6, 8'hB6, 8'h92, 8'hB7, 8'hB7, 8'hB7, 8'h92, 8'hFF },
{8'hFF, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'h92, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF }
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
			RGBout <= object_colors[offsetY][offsetX];	
		else 
			RGBout <= TRANSPARENT_ENCODING ; // force color to transparent so it will not be displayed 
	end 
end

//======--------------------------------------------------------------------------------------------------------------=
// decide if to draw the pixel or not 
assign drawingRequest = (RGBout != TRANSPARENT_ENCODING ) ? 1'b1 : 1'b0 ; // get optional transparent command from the bitmpap   

endmodule
