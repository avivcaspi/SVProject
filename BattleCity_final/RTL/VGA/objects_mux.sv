//-- Alex Grinshpun Apr 2017
//-- Dudy Nov 13 2017
// System-Verilog Alex Grinshpun May 2018
// New coding convention dudy December 2018
// (c) Technion IIT, Department of Electrical Engineering  May 2019 

module	objects_mux	(
//		--------	Clock Input		
					input		logic	clk,
					input		logic	resetN,
					input 	logic hideMap,
					input 	logic showEnd,
		// tank 
					input		logic	tank1DrawingRequest, 
					input		logic	[7:0] tank1RGB,
					input		logic	tank2DrawingRequest, 
					input		logic	[7:0] tank2RGB, 
		// brick
					input 	logic brickDrawingRequest,
					input 	logic [7:0] brickRGB,	
					
		// missle
					input 	logic missle1DrawingRequest,
					input 	logic [7:0] missle1RGB,
					input 	logic missle2DrawingRequest,
					input 	logic [7:0] missle2RGB,
					
		// buffs
					input		logic buff1DrawingRequest,
					input		logic [7:0] buff1RGB,
					input		logic buff2DrawingRequest,
					input		logic [7:0] buff2RGB,
					input		logic buff3DrawingRequest,
					input		logic [7:0] buff3RGB,
					input		logic buff4DrawingRequest,
					input		logic [7:0] buff4RGB,
					
		// election house 
					input 	logic electionDrawingRequest,
					input		logic [7:0] electionRGB,
					
		// digits
					input		logic digit1DrawingRequest,
					input 	logic [7:0] digit1RGB,
					input		logic digit2DrawingRequest,
					input 	logic [7:0] digit2RGB,
					input		logic digit3DrawingRequest,
					input 	logic [7:0] digit3RGB,
					input		logic digit4DrawingRequest,
					input 	logic [7:0] digit4RGB,

										
		// right-side images and data
					input		logic buildDrawingRequest,
					input 	logic [7:0] buildRGB,
					input		logic p1DrawingRequest,
					input 	logic [7:0] p1RGB,
					input		logic p2DrawingRequest,
					input 	logic [7:0] p2RGB,
					
		// open game screen
					input		logic openDrawingRequest,
					input 	logic [7:0] openRGB,
					
		// end game screen
					input 	logic finallyDrawingRequest,
					input 	logic [7:0] finallyRGB,
					input 	logic didDrawingRequest,
					input 	logic [7:0] didRGB,
					input 	logic winnerDrawingRequest,
					input 	logic [7:0] winnerRGB,
					
		// background 
					input		logic	[7:0] backGroundRGB, 

					output	logic	[7:0] redOut, // full 24 bits color output
					output	logic	[7:0] greenOut, 
					output	logic	[7:0] blueOut 
);

logic [7:0] tmpRGB;


assign redOut	  = {tmpRGB[7:5], {5{tmpRGB[5]}}}; //--  extend LSB to create 10 bits per color  
assign greenOut  = {tmpRGB[4:2], {5{tmpRGB[2]}}};
assign blueOut	  = {tmpRGB[1:0], {6{tmpRGB[0]}}};

//======--------------------------------------------------------------------------------------------------------------=
always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
			tmpRGB	<= 8'b0;
	end
	else begin
		if (hideMap == 1'b0) begin //map is shown
			if(winnerDrawingRequest == 1'b1 && showEnd)
				tmpRGB <= winnerRGB;
			else if(didDrawingRequest == 1'b1 && showEnd)
				tmpRGB <= didRGB;
			else if(finallyDrawingRequest == 1'b1 && showEnd)
				tmpRGB <= finallyRGB;
			
			else if (missle1DrawingRequest == 1'b1)
				tmpRGB <= missle1RGB;
			
			else if (tank1DrawingRequest == 1'b1 )   
				tmpRGB <= tank1RGB;  
				
			else if (missle2DrawingRequest == 1'b1)
				tmpRGB <= missle2RGB;
			
			else if (tank2DrawingRequest == 1'b1 )   
				tmpRGB <= tank2RGB;  
			
			else if (brickDrawingRequest == 1'b1)
				tmpRGB <= brickRGB;
			else if (electionDrawingRequest == 1'b1 )   
				tmpRGB <= electionRGB;
			else if (buff1DrawingRequest == 1'b1 )   
				tmpRGB <= buff1RGB;
			else if (buff2DrawingRequest == 1'b1 )   
				tmpRGB <= buff2RGB;
			else if (buff3DrawingRequest == 1'b1 )   
				tmpRGB <= buff3RGB;
			else if (buff4DrawingRequest == 1'b1 )   
				tmpRGB <= buff4RGB;
			
			else if (digit1DrawingRequest == 1'b1)
				tmpRGB <= digit1RGB;
			else if (digit2DrawingRequest == 1'b1)
				tmpRGB <= digit2RGB;
			else if (digit3DrawingRequest == 1'b1)
				tmpRGB <= digit3RGB;
			else if (digit4DrawingRequest == 1'b1)
				tmpRGB <= digit4RGB;
			else if (buildDrawingRequest == 1'b1) 
				tmpRGB <= buildRGB;
			else if (p1DrawingRequest == 1'b1)
				tmpRGB <= p1RGB;
			else if (p2DrawingRequest == 1'b1)
				tmpRGB <= p2RGB;
		
			else
				tmpRGB <= backGroundRGB ; // last priority 
			 
		end
		else begin // map is hiden (begining or end of game)
				if (openDrawingRequest == 1'b1)
					tmpRGB <= openRGB;
				else
				tmpRGB <= backGroundRGB ;
		end
	end
end

endmodule


