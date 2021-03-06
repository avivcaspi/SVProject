localparam  int OBJECT_HEIGHT_Y = 25;
localparam  int OBJECT_WIDTH_X = 25;

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors = {
{8'hBE, 8'hBA, 8'h24, 8'h49, 8'hBE, 8'h96, 8'h24, 8'h4D, 8'hDF, 8'h96, 8'h24, 8'h6D, 8'hDF, 8'h71, 8'h04, 8'h92, 8'hDF, 8'h6D, 8'h24, 8'h96, 8'hBE, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hBE, 8'h9A, 8'h00, 8'h24, 8'hBE, 8'h96, 8'h00, 8'h29, 8'hBE, 8'h72, 8'h00, 8'h4D, 8'hBF, 8'h71, 8'h-3.200000e+01, 8'h71, 8'hBF, 8'h49, 8'h00, 8'h96, 8'hBE, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h2D, 8'h29, 8'h00, 8'h04, 8'h2D, 8'h09, 8'h00, 8'h04, 8'h2D, 8'h09, 8'h00, 8'h04, 8'h2D, 8'h04, 8'h00, 8'h09, 8'h2D, 8'h04, 8'h00, 8'h09, 8'h2D, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h09, 8'h09, 8'h24, 8'h24, 8'h0D, 8'h09, 8'h24, 8'h24, 8'h0D, 8'h09, 8'h24, 8'h28, 8'h0D, 8'h29, 8'h24, 8'h29, 8'h0D, 8'h24, 8'h24, 8'h09, 8'h09, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h09, 8'h2D, 8'hBA, 8'hBE, 8'hBE, 8'hBE, 8'hBA, 8'hBA, 8'hBE, 8'hBA, 8'hBA, 8'hBA, 8'hBE, 8'hBA, 8'hBA, 8'hBA, 8'hBE, 8'hBA, 8'hBE, 8'h2D, 8'h09, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h29, 8'h2D, 8'hBA, 8'hBA, 8'h9A, 8'hBA, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBA, 8'hBA, 8'hBE, 8'h51, 8'h09, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h09, 8'h2D, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h2D, 8'h51, 8'h9A, 8'h9A, 8'h9A, 8'h9A, 8'h9A, 8'h9A, 8'h9A, 8'hBA, 8'hBE, 8'hBA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hBA, 8'hBE, 8'hDF, 8'h9A, 8'h09, 8'h09, 8'h09, 8'h09, 8'h09, 8'h09, 8'h09, 8'h72, 8'hDF, 8'h4D, 8'h-3.200000e+01, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hBA, 8'hBE, 8'h9A, 8'h76, 8'h51, 8'h51, 8'h51, 8'h51, 8'h51, 8'h2D, 8'h09, 8'h51, 8'h9A, 8'h4D, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hBE, 8'hBA, 8'h09, 8'h2D, 8'hBE, 8'hBE, 8'hDF, 8'hDF, 8'hDF, 8'h76, 8'h09, 8'h09, 8'h09, 8'h04, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h76, 8'h76, 8'h09, 8'h2D, 8'hBE, 8'hBA, 8'h76, 8'h76, 8'h76, 8'h4D, 8'h04, 8'h09, 8'h09, 8'h2D, 8'h4D, 8'hB6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h09, 8'h09, 8'h09, 8'h2D, 8'hDF, 8'h9A, 8'h09, 8'h09, 8'h09, 8'h04, 8'h00, 8'h04, 8'h09, 8'h76, 8'hE3, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE, 8'hBE },
{8'hFF, 8'hFF, 8'h09, 8'h09, 8'h09, 8'h2D, 8'h76, 8'h51, 8'h04, 8'h04, 8'h04, 8'h04, 8'h00, 8'h04, 8'h09, 8'h4D, 8'h71, 8'hBA, 8'hDF, 8'hDF, 8'hDF, 8'hDF, 8'hDF, 8'hDF, 8'hDF },
{8'hFF, 8'hFF, 8'h09, 8'h09, 8'h09, 8'h09, 8'h09, 8'h04, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h09, 8'h09, 8'h04, 8'h04, 8'h09, 8'h09, 8'h04, 8'h04, 8'h04, 8'h04, 8'h04, 8'h09, 8'h09, 8'h04, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h09, 8'h09, 8'h00, 8'h04, 8'h09, 8'h09, 8'h09, 8'h09, 8'h09, 8'h09, 8'h09, 8'h09, 8'h09, 8'h04, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h00, 8'h00, 8'h04, 8'h04, 8'h04, 8'h04, 8'h04, 8'h04, 8'h04, 8'h04, 8'h04, 8'h4D, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h92, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hDF, 8'hBA, 8'h49, 8'h29, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h24, 8'h49, 8'h49, 8'h49, 8'h49, 8'h49, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hBE, 8'hBA, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h2D, 8'h2D, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h04, 8'h09, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h09, 8'h09, 8'h00, 8'h04, 8'h09, 8'h09, 8'h00, 8'h04, 8'h09, 8'h08, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h08, 8'h09, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h09, 8'h09, 8'h00, 8'h04, 8'h09, 8'h09, 8'h00, 8'h04, 8'h09, 8'h08, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h08, 8'h09, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'h09, 8'h09, 8'h00, 8'h04, 8'h09, 8'h09, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h04, 8'h09, 8'h04, 8'h00, 8'h08, 8'h09, 8'hFF, 8'hFF, 8'hFF, 8'hFF }
};

wire [7:0] red_sig, green_sig, blue_sig;
assign red_sig     = {object_colors[offsetY][offsetX][7:5] , 5'd0};
assign green_sig   = {object_colors[offsetY][offsetX][4:2] , 5'd0};
assign blue_sig    = {object_colors[offsetY][offsetX][1:0] , 6'd0};


