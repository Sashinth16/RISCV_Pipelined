`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2026 19:50:56
// Design Name: 
// Module Name: alu
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

module alu(
    input  [31:0] a,
    input  [31:0] b,
    input  [2:0]  alu_ctrl,
    output reg [31:0] result,
    output zero
);
    always @(*) begin
        case (alu_ctrl)
            3'b000: result = a + b;                     // ADD
            3'b001: result = a - b;                      // SUB
            3'b010: result = a & b;                       // AND
            3'b011: result = a | b;                        // OR
            3'b100: result = a ^ b;                        // XOR
            3'b101: result = (a < b) ? 32'd1 : 32'd0;      // SLT (unsigned here)
            default: result = 32'd0;
        endcase
    end

    assign zero = (result == 32'd0);
endmodule
