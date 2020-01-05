//-- Alex Grinshpun Apr 2017
//-- Dudy Nov 13 2017
// System-Verilog version Alex Grinshpun May 2018
// coding convention dudy December 2018
// (c) Technion IIT, Department of Electrical Engineering 2019 


module	back_ground_draw	(	

					input	logic	clk,
					input	logic	resetN,
					input 	logic	[10:0]	pixelX,
					input 	logic	[10:0]	pixelY,

					output	logic	[7:0]	BG_RGB
);

const int	xFrameSize	=	639;
const int	yFrameSize	=	479;
const int	bracketOffset =	16;

logic [2:0] redBits;
logic [2:0] greenBits;
logic [1:0] blueBits;

localparam logic [2:0] DARK_COLOR = 3'b111 ;// bitmap of a dark color
localparam logic [2:0] LIGHT_COLOR = 3'b000 ;// bitmap of a light color

assign BG_RGB =  {redBits , greenBits , blueBits} ; //collect color nibbles to an 8 bit word 

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
				redBits <= DARK_COLOR ;	
				greenBits <= DARK_COLOR  ;	
				blueBits <= DARK_COLOR ;	 
	end 
	else begin
	
	// defaults 
		greenBits <= 3'b101 ; 
		redBits <= 3'b101 ;
		blueBits <= 3'b11;
					
		// draw  four lines with "bracketOffset" offset from the border 
		
		if (pixelX == bracketOffset ||
						pixelY == bracketOffset - 1 ||
						pixelX == 545 + bracketOffset|| 
						pixelY == 449 + bracketOffset) 
			begin 
					redBits <= DARK_COLOR ;	
					greenBits <= DARK_COLOR  ;	
					blueBits <= DARK_COLOR ;	 
			end	 	   
		
		if (pixelX > bracketOffset &&
						pixelY > bracketOffset - 1 &&
						pixelX <= 544 + bracketOffset&& 
						pixelY <= 448 + bracketOffset) 
			begin 
					redBits <= LIGHT_COLOR ;	
					greenBits <= LIGHT_COLOR  ;	
					blueBits <= LIGHT_COLOR ;	 
			end	 	
	end; 	
end 

endmodule

