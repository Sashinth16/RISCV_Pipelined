`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2026 15:57:36
// Design Name: 
// Module Name: pc
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


module pc(input clk,input rst, input [31:0]pc_next,output reg [31:0]pc_out

    );
    always @(posedge clk) begin
        if(rst) begin
            pc_out <= 32'd0;
        end
        
        else begin
            pc_out <= pc_next;
        end
    end
endmodule
