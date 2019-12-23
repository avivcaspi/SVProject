localparam  int OBJECT_HEIGHT_Y = 32;
localparam  int OBJECT_WIDTH_X = 32;

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors = {
{8'hC4, 8'hC5, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hA4, 8'hA4, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC5, 8'hC4, 8'hA4, 8'hA4, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hA4, 8'hA4 },
{8'hC4, 8'hA4, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hA4, 8'hA4, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC4, 8'hA4, 8'hA4, 8'hA4, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC4, 8'hA4 },
{8'hC4, 8'hA4, 8'hF6, 8'hF6, 8'hFB, 8'hFB, 8'hFB, 8'hFB, 8'hF2, 8'hED, 8'hED, 8'hF2, 8'hF6, 8'hF6, 8'hF6, 8'hF6, 8'hF6, 8'hF6, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hED, 8'hF6, 8'hF6, 8'hF6, 8'hF6, 8'hC9, 8'hC5 },
{8'hC4, 8'hC4, 8'hF6, 8'hFB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hFA, 8'hFB, 8'hFB, 8'hFB, 8'hFB, 8'hFA, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hFA, 8'hFB, 8'hFB, 8'hF6, 8'hC9, 8'hC9 },
{8'hC9, 8'hC9, 8'hFB, 8'hFF, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF6, 8'hF6, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hE9, 8'hED, 8'hF2, 8'hFA, 8'hF6, 8'hC9, 8'hC9 },
{8'hC9, 8'hC9, 8'hFB, 8'hFF, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hFA, 8'hFA, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hFA, 8'hF6, 8'hC9, 8'hC9 },
{8'hC9, 8'hC9, 8'hFB, 8'hFF, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF6, 8'hF6, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hA4, 8'hA4 },
{8'hC9, 8'hC9, 8'hFB, 8'hFF, 8'hED, 8'hED, 8'hED, 8'hED, 8'hFA, 8'hFA, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hED, 8'hA4, 8'hA0 },
{8'hC9, 8'hC9, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hA4, 8'hA4 },
{8'hC9, 8'hC9, 8'hED, 8'hF2, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hED, 8'hC4, 8'hA4 },
{8'hC5, 8'hC4, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hC9, 8'hC9, 8'hA4, 8'hA4 },
{8'hC4, 8'hC4, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hC9, 8'hC5, 8'hA4, 8'hA4 },
{8'hC9, 8'hC9, 8'hF6, 8'hFA, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hA4, 8'hA0 },
{8'hC9, 8'hC9, 8'hF6, 8'hFB, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hA4, 8'hA4 },
{8'hC9, 8'hC9, 8'hF6, 8'hFB, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hA4, 8'hC4 },
{8'hC9, 8'hC9, 8'hF6, 8'hFA, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hC9, 8'hA4, 8'hC4 },
{8'hC9, 8'hC9, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hC9, 8'hE9, 8'hED, 8'hE9, 8'hA4, 8'hC4 },
{8'hC9, 8'hC9, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hA4, 8'hC4 },
{8'hC5, 8'hC4, 8'hED, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hA4, 8'hA4 },
{8'hC4, 8'hA4, 8'hED, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hA4, 8'hA4 },
{8'hC4, 8'hA4, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hA0, 8'hA4 },
{8'hC4, 8'hA4, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hA0, 8'hA4 },
{8'hC4, 8'hA4, 8'hC9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hA0, 8'hA4 },
{8'hC4, 8'hA4, 8'hC9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hA4, 8'hA4 },
{8'hA4, 8'hA0, 8'hC9, 8'hE9, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hED, 8'hE9, 8'hA4, 8'hC4 },
{8'hA4, 8'hA0, 8'hC9, 8'hE9, 8'hED, 8'hED, 8'hF2, 8'hF2, 8'hF2, 8'hF2, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hC4, 8'hC5 },
{8'hA4, 8'hA0, 8'hC5, 8'hC9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hC9, 8'hE9, 8'hED, 8'hED, 8'hC9, 8'hC9 },
{8'hA4, 8'hA0, 8'hC9, 8'hC9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hC9, 8'hC9 },
{8'hA9, 8'hA0, 8'hC9, 8'hE9, 8'hC9, 8'hC9, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hE9, 8'hE9, 8'hE9, 8'hE9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hED, 8'hC9, 8'hC9 },
{8'hC9, 8'hA0, 8'hC9, 8'hC9, 8'hC9, 8'hC5, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hE9, 8'hED, 8'hED, 8'hE9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hED, 8'hED, 8'hED, 8'hED, 8'hF2, 8'hED, 8'hC9, 8'hC9 },
{8'hC9, 8'hA0, 8'hA0, 8'hA0, 8'hA0, 8'hA0, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA0, 8'hA0, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hC4, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9 },
{8'hCD, 8'hC9, 8'hC9, 8'hC9, 8'hA4, 8'hA4, 8'hC4, 8'hC4, 8'hC4, 8'hC4, 8'hC4, 8'hC4, 8'hC4, 8'hC4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hC4, 8'hA4, 8'hA4, 8'hA4, 8'hA4, 8'hC4, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9, 8'hC9 }
};

wire [7:0] red_sig, green_sig, blue_sig;
assign red_sig     = {object_colors[offsetY][offsetX][7:5] , 5'd0};
assign green_sig   = {object_colors[offsetY][offsetX][4:2] , 5'd0};
assign blue_sig    = {object_colors[offsetY][offsetX][1:0] , 6'd0};


