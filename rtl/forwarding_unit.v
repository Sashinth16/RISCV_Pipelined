`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2026 10:56:55
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit(
    input      [4:0] id_ex_rs1, id_ex_rs2,
    input      [4:0] ex_mem_rd, mem_wb_rd,
    input            ex_mem_reg_write, mem_wb_reg_write,
    output reg [1:0] forward_a, forward_b
);
    always @(*) begin
        // Forward A (rs1)
        if (ex_mem_reg_write && ex_mem_rd != 0
            && ex_mem_rd == id_ex_rs1)
            forward_a = 2'b10;  // EX forwarding
        else if (mem_wb_reg_write && mem_wb_rd != 0
            && mem_wb_rd == id_ex_rs1)
            forward_a = 2'b01;  // MEM forwarding
        else
            forward_a = 2'b00;  // no forwarding

        // Forward B (rs2)
        if (ex_mem_reg_write && ex_mem_rd != 0
            && ex_mem_rd == id_ex_rs2)
            forward_b = 2'b10;  // EX forwarding
        else if (mem_wb_reg_write && mem_wb_rd != 0
            && mem_wb_rd == id_ex_rs2)
            forward_b = 2'b01;  // MEM forwarding
        else
            forward_b = 2'b00;  // no forwarding
    end
endmodule