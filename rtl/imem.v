`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2026 20:58:51
// Design Name: 
// Module Name: imem
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

module imem(
    input  [31:0] addr,
    output [31:0] instr
);
    reg [31:0] mem [0:63];  // 64 instruction slots

    initial begin
        mem[0] = 32'h00500093;  // ADDI x1, x0, 5
        mem[1] = 32'h00A00113;  // ADDI x2, x0, 10
        mem[2] = 32'h002081B3;  // ADD  x3, x1, x2
        mem[3] = 32'h00000013;  // NOP
    end

    assign instr = mem[addr[31:2]];  // addr>>2 converts byte address to word index
endmodule
