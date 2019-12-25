//-- Alex Grinshpun Apr 2017
//-- Dudy Nov 13 2017
// System-Verilog Alex Grinshpun May 2018
// New coding convention dudy December 2018
// (c) Technion IIT, Department of Electrical Engineering  May 2019 

module	objects_mux	(
//		--------	Clock Input		
					input		logic	clk,
					input		logic	resetN,
		// tank 
					input		logic	tank1DrawingRequest, // two set of inputs per unit
					input		logic	[7:0] tank1RGB,
					input		logic	tank2DrawingRequest, // two set of inputs per unit
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
		if (missle1DrawingRequest == 1'b1)
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
		
		else
			tmpRGB <= backGroundRGB ; // last priority 
		end ; 
	end

endmodule


