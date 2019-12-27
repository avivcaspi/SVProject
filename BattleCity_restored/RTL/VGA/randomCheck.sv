

module randomCheck	(	
					input	logic	clk,
					input	logic	resetN,
					input logic one_sec,
					input logic [10:0] matrixTopLeftX,
					input logic [10:0] matrixTopLeftY,
					input logic [4:0] inRandomX,
					input logic [3:0] inRandomY,
					input logic collision,
					input logic randomRise,
					
					output logic newRandom,
					output logic [10:0] randomX,
					output logic [10:0] randomY,
					output logic drawEn
);


parameter int maxCounter = 15;
int flag = 0;
int randX = 0;
int randY = 0;
int counter = 0;

assign randomX = randX * 32 + matrixTopLeftX + 3;
assign randomY = randY * 32 + matrixTopLeftY + 3;


always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
			newRandom <= 1'b0;
			drawEn <= 1'b0;
			randX <= 4;
			randY <= 4;
			flag <= 0;
			counter <= 0;
			
	end
	else begin
		if (counter == maxCounter) begin
			drawEn <= 1'b0;
			flag <= 0;
			counter <= 0;
		end
		else begin
			if (randomRise == 1'b1 && flag == 0) begin
				flag <= 1;
				randX <= inRandomX;
				randY <= inRandomY;
			end
			if (collision == 1'b1) begin
				drawEn <= 1'b0;
				flag <= 0;
				counter <= 0;
			end
			else if ( flag == 1) begin
				drawEn <= 1'b1;
				if(one_sec == 1'b1) begin
					counter++;
				end
			end
		end
	end
end

endmodule
