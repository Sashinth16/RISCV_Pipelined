`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2026 11:09:32
// Design Name: 
// Module Name: control_unit
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

module control_unit(
    input  [6:0] opcode,
    output reg   reg_write,
    output reg   alu_src,
    output reg   mem_read,
    output reg   mem_write,
    output reg   mem_to_reg,
    output reg   branch,
    output reg [2:0] alu_op,
    output reg [2:0] imm_sel
);
    always @(*) begin
        case(opcode)
            7'b0110011: begin  // ADD
                reg_write  = 1;
                alu_src    = 0;
                mem_read   = 0;
                mem_write  = 0;
                mem_to_reg = 0;
                branch     = 0;
                alu_op     = 3'b000;
                imm_sel    = 3'b000;
            end
            7'b0010011: begin  // ADDI
                reg_write  = 1;
                alu_src    = 1;
                mem_read   = 0;
                mem_write  = 0;
                mem_to_reg = 0;
                branch     = 0;
                alu_op     = 3'b000;
                imm_sel    = 3'b000;
            end
            7'b0000011: begin  // LW
                reg_write  = 1;
                alu_src    = 1;
                mem_read   = 1;
                mem_write  = 0;
                mem_to_reg = 1;
                branch     = 0;
                alu_op     = 3'b000;
                imm_sel    = 3'b000;
            end
            7'b0100011: begin  // SW
                reg_write  = 0;
                alu_src    = 1;
                mem_read   = 0;
                mem_write  = 1;
                mem_to_reg = 0;
                branch     = 0;
                alu_op     = 3'b000;
                imm_sel    = 3'b001;
            end
            7'b1100011: begin  // BEQ
                reg_write  = 0;
                alu_src    = 0;
                mem_read   = 0;
                mem_write  = 0;
                mem_to_reg = 0;
                branch     = 1;
                alu_op     = 3'b001;
                imm_sel    = 3'b010;
            end
            default: begin
                reg_write  = 0;
                alu_src    = 0;
                mem_read   = 0;
                mem_write  = 0;
                mem_to_reg = 0;
                branch     = 0;
                alu_op     = 3'b000;
                imm_sel    = 3'b000;
            end
        endcase
    end
endmodule