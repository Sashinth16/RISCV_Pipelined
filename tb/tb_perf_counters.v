`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.06.2026 08:02:37
// Design Name: 
// Module Name: tb_perf_counters
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


module tb_perf_counters;

    reg        clk, rst;
    reg        reg_write_wb, stall;
    reg [4:0]  rd_wb;
    wire [31:0] cycle_count, instr_count, stall_count, cpi_x100;

    perf_counters uut (
        .clk         (clk),
        .rst         (rst),
        .reg_write_wb(reg_write_wb),
        .stall       (stall),
        .rd_wb       (rd_wb),
        .cycle_count (cycle_count),
        .instr_count (instr_count),
        .stall_count (stall_count),
        .cpi_x100    (cpi_x100)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // reset everything
        rst=1; reg_write_wb=0; stall=0; rd_wb=5'd0; #10;
        rst=0;

        // 3 real instructions complete WB
        reg_write_wb=1; rd_wb=5'd1; #10;  // instr 1 - x1
        reg_write_wb=1; rd_wb=5'd2; #10;  // instr 2 - x2
        reg_write_wb=1; rd_wb=5'd3; #10;  // instr 3 - x3

        // 2 stall cycles
        reg_write_wb=0; rd_wb=5'd0;
        stall=1; #10;
        stall=1; #10;
        stall=0;

        // 2 more instructions
        reg_write_wb=1; rd_wb=5'd4; #10;
        reg_write_wb=1; rd_wb=5'd5; #10;

        // NOP - rd=0, should NOT increment instr_count
        reg_write_wb=1; rd_wb=5'd0; #10;

        // idle
        reg_write_wb=0; #20;

        $finish;
    end

    initial begin
        $monitor("time=%0t cycles=%d instrs=%d stalls=%d cpi_x100=%d",
                  $time, cycle_count, instr_count, stall_count, cpi_x100);
    end

endmodule
