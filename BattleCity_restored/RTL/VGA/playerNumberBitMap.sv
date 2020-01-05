//
// coding convention dudy December 2018
// (c) Technion IIT, Department of Electrical Engineering 2019 
// generating a number bitmap 

module PlayerNumberBitMap	(	
					input		logic	clk,
					input		logic	resetN,
					input 	logic	[10:0] offsetX,// offset from top left  position 
					input 	logic	[10:0] offsetY,
					input		logic	InsideRectangle, //input that the pixel is within a bracket 
					input 	logic	index, // the digit's index to display
					
					output	logic				drawingRequest, //output that the pixel should be dispalyed 
					output	logic	[7:0]		RGBout
);

parameter  logic	[7:0] digit_color = 8'hff ; //set the color of the digit 


bit [0:1] [0:31] [0:33] number_bitmap  = {

																	
{34'b	0111111111111100000000000011100000,
34'b	1111111111111110000000000111100000,
34'b	1111000000011111000000011111100000,
34'b	1110000000001111000000111111100000,
34'b	1110000000000111000001111111100000,
34'b	1110000000000111000011111111100000,
34'b	1110000000000111000111111011100000,
34'b	1110000000000111000111100011100000,
34'b	1110000000000111000111000011100000,
34'b	1110000000000111000010000011100000,
34'b	1110000000000111000000000011100000,
34'b	1110000000000111000000000011100000,
34'b	1110000000000111000000000011100000,
34'b	1111100000001111000000000011100000,
34'b	1111111111111111000000000011100000,
34'b	1111111111111110000000000011100000,
34'b	1111000000000000000000000011100000,
34'b	1110000000000000000000000011100000,
34'b	1110000000000000000000000011100000,
34'b	1110000000000000000000000011100000,
34'b	1110000000000000000000000011100000,
34'b	1110000000000000000000000011100000,
34'b	1110000000000000000000000011100000,
34'b	1110000000000000000000000011100000,
34'b	1110000000000000000000000011100000,
34'b	1110000000000000000000000011100000,
34'b	1110000000000000000000000011100000,
34'b	1110000000000000000000000011100000,
34'b	1110000000000000000111111111111111,
34'b	1110000000000000000111111111111111,
34'b	1110000000000000000111111111111111,
34'b	1110000000000000000111111111111111},
																	
{34'b	0111111111111100000000111111100000,
34'b	1111111111111110000001111111110000,
34'b	1111000000011111000111111111111000,
34'b	1110000000001111001111111111111000,
34'b	1110000000000111001111110011111100,
34'b	1110000000000111001111000011111100,
34'b	1110000000000111001110000001111110,
34'b	1110000000000111000000000000111110,
34'b	1110000000000111000000000000111110,
34'b	1110000000000111000000000000111110,
34'b	1110000000000111000000000000111100,
34'b	1110000000000111000000000001111100,
34'b	1110000000000111000000000001111100,
34'b	1111100000001111000000000001111000,
34'b	1111111111111111000000000011111000,
34'b	1111111111111110000000000011111000,
34'b	1111000000000000000000000011111000,
34'b	1110000000000000000000000011110000,
34'b	1110000000000000000000000011100000,
34'b	1110000000000000000000000111000000,
34'b	1110000000000000000000001111000000,
34'b	1110000000000000000000011110000000,
34'b	1110000000000000000000111100000000,
34'b	1110000000000000000001111100000000,
34'b	1110000000000000000001111100000000,
34'b	1110000000000000000011111000000000,
34'b	1110000000000000000111110000000001,
34'b	1110000000000000001111100000000011,
34'b	1110000000000000001111111111111111,
34'b	1110000000000000001111111111111111,
34'b	1110000000000000001111111111111111,
34'b	1110000000000000001111111111111111},
																	



} ; 
																	

// pipeline (ff) to get the pixel color from the array 	 

always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
		drawingRequest <=	1'b0;
	end
	else begin
			drawingRequest <= (number_bitmap[index][offsetY][offsetX]) && (InsideRectangle == 1'b1 );	//get value from bitmap  
	end 
end

assign RGBout = digit_color ; // this is a fixed color 

endmodule