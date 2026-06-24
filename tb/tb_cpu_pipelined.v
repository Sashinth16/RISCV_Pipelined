`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2026 11:18:47
// Design Name: 
// Module Name: tb_cpu_pipelined
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


module tb_cpu_pipelined;

    reg clk, rst;

    cpu_pipelined uut (
        .clk(clk),
        .rst(rst)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    
    initial begin
        uut.IMEM.mem[0] = 32'h00500093; // ADDI x1, x0, 5
        uut.IMEM.mem[1] = 32'h00A00113; // ADDI x2, x0, 10
        uut.IMEM.mem[2] = 32'h002081B3; // ADD  x3, x1, x2
        uut.IMEM.mem[3] = 32'h00000013; // NOP
    end

    initial begin
        rst = 1; #10; 
        rst = 0;       
        #150;          
        $finish;
    end

    initial begin
        $monitor("time=%0t pc=%h instr_id=%h alu_result_wb=%h reg_write_wb=%b rd_wb=%d",
                  $time, uut.pc_out, uut.instr_id,
                  uut.alu_result_wb, uut.reg_write_wb, uut.rd_wb);
    end

endmodule
