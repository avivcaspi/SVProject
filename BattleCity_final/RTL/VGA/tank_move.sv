
module	tank_move	(	
 
					input	logic	clk,
					input	logic	resetN,
					input	logic	startOfFrame,  // short pulse every start of frame 30Hz 
					input logic brickCollision,	// collisions signals
					input logic missleCollision,
					input logic tankCollision,
					input logic [3:0] inputKeyPressed,
					input logic runEn,		//enable the tank to move
					input logic resetPos,	//reset the position of the tank
					output	logic	[10:0]	topLeftX,// output the top left corner 
					output	logic	[10:0]	topLeftY,
					output 	logic [1:0] 	tankDir	//tank firing direction
					
);

parameter int INITIAL_X = 280;
parameter int INITIAL_Y = 185;
parameter int INITIAL_X_SPEED = 0;
parameter int INITIAL_Y_SPEED = 0;
parameter int MOVEMENT_X_SPEED = 20;
parameter int MOVEMENT_Y_SPEED = 20;

const int	MULTIPLIER	=	64;

int Xspeed, topLeftX_tmp; // local parameters 
int Yspeed, topLeftY_tmp;
int flag;		// collision flag
int lastSpeedX;
int lastSpeedY;


//  calculation x Axis speed 

//======--------------------------------------------------------------------------------------------------------------=
always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
		Xspeed	<= INITIAL_X_SPEED;
	end
	else 	begin
		// allows only one key pressed at a time
		if(brickCollision == 1'b0 &&  tankCollision == 1'b0) begin
			if(inputKeyPressed[2] ^ inputKeyPressed[3] && !inputKeyPressed[0] && !inputKeyPressed[1]) begin
				if(inputKeyPressed[2]) begin
					Xspeed <= -MOVEMENT_X_SPEED;
					
				end
				else begin
					Xspeed <= MOVEMENT_X_SPEED;
				end
			end
			else 
				Xspeed <= 0;
		end
	end
end


//  calculation Y Axis speed using gravity

//======--------------------------------------------------------------------------------------------------------------=
always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin 
		Yspeed	<= INITIAL_Y_SPEED;
	end 
	else 	begin
	// allows only one key pressed at a time
		if(brickCollision == 1'b0 &&  tankCollision == 1'b0) begin
			if(inputKeyPressed[0] ^ inputKeyPressed[1] && !inputKeyPressed[2] && !inputKeyPressed[3]) begin
				if(inputKeyPressed[0]) begin
					Yspeed <= MOVEMENT_Y_SPEED;
				end
				else begin
					Yspeed <= -MOVEMENT_Y_SPEED;
				end
			end
			else
				Yspeed <= 0;
		end
	end
end

// position calculate 

//======--------------------------------------------------------------------------------------------------------------=
always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN)
	begin
		topLeftX_tmp	<= INITIAL_X * MULTIPLIER;
		topLeftY_tmp	<= INITIAL_Y * MULTIPLIER;
		lastSpeedY <= INITIAL_Y_SPEED;
		lastSpeedX <= INITIAL_X_SPEED;
		flag <= 0;
		tankDir <= 2'b01; //right 
	end
	else begin
		if (runEn) begin
				// handling tank and brick collision (should stop the tank)
			if((brickCollision == 1'b1 || tankCollision == 1'b1) && flag == 0) begin
				topLeftX_tmp  <= topLeftX_tmp - lastSpeedX; 	
				topLeftY_tmp  <= topLeftY_tmp - lastSpeedY; 
				flag <= 1;
			end
			
			else if (startOfFrame == 1'b1) begin // perform only 30 times per second 
					topLeftX_tmp  <= topLeftX_tmp + Xspeed; 	
					topLeftY_tmp  <= topLeftY_tmp + Yspeed; 
					lastSpeedX <= Xspeed;
					lastSpeedY <= Yspeed;
					flag <= 0;
					
					// determine tank direction
					case (inputKeyPressed)
					4'b0001: tankDir <= 2; //down
					4'b0010: tankDir <= 0;	//up
					4'b0100: tankDir <= 3;	//left
					4'b1000: tankDir <= 1;	//right
					endcase
			end
		end
		else if (resetPos)begin
			topLeftX_tmp	<= INITIAL_X * MULTIPLIER;
			topLeftY_tmp	<= INITIAL_Y * MULTIPLIER;
			lastSpeedY <= INITIAL_Y_SPEED;
			lastSpeedX <= INITIAL_X_SPEED;
			flag <= 0;
			tankDir <= 2'b01; //right 
		end
	end
end



//======--------------------------------------------------------------------------------------------------------------=
//get a better (64 times) resolution using integer   
assign 	topLeftX = topLeftX_tmp / MULTIPLIER ;   // note:  it must be 2^n 
assign 	topLeftY = topLeftY_tmp / MULTIPLIER ;    


endmodule
