

module election_house_counter	(	
					input	logic	clk,
					input	logic	resetN,
					input logic start_of_frame,
					input logic collisionTank1Election,
					input logic collisionTank2Election,
					
					output logic tank1Bonus,
					output logic tank2Bonus,
					output logic coolingDown
);


parameter int maxCounter = 5;
parameter int coolDown = 20;
const int sof_sec = 30;
int coolDownInSOF = coolDown * sof_sec;
int maxCounterInSof = maxCounter * sof_sec;
int tank1Collisionflag = 0;
int tank2Collisionflag = 0;
int sof_counter1 = 0;
int sof_counter2 = 0;
int flag = 0;
int counterCoolDown = 0;

 

always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
			tank1Bonus <= 0;
			tank2Bonus <= 0;
			flag <= 0;
			sof_counter1 <= 0;
			sof_counter2 <= 0;
			coolingDown <= 0;
			
	end
	else begin
		
		if (coolingDown == 0) begin
			if (start_of_frame == 1'b1) begin
				if(tank1Collisionflag == 1) begin
					if(sof_counter1 == maxCounterInSof) begin
						coolingDown <= 1;
						tank1Bonus <= 1;
						sof_counter1 <= 0;
						sof_counter2 <= 0;
					end
					else begin
						sof_counter1 <= sof_counter1 + 1;
					end
					tank1Collisionflag <= 0;
				end
				else begin
					sof_counter1 <= 0;
				end
				if(tank2Collisionflag == 1) begin
					if(sof_counter2 == maxCounterInSof) begin
						coolingDown <= 1;
						tank2Bonus <= 1;
						sof_counter2 <= 0;
						sof_counter1 <= 0;
					end
					else begin
						sof_counter2 <= sof_counter2 + 1;
					end
					tank2Collisionflag <= 0;
				end
				else begin
					sof_counter2 <= 0;
				end
			end
			else begin //start_of_frame == 0
				if (collisionTank1Election == 1'b1) begin
					tank1Collisionflag <= 1;
				end
				if (collisionTank2Election == 1'b1) begin
					tank2Collisionflag <= 1;
				end
			end
		end
		else begin //coolingDown == 1 Cooling Down
			tank1Bonus <= 0;
			tank2Bonus <= 0;
			if (start_of_frame == 1'b1) begin
				if (counterCoolDown == coolDownInSOF) begin
					counterCoolDown <= 0;
					coolingDown <= 0;
				end
				else begin
					counterCoolDown <= counterCoolDown + 1;
				end
			end
		end
	end
end

endmodule
