//-- Alex Grinshpun Apr 2017
//-- Dudy Nov 13 2017
// System-Verilog Alex Grinshpun May 2018
// New coding convention dudy December 2018
// (c) Technion IIT, Department of Electrical Engineering 2019 


module	bricks_matrix	(	
					input		logic	clk,
					input		logic	resetN,
					input 	logic	[10:0] pixelX,// current VGA pixel 
					input 	logic	[10:0] pixelY,
					input 	logic [10:0] topLeftX,
					input 	logic [10:0] topLeftY,
					input 	logic [4:0] brickCollision1X,
					input 	logic [3:0] brickCollision1Y,
					input 	logic collision,
					
					output 	logic	[10:0] offsetX,// offset inside bracket from top left position 
					output 	logic	[10:0] offsetY,
					output	logic	drawingRequest, // indicates pixel inside the bracket
					output	logic	[7:0]	 RGBout, //optional color output for mux  	
					output 	logic [13:0][16:0] matrix,
					output 	logic [2:0]	brickNum
);

parameter  int BLOCK_WIDTH = 32;
parameter  int BLOCK_HEIGHT = 32;
parameter  int blocksPerRow = 17;
parameter  int blocksPerColumn = 14;
localparam  int OBJECT_WIDTH_X = BLOCK_WIDTH * blocksPerRow;
localparam  int OBJECT_HEIGHT_Y = BLOCK_HEIGHT * blocksPerColumn;

parameter  logic [7:0] OBJECT_COLOR = 8'h5b ; 
localparam logic [7:0] TRANSPARENT_ENCODING = 8'hFF ;// bitmap  representation for a transparent pixel 
							
int rightX ; //coordinates of the sides  
int bottomY ;
logic insideBracket ; 
int matrixX;
int matrixY;
int flag;
logic [0:13] [0:16] [2:0] bricks_matrix;

//======--------------------------------------------------------------------------------------------------------------=
// Calculate object right  & bottom  boundaries
assign rightX	= (topLeftX + OBJECT_WIDTH_X);
assign bottomY	= (topLeftY + OBJECT_HEIGHT_Y);
assign matrixX = (pixelX - topLeftX) / 32;
assign matrixY = (pixelY - topLeftY) / 32;
assign brickNum = bricks_matrix[matrixY][matrixX];


//======--------------------------------------------------------------------------------------------------------------=
always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
		bricks_matrix = {
{3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h3 },
{3'h0, 3'h1, 3'h0, 3'h2, 3'h0, 3'h1, 3'h1, 3'h0, 3'h1, 3'h1, 3'h1, 3'h1, 3'h1, 3'h0, 3'h0, 3'h0, 3'h0 },
{3'h0, 3'h1, 3'h0, 3'h2, 3'h0, 3'h3, 3'h1, 3'h0, 3'h0, 3'h0, 3'h0, 3'h2, 3'h2, 3'h0, 3'h0, 3'h0, 3'h0 },
{3'h0, 3'h1, 3'h0, 3'h2, 3'h0, 3'h3, 3'h3, 3'h0, 3'h0, 3'h0, 3'h0, 3'h2, 3'h2, 3'h0, 3'h0, 3'h0, 3'h0 },
{3'h0, 3'h1, 3'h0, 3'h2, 3'h0, 3'h3, 3'h1, 3'h2, 3'h0, 3'h0, 3'h0, 3'h2, 3'h2, 3'h0, 3'h0, 3'h0, 3'h0 },
{3'h0, 3'h1, 3'h0, 3'h2, 3'h0, 3'h3, 3'h3, 3'h1, 3'h0, 3'h0, 3'h0, 3'h2, 3'h2, 3'h0, 3'h0, 3'h0, 3'h0 },
{3'h0, 3'h1, 3'h0, 3'h2, 3'h0, 3'h3, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h2, 3'h2, 3'h0, 3'h0, 3'h0, 3'h0 },
{3'h0, 3'h1, 3'h0, 3'h2, 3'h0, 3'h3, 3'h3, 3'h2, 3'h0, 3'h0, 3'h0, 3'h2, 3'h2, 3'h0, 3'h0, 3'h0, 3'h0 },
{3'h0, 3'h1, 3'h0, 3'h2, 3'h0, 3'h3, 3'h1, 3'h0, 3'h0, 3'h0, 3'h0, 3'h2, 3'h2, 3'h0, 3'h0, 3'h0, 3'h0 },
{3'h0, 3'h1, 3'h0, 3'h2, 3'h0, 3'h3, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h2, 3'h0, 3'h0, 3'h0, 3'h0 },
{3'h0, 3'h1, 3'h0, 3'h2, 3'h0, 3'h3, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h2, 3'h0, 3'h0, 3'h0, 3'h0 },
{3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h2, 3'h0, 3'h0, 3'h0, 3'h0 },
{3'h1, 3'h0, 3'h0, 3'h0, 3'h0, 3'h1, 3'h1, 3'h1, 3'h1, 3'h1, 3'h1, 3'h1, 3'h1, 3'h0, 3'h0, 3'h0, 3'h0 },
{3'h2, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h1 }};
		for (int i = 0; i < blocksPerColumn; i++) begin
			for( int j = 0; j < blocksPerRow; j++) begin
				case(bricks_matrix[i][j])
				3'b000: matrix[i][j] = 1'b0;
				default: matrix[i][j] = 1'b1;
				endcase
			end
		end
		flag <= 0;
	end
	else begin 
		if (collision == 1'b1 && flag == 0) begin
			flag <= 1;
			case (bricks_matrix[brickCollision1Y][brickCollision1X])
				3'b001: begin 
								bricks_matrix[brickCollision1Y][brickCollision1X] <= 3'b000;
								matrix[brickCollision1Y][brickCollision1X] <= 1'b0;
						  end
				3'b010: bricks_matrix[brickCollision1Y][brickCollision1X] <= 3'b001;
				3'b011: bricks_matrix[brickCollision1Y][brickCollision1X] <= 3'b010;
			endcase
		end
		else if (collision == 1'b0) begin
			flag <= 0;
		end
		
	end
end 
//======--------------------------------------------------------------------------------------------------------------=
always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
		RGBout			<=	8'b0;
		drawingRequest	<=	1'b0;
		
	end
	else begin 
	
//		if ( (pixelX  >= topLeftX) &&  (pixelX < rightX) 
//			&& (pixelY  >= topLeftY) &&  (pixelY < bottomY) ) // test if it is inside the rectangle 

		//this is an example of using blocking sentence inside an always_ff block, 
		//and not waiting a clock to use the result  
		insideBracket  = 	 ( (pixelX  >= topLeftX) &&  (pixelX < rightX) // ----- LEGAL BLOCKING ASSINGMENT in ALWAYS_FF CODE 
						   && (pixelY  >= topLeftY) &&  (pixelY < bottomY) )  ; 
		
		if (insideBracket ) // test if it is inside the rectangle 
		begin 
			RGBout  <= OBJECT_COLOR ;	// colors table 
			if (bricks_matrix[matrixY][matrixX] > 3'b0) begin
				drawingRequest <= 1'b1;
			end
			else 
				drawingRequest <= 1'b0;
			offsetX	<= (pixelX - topLeftX) % 32; //calculate relative offsets from top left corner
			offsetY	<= (pixelY - topLeftY) % 32;
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