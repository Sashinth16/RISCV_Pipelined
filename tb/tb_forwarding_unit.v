`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2026 10:57:58
// Design Name: 
// Module Name: tb_forwarding_unit
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

module tb_forwarding_unit;

    reg [4:0] id_ex_rs1, id_ex_rs2;
    reg [4:0] ex_mem_rd, mem_wb_rd;
    reg       ex_mem_reg_write, mem_wb_reg_write;
    wire [1:0] forward_a, forward_b;

    forwarding_unit uut (
        .id_ex_rs1      (id_ex_rs1),
        .id_ex_rs2      (id_ex_rs2),
        .ex_mem_rd      (ex_mem_rd),
        .mem_wb_rd      (mem_wb_rd),
        .ex_mem_reg_write(ex_mem_reg_write),
        .mem_wb_reg_write(mem_wb_reg_write),
        .forward_a      (forward_a),
        .forward_b      (forward_b)
    );

    initial begin

        ex_mem_reg_write=0; mem_wb_reg_write=0;
        ex_mem_rd=5'd1; mem_wb_rd=5'd2;
        id_ex_rs1=5'd1; id_ex_rs2=5'd2; #10;

        ex_mem_reg_write=1; mem_wb_reg_write=0;
        ex_mem_rd=5'd1; id_ex_rs1=5'd1; id_ex_rs2=5'd3; #10;

        ex_mem_reg_write=0; mem_wb_reg_write=1;
        mem_wb_rd=5'd2; id_ex_rs1=5'd3; id_ex_rs2=5'd2; #10;

        ex_mem_reg_write=1; mem_wb_reg_write=1;
        ex_mem_rd=5'd1; mem_wb_rd=5'd1;
        id_ex_rs1=5'd1; id_ex_rs2=5'd4; #10;

        ex_mem_reg_write=1; mem_wb_reg_write=1;
        ex_mem_rd=5'd0; mem_wb_rd=5'd0;
        id_ex_rs1=5'd0; id_ex_rs2=5'd0; #10;

        $finish;
    end

    initial begin
        $monitor("time=%0t fwd_a=%b fwd_b=%b | ex_rw=%b ex_rd=%d mem_rw=%b mem_rd=%d rs1=%d rs2=%d",
                  $time, forward_a, forward_b,
                  ex_mem_reg_write, ex_mem_rd,
                  mem_wb_reg_write, mem_wb_rd,
                  id_ex_rs1, id_ex_rs2);
    end

endmodule
