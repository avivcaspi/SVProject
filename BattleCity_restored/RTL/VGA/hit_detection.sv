

module hit_detection	(	
					input	logic	clk,
					input	logic	resetN,
					input logic tank1DrawingRequest,
					input logic [10:0] tank1TopLeftX,
					input logic [10:0] tank1TopLeftY,
					input logic missle1DrawingRequest,
					input logic [10:0] missle1TopLeftX,
					input logic [10:0] missle1TopLeftY,
					input logic tank2DrawingRequest,
					input logic [10:0] tank2TopLeftX,
					input logic [10:0] tank2TopLeftY,
					input logic missle2DrawingRequest,
					input logic [10:0] missle2TopLeftX,
					input logic [10:0] missle2TopLeftY,
					input logic brickDrawingRequest,
					input logic [0:13][0:16] brickMatrix,
					input logic [10:0] matrixTopLeftX,
					input logic [10:0] matrixTopLeftY,
					input logic [10:0] pixelX,
					input logic [10:0] pixelY,
					output logic collisionTank1BrickWall,	//brick tank1 collision
					output logic collisionMissle1Wall,	//missle1 borders collision
					output logic collisionMissle1Brick, 	//missle1 brick collision
					output logic collisionTank2BrickWall,	//brick tank2 collision
					output logic collisionMissle2Wall,	//missle2 borders collision
					output logic collisionMissle2Brick, 	//missle2 brick collision
					output logic collisionTank1Tank2,	// tank1 tank2 collision
					output logic collisionTank1missle2,	//tank1 missle2 collision
					output logic collisionTank2missle1,	//tank2 missle 1 collision
					output logic collisionMissle1Missle2,	//tank2 missle 1 collision
					output logic [4:0] brickCollisionX,
					output logic [3:0] brickCollisionY
);

parameter int BRICK_WIDTH = 32;
parameter int BRICK_HEIGHT = 32;
parameter int tankWidth = 25;
parameter int tankHeight = 25;
parameter int missleWidth = 10;
parameter int missleHeight = 10;
parameter int screenLeft = 16;
parameter int screenRight = 560;
parameter int screenTop = 16;
parameter int screenBottom = 464;
int tank1OffsetX;
int tank1OffsetY;
int tank1MatrixOffsetX;
int tank1MatrixOffsetY;
int reminderRight1;
int reminderBottom1;
int tank2OffsetX;
int tank2OffsetY;
int tank2MatrixOffsetX;
int tank2MatrixOffsetY;
int reminderRight2;
int reminderBottom2;

assign tank1OffsetX =  tank1TopLeftX - matrixTopLeftX;
assign tank1OffsetY = tank1TopLeftY - matrixTopLeftY;
assign tank1MatrixOffsetX = tank1OffsetX / BRICK_WIDTH;
assign tank1MatrixOffsetY = tank1OffsetY / BRICK_HEIGHT;
assign reminderRight1 = (tank1OffsetX + tankWidth) / BRICK_WIDTH - tank1MatrixOffsetX;
assign reminderBottom1 = (tank1OffsetY + tankHeight) / BRICK_HEIGHT - tank1MatrixOffsetY;
assign tank2OffsetX =  tank2TopLeftX - matrixTopLeftX;
assign tank2OffsetY = tank2TopLeftY - matrixTopLeftY;
assign tank2MatrixOffsetX = tank2OffsetX / BRICK_WIDTH;
assign tank2MatrixOffsetY = tank2OffsetY / BRICK_HEIGHT;
assign reminderRight2 = (tank2OffsetX + tankWidth) / BRICK_WIDTH - tank2MatrixOffsetX;
assign reminderBottom2 = (tank2OffsetY + tankHeight) / BRICK_HEIGHT - tank2MatrixOffsetY;
assign brickCollisionX = (pixelX - matrixTopLeftX) / BRICK_WIDTH;
assign brickCollisionY = (pixelY - matrixTopLeftY) / BRICK_HEIGHT;



always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
			collisionTank1BrickWall	<= 1'b0;
			collisionMissle1Wall 	<= 1'b0;
			collisionMissle1Brick 	<= 1'b0;
			collisionTank2BrickWall	<= 1'b0;
			collisionMissle2Wall 	<= 1'b0;
			collisionMissle2Brick 	<= 1'b0;
	end
	else begin
		//Check tank1 collision with bricks
		if (brickMatrix[tank1MatrixOffsetY][tank1MatrixOffsetX])
				collisionTank1BrickWall <= 1'b1;
		else if(reminderRight1 > 0 && brickMatrix[tank1MatrixOffsetY][tank1MatrixOffsetX + 1]) begin
			collisionTank1BrickWall <= 1'b1;
		end
		else if (reminderBottom1 > 0 && brickMatrix[tank1MatrixOffsetY + 1][tank1MatrixOffsetX]) begin	
			collisionTank1BrickWall <= 1'b1;
		end
		else if (reminderBottom1 > 0 && reminderRight1 > 0 && brickMatrix[tank1MatrixOffsetY+ 1][tank1MatrixOffsetX + 1]) begin
			collisionTank1BrickWall <= 1'b1;
		end
		// Check tank1 collision with end screen 
		else if (tank1TopLeftX < screenLeft || tank1TopLeftX + tankWidth > screenRight || tank1TopLeftY < screenTop || tank1TopLeftY + tankHeight > screenBottom) begin
			collisionTank1BrickWall <= 1'b1;
		end
		else	begin
			collisionTank1BrickWall <= 1'b0;
		end
		
		
		// Check missle1 collision with end screen and brick collision 
		if (missle1TopLeftX < screenLeft || missle1TopLeftX + missleWidth > screenRight || missle1TopLeftY < screenTop || missle1TopLeftY + missleHeight > screenBottom) begin
			collisionMissle1Wall <= 1'b1;
		end
		else begin
			collisionMissle1Wall <= 1'b0;
		end
		if (brickDrawingRequest && missle1DrawingRequest) begin
			collisionMissle1Brick <= 1'b1;
		end
		else begin
			collisionMissle1Brick <= 1'b0;
		end
		
		//Check tank2 collision with bricks
		if (brickMatrix[tank2MatrixOffsetY][tank2MatrixOffsetX])
				collisionTank2BrickWall <= 1'b1;
		else if(reminderRight2 > 0 && brickMatrix[tank2MatrixOffsetY][tank2MatrixOffsetX + 1]) begin
			collisionTank2BrickWall <= 1'b1;
		end
		else if (reminderBottom2 > 0 && brickMatrix[tank2MatrixOffsetY + 1][tank2MatrixOffsetX]) begin	
			collisionTank2BrickWall <= 1'b1;
		end
		else if (reminderBottom2 > 0 && reminderRight2 > 0 && brickMatrix[tank2MatrixOffsetY+ 1][tank2MatrixOffsetX + 1]) begin
			collisionTank2BrickWall <= 1'b1;
		end
		// Check tank2 collision with end screen 
		else if (tank2TopLeftX < screenLeft || tank2TopLeftX + tankWidth > screenRight || tank2TopLeftY < screenTop || tank2TopLeftY + tankHeight > screenBottom) begin
			collisionTank2BrickWall <= 1'b1;
		end
		else	begin
			collisionTank2BrickWall <= 1'b0;
		end
		
		
		// Check missle2 collision with end screen and brick collision 
		if (missle2TopLeftX < screenLeft || missle2TopLeftX + missleWidth > screenRight || missle2TopLeftY < screenTop || missle2TopLeftY + missleHeight > screenBottom) begin
			collisionMissle2Wall <= 1'b1;
		end
		else begin
			collisionMissle2Wall <= 1'b0;
		end
		if (brickDrawingRequest && missle2DrawingRequest) begin
			collisionMissle2Brick <= 1'b1;
		end
		else begin
			collisionMissle2Brick <= 1'b0;
		end
		
		// check tank1 tank2 collision
		if (tank1DrawingRequest && tank2DrawingRequest) begin
			collisionTank1Tank2 <= 1'b1;
		end
		else begin
			collisionTank1Tank2 <= 1'b0;
		end
		
		// check tank1 missle 2 collision
		if (tank1DrawingRequest && missle2DrawingRequest) begin
			collisionTank1missle2 <= 1'b1;
		end
		else begin
			collisionTank1missle2 <= 1'b0;
		end
		
		// check tank2 missle 1 collision
		if (tank2DrawingRequest && missle1DrawingRequest) begin
			collisionTank2missle1 <= 1'b1;
		end
		else begin
			collisionTank2missle1 <= 1'b0;
		end
		
		// check missle1 missle2 collision
		if (missle1DrawingRequest && missle2DrawingRequest) begin
			collisionMissle1Missle2 <= 1'b1;
		end
		else begin
			collisionMissle1Missle2 <= 1'b0;
		end
	end
end

endmodule
