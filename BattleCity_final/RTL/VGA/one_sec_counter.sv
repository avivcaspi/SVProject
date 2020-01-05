// (c) Technion IIT, Department of Electrical Engineering 2018 

// Implements a slow clock as an one-second counter with
// a one-secound output pulse and a 0.5 Hz duty50 output
// Turbo input sets both outputs 10 times faster
 // Alex Grinshpun Oct 2018
module one_sec_counter      	
	(
   // Input, Output Ports
	input  logic clk, 
	input  logic resetN, 
	input  logic turbo,
	output logic one_sec, 
	output logic duty50
   );
	
	int oneSecVal ; //
	//int oneSecValTurbo ; 
	int oneSecCount ;
	int sec ;


always_comb
begin
// Don't modify the numbers, as soon as you run Modelsim. all will be fine. belive me
	oneSecVal = 26'd50_000_000;
// synthesis translate_off
	//oneSecVal = 32; //smaller parameter for simulation
// synthesis translate_on
	
	if (turbo) 
		sec = oneSecVal / 16 ;
	else
		sec = oneSecVal;
	
end
	
   always_ff @( posedge clk or negedge resetN )
   begin
		
      // Asynchronic reset
      if ( !resetN ) begin
			one_sec <= 1'b0;
			duty50 <= 1'b0;
			oneSecCount <= 26'd0;
		end //asynch
		// Synchronic logic	
      else begin
				if (oneSecCount >= sec) begin
					one_sec <= 1'b1;
					duty50 <= ~duty50;
					oneSecCount <= 0;
				end
				else begin
					oneSecCount <= oneSecCount + 1;
					one_sec		<= 1'b0;
				end
		end //synch
	end // always
endmodule