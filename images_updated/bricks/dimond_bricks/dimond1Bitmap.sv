localparam  int OBJECT_HEIGHT_Y = 32;
localparam  int OBJECT_WIDTH_X = 32;

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors = {
{8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1F, 8'h1F, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h1A, 8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1F, 8'h1A, 8'h1A, 8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h16, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1A, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1F, 8'h1A, 8'h1A, 8'h1B, 8'h1F, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1F, 8'h1F, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1F, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1F, 8'h1F, 8'h1A, 8'h16, 8'h1F, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h16, 8'h16, 8'h1F, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h16, 8'h16, 8'h1F, 8'h1F, 8'h16, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h1A, 8'h1B, 8'h1F, 8'h1A, 8'h1A },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h1F, 8'h1F, 8'h16, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h1A },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1F, 8'h1F, 8'h16, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h16 },
{8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h16, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h16, 8'h1B, 8'h1F, 8'h1A, 8'h16 },
{8'h1A, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h16, 8'h16, 8'h1F, 8'h1F, 8'h1A, 8'h16, 8'h1F, 8'h1F, 8'h1A, 8'h16 },
{8'h1A, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h1F, 8'h1F, 8'h1A, 8'h16, 8'h1F, 8'h1F, 8'h1A, 8'h16 },
{8'h1A, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h16, 8'h16, 8'h1F, 8'h1F, 8'h1A, 8'h16 },
{8'h1A, 8'h1B, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h16, 8'h16, 8'h1F, 8'h1F, 8'h16, 8'h16 },
{8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h16, 8'h16, 8'h1F, 8'h1F, 8'h16, 8'h16 },
{8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h1F, 8'h1F, 8'h16, 8'h16 },
{8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1F, 8'h1F, 8'h16, 8'h16 },
{8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1B, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h1F, 8'h16, 8'h16 },
{8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h16, 8'h16 },
{8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h1A, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16, 8'h16 }
};

wire [7:0] red_sig, green_sig, blue_sig;
assign red_sig     = {object_colors[offsetY][offsetX][7:5] , 5'd0};
assign green_sig   = {object_colors[offsetY][offsetX][4:2] , 5'd0};
assign blue_sig    = {object_colors[offsetY][offsetX][1:0] , 6'd0};


