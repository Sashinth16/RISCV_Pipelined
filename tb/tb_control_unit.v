`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2026 11:16:09
// Design Name: 
// Module Name: tb_control_unit
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

module tb_control_unit;

    reg  [6:0] opcode;
    wire       reg_write, alu_src, mem_read, mem_write, mem_to_reg, branch;
    wire [2:0] alu_op;

    control_unit uut (
        .opcode    (opcode),
        .reg_write (reg_write),
        .alu_src   (alu_src),
        .mem_read  (mem_read),
        .mem_write (mem_write),
        .mem_to_reg(mem_to_reg),
        .branch    (branch),
        .alu_op    (alu_op)
    );

    initial begin
        opcode = 7'b0110011; #10;  // ADD/SUB
        opcode = 7'b0010011; #10;  // ADDI
        opcode = 7'b0000011; #10;  // LW
        opcode = 7'b0100011; #10;  // SW
        opcode = 7'b1100011; #10;  // BEQ
        opcode = 7'b0000000; #10;  // unknown → default
        $finish;
    end

    initial begin
        $monitor("time=%0t opcode=%b | rw=%b asrc=%b mr=%b mw=%b m2r=%b br=%b aluop=%b",
                  $time, opcode, reg_write, alu_src, mem_read,
                  mem_write, mem_to_reg, branch, alu_op);
    end

endmodule