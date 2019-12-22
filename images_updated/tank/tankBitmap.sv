localparam  int OBJECT_HEIGHT_Y = 25;
localparam  int OBJECT_WIDTH_X = 25;

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors = {
{8'hBE, 8'hBA, 8'h2C, 8'h4D, 8'hBE, 8'h9A, 8'h2C, 8'h51, 8'hBF, 8'h96, 8'h28, 8'h71, 8'hBF, 8'h75, 8'h28, 8'h76, 8'hBF, 8'h51, 8'h28, 8'h9A, 8'hBE, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hBE, 8'h9A, 8'h08, 8'h2C, 8'hBE, 8'h9A, 8'h08, 8'h2D, 8'hBE, 8'h76, 8'h08, 8'h51, 8'hBF, 8'h51, 8'h08, 8'h75, 8'hBF, 8'h51, 8'h08, 8'h76, 8'hBE, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h31, 8'h31, 8'h08, 8'h08, 8'h31, 8'h11, 8'h08, 8'h0C, 8'h31, 8'h11, 8'h08, 8'h0C, 8'h31, 8'h0C, 8'h08, 8'h0C, 8'h31, 8'h0C, 8'h08, 8'h11, 8'h31, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h11, 8'h11, 8'h0C, 8'h0C, 8'h11, 8'h11, 8'h2C, 8'h0C, 8'h11, 8'h11, 8'h2C, 8'h0C, 8'h11, 8'h0D, 8'h2C, 8'h11, 8'h11, 8'h0C, 8'h2C, 8'h11, 8'h11, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h11, 8'h11, 8'h9A, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'h35, 8'h10, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h31, 8'h31, 8'hBE, 8'hBE, 8'h9A, 8'h9E, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'h55, 8'h11, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h11, 8'h35, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hDF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h31, 8'h55, 8'h9A, 8'h9A, 8'h9A, 8'h9A, 8'h9A, 8'h9A, 8'h9A, 8'h9E, 8'hBE, 8'hBA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hBE, 8'hBE, 8'hBF, 8'h9A, 8'h11, 8'h11, 8'h11, 8'h11, 8'h11, 8'h11, 8'h11, 8'h76, 8'hBF, 8'h51, 8'h-2.400000e+01, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hBE, 8'hBE, 8'h9A, 8'h7A, 8'h55, 8'h55, 8'h55, 8'h55, 8'h55, 8'h31, 8'h11, 8'h55, 8'h9A, 8'h51, 8'h08, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hBE, 8'h9E, 8'h11, 8'h35, 8'hBE, 8'hBE, 8'hBF, 8'hBF, 8'hBF, 8'h7A, 8'h11, 8'h11, 8'h11, 8'h0C, 8'h08, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h7A, 8'h76, 8'h11, 8'h35, 8'hBE, 8'h9E, 8'h7A, 8'h7A, 8'h7A, 8'h55, 8'h0C, 8'h11, 8'h11, 8'h31, 8'h51, 8'hBA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h11, 8'h11, 8'h11, 8'h35, 8'hBF, 8'h9A, 8'h11, 8'h11, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h7A, 8'hBF, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE },
{8'hFF, 8'hFF, 8'h11, 8'h11, 8'h11, 8'h31, 8'h7A, 8'h55, 8'h0C, 8'h0C, 8'h0C, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h31, 8'h75, 8'hBA, 8'hDF, 8'hDF, 8'hDF, 8'hDF, 8'hDF, 8'hDF, 8'hDF },
{8'hFF, 8'hFF, 8'h11, 8'h11, 8'h11, 8'h11, 8'h11, 8'h0C, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h11, 8'h11, 8'h0C, 8'h0C, 8'h11, 8'h11, 8'h0C, 8'h0C, 8'h0C, 8'h0C, 8'h0C, 8'h11, 8'h11, 8'h0C, 8'h08, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h11, 8'h10, 8'h08, 8'h0C, 8'h11, 8'h11, 8'h11, 8'h11, 8'h11, 8'h11, 8'h11, 8'h11, 8'h11, 8'h0C, 8'h08, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h08, 8'h08, 8'h0C, 8'h0C, 8'h0C, 8'h0C, 8'h0C, 8'h0C, 8'h0C, 8'h0C, 8'h0C, 8'h51, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h96, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hBF, 8'hBE, 8'h51, 8'h2D, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h2C, 8'h51, 8'h51, 8'h51, 8'h4D, 8'h51, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hBE, 8'h9A, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h35, 8'h31, 8'h08, 8'h08, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h11, 8'h11, 8'h08, 8'h08, 8'h11, 8'h11, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h11, 8'h11, 8'h08, 8'h08, 8'h11, 8'h11, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h11, 8'h11, 8'h08, 8'h08, 8'h11, 8'h11, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'h0C, 8'h08, 8'h0C, 8'h11, 8'hFF, 8'hFF, 8'hFF, 8'hFF }
};

wire [7:0] red_sig, green_sig, blue_sig;
assign red_sig     = {object_colors[offsetY][offsetX][7:5] , 5'd0};
assign green_sig   = {object_colors[offsetY][offsetX][4:2] , 5'd0};
assign blue_sig    = {object_colors[offsetY][offsetX][1:0] , 6'd0};


