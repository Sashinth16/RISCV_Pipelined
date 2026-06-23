`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2026 21:55:44
// Design Name: 
// Module Name: imm_gen
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

module imm_gen(
    input  [31:0] instr,
    input  [2:0]  imm_sel,
    output reg [31:0] imm_out
);
    always @(*) begin
        case (imm_sel)
            3'b000: imm_out = {{20{instr[31]}}, instr[31:20]};
            3'b001: imm_out = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            3'b010: imm_out = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
            default: imm_out = 32'd0;
        endcase
    end
endmodule
