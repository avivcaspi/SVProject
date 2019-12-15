

module game_controller	(	
					input	logic	clk,
					input	logic	resetN,
					input	logic	drawing_request_tank, 
					input	logic	drawing_request_brick, 
					input logic [10:0] tankTopLeftX,
					input logic [10:0] tankTopLeftY,
					input logic [10:0] brickTopLeftX,
					input logic [10:0] brickTopLeftY,
					output logic collision
);

parameter int BRICK_WIDTH = 32;
parameter int BRICK_HEIGHT = 32;
parameter int tankWidth = 32;
parameter int tankHeight = 32;

always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
			collision	<= 1'b0;
	end
	else begin
		if (tankTopLeftX >= brickTopLeftX && tankTopLeftX <= brickTopLeftX + BRICK_WIDTH
				&& tankTopLeftY >= brickTopLeftY && tankTopLeftY <= brickTopLeftY + BRICK_HEIGHT) begin
				collision <= 1'b1;
				end
		else if (tankTopLeftX + tankWidth >= brickTopLeftX && tankTopLeftX + tankWidth<= brickTopLeftX + BRICK_WIDTH
				&& tankTopLeftY >= brickTopLeftY && tankTopLeftY <= brickTopLeftY + BRICK_HEIGHT) begin
				collision <= 1'b1;
				end
		else if (tankTopLeftX >= brickTopLeftX && tankTopLeftX <= brickTopLeftX + BRICK_WIDTH
				&& tankTopLeftY + tankHeight >= brickTopLeftY && tankTopLeftY + tankHeight <= brickTopLeftY + BRICK_HEIGHT) begin
				collision <= 1'b1;
				end
		else if (tankTopLeftX + tankWidth >= brickTopLeftX && tankTopLeftX + tankWidth<= brickTopLeftX + BRICK_WIDTH
				&& tankTopLeftY + tankHeight>= brickTopLeftY && tankTopLeftY + tankHeight<= brickTopLeftY + BRICK_HEIGHT) begin
				collision <= 1'b1;
				end
		else 
			collision <= 1'b0;
			
		
	end

end

endmodule
