
module game_controller 	(
	input logic clk, 
	input logic resetN,
	input logic enterPressed, // signal to start the game
	input logic tank1Win,	//signals about tanks scores
	input logic tank2Win,
	input logic tank1Lose,
	input logic tank2Lose,
	input logic one_sec,
	
	output logic hideMap,
	output logic runEn,
	output logic randomPick,
	output logic pickMap,
	output logic showEnd, 
	output logic [3:0] counter_tens,
	output logic [3:0] counter_ones);
	

	enum logic [2:0] {sidle, srandom_pick, srun, schange, send} cur_st, nxt_st;
	
	const int MIN_SECONDS = 60;  // time untill we change map
	int clockCount = 0;
	int minFlag = 0;
	assign counter_tens = clockCount / 10; //for 7SEG 
	assign counter_ones = clockCount % 10;
	
// Counter to determine 1 min //////////////////
always_ff @(posedge clk or negedge resetN) 
   begin
	   
   if ( !resetN ) begin  // Asynchronic reset
		clockCount <= 0;
		minFlag <= 0;
	end 
		
   else begin // Synchronic logic
		if (one_sec) begin
			if (cur_st == srun) begin
				if (clockCount < MIN_SECONDS ) begin
					clockCount <= clockCount + 1;
					end
				else begin
					clockCount <= 0;
					minFlag <= 1;
					end 
			end
		end
		else 
			minFlag <= 0;
	end // synch
end // always time counter ///////////////////////////////////////////	

	
always_ff @(posedge clk or negedge resetN) // State machine logic ////
   begin
	   
   if ( !resetN ) begin // Asynchronic reset
		cur_st <= sidle;
		end // asynch
	else begin 				// Synchronic logic	
		cur_st <= nxt_st; // Update current state
		end 
		
end // always state machine //////////////////////////////////////////

	
always_comb // Update the next state  ////////////////////////////////
	begin
		nxt_st = cur_st;	// Set default values
		

		case (cur_st)
		
			sidle: begin
				if (enterPressed) //pressing enter will change state 
					nxt_st = srandom_pick;
				end // sidle
				
			srandom_pick: begin //picking random map
				nxt_st = srun;
				
				end // srandom_pick
				
			srun: begin //the game is running until someone win or 1 min has passed
				if(tank1Win || tank2Win || tank1Lose || tank2Lose) 
					nxt_st = send;
				else if(minFlag)
					nxt_st = schange;
				
				end // srun
				
			schange: begin //changing map
				
				nxt_st = srun;
				
				end // schange
				
			send: begin	//end screen
				nxt_st = send;
				
				end // send
		
		endcase
end // always next state ///////////////////////////////


always_comb // Update the outputs //////////////////////
   begin
	
	hideMap = 1'b0; //defaults values
	runEn = 1'b0; 
	pickMap = 1'b0;
	showEnd = 1'b0;
	randomPick = 1'b0;
	
	case (cur_st)
				
		sidle: begin
			hideMap = 1'b1;
			end // sidle
				
		srandom_pick: begin
			hideMap = 1'b1;
			randomPick = 1'b1;
			
			end // srandom_pick
			
		srun: begin
			runEn = 1'b1;
			end // srun
			
		schange: begin
			hideMap = 1'b1;
			pickMap = 1'b1;
			end // schange
			
		send: begin
			showEnd = 1'b1;
			end // send
	
	endcase
end // always outputs //////////////////////////////
	
endmodule

