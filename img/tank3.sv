localparam  int OBJECT_HEIGHT_Y = 25;
localparam  int OBJECT_WIDTH_X = 25;

logic [0:OBJECT_WIDTH_X-1] [0:OBJECT_HEIGHT_Y-1] [8-1:0] object_colors = {
{8'hFA, 8'h6D, 8'h00, 8'hB6, 8'h91, 8'h00, 8'hB6, 8'hB6, 8'h00, 8'h91, 8'hDA, 8'h00, 8'h6D, 8'hDA, 8'h04, 8'h49, 8'hFA, 8'hCC, 8'hD1, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFA, 8'h6D, 8'h00, 8'hB5, 8'h91, 8'h00, 8'hB1, 8'hB1, 8'h00, 8'h8D, 8'hD6, 8'h00, 8'h6D, 8'hD6, 8'h04, 8'h49, 8'hFA, 8'hAC, 8'hAD, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hEC, 8'h68, 8'h00, 8'hA8, 8'h88, 8'h00, 8'hA8, 8'hA8, 8'h00, 8'h88, 8'hCC, 8'h00, 8'h64, 8'hCC, 8'h00, 8'h44, 8'hCC, 8'h20, 8'h49, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hEC, 8'h88, 8'h24, 8'hCC, 8'hA8, 8'h24, 8'hA8, 8'hA8, 8'h24, 8'h88, 8'hCC, 8'h24, 8'h88, 8'hCC, 8'h44, 8'h68, 8'hD1, 8'h24, 8'h49, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hCC, 8'hD1, 8'hDA, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hD1, 8'hDA, 8'h24, 8'h29, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hD1, 8'hD5, 8'hDA, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD5, 8'hDA, 8'h6D, 8'h6D, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hDA, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD5, 8'hD6, 8'hDA, 8'hDA, 8'hDA, 8'hD5, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hDA, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'hD1, 8'hDA, 8'hDA, 8'hD5, 8'hCC, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hD1, 8'hCC, 8'hCC, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'hCC, 8'hD1, 8'hD5, 8'hD5, 8'hD1, 8'hCC, 8'h91, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hC8, 8'hCC, 8'hD1, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hEC, 8'hEC, 8'hCC, 8'hCC, 8'hCC, 8'hCC, 8'h20, 8'h25, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'hCC, 8'hCC, 8'hD1, 8'hDA, 8'hD5, 8'hD1, 8'hD1, 8'hD1, 8'hD1, 8'h68, 8'hA8, 8'hEC, 8'hD1, 8'hD1, 8'hD1, 8'h6D, 8'h91, 8'hFF, 8'hFB, 8'hFB, 8'hFB, 8'hFB, 8'hFB },
{8'hFF, 8'hFF, 8'hCC, 8'hCC, 8'hD1, 8'hDA, 8'hF1, 8'hEC, 8'hEC, 8'hEC, 8'hC8, 8'h00, 8'h64, 8'hEC, 8'hDA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'hDA },
{8'hFF, 8'hFF, 8'hCC, 8'hCC, 8'hCC, 8'hD1, 8'h88, 8'h64, 8'h64, 8'h64, 8'h44, 8'h00, 8'h64, 8'hEC, 8'hD1, 8'hB1, 8'h6D, 8'h6D, 8'h91, 8'hFF, 8'hFB, 8'hFB, 8'hFB, 8'hFB, 8'hFB },
{8'hFF, 8'hFF, 8'hEC, 8'hCC, 8'hCC, 8'hCC, 8'h24, 8'h-3.200000e+01, 8'h00, 8'h-3.200000e+01, 8'h00, 8'h-3.200000e+01, 8'h64, 8'hEC, 8'hEC, 8'h88, 8'h-3.200000e+01, 8'h-3.600000e+01, 8'h29, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h44, 8'hCC, 8'hEC, 8'hCC, 8'h88, 8'h68, 8'h88, 8'h88, 8'h88, 8'h88, 8'h64, 8'h44, 8'h44, 8'h24, 8'h00, 8'h6D, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h00, 8'hA8, 8'hEC, 8'hEC, 8'hEC, 8'hEC, 8'hEC, 8'hEC, 8'hEC, 8'hEC, 8'h64, 8'h-3.200000e+01, 8'h00, 8'h00, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h00, 8'h44, 8'h44, 8'h44, 8'h44, 8'h44, 8'h44, 8'h44, 8'h44, 8'h44, 8'h24, 8'h00, 8'h00, 8'h00, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFF, 8'hFF, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFA, 8'h91, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hAD, 8'hF6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hFA, 8'h6D, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'hA8, 8'hD1, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hF0, 8'h68, 8'h00, 8'h88, 8'h68, 8'h00, 8'h88, 8'h88, 8'h00, 8'h64, 8'h88, 8'h00, 8'h44, 8'hA8, 8'h00, 8'h44, 8'hA8, 8'h44, 8'h69, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hEC, 8'h68, 8'h00, 8'hC8, 8'h88, 8'h00, 8'hA8, 8'hA8, 8'h00, 8'h88, 8'hCC, 8'h00, 8'h64, 8'hCC, 8'h00, 8'h44, 8'hEC, 8'h20, 8'h29, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hEC, 8'h68, 8'h00, 8'hA8, 8'h88, 8'h00, 8'hA8, 8'hA8, 8'h00, 8'h88, 8'hCC, 8'h00, 8'h64, 8'hCC, 8'h00, 8'h44, 8'hEC, 8'h20, 8'h49, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
{8'hEC, 8'h68, 8'h00, 8'hA8, 8'h88, 8'h00, 8'hA8, 8'hA8, 8'h00, 8'h88, 8'hCC, 8'h00, 8'h64, 8'hCC, 8'h00, 8'h44, 8'hCC, 8'h20, 8'h49, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF }
};

wire [7:0] red_sig, green_sig, blue_sig;
assign red_sig     = {object_colors[offsetY][offsetX][7:5] , 5'd0};
assign green_sig   = {object_colors[offsetY][offsetX][4:2] , 5'd0};
assign blue_sig    = {object_colors[offsetY][offsetX][1:0] , 6'd0};


