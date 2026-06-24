`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2026 09:15:06
// Design Name: 
// Module Name: mem_wb_reg
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


module mem_wb_reg(
    input         clk, rst,
    input  [31:0] read_data_in, alu_result_in,
    input  [4:0]  rd_in,
    input         mem_to_reg_in, reg_write_in,
    output reg [31:0] read_data_out, alu_result_out,
    output reg [4:0]  rd_out,
    output reg        mem_to_reg_out, reg_write_out
);
    always @(posedge clk) begin
        if (rst) begin
            read_data_out  <= 0; alu_result_out <= 0;
            rd_out         <= 0; mem_to_reg_out <= 0;
            reg_write_out  <= 0;
        end
        else begin
            read_data_out  <= read_data_in;
            alu_result_out <= alu_result_in;
            rd_out         <= rd_in;
            mem_to_reg_out <= mem_to_reg_in;
            reg_write_out  <= reg_write_in;
        end
    end
endmodule