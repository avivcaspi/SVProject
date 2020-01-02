localparam  int OBJECT_HEIGHT_Y = 32;
localparam  int OBJECT_WIDTH_X = 32;

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors = {
{8'hDA, 8'hD6, 8'h00, 8'h04, 8'hDA, 8'hDA, 8'h00, 8'h00, 8'hDA, 8'hDA, 8'h04, 8'h00, 8'hDA, 8'hDA, 8'h04, 8'h00, 8'hDA, 8'hDA, 8'h04, 8'h04, 8'hDA, 8'hDA, 8'hCC, 8'hCC, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFA, 8'hDA, 8'h00, 8'h00, 8'hDA, 8'hDA, 8'h04, 8'h00, 8'hDA, 8'hDA, 8'h04, 8'h00, 8'hDA, 8'hDA, 8'h00, 8'h04, 8'hDA, 8'hDA, 8'h00, 8'h00, 8'hDA, 8'hFA, 8'hEC, 8'hCC, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hD1, 8'hD1, 8'h00, 8'h00, 8'hD1, 8'hD1, 8'h00, 8'h00, 8'hD1, 8'hD1, 8'h00, 8'h00, 8'hD1, 8'hD1, 8'h00, 8'h00, 8'hD1, 8'hD1, 8'h00, 8'h00, 8'hD1, 8'hD1, 8'h44, 8'h68, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hEC, 8'hC8, 8'h00, 8'h00, 8'hC8, 8'hC8, 8'h00, 8'h00, 8'hC8, 8'hC8, 8'h00, 8'h00, 8'hC8, 8'hC8, 8'h00, 8'h00, 8'hC8, 8'hC8, 8'h00, 8'h00, 8'hC8, 8'hC8, 8'h00, 8'h04, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hCC, 8'hCC, 8'h24, 8'h24, 8'hCC, 8'hCC, 8'h24, 8'h24, 8'hCC, 8'hCC, 8'h24, 8'h24, 8'hCC, 8'hCC, 8'h24, 8'h24, 8'hCC, 8'hCC, 8'h24, 8'h24, 8'hCC, 8'hCC, 8'h00, 8'h04, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hCC, 8'hCC, 8'hDA, 8'hDA, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hDA, 8'hD6, 8'h00, 8'h04, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hCC, 8'hCC, 8'hDA, 8'hDA, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hDA, 8'hDA, 8'h00, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hDA, 8'hDA, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hDA, 8'hDA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hDA, 8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hD6, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hD6, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hDA, 8'hDA, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hCC, 8'hCC, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hFA, 8'hDA, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hCC, 8'hCC, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hD1, 8'hD1, 8'hCC, 8'hCC, 8'hD5, 8'hF5, 8'hF5, 8'hF5, 8'hF5, 8'hF5, 8'hF5, 8'hD5, 8'hCC, 8'hCC, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hCC, 8'hCC, 8'h49, 8'h49, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hCC, 8'hEC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hC8, 8'h00, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hDA, 8'hDA, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'h88, 8'hA8, 8'hCC, 8'hEC, 8'hCD, 8'hD1, 8'hD1, 8'hCD, 8'h49, 8'h49, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hDA, 8'hDA, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hC8, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA },
{8'hFF, 8'hFF, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hDA, 8'hDA, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA },
{8'hFF, 8'hFF, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hD1, 8'hCD, 8'h44, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'hD1, 8'hCD, 8'h49, 8'h24, 8'h24, 8'h49, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hCC, 8'hEC, 8'hCC, 8'hCC, 8'hEC, 8'hC8, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hCC, 8'hEC, 8'hEC, 8'hCC, 8'h00, 8'h00, 8'h00, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h88, 8'h88, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'h44, 8'h44, 8'h44, 8'h44, 8'h44, 8'h44, 8'h44, 8'h44, 8'h88, 8'h88, 8'h88, 8'h88, 8'h00, 8'h00, 8'h49, 8'h4D, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h04, 8'h00, 8'hCC, 8'hEC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h24, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h04, 8'h00, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h24, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h04, 8'h00, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h24, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h24, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h24, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h24, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h04, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h24, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hDA, 8'hD6, 8'h04, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hC8, 8'hCC, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hDA, 8'hD6, 8'h04, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hA8, 8'hCC, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hCC, 8'hCC, 8'h00, 8'h00, 8'h88, 8'h88, 8'h00, 8'h00, 8'hA8, 8'hA8, 8'h00, 8'h00, 8'hA8, 8'hA8, 8'h00, 8'h00, 8'hA8, 8'hA8, 8'h00, 8'h00, 8'hA8, 8'hA8, 8'h24, 8'h24, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hCC, 8'hC8, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h04, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hEC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h04, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hEC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h04, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hCC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h00, 8'hCC, 8'hCC, 8'h00, 8'h04, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF }
};

wire [7:0] red_sig, green_sig, blue_sig;
assign red_sig     = {object_colors[offsetY][offsetX][7:5] , 5'd0};
assign green_sig   = {object_colors[offsetY][offsetX][4:2] , 5'd0};
assign blue_sig    = {object_colors[offsetY][offsetX][1:0] , 6'd0};


