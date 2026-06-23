`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2026 11:34:11
// Design Name: 
// Module Name: cpu_singlecycle
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


module cpu_singlecycle(
    input clk,
    input rst
);

    // internal wires
    wire [31:0] pc_out, pc_plus4, pc_next, branch_target;
    wire [31:0] instr;
    wire [31:0] rd1, rd2, imm;
    wire [31:0] alu_b, alu_result;
    wire [31:0] read_data, write_back;
    wire        zero;
    wire        reg_write, alu_src, mem_read, mem_write, mem_to_reg, branch;
    wire [2:0]  alu_op;
    wire        pc_src;
    wire [2:0] imm_sel;

    // PC source: branch taken or PC+4
    assign pc_plus4    = pc_out + 32'd4;
    assign branch_target = pc_out + (imm << 1);
    assign pc_src      = branch & zero;
    assign pc_next     = pc_src ? branch_target : pc_plus4;

    // ALU input B mux
    assign alu_b = alu_src ? imm : rd2;

    // writeback mux
    assign write_back = mem_to_reg ? read_data : alu_result;

    // module instantiations
    pc PC (
        .clk    (clk),
        .rst    (rst),
        .pc_next(pc_next),
        .pc_out (pc_out)
    );

    imem IMEM (
        .addr (pc_out),
        .instr(instr)
    );

    control_unit CU (
        .opcode    (instr[6:0]),
        .reg_write (reg_write),
        .alu_src   (alu_src),
        .mem_read  (mem_read),
        .mem_write (mem_write),
        .mem_to_reg(mem_to_reg),
        .branch    (branch),
        .alu_op    (alu_op),
        .imm_sel(imm_sel)
    );

    regfile RF (
        .clk(clk),
        .we (reg_write),
        .rs1(instr[19:15]),
        .rs2(instr[24:20]),
        .rd (instr[11:7]),
        .wd (write_back),
        .rd1(rd1),
        .rd2(rd2)
    );

    imm_gen IG (
        .instr  (instr),
        .imm_sel(imm_sel),
        .imm_out(imm)
    );

    alu ALU (
        .a       (rd1),
        .b       (alu_b),
        .alu_ctrl(alu_op),
        .result  (alu_result),
        .zero    (zero)
    );

    dmem DMEM (
        .clk       (clk),
        .mem_read  (mem_read),
        .mem_write (mem_write),
        .addr      (alu_result),
        .write_data(rd2),
        .read_data (read_data)
    );

endmodule
