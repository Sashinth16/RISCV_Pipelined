`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2026 09:25:57
// Design Name: 
// Module Name: hazard_unit
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


module hazard_unit(
    input         id_ex_mem_read,
    input  [4:0]  id_ex_rd,
    input  [4:0]  if_id_rs1,
    input  [4:0]  if_id_rs2,
    output        stall,
    output        flush_id_ex
);
    assign stall      = id_ex_mem_read &
                        ((id_ex_rd == if_id_rs1) |
                         (id_ex_rd == if_id_rs2));
    assign flush_id_ex = stall;
endmodule
