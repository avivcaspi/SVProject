localparam  int OBJECT_HEIGHT_Y = 32;
localparam  int OBJECT_WIDTH_X = 32;

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors = {
{8'hFE, 8'hD9, 8'h6C, 8'h6C, 8'hD9, 8'hD9, 8'h6C, 8'h6C, 8'hD9, 8'hF9, 8'h6C, 8'h6C, 8'hF9, 8'hD9, 8'h6C, 8'h6C, 8'hF9, 8'hDA, 8'h6C, 8'h6C, 8'hDA, 8'hF9, 8'hF4, 8'hF4, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFE, 8'hDA, 8'h6C, 8'h6C, 8'hFA, 8'hDA, 8'h6C, 8'h6C, 8'hFA, 8'hFA, 8'h6C, 8'h6C, 8'hFA, 8'hDA, 8'h6C, 8'h6C, 8'hFA, 8'hFA, 8'h6C, 8'h6C, 8'hDA, 8'hFA, 8'hF4, 8'hF4, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF5, 8'hD5, 8'h6C, 8'h6C, 8'hD5, 8'hD5, 8'h6C, 8'h6C, 8'hD5, 8'hD5, 8'h6C, 8'h6C, 8'hF5, 8'hD5, 8'h6C, 8'h6C, 8'hD5, 8'hD5, 8'h6C, 8'h6C, 8'hD5, 8'hF5, 8'h90, 8'h90, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF4, 8'hD4, 8'h6C, 8'h6C, 8'hF4, 8'hD4, 8'h6C, 8'h6C, 8'hD4, 8'hD4, 8'h6C, 8'h6C, 8'hD4, 8'hF4, 8'h6C, 8'h6C, 8'hF4, 8'hD4, 8'h6C, 8'h6C, 8'hF4, 8'hD4, 8'h6C, 8'h6C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF4, 8'hD4, 8'h90, 8'h90, 8'hF4, 8'hF4, 8'h8C, 8'h8C, 8'hF4, 8'hF4, 8'h8C, 8'h6C, 8'hF4, 8'hF4, 8'h8C, 8'h8C, 8'hF4, 8'hF4, 8'h8C, 8'h8C, 8'hF4, 8'hD4, 8'h6C, 8'h6C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF4, 8'hF4, 8'hF9, 8'hF9, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF9, 8'hD9, 8'h6C, 8'h6C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF4, 8'hF4, 8'hF9, 8'hF9, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF9, 8'hD9, 8'h6C, 8'h6C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFA, 8'hFA, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hFA, 8'hFA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFE, 8'hFA, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFE, 8'hFA, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hD9, 8'hD9, 8'hD9, 8'hF9, 8'hF9, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hF9, 8'hF9, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFE, 8'hF9, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hD0, 8'h88, 8'h88, 8'h64, 8'hAC, 8'hF4, 8'hF9, 8'hFE, 8'hFE, 8'hF9, 8'hF4, 8'hF4, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFE, 8'hF9, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'h88, 8'h64, 8'h64, 8'h88, 8'hF4, 8'hF9, 8'hFE, 8'hFE, 8'hF9, 8'hF4, 8'hF4, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hF5, 8'hF4, 8'hF4, 8'hF4, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hD1, 8'h64, 8'h64, 8'h64, 8'hD0, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'h91, 8'h91, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hFA, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFA, 8'h88, 8'h64, 8'h64, 8'hAC, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hD4, 8'h6C, 8'h6C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF9, 8'hFA, 8'hF9, 8'hF9, 8'hF9, 8'hF9, 8'hAC, 8'h64, 8'h64, 8'h88, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hD4, 8'h90, 8'h91, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF9, 8'hF9, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'h88, 8'h64, 8'h64, 8'h88, 8'hD4, 8'hF4, 8'hF9, 8'hFE, 8'hFA, 8'hFE, 8'hFE, 8'hFE, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA },
{8'hFF, 8'hFF, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hFA, 8'hFA, 8'hF4, 8'hF4, 8'hF4, 8'hD0, 8'h88, 8'h64, 8'h64, 8'h68, 8'hD4, 8'hF4, 8'hF9, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA },
{8'hFF, 8'hFF, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'h90, 8'h8C, 8'h8C, 8'h8C, 8'h64, 8'h64, 8'h64, 8'h6C, 8'hD4, 8'hF4, 8'hF4, 8'hD4, 8'h90, 8'h90, 8'h90, 8'h91, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hD4, 8'h6C, 8'h4C, 8'h4C, 8'h68, 8'h64, 8'h64, 8'h68, 8'h6C, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'h6C, 8'h4C, 8'h4C, 8'h6C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hD0, 8'hD0, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'h90, 8'h8C, 8'h8C, 8'h88, 8'h88, 8'h88, 8'h8C, 8'h90, 8'hB0, 8'hD0, 8'hD0, 8'hB0, 8'h6C, 8'h6C, 8'h91, 8'h91, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h6C, 8'h6C, 8'hD4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'h6C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h6C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h6C, 8'h6C, 8'hD4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hD4, 8'h6C, 8'h4C, 8'h6C, 8'h6C, 8'h4C, 8'h6C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h4C, 8'h6C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h6C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h4C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h4C, 8'h6C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h6C, 8'h4C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h4C, 8'h6C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFE, 8'hD9, 8'h6C, 8'h4C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h4C, 8'h6C, 8'hD4, 8'hF4, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFA, 8'hD9, 8'h6C, 8'h4C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'h6C, 8'hD4, 8'hF4, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF4, 8'hD4, 8'h6C, 8'h6C, 8'hD0, 8'hD0, 8'h6C, 8'h6C, 8'hD0, 8'hD0, 8'h6C, 8'h6C, 8'hD0, 8'hD0, 8'h6C, 8'h6C, 8'hD0, 8'hD0, 8'h6C, 8'h6C, 8'hD0, 8'hD0, 8'h6C, 8'h8C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF4, 8'hD4, 8'h6C, 8'h6C, 8'hF4, 8'hF4, 8'h6C, 8'h6C, 8'hF4, 8'hF4, 8'h6C, 8'h6C, 8'hF4, 8'hF4, 8'h6C, 8'h6C, 8'hF4, 8'hF4, 8'h6C, 8'h6C, 8'hF4, 8'hF4, 8'h6C, 8'h6C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF4, 8'hD4, 8'h6C, 8'h6C, 8'hD4, 8'hD4, 8'h6C, 8'h6C, 8'hD4, 8'hF4, 8'h6C, 8'h6C, 8'hF4, 8'hF4, 8'h6C, 8'h6C, 8'hF4, 8'hF4, 8'h6C, 8'h6C, 8'hD4, 8'hF4, 8'h6C, 8'h6C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF4, 8'hD4, 8'h6C, 8'h6C, 8'hD4, 8'hD4, 8'h6C, 8'h6C, 8'hD4, 8'hF4, 8'h6C, 8'h6C, 8'hF4, 8'hF4, 8'h6C, 8'h6C, 8'hF4, 8'hF4, 8'h6C, 8'h6C, 8'hD4, 8'hF4, 8'h6C, 8'h6C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF4, 8'hD4, 8'h6C, 8'h6C, 8'hD4, 8'hD4, 8'h6C, 8'h6C, 8'hD4, 8'hD4, 8'h6C, 8'h6C, 8'hD4, 8'hD4, 8'h6C, 8'h6C, 8'hD4, 8'hD4, 8'h6C, 8'h6C, 8'hD4, 8'hD4, 8'h6C, 8'h6C, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF }
};

wire [7:0] red_sig, green_sig, blue_sig;
assign red_sig     = {object_colors[offsetY][offsetX][7:5] , 5'd0};
assign green_sig   = {object_colors[offsetY][offsetX][4:2] , 5'd0};
assign blue_sig    = {object_colors[offsetY][offsetX][1:0] , 6'd0};


