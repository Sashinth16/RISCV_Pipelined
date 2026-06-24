`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2026 09:17:03
// Design Name: 
// Module Name: tb_mem_wb_reg
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


module tb_mem_wb_reg;
    reg clk, rst;
    reg [31:0] read_data_in, alu_result_in;
    reg [4:0]  rd_in;
    reg        mem_to_reg_in, reg_write_in;

    wire [31:0] read_data_out, alu_result_out;
    wire [4:0]  rd_out;
    wire        mem_to_reg_out, reg_write_out;

    mem_wb_reg uut (
        .clk(clk), .rst(rst),
        .read_data_in(read_data_in), .alu_result_in(alu_result_in),
        .rd_in(rd_in), .mem_to_reg_in(mem_to_reg_in),
        .reg_write_in(reg_write_in),
        .read_data_out(read_data_out), .alu_result_out(alu_result_out),
        .rd_out(rd_out), .mem_to_reg_out(mem_to_reg_out),
        .reg_write_out(reg_write_out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst=1; #10;
        rst=0;
        read_data_in=32'hABCD; alu_result_in=32'hF;
        rd_in=5'd3; mem_to_reg_in=1; reg_write_in=1; #10;

        read_data_in=32'h1234; alu_result_in=32'hFF;
        rd_in=5'd5; mem_to_reg_in=0; reg_write_in=1; #10;

        rst=1; #10;
        rst=0; #10;

        $finish;
    end

    initial begin
        $monitor("time=%0t rst=%b read_data_in=%h read_data_out=%h reg_write_out=%b",
                  $time, rst, read_data_in, read_data_out, reg_write_out);
    end
endmodule
