
module	missle_move	(	
 
					input	logic	clk,
					input	logic	resetN,
					input	logic	startOfFrame,  // short pulse every start of frame 30Hz 
					input logic collision,
					input logic inputKeyPressed, //shooting key was pressed
					input logic [10:0] tankTopLeftX,
					input logic [10:0] tankTopLeftY,
					input logic [1:0] tankDir,
					input logic runEn,
					output	logic	[10:0]	topLeftX,// output the top left corner 
					output	logic	[10:0]	topLeftY,
					output logic drawEn,
					output logic [1:0] dir
);


parameter int INITIAL_X_SPEED = 0;
parameter int INITIAL_Y_SPEED = 0;
parameter int MOVEMENT_X_SPEED = 300;
parameter int MOVEMENT_Y_SPEED = 300;

const int	MULTIPLIER	=	64;

const int halfTankWidth = 0; // middle index of tank
const int halfTankHeight = 0;

int Xspeed, topLeftX_tmp; // local parameters 
int Yspeed, topLeftY_tmp;
int flag;	// flag that collision happened recently
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
		if(inputKeyPressed && flag == 0) begin
			// determine missle direction according to tank direction
			case (tankDir) 
			2'b00 : Xspeed <= 0; //up
			2'b01 : Xspeed <= MOVEMENT_X_SPEED; // right
			2'b10 : Xspeed <= 0; //down
			2'b11 : Xspeed <= -MOVEMENT_X_SPEED; //left
			default : Xspeed <= MOVEMENT_X_SPEED;
			endcase
		end
		else if (drawEn == 1'b0)
			Xspeed <= 0;
	end
end


//  calculation Y Axis speed 

//======--------------------------------------------------------------------------------------------------------------=
always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin 
		Yspeed	<= INITIAL_Y_SPEED;
	end 
	else 	begin
		if(inputKeyPressed && flag == 0) begin
			case (tankDir) 
			2'b00 : Yspeed <= -MOVEMENT_Y_SPEED; //up
			2'b01 : Yspeed <= 0; // right
			2'b10 : Yspeed <= MOVEMENT_Y_SPEED; //down
			2'b11 : Yspeed <= 0; //left
			default : Yspeed <= 0;
			endcase
		end
		else if (drawEn == 1'b0)
			Yspeed <= 0;
	end
end

// position calculate 

//======--------------------------------------------------------------------------------------------------------------=
always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN)
	begin
		dir <= 2'b00;
		drawEn <= 1'b0;
		flag <= 0;
		topLeftX_tmp	<= tankTopLeftX * MULTIPLIER + halfTankWidth;
		topLeftY_tmp	<= tankTopLeftY * MULTIPLIER + halfTankHeight;
	end
	else begin
		if (runEn) begin
			// firing handling 
			if(inputKeyPressed == 1'b1 && flag == 0) begin 
				dir <= tankDir;
				drawEn <= 1'b1;
				flag <= 1;
				topLeftX_tmp <= tankTopLeftX * MULTIPLIER + halfTankWidth;
				topLeftY_tmp <= tankTopLeftY * MULTIPLIER + halfTankHeight;
			end
			// collision handling
			if(collision == 1'b1) begin
				drawEn <= 1'b0;
				flag <= 0;
				// reset missle location at collision to avoid borders collision problem
				topLeftX_tmp <= tankTopLeftX * MULTIPLIER + halfTankWidth;
				topLeftY_tmp <= tankTopLeftY * MULTIPLIER + halfTankHeight;
			end
			else if (startOfFrame == 1'b1 && drawEn == 1'b1) begin // perform only 30 times per second 
					topLeftX_tmp  <= topLeftX_tmp + Xspeed; 	
					topLeftY_tmp  <= topLeftY_tmp + Yspeed; 
			end
		end
	end
end



//======--------------------------------------------------------------------------------------------------------------=
//get a better (64 times) resolution using integer   
assign 	topLeftX = topLeftX_tmp / MULTIPLIER ;   // note:  it must be 2^n 
assign 	topLeftY = topLeftY_tmp / MULTIPLIER ;    


endmodule
