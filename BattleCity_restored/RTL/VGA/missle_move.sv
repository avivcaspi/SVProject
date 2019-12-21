//-- Alex Grinshpun Apr 2017
//-- Dudy Nov 13 2017
// System-Verilog Alex Grinshpun May 2018
// New coding convention dudy December 2018


module	missle_move	(	
 
					input	logic	clk,
					input	logic	resetN,
					input	logic	startOfFrame,  // short pulse every start of frame 30Hz 
					input logic collision,
					input logic inputKeyPressed, //shooting key was pressed
					input logic [10:0] tankTopLeftX,
					input logic [10:0] tankTopLeftY,
					input logic [1:0] tankDir,
					output	logic	[10:0]	topLeftX,// output the top left corner 
					output	logic	[10:0]	topLeftY,
					output logic drawEn
);


parameter int INITIAL_X_SPEED = 0;
parameter int INITIAL_Y_SPEED = 0;
parameter int MOVEMENT_X_SPEED = 300;
parameter int MOVEMENT_Y_SPEED = 300;

const int	MULTIPLIER	=	64;
// multiplier is used to work with integers in high resolution 
// we devide at the end by multiplier which must be 2^n 
const int	x_FRAME_SIZE	=	639 * MULTIPLIER;
const int	y_FRAME_SIZE	=	479 * MULTIPLIER;


int Xspeed, topLeftX_tmp; // local parameters 
int Yspeed, topLeftY_tmp;
int flag;
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
		drawEn <= 1'b0;
		flag <= 0;
		topLeftX_tmp	<= tankTopLeftX * MULTIPLIER;
		topLeftY_tmp	<= tankTopLeftY * MULTIPLIER;
	end
	else begin
		if(inputKeyPressed == 1'b1 && flag == 0) begin
			drawEn <= 1'b1;
			flag <= 1;
			topLeftX_tmp <= (tankTopLeftX) * MULTIPLIER;
			topLeftY_tmp <= (tankTopLeftY) * MULTIPLIER;
		end
		if(collision == 1'b1) begin
			drawEn <= 1'b0;
			flag <= 0;
			topLeftX_tmp	<= tankTopLeftX * MULTIPLIER;
			topLeftY_tmp	<= tankTopLeftY * MULTIPLIER;
		end
		else if (startOfFrame == 1'b1 && drawEn == 1'b1) begin // perform only 30 times per second 
				topLeftX_tmp  <= topLeftX_tmp + Xspeed; 	
				topLeftY_tmp  <= topLeftY_tmp + Yspeed; 
		end
	end
end



//======--------------------------------------------------------------------------------------------------------------=
//get a better (64 times) resolution using integer   
assign 	topLeftX = topLeftX_tmp / MULTIPLIER ;   // note:  it must be 2^n 
assign 	topLeftY = topLeftY_tmp / MULTIPLIER ;    


endmodule
