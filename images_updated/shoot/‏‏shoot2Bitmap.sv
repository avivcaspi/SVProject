localparam  int OBJECT_HEIGHT_Y = 25;
localparam  int OBJECT_WIDTH_X = 25;

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors = {
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h45, 8'h45, 8'h45, 8'h45, 8'h45, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB2, 8'h45, 8'h45, 8'h45, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h45, 8'h45, 8'h45, 8'hB2, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h45, 8'h45, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h45, 8'h45, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h86, 8'h86, 8'h85, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h45, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'h45, 8'h65, 8'h65, 8'h65, 8'h85, 8'h85, 8'h86, 8'h86, 8'hAA, 8'hAA, 8'hAA, 8'h86, 8'h86, 8'h85, 8'h65, 8'h65, 8'h65, 8'h65, 8'h45, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h45, 8'h65, 8'h65, 8'h65, 8'h86, 8'h86, 8'hAA, 8'hAA, 8'hCA, 8'hCF, 8'hCF, 8'hCF, 8'hCA, 8'hAA, 8'hAA, 8'h86, 8'h85, 8'h65, 8'h65, 8'h65, 8'h45, 8'hFF, 8'hFF },
{8'hFF, 8'h8E, 8'h65, 8'h65, 8'h65, 8'h86, 8'hAA, 8'hCA, 8'hCA, 8'hCF, 8'hEF, 8'hF3, 8'hD3, 8'hF3, 8'hEF, 8'hCF, 8'hCA, 8'hAA, 8'hAA, 8'h85, 8'h65, 8'h65, 8'h65, 8'h8E, 8'hFF },
{8'hFF, 8'h45, 8'h65, 8'h65, 8'h85, 8'hA6, 8'hCA, 8'hCF, 8'hF3, 8'hF3, 8'hF3, 8'hD7, 8'hD7, 8'hD7, 8'hF3, 8'hF3, 8'hF3, 8'hCF, 8'hAA, 8'h86, 8'h65, 8'h65, 8'h65, 8'h45, 8'hFF },
{8'h69, 8'h65, 8'h65, 8'h65, 8'h86, 8'hAA, 8'hCB, 8'hF3, 8'hD7, 8'hD7, 8'hD7, 8'hBB, 8'hBB, 8'hBB, 8'hD7, 8'hD7, 8'hF3, 8'hEF, 8'hCA, 8'hA6, 8'h85, 8'h65, 8'h65, 8'h65, 8'hFF },
{8'h45, 8'h65, 8'h65, 8'h65, 8'h86, 8'hAA, 8'hCF, 8'hF3, 8'hD7, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hDB, 8'hD3, 8'hEF, 8'hCB, 8'hAA, 8'h86, 8'h65, 8'h65, 8'h65, 8'h45 },
{8'h45, 8'h65, 8'h65, 8'h85, 8'hAA, 8'hCA, 8'hEF, 8'hD3, 8'hD7, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hD7, 8'hF3, 8'hEF, 8'hCA, 8'hA6, 8'h85, 8'h65, 8'h65, 8'h45 },
{8'h65, 8'h65, 8'h65, 8'h86, 8'hAA, 8'hCF, 8'hF3, 8'hD7, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hD7, 8'hF3, 8'hCF, 8'hAA, 8'h86, 8'h65, 8'h65, 8'h45 },
{8'h45, 8'h65, 8'h65, 8'h86, 8'hAA, 8'hCB, 8'hEF, 8'hD7, 8'hDB, 8'hBB, 8'hBB, 8'hDB, 8'hDB, 8'hBB, 8'hBB, 8'hBB, 8'hD7, 8'hD3, 8'hEF, 8'hCA, 8'hAA, 8'h85, 8'h65, 8'h65, 8'h45 },
{8'h45, 8'h65, 8'h65, 8'h85, 8'hA6, 8'hCA, 8'hEF, 8'hF3, 8'hD7, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hDB, 8'hD3, 8'hEF, 8'hCB, 8'hAA, 8'h86, 8'h85, 8'h65, 8'h65, 8'h45 },
{8'h45, 8'h65, 8'h65, 8'h65, 8'h86, 8'hAA, 8'hCB, 8'hF3, 8'hD7, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hBB, 8'hD7, 8'hF3, 8'hEF, 8'hCA, 8'hAA, 8'h86, 8'h65, 8'h65, 8'h65, 8'h69 },
{8'h6D, 8'h65, 8'h65, 8'h65, 8'h86, 8'hAA, 8'hCA, 8'hEF, 8'hD3, 8'hD3, 8'hD7, 8'hD7, 8'hBB, 8'hD7, 8'hD7, 8'hD7, 8'hF3, 8'hCF, 8'hCA, 8'hA6, 8'h85, 8'h65, 8'h65, 8'h65, 8'hFF },
{8'hFF, 8'h45, 8'h65, 8'h65, 8'h85, 8'hA6, 8'hCA, 8'hCF, 8'hEF, 8'hEF, 8'hEF, 8'hD3, 8'hD7, 8'hF3, 8'hEF, 8'hEF, 8'hCF, 8'hCA, 8'hAA, 8'h86, 8'h65, 8'h65, 8'h65, 8'h45, 8'hFF },
{8'hFF, 8'hFF, 8'h65, 8'h65, 8'h65, 8'h86, 8'hAA, 8'hAA, 8'hCA, 8'hCA, 8'hCB, 8'hEF, 8'hF3, 8'hEF, 8'hCB, 8'hCA, 8'hCA, 8'hAA, 8'h86, 8'h85, 8'h65, 8'h65, 8'h45, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h45, 8'h65, 8'h65, 8'h65, 8'h85, 8'h86, 8'hA6, 8'hA6, 8'hAA, 8'hCA, 8'hCB, 8'hCA, 8'hAA, 8'hAA, 8'hA6, 8'h86, 8'h85, 8'h65, 8'h65, 8'h45, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h69, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h85, 8'h86, 8'h86, 8'hA6, 8'hAA, 8'hA6, 8'h86, 8'h86, 8'h85, 8'h65, 8'h65, 8'h65, 8'h65, 8'h45, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h65, 8'h45, 8'h65, 8'h65, 8'h65, 8'h65, 8'h85, 8'h85, 8'h85, 8'h85, 8'h85, 8'h65, 8'h65, 8'h65, 8'h65, 8'h45, 8'h65, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hB2, 8'h69, 8'h45, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h45, 8'h65, 8'hB2, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'h45, 8'h45, 8'h65, 8'h65, 8'h65, 8'h65, 8'h65, 8'h45, 8'h45, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF }
};

wire [7:0] red_sig, green_sig, blue_sig;
assign red_sig     = {object_colors[offsetY][offsetX][7:5] , 5'd0};
assign green_sig   = {object_colors[offsetY][offsetX][4:2] , 5'd0};
assign blue_sig    = {object_colors[offsetY][offsetX][1:0] , 6'd0};


