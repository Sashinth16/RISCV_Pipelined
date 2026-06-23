`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2026 10:13:00
// Design Name: 
// Module Name: tb_regfile
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


module tb_regfile;

    reg         clk, we;
    reg  [4:0]  rs1, rs2, rd;
    reg  [31:0] wd;
    wire [31:0] rd1, rd2;

    regfile uut (
        .clk(clk),
        .we(we),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .wd(wd),
        .rd1(rd1),
        .rd2(rd2)
    );

    // clock generator
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // test 1: no write, check nothing breaks
        we = 0; rs1 = 5'd1; rs2 = 5'd2;
        rd = 5'd0; wd = 32'd0; #10;

        // test 2: write 0xAAAA into x1, read it back
        we = 1; rd = 5'd1; wd = 32'hAAAA; #10;
        we = 0; rs1 = 5'd1; #10;

        // test 3: write 0xBBBB into x2, read it back
        we = 1; rd = 5'd2; wd = 32'hBBBB; #10;
        we = 0; rs2 = 5'd2; #10;

        // test 4: try writing to x0, confirm rd1 still returns 0
        we = 1; rd = 5'd0; wd = 32'hFFFF; #10;
        we = 0; rs1 = 5'd0; #10;

        // test 5: we=0, try writing to x1, confirm rd1 still holds 0xAAAA
        we = 0; rd = 5'd1; wd = 32'hDEAD; #10;
        rs1 = 5'd1; #10;

        $finish;
    end

    initial begin
        $monitor("time=%0t we=%b rd=%d wd=%h rs1=%d rd1=%h rs2=%d rd2=%h",
                  $time, we, rd, wd, rs1, rd1, rs2, rd2);
    end

endmodule
