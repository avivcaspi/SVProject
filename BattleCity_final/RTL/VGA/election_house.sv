
module	election_house	(	
					input		logic	clk,
					input		logic	resetN,
					input 	logic	[10:0] pixelX,// current VGA pixel 
					input 	logic	[10:0] pixelY,
					input 	logic [10:0] matrixTopLeftX,
					input		logic [10:0] matrixTopLeftY,
					
					output 	logic	[10:0] offsetX,// offset inside bracket from top left position 
					output 	logic	[10:0] offsetY,
					output	logic	drawingRequest, // indicates pixel inside the bracket
					output	logic	[7:0]	 RGBout //optional color output for mux 
);

parameter  int INDEX_X = 9;
parameter  int INDEX_Y = 7;
parameter  int OBJECT_WIDTH_X = 32;
parameter  int OBJECT_HEIGHT_Y = 32;
parameter  logic [7:0] OBJECT_COLOR_BORDERS = 8'hF0 ; 
parameter  logic [7:0] OBJECT_COLOR = 8'h00 ; 
localparam logic [7:0] TRANSPARENT_ENCODING = 8'hFF ;// bitmap  representation for a transparent pixel 
 
int topLeftX;
int topLeftY;
int rightX ; //coordinates of the sides  
int bottomY ;
logic insideBracket ; 

//======--------------------------------------------------------------------------------------------------------------=
// Calculate object right  & bottom  boundaries
assign topLeftX	= (INDEX_X * 32 + matrixTopLeftX);
assign topLeftY	= (INDEX_Y * 32 + matrixTopLeftY);
assign rightX = topLeftX + OBJECT_WIDTH_X;
assign bottomY = topLeftY + OBJECT_HEIGHT_Y;


//======--------------------------------------------------------------------------------------------------------------=
always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
		RGBout			<=	8'b0;
		drawingRequest	<=	1'b0;
	end
	else begin 
	
		insideBracket  = 	 ( (pixelX  >= topLeftX) &&  (pixelX < rightX) // ----- LEGAL BLOCKING ASSINGMENT in ALWAYS_FF CODE 
						   && (pixelY  >= topLeftY) &&  (pixelY < bottomY) )  ; 
		
		if (insideBracket ) // test if it is inside the rectangle 
		begin 
			drawingRequest <= 1'b1 ;
			offsetX	<= (pixelX - topLeftX); //calculate relative offsets from top left corner
			offsetY	<= (pixelY - topLeftY);
			RGBout  <= OBJECT_COLOR ;
				
			
		end 
		
		else begin  
			RGBout <= TRANSPARENT_ENCODING ; // so it will not be displayed 
			drawingRequest <= 1'b0 ;// transparent color 
			offsetX	<= 0; //no offset
			offsetY	<= 0; //no offset
		end 
		
	end
end 
endmodule 