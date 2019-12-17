

module game_controller	(	
					input	logic	clk,
					input	logic	resetN,
					input logic [10:0] tankTopLeftX,
					input logic [10:0] tankTopLeftY,
					input logic brickDrawingRequest,
					input logic missleDrawingRequest,
					input logic [10:0] missleTopLeftX,
					input logic [10:0] missleTopLeftY,
					input logic [0:9][9:0] brickMatrix,
					input logic [10:0] matrixTopLeftX,
					input logic [10:0] matrixTopLeftY,
					output logic collision,	//brick tank collision
					output logic collision1	//missle brick collision
);

parameter int BRICK_WIDTH = 32;
parameter int BRICK_HEIGHT = 32;
parameter int tankWidth = 32;
parameter int tankHeight = 32;
parameter int missleWidth = 10;
parameter int missleHeight = 10;
parameter int screenLeft = 64;
parameter int screenRight = 576;
parameter int screenTop = 32;
parameter int screenBottom = 416;
int tankOffsetX;
int tankOffsetY;
int tankMatrixOffsetX;
int tankMatrixOffsetY;
int reminderRight;
int reminderBottom;

assign tankOffsetX =  tankTopLeftX - matrixTopLeftX;
assign tankOffsetY = tankTopLeftY - matrixTopLeftY;
assign tankMatrixOffsetX = tankOffsetX / BRICK_WIDTH;
assign tankMatrixOffsetY = tankOffsetY / BRICK_HEIGHT;
assign reminderRight = tankOffsetX % BRICK_WIDTH;
assign reminderBottom = tankOffsetY % BRICK_HEIGHT;

always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
			collision	<= 1'b0;
			collision1 	<= 1'b0;
	end
	else begin
		//Check tank1 collision with bricks
		if (brickMatrix[tankMatrixOffsetY][tankMatrixOffsetX])
				collision <= 1'b1;
		else if(reminderRight > 0 && brickMatrix[tankMatrixOffsetY][tankMatrixOffsetX + 1]) begin
			collision <= 1'b1;
		end
		else if (reminderBottom > 0 && brickMatrix[tankMatrixOffsetY + 1][tankMatrixOffsetX]) begin	
			collision <= 1'b1;
		end
		else if (reminderBottom > 0 && reminderRight > 0 && brickMatrix[tankMatrixOffsetY+ 1][tankMatrixOffsetX + 1]) begin
			collision <= 1'b1;
		end
		else	begin
				collision <= 1'b0;
		end
		
		// Check missle1 collision with end screen and brick collision 
		if (missleTopLeftX < screenLeft || missleTopLeftX + missleWidth > screenRight || missleTopLeftY < screenTop || missleTopLeftY + missleHeight > screenBottom || (brickDrawingRequest && missleDrawingRequest)) begin
			collision1 <= 1'b1;
		end
		else
			collision1 <= 1'b0;
	end
end

endmodule
