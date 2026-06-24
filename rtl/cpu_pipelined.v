`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2026 11:14:44
// Design Name: 
// Module Name: cpu_pipelined
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


module cpu_pipelined(
    input clk,
    input rst
);


    wire [31:0] pc_out, pc_next, pc_plus4;
    wire [31:0] instr_if;

    wire [31:0] pc_id, instr_id;

    wire [31:0] rd1_id, rd2_id, imm_id;
    wire [6:0]  opcode_id;
    wire [4:0]  rs1_id, rs2_id, rd_id;
    wire        reg_write_id, alu_src_id, mem_read_id;
    wire        mem_write_id, mem_to_reg_id, branch_id;
    wire [2:0]  alu_op_id, imm_sel_id;

    wire [31:0] pc_ex, rd1_ex, rd2_ex, imm_ex;
    wire [4:0]  rs1_ex, rs2_ex, rd_ex;
    wire [2:0]  alu_op_ex;
    wire        alu_src_ex, mem_read_ex, mem_write_ex;
    wire        mem_to_reg_ex, reg_write_ex, branch_ex;

    // ─── EX stage wires ───
    wire [31:0] alu_a, alu_b_pre, alu_b;
    wire [31:0] alu_result_ex;
    wire        zero_ex, taken_ex;
    wire [1:0]  forward_a, forward_b;

    // ─── EX/MEM register outputs ───
    wire [31:0] alu_result_mem, rd2_mem, pc_mem;
    wire [4:0]  rd_mem;
    wire        zero_mem, mem_read_mem, mem_write_mem;
    wire        mem_to_reg_mem, reg_write_mem, branch_mem;

    wire [31:0] read_data_mem;
    wire        taken_mem;

    wire [31:0] read_data_wb, alu_result_wb;
    wire [4:0]  rd_wb;
    wire        mem_to_reg_wb, reg_write_wb;

    wire [31:0] write_back;

    wire stall, flush_id_ex;


    wire [31:0] branch_target;
    assign pc_plus4      = pc_out + 32'd4;
    assign branch_target = pc_mem + (alu_result_mem);
    assign taken_mem     = branch_mem & zero_mem;
    assign pc_next       = taken_mem ? branch_target : pc_plus4;


    assign write_back = mem_to_reg_wb ? read_data_wb : alu_result_wb;

    assign alu_a = (forward_a == 2'b10) ? alu_result_mem :
                   (forward_a == 2'b01) ? write_back     : rd1_ex;

    assign alu_b_pre = (forward_b == 2'b10) ? alu_result_mem :
                       (forward_b == 2'b01) ? write_back     : rd2_ex;

    assign alu_b = alu_src_ex ? imm_ex : alu_b_pre;


    assign opcode_id = instr_id[6:0];
    assign rs1_id    = instr_id[19:15];
    assign rs2_id    = instr_id[24:20];
    assign rd_id     = instr_id[11:7];


    pc PC (
        .clk    (clk),
        .rst    (rst),
        .pc_next(stall ? pc_out : pc_next),
        .pc_out (pc_out)
    );

    imem IMEM (
        .addr (pc_out),
        .instr(instr_if)
    );


    if_id_reg IF_ID (
        .clk     (clk), .rst(rst),
        .flush   (taken_mem),
        .stall   (stall),
        .pc_in   (pc_out),
        .instr_in(instr_if),
        .pc_out  (pc_id),
        .instr_out(instr_id)
    );

    control_unit CU (
        .opcode    (opcode_id),
        .reg_write (reg_write_id),
        .alu_src   (alu_src_id),
        .mem_read  (mem_read_id),
        .mem_write (mem_write_id),
        .mem_to_reg(mem_to_reg_id),
        .branch    (branch_id),
        .alu_op    (alu_op_id),
        .imm_sel   (imm_sel_id)
    );

    regfile RF (
        .clk(clk),
        .we (reg_write_wb),
        .rs1(rs1_id),
        .rs2(rs2_id),
        .rd (rd_wb),
        .wd (write_back),
        .rd1(rd1_id),
        .rd2(rd2_id)
    );

    imm_gen IG (
        .instr  (instr_id),
        .imm_sel(imm_sel_id),
        .imm_out(imm_id)
    );

    id_ex_reg ID_EX (
        .clk(clk), .rst(rst),
        .flush(flush_id_ex), .stall(1'b0),
        .pc_in(pc_id), .rd1_in(rd1_id), .rd2_in(rd2_id), .imm_in(imm_id),
        .rs1_in(rs1_id), .rs2_in(rs2_id), .rd_in(rd_id),
        .alu_op_in(alu_op_id), .alu_src_in(alu_src_id),
        .mem_read_in(mem_read_id), .mem_write_in(mem_write_id),
        .mem_to_reg_in(mem_to_reg_id), .reg_write_in(reg_write_id),
        .branch_in(branch_id),
        .pc_out(pc_ex), .rd1_out(rd1_ex), .rd2_out(rd2_ex), .imm_out(imm_ex),
        .rs1_out(rs1_ex), .rs2_out(rs2_ex), .rd_out(rd_ex),
        .alu_op_out(alu_op_ex), .alu_src_out(alu_src_ex),
        .mem_read_out(mem_read_ex), .mem_write_out(mem_write_ex),
        .mem_to_reg_out(mem_to_reg_ex), .reg_write_out(reg_write_ex),
        .branch_out(branch_ex)
    );

   
    alu ALU (
        .a       (alu_a),
        .b       (alu_b),
        .alu_ctrl(alu_op_ex),
        .result  (alu_result_ex),
        .zero    (zero_ex)
    );

    forwarding_unit FU (
        .id_ex_rs1      (rs1_ex),
        .id_ex_rs2      (rs2_ex),
        .ex_mem_rd      (rd_mem),
        .mem_wb_rd      (rd_wb),
        .ex_mem_reg_write(reg_write_mem),
        .mem_wb_reg_write(reg_write_wb),
        .forward_a      (forward_a),
        .forward_b      (forward_b)
    );

    branch_predictor BP (
        .branch(branch_ex),
        .zero  (zero_ex),
        .taken (taken_ex)
    );


    ex_mem_reg EX_MEM (
        .clk(clk), .rst(rst), .flush(taken_mem),
        .alu_result_in(alu_result_ex), .rd2_in(rd2_ex), .pc_in(pc_ex),
        .rd_in(rd_ex), .zero_in(zero_ex),
        .mem_read_in(mem_read_ex), .mem_write_in(mem_write_ex),
        .mem_to_reg_in(mem_to_reg_ex), .reg_write_in(reg_write_ex),
        .branch_in(branch_ex),
        .alu_result_out(alu_result_mem), .rd2_out(rd2_mem), .pc_out(pc_mem),
        .rd_out(rd_mem), .zero_out(zero_mem),
        .mem_read_out(mem_read_mem), .mem_write_out(mem_write_mem),
        .mem_to_reg_out(mem_to_reg_mem), .reg_write_out(reg_write_mem),
        .branch_out(branch_mem)
    );

    dmem DMEM (
        .clk       (clk),
        .mem_read  (mem_read_mem),
        .mem_write (mem_write_mem),
        .addr      (alu_result_mem),
        .write_data(rd2_mem),
        .read_data (read_data_mem)
    );

  
    mem_wb_reg MEM_WB (
        .clk(clk), .rst(rst),
        .read_data_in(read_data_mem), .alu_result_in(alu_result_mem),
        .rd_in(rd_mem), .mem_to_reg_in(mem_to_reg_mem),
        .reg_write_in(reg_write_mem),
        .read_data_out(read_data_wb), .alu_result_out(alu_result_wb),
        .rd_out(rd_wb), .mem_to_reg_out(mem_to_reg_wb),
        .reg_write_out(reg_write_wb)
    );

   
    hazard_unit HU (
        .id_ex_mem_read(mem_read_ex),
        .id_ex_rd      (rd_ex),
        .if_id_rs1     (rs1_id),
        .if_id_rs2     (rs2_id),
        .stall         (stall),
        .flush_id_ex   (flush_id_ex)
    );

endmodule
