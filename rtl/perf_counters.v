`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.06.2026 08:00:11
// Design Name: 
// Module Name: perf_counters
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


module perf_counters(
    input        clk,
    input        rst,
    input        reg_write_wb,
    input        stall,
    input  [4:0] rd_wb,
    output reg [31:0] cycle_count,
    output reg [31:0] instr_count,
    output reg [31:0] stall_count,
    output reg [31:0] cpi_x100
);
    always @(posedge clk) begin
        if (rst) begin
            cycle_count <= 0;
            instr_count <= 0;
            stall_count <= 0;
            cpi_x100    <= 0;
        end
        else begin
            // count every cycle
            cycle_count <= cycle_count + 1;

            // count instructions reaching WB
            // exclude NOPs (rd=0, reg_write=0)
            if (reg_write_wb && rd_wb != 5'd0)
                instr_count <= instr_count + 1;

            // count stall cycles
            if (stall)
                stall_count <= stall_count + 1;

            // CPI x100 to avoid floating point
            // cpi = cycle_count / instr_count
            if (instr_count > 0)
                cpi_x100 <= (cycle_count * 100) / instr_count;
        end
    end
endmodule
