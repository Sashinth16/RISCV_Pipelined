`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2026 12:20:05
// Design Name: 
// Module Name: register_n
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register_n #(parameter WIDTH = 8)(input clk,input rst,input [WIDTH-1:0]d,output reg [WIDTH-1:0]q

    );
    always @(posedge clk) begin
        if(rst)
            q<=0;
        else
            q<=d; 
    end
endmodule
