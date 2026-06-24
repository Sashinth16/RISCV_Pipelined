`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2026 09:16:00
// Design Name: 
// Module Name: tb_ex_mem_reg
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


module tb_ex_mem_reg;
    reg clk, rst, flush;
    reg [31:0] alu_result_in, rd2_in, pc_in;
    reg [4:0]  rd_in;
    reg        zero_in, mem_read_in, mem_write_in,
               mem_to_reg_in, reg_write_in, branch_in;

    wire [31:0] alu_result_out, rd2_out, pc_out;
    wire [4:0]  rd_out;
    wire        zero_out, mem_read_out, mem_write_out,
                mem_to_reg_out, reg_write_out, branch_out;

    ex_mem_reg uut (
        .clk(clk), .rst(rst), .flush(flush),
        .alu_result_in(alu_result_in), .rd2_in(rd2_in), .pc_in(pc_in),
        .rd_in(rd_in), .zero_in(zero_in), .mem_read_in(mem_read_in),
        .mem_write_in(mem_write_in), .mem_to_reg_in(mem_to_reg_in),
        .reg_write_in(reg_write_in), .branch_in(branch_in),
        .alu_result_out(alu_result_out), .rd2_out(rd2_out), .pc_out(pc_out),
        .rd_out(rd_out), .zero_out(zero_out), .mem_read_out(mem_read_out),
        .mem_write_out(mem_write_out), .mem_to_reg_out(mem_to_reg_out),
        .reg_write_out(reg_write_out), .branch_out(branch_out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst=1; #10;
        rst=0;
        alu_result_in=32'hF; rd2_in=32'hA;
        pc_in=32'h8; rd_in=5'd3;
        zero_in=0; mem_read_in=0; mem_write_in=0;
        mem_to_reg_in=0; reg_write_in=1; branch_in=0; #10;

        flush=1; #10;
        flush=0;
        alu_result_in=32'hDEAD; #10;

        $finish;
    end

    initial begin
        $monitor("time=%0t rst=%b flush=%b alu_result_in=%h alu_result_out=%h reg_write_out=%b",
                  $time, rst, flush, alu_result_in, alu_result_out, reg_write_out);
    end
endmodule
