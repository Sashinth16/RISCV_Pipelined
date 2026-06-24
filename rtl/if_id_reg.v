`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2026 07:29:31
// Design Name: 
// Module Name: if_id_reg
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


module if_id_reg(input clk,input rst,input stall,input flush,input [31:0]pc_in,input [31:0]instr_in,output reg [31:0]pc_out,output reg [31:0]instr_out

    );
    always @(posedge clk) begin
        if(rst|flush) begin
            pc_out <= 32'd0;
            instr_out <= 32'd0;
        end
        else if(stall) begin
            pc_out <= pc_out;
            instr_out <= instr_out;
        end
        else begin
            pc_out <= pc_in;
            instr_out <= instr_in;
        end
    end
endmodule
