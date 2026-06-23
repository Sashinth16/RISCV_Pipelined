`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2026 11:25:47
// Design Name: 
// Module Name: tb_dmem
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


module tb_dmem;

    reg         clk, mem_read, mem_write;
    reg  [31:0] addr, write_data;
    wire [31:0] read_data;

    dmem uut (
        .clk       (clk),
        .mem_read  (mem_read),
        .mem_write (mem_write),
        .addr      (addr),
        .write_data(write_data),
        .read_data (read_data)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        mem_write = 1; mem_read = 0;
        addr = 32'd8; write_data = 32'hDEAD; #10;

        mem_write = 0; mem_read = 1;
        addr = 32'd8; #10;

        mem_read = 0; #10;

        mem_write = 0; mem_read = 0;
        addr = 32'd8; write_data = 32'hBEEF; #10;
        mem_read = 1; #10;

        $finish;
    end

    initial begin
        $monitor("time=%0t mw=%b mr=%b addr=%d wdata=%h rdata=%h",
                  $time, mem_write, mem_read, addr, write_data, read_data);
    end

endmodule
