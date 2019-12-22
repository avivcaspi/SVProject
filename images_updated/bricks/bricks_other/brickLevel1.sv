localparam  int OBJECT_HEIGHT_Y = 32;
localparam  int OBJECT_WIDTH_X = 32;

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors = {
{8'hD5, 8'hD6, 8'hB1, 8'h8D, 8'hB1, 8'hB1, 8'hD5, 8'hD6, 8'hD6, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'h8D, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'h91, 8'h69, 8'h69, 8'hD5, 8'hD6, 8'hB5, 8'h8D, 8'hD5, 8'hD5, 8'hD5 },
{8'hD5, 8'hD6, 8'hD5, 8'h91, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hB1, 8'h91, 8'hD5, 8'hD6, 8'hB1, 8'h69, 8'h69, 8'h69, 8'hB1, 8'hB1, 8'h8D, 8'h6D, 8'h6D, 8'h91, 8'h8D, 8'h8D, 8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'hD5, 8'hD5, 8'hD5 },
{8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD5, 8'h8D, 8'hD6, 8'hB1, 8'h8D, 8'h69, 8'hB1, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'h6D, 8'hD5, 8'hDA, 8'hD5, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hB1 },
{8'hD5, 8'hD5, 8'hD6, 8'h91, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'h69, 8'h8D, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hD5, 8'hD6, 8'hB5, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'h8D },
{8'hD5, 8'hD5, 8'hD6, 8'hB1, 8'h8D, 8'hB1, 8'h91, 8'hB1, 8'hD5, 8'hD6, 8'h8D, 8'hB1, 8'hD6, 8'hD5, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hB5, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'h8D, 8'h8D },
{8'hB5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hD5, 8'hD5, 8'hB5, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hB5, 8'h8D, 8'h8D, 8'hD5, 8'hD5, 8'hB5, 8'h69, 8'h91, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hB1, 8'h6D },
{8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'h6D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'hD5, 8'hB1, 8'h8D, 8'h8D, 8'h91, 8'h8D, 8'hB1, 8'hD5, 8'hB1, 8'h8D, 8'h91, 8'h8D, 8'hB1, 8'hD6, 8'hD5, 8'hD6, 8'h6D },
{8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'h8D, 8'h8D, 8'h8D, 8'hB1, 8'hD6, 8'hD5, 8'h91, 8'hB1, 8'h8D, 8'hB5, 8'hD6, 8'hB5, 8'h69, 8'h8D, 8'hB1, 8'hB1, 8'h6D },
{8'h8D, 8'h8D, 8'h8D, 8'hB1, 8'hB5, 8'h8D, 8'hD5, 8'hB1, 8'h69, 8'h6D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h69, 8'h8D, 8'hB5, 8'hD5, 8'hD6, 8'hD6, 8'hD5, 8'hD6, 8'h8D, 8'h8D, 8'hD5, 8'hD5, 8'hDA, 8'h91, 8'hB1, 8'hB5, 8'h8D, 8'h6D },
{8'hB1, 8'h6D, 8'hB1, 8'hD5, 8'hD5, 8'h6D, 8'h8D, 8'h8D, 8'hB1, 8'h6D, 8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'h6D, 8'h8D, 8'hD5, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'h8D, 8'h8D, 8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'hD5, 8'hDA, 8'hD6, 8'h8D },
{8'hD5, 8'h8D, 8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'h8D, 8'hB1, 8'hD5, 8'hB1, 8'h6D, 8'hD5, 8'hD5, 8'h8D, 8'hB5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'h91, 8'hD6, 8'hD6, 8'hD6, 8'h8D },
{8'hD5, 8'h8D, 8'hD5, 8'hD5, 8'hD6, 8'h91, 8'hB1, 8'hD1, 8'hD5, 8'hB1, 8'h8D, 8'hB5, 8'hB1, 8'hB1, 8'hD6, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB5, 8'h69, 8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hD6, 8'hD6, 8'hD6, 8'h8D },
{8'hD6, 8'h8D, 8'hB1, 8'hD5, 8'hD6, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'h8D, 8'h8D, 8'h8D, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'h8D, 8'hB1, 8'h8D, 8'hB1, 8'hB1, 8'h8D, 8'hD5, 8'hD6, 8'hD6, 8'hB5, 8'h8D },
{8'hD5, 8'h91, 8'h8D, 8'hD5, 8'hD6, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD6, 8'hB1, 8'h69, 8'hB1, 8'hD5, 8'hD5, 8'h8D, 8'h69, 8'h8D, 8'h8D, 8'h69, 8'h8D, 8'hD5, 8'hFA, 8'h8D, 8'h8D, 8'h8D, 8'h69, 8'h8D, 8'hD5, 8'hD6, 8'hB1, 8'hB1 },
{8'hD5, 8'hD5, 8'h8D, 8'hB5, 8'hD5, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'h8D, 8'hD5, 8'hB1, 8'h6D, 8'hB1, 8'h8D, 8'h8D, 8'hB1, 8'hD5, 8'hD6, 8'hFA, 8'h8D, 8'hB1, 8'hDA, 8'hD5, 8'h6D, 8'h8D, 8'hB1, 8'h8D, 8'hB1 },
{8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'hB1, 8'h8D, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hB1, 8'h8D, 8'h6D, 8'h8D, 8'hD5, 8'hD5, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'hB1, 8'h8D, 8'hB1 },
{8'hD5, 8'hD6, 8'hB1, 8'h69, 8'h8D, 8'h8D, 8'h69, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hDA, 8'hD5, 8'h8D, 8'h8D, 8'hD5, 8'hD5, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hB1, 8'hB1 },
{8'hD5, 8'hB1, 8'h8D, 8'hB1, 8'hD6, 8'hD5, 8'h8D, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hFA, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h91, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1 },
{8'h8D, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'h69, 8'hB1, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hD6, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'h69, 8'h69, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1 },
{8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hFA, 8'h91, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hB1, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'h69, 8'h8D, 8'hD5, 8'hB1, 8'h6D, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hB1 },
{8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hDA, 8'hD6, 8'h6D, 8'hB1, 8'hB1, 8'hD5, 8'hD6, 8'hD6, 8'h6D, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'h91, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'h8D },
{8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hDA, 8'hB1, 8'h6D, 8'h8D, 8'hD5, 8'hD5, 8'h8D, 8'h8D, 8'h8D, 8'hB1, 8'hB1, 8'hD5, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'h8D, 8'h8D, 8'hB1, 8'hB1, 8'h8D, 8'h8D },
{8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hB1, 8'hD6, 8'h6D, 8'h8D, 8'h8D, 8'h8D, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'h6D, 8'h8D, 8'hB1, 8'hB1, 8'hB1 },
{8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'hD6, 8'h8D, 8'h8D, 8'h8D, 8'hB1, 8'hD6, 8'hB1, 8'h8D, 8'hB1, 8'h69, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD6 },
{8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD5, 8'hD6, 8'h8D, 8'hB1, 8'hD6, 8'hD5, 8'hD5, 8'hD6, 8'h8D, 8'h69, 8'h8D, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'h6D, 8'hB1, 8'hD5, 8'hD6, 8'hD5, 8'hD5, 8'hD6 },
{8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'hB5, 8'hB1, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hB1, 8'h49, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hD5, 8'hD6 },
{8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hB5, 8'h69, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB5, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hD5 },
{8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'hD1, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'h69, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h6D, 8'hB1, 8'hB5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hB5 },
{8'h6D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'hB1, 8'h6D, 8'h8D, 8'h8D, 8'h91, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'h91, 8'h8D, 8'hD5, 8'hD6, 8'hD5, 8'hD6, 8'hD6, 8'hD5 },
{8'h8D, 8'h69, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD6, 8'hD6, 8'hD5, 8'hD6 },
{8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hB1, 8'h8D, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5 },
{8'hD5, 8'hB1, 8'h69, 8'h8D, 8'hD5, 8'hB1, 8'h6D, 8'hD5, 8'hD5, 8'hB1, 8'hD5, 8'hD6, 8'h8D, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'h8D, 8'h8D, 8'hD5, 8'hB1, 8'hB1, 8'hB1, 8'h8D, 8'h69, 8'hB1, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h8D }
};

wire [7:0] red_sig, green_sig, blue_sig;
assign red_sig     = {object_colors[offsetY][offsetX][7:5] , 5'd0};
assign green_sig   = {object_colors[offsetY][offsetX][4:2] , 5'd0};
assign blue_sig    = {object_colors[offsetY][offsetX][1:0] , 6'd0};


