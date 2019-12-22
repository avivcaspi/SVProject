
// 1

localparam  int OBJECT_HEIGHT_Y = 32;
localparam  int OBJECT_WIDTH_X = 32;

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors = {
{8'hDA, 8'hAD, 8'hCD, 8'hCD, 8'hA9, 8'hAD, 8'hA9, 8'hA9, 8'hAD, 8'hCD, 8'hD6, 8'hD1, 8'hCD, 8'hAD, 8'hA8, 8'hA8, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hAD, 8'hD6, 8'hAD, 8'hA9, 8'hA9, 8'h89, 8'hA9, 8'hA9, 8'hA9, 8'h89, 8'hA9, 8'hAD },
{8'hDA, 8'hAD, 8'hA9, 8'hA9, 8'hA8, 8'hA9, 8'hA8, 8'hA8, 8'hA9, 8'hAD, 8'hD1, 8'hD1, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'h88, 8'hA8, 8'hA8, 8'hA8, 8'hAD, 8'hD6, 8'hAD, 8'hA8, 8'hA8, 8'h88, 8'h88, 8'h84, 8'h88, 8'h84, 8'h88, 8'hA9 },
{8'hDA, 8'hAD, 8'hAD, 8'hA9, 8'hA9, 8'hA8, 8'hA9, 8'hA9, 8'hA9, 8'hCD, 8'hD5, 8'hD1, 8'hA9, 8'hA8, 8'h88, 8'hA8, 8'hA8, 8'h88, 8'hA8, 8'hA8, 8'hAD, 8'hD6, 8'hAD, 8'hA8, 8'hA8, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hA9 },
{8'hDA, 8'hCD, 8'hAD, 8'hAD, 8'hAD, 8'hA9, 8'hA9, 8'hA9, 8'hAD, 8'hCD, 8'hD6, 8'hD1, 8'hA9, 8'hA8, 8'hA8, 8'hA9, 8'hA9, 8'hA8, 8'h88, 8'h88, 8'hAD, 8'hD6, 8'hAD, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'h88, 8'h88, 8'h88, 8'hA9 },
{8'hFA, 8'hD6, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD5, 8'hD6, 8'hD6, 8'hD1, 8'hD1, 8'hD1, 8'hB1, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hD2, 8'hDA, 8'hD6, 8'hD1, 8'hD1, 8'hD1, 8'hD2, 8'hD2, 8'hB1, 8'hB1, 8'hB1, 8'hD2 },
{8'hD2, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hDA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD6, 8'hD6, 8'hD1, 8'hD1, 8'hB1 },
{8'hA8, 8'hA8, 8'hA9, 8'hA8, 8'hA9, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hAD, 8'hA9, 8'hA9, 8'hA8 },
{8'hA8, 8'h88, 8'hA8, 8'hA9, 8'hA9, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hA9, 8'hA8, 8'h88, 8'hA8 },
{8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hA9, 8'hA9, 8'hA8, 8'hA9 },
{8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hB1, 8'hDA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD6, 8'hB1, 8'hAD, 8'hAD, 8'hAD },
{8'hFB, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hDA, 8'hDA, 8'hFB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hDA, 8'hD6, 8'hD6, 8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA },
{8'hDA, 8'hAD, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA8, 8'hA9, 8'hA9, 8'hAD, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hAD, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h8D },
{8'hD6, 8'hAD, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hA9, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h64, 8'h64, 8'h89 },
{8'hD6, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hD2, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hA9, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h64, 8'h64, 8'h89 },
{8'hD6, 8'hAD, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hA9, 8'hD2, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hA9, 8'h88, 8'h84, 8'h88, 8'h84, 8'h88, 8'h84, 8'h84, 8'h84, 8'hAD },
{8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hFB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFB, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD2, 8'hB1, 8'hB1, 8'hD6 },
{8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hAD, 8'hAD, 8'hAD, 8'hA9 },
{8'hA8, 8'hA8, 8'hA8, 8'hA9, 8'hA9, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hA9, 8'hA8, 8'hA8, 8'hA8 },
{8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hAD, 8'hA8, 8'hA8, 8'hA8 },
{8'hA8, 8'hA8, 8'hA9, 8'hA9, 8'hA8, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hAD, 8'hA9, 8'hA9, 8'hA8 },
{8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hD6 },
{8'hDA, 8'hB1, 8'hB1, 8'hAD, 8'hB1, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hB1, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hD1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hB1, 8'hD6 },
{8'hD6, 8'hA8, 8'hA8, 8'h88, 8'h88, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hA8, 8'hD2, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hA9, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h84, 8'h88, 8'hAD },
{8'hD6, 8'hA9, 8'h88, 8'h88, 8'h84, 8'h84, 8'h88, 8'h88, 8'h84, 8'h88, 8'hD1, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD6, 8'hA9, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h84, 8'h89 },
{8'hD6, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hD2, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD6, 8'hA8, 8'h88, 8'h84, 8'h84, 8'h84, 8'h88, 8'h84, 8'h84, 8'h88, 8'hAD },
{8'hDA, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hAD, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDA, 8'hAD, 8'hAD, 8'h8D, 8'hAD, 8'h8D, 8'hAD, 8'h8D, 8'h8D, 8'hAD, 8'hB1 },
{8'hD6, 8'hD6, 8'hB2, 8'hD2, 8'hD6, 8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD2, 8'hD2, 8'hD6, 8'hDA, 8'hD6, 8'hD2, 8'hD2, 8'hD2, 8'hD2 },
{8'h88, 8'h88, 8'h88, 8'h88, 8'hA9, 8'hD1, 8'hAD, 8'hA9, 8'hA8, 8'h88, 8'h88, 8'h88, 8'hA8, 8'h88, 8'h88, 8'hAD, 8'hD1, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hD2, 8'hB1, 8'hA8, 8'hA8, 8'h88, 8'h88 },
{8'h88, 8'h88, 8'h88, 8'h88, 8'hA9, 8'hB1, 8'hAD, 8'h89, 8'h88, 8'h88, 8'h88, 8'h88, 8'h84, 8'h84, 8'h88, 8'hAD, 8'hB1, 8'h88, 8'h88, 8'h88, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h88, 8'hB1, 8'hAD, 8'hA8, 8'hA8, 8'h84, 8'h88 },
{8'hA8, 8'hA8, 8'h88, 8'h88, 8'hA9, 8'hB1, 8'hAD, 8'h88, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h88, 8'h88, 8'hAD, 8'hB1, 8'h88, 8'h88, 8'h88, 8'h88, 8'h84, 8'h84, 8'h84, 8'h84, 8'h88, 8'hB1, 8'hAD, 8'hA8, 8'hA8, 8'h88, 8'h84 },
{8'hA9, 8'h89, 8'h88, 8'h88, 8'hA9, 8'hD6, 8'hAD, 8'h89, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hAD, 8'hB2, 8'h89, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'h88, 8'hD2, 8'hB1, 8'hAD, 8'hA9, 8'h88, 8'h88 },
{8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hFB, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hFB, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hFB, 8'hFB, 8'hFA, 8'hDA, 8'hDA, 8'hDA }
};

wire [7:0] red_sig, green_sig, blue_sig;
assign red_sig     = {object_colors[offsetY][offsetX][7:5] , 5'd0};
assign green_sig   = {object_colors[offsetY][offsetX][4:2] , 5'd0};
assign blue_sig    = {object_colors[offsetY][offsetX][1:0] , 6'd0};


