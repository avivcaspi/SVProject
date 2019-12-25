module random 	
 ( 
	input	logic  clk,
	input	logic  resetN, 
	input	logic	 rise,
	input logic  keyPressed,
	output logic [SIZE_BITS-1:0] dout	
  ) ;

// Generating a random number by latching a fast counter with the rising edge of an input ( e.g. key pressed )
  
parameter INITIAL = 0;
parameter SIZE_BITS = 8;
parameter MIN_VAL = 0;  //set the min and max values 
parameter MAX_VAL = 479;
parameter KEY_MAX = 1;

	logic [SIZE_BITS-1:0] counter;
	logic rise_d;
	int flag = 0;
	int keyCounter = 0;
	
always_ff @(posedge clk or negedge resetN) begin
		if (!resetN) begin
			dout <= INITIAL;
			counter <= MIN_VAL;
			rise_d <= 1'b0;
			keyCounter <= 0;
		end
		
		else begin
			counter <= counter + 1;
			if ( counter > MAX_VAL ) 
				counter <=  MIN_VAL ; // set min and max mvalues 
			rise_d <= rise;
			if (rise && !rise_d) // rising edge 
				flag <= 1;
			if (flag == 1 && keyPressed == 1'b1) begin
				keyCounter++;
				if (keyCounter == KEY_MAX) begin
					dout <= counter;
					flag <= 0;
					keyCounter <= 0;
				end
			end
		end
	
	end
 
endmodule

