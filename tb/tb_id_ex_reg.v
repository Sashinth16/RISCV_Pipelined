`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2026 07:57:21
// Design Name: 
// Module Name: tb_id_ex_reg
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


module tb_id_ex_reg;
    reg clk, rst, flush, stall;
    reg [31:0] pc_in, rd1_in, rd2_in, imm_in;
    reg [4:0]  rs1_in, rs2_in, rd_in;
    reg [2:0]  alu_op_in;
    reg        alu_src_in, mem_read_in, mem_write_in,
               mem_to_reg_in, reg_write_in, branch_in;

    wire [31:0] pc_out, rd1_out, rd2_out, imm_out;
    wire [4:0]  rs1_out, rs2_out, rd_out;
    wire [2:0]  alu_op_out;
    wire        alu_src_out, mem_read_out, mem_write_out,
                mem_to_reg_out, reg_write_out, branch_out;

    id_ex_reg uut (
        .clk(clk), .rst(rst), .flush(flush), .stall(stall),
        .pc_in(pc_in), .rd1_in(rd1_in), .rd2_in(rd2_in), .imm_in(imm_in),
        .rs1_in(rs1_in), .rs2_in(rs2_in), .rd_in(rd_in),
        .alu_op_in(alu_op_in), .alu_src_in(alu_src_in),
        .mem_read_in(mem_read_in), .mem_write_in(mem_write_in),
        .mem_to_reg_in(mem_to_reg_in), .reg_write_in(reg_write_in),
        .branch_in(branch_in),
        .pc_out(pc_out), .rd1_out(rd1_out), .rd2_out(rd2_out), .imm_out(imm_out),
        .rs1_out(rs1_out), .rs2_out(rs2_out), .rd_out(rd_out),
        .alu_op_out(alu_op_out), .alu_src_out(alu_src_out),
        .mem_read_out(mem_read_out), .mem_write_out(mem_write_out),
        .mem_to_reg_out(mem_to_reg_out), .reg_write_out(reg_write_out),
        .branch_out(branch_out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst=1; #10;
        rst=0;
        pc_in=32'h4; rd1_in=32'h5; rd2_in=32'hA;
        imm_in=32'h5; rs1_in=5'd0; rs2_in=5'd1;
        rd_in=5'd3; alu_op_in=3'b000; alu_src_in=1;
        mem_read_in=0; mem_write_in=0;
        mem_to_reg_in=0; reg_write_in=1; branch_in=0; #10;

        stall=1; rd1_in=32'hDEAD; #10;
        stall=0; #10;

        flush=1; #10;
        flush=0; #10;

        $finish;
    end

    initial begin
        $monitor("time=%0t rst=%b flush=%b stall=%b rd1_in=%h rd1_out=%h reg_write_out=%b",
                  $time, rst, flush, stall, rd1_in, rd1_out, reg_write_out);
    end
endmodule
