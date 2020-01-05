

module timer	(	
					input	logic	clk,
					input	logic	resetN,
					input logic slowClk,
					
					output logic rise
);

parameter int maxCounter = 5;

int sec_counter = 0;

always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
			rise <= 1'b0;
			sec_counter <= 0;
	end
	else begin
		if (slowClk == 1'b1) begin //perform 30 times per sec
			if (sec_counter == maxCounter) begin
				rise <= 1'b1;
				sec_counter <= 0;
			end
			else begin
				rise <= 0;
				sec_counter++;
			end
			
			
		end
	end
end

endmodule