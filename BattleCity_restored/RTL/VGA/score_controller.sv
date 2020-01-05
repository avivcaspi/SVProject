// control the score of the game
// checks for collisions and bonus to determine the score of each player

module score_controller	(	
					input	logic	clk,
					input	logic	resetN,
					input logic countEn,
					input logic one_sec,
					input logic collisionTank1Missle2,
					input logic collisionTank2Missle1,
					input logic collisionTank1Buff1,
					input logic collisionTank2Buff1,
					input logic collisionTank1Buff2,
					input logic collisionTank2Buff2,
					input logic collisionTank1Buff3,
					input logic collisionTank2Buff3,
					input logic collisionTank1Buff4,
					input logic collisionTank2Buff4,
					input logic tank1Bonus,
					input logic tank2Bonus,
					output logic [3:0] tank1Digit1,
					output logic [3:0] tank1Digit2,
					output logic [3:0] tank2Digit1,
					output logic [3:0] tank2Digit2,	
					output logic tank1Win,
					output logic tank2Win,
					output logic tank1Lose,
					output logic tank2Lose,
					output logic tank1Shield,
					output logic tank2Shield
					
);

localparam int WIN_SCORE = 61;
localparam int LOSE_SCORE = 3; //Blocking percentage
localparam int START_SCORE = 25;
localparam int HIT_SCORE = 4;
localparam int BONUS = 10;
localparam int BUFF_1_SCORE = 3;
localparam int BUFF_2_SCORE = 2;
localparam int BUFF_3_SCORE = 4;
localparam int BUFF_4_SCORE = 5;
localparam int TANK_COOLDOWN = 2;
localparam int TANK_IMMUNITY = 10;
int tank1Score = START_SCORE;
int tank2Score = START_SCORE;
// flags to avoid double scoring
int flag_missle1 = 0;
int flag_missle2 = 0;
int flag_buff11 = 0;
int flag_buff12 = 0;
int flag_buff21 = 0;
int flag_buff22 = 0;
int flag_buff31 = 0;
int flag_buff32 = 0;
int flag_immunity1 = 0;
int flag_immunity2 = 0;
int flag_bonus1 = 0;
int flag_bonus2 = 0;
int counter_tank1 = 0;
int counter_tank2 = 0;
int counter_tank1Immunity = 0;
int counter_tank2Immunity = 0;
int point_cooldown1 = 0;
int point_cooldown2 = 0;

assign tank1Digit1 = tank1Score / 10;
assign tank1Digit2 = tank1Score % 10;
assign tank2Digit1 = tank2Score / 10;
assign tank2Digit2 = tank2Score % 10;
assign tank1Shield = flag_missle1 || flag_immunity1;
assign tank2Shield = flag_missle2 || flag_immunity2;

always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
			tank1Win <= 0;
			tank2Win <= 0;
			tank1Lose <= 0;
			tank2Lose <= 0;
			tank1Score <= START_SCORE;
			tank2Score <= START_SCORE;
	end
	else begin
		//Check if anyone won or lost
		if (tank1Score >= WIN_SCORE) begin
			tank1Win <= 1'b1;
		end
		else if (tank2Score >= WIN_SCORE) begin
			tank2Win <= 1'b1;
		end
		else if (tank1Score <= LOSE_SCORE) begin
			tank1Lose <= 1'b1;
		end
		else if (tank2Score <= LOSE_SCORE) begin
			tank2Lose <= 1'b1;
		end
		else if (countEn) begin //no-one won/lost
			if (flag_missle1) begin
				if(one_sec) begin
					if(counter_tank1 == TANK_COOLDOWN) begin
						counter_tank1 <= 0;
						flag_missle1 <= 0;
					end
					else begin
						counter_tank1 <= counter_tank1 + 1;
					end
				end
			end
			else if (collisionTank1Missle2 && flag_immunity1 == 1'b0) begin
				tank1Score <= tank1Score - HIT_SCORE;
				flag_missle1 <= 1;
			end
			if (flag_missle2) begin
				if(one_sec) begin
					if(counter_tank2 == TANK_COOLDOWN) begin
						counter_tank2 <= 0;
						flag_missle2 <= 0;
					end
					else begin
						counter_tank2 <= counter_tank2 + 1;
					end
				end
			end
			else if (collisionTank2Missle1 && flag_immunity2 == 1'b0) begin
				tank2Score <= tank2Score - HIT_SCORE;
				flag_missle2 <= 1;
			end
			if (point_cooldown1) begin
				if(one_sec) begin
					point_cooldown1 <= 0;
				end
			end
			else begin
				if (collisionTank1Buff1 && flag_buff11 == 0) begin
				tank1Score <= tank1Score + BUFF_1_SCORE;
				flag_buff11 <= 1;
				point_cooldown1 <= 1;
				end
				else begin
					flag_buff11 <= 0;
				end
				if (collisionTank1Buff2 && flag_buff21 == 0) begin
					tank1Score <= tank1Score + BUFF_2_SCORE;
					flag_buff21 <= 1;
					point_cooldown1 <= 1;
				end
				else begin
					flag_buff21 <= 0;
				end
				if (collisionTank1Buff3 && flag_buff31 == 0) begin
					tank1Score <= tank1Score + BUFF_3_SCORE;
					flag_buff31 <= 1;
					point_cooldown1 <= 1;
				end
				else begin
					flag_buff31 <= 0;
				end
			end
			
			if (flag_immunity1) begin
				if(one_sec) begin
					if(counter_tank1Immunity == TANK_IMMUNITY) begin
						counter_tank1Immunity <= 0;
						flag_immunity1 <= 0;
					end
					else begin
						counter_tank1Immunity <= counter_tank1Immunity + 1;
					end
				end
			end
			else if (collisionTank1Buff4 ) begin
				flag_immunity1 <= 1;
			end
			
			if (point_cooldown2) begin
				if(one_sec) begin
					point_cooldown2 <= 0;
				end
			end
			else begin
				if (collisionTank2Buff1 && flag_buff12 == 0) begin
					tank2Score <= tank2Score + BUFF_1_SCORE;
					flag_buff12 <= 1;
					point_cooldown2 <= 1;

				end
				else begin
					flag_buff12 <= 0;
				end
				if (collisionTank2Buff2 && flag_buff22 == 0) begin
					tank2Score <= tank2Score + BUFF_2_SCORE;
					flag_buff22 <= 1;
					point_cooldown2 <= 1;
				end
				else begin
					flag_buff22 <= 0;
				end
				if (collisionTank2Buff3 && flag_buff32 == 0) begin
					tank2Score <= tank2Score + BUFF_3_SCORE;
					flag_buff32 <= 1;
					point_cooldown2 <= 1;
				end
				else begin
					flag_buff32 <= 0;
				end
			end
			
			if (flag_immunity2) begin
				if(one_sec) begin
					if(counter_tank2Immunity == TANK_IMMUNITY) begin
						counter_tank2Immunity <= 0;
						flag_immunity2 <= 0;
					end
					else begin
						counter_tank2Immunity <= counter_tank2Immunity + 1;
					end
				end
			end
			else if (collisionTank2Buff4 ) begin
				flag_immunity2 <= 1;
			end
			if (tank1Bonus && flag_bonus1 == 0) begin
				tank1Score <= tank1Score + BONUS;
				flag_bonus1 <= 1;
			end
			else begin
				flag_bonus1 <= 0;
			end
			if (tank2Bonus && flag_bonus2 == 0) begin
				tank2Score <= tank2Score + BONUS;
				flag_bonus2 <= 1;
			end
			else begin
				flag_bonus2 <= 0;
			end
		end
	end
end


endmodule
