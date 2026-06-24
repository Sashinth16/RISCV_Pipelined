`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2026 09:26:49
// Design Name: 
// Module Name: tb_hazard_unit
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


module tb_hazard_unit;

    reg        id_ex_mem_read;
    reg [4:0]  id_ex_rd, if_id_rs1, if_id_rs2;
    wire       stall, flush_id_ex;

    hazard_unit uut (
        .id_ex_mem_read(id_ex_mem_read),
        .id_ex_rd      (id_ex_rd),
        .if_id_rs1     (if_id_rs1),
        .if_id_rs2     (if_id_rs2),
        .stall         (stall),
        .flush_id_ex   (flush_id_ex)
    );

    initial begin

        id_ex_mem_read=0; id_ex_rd=5'd1;
        if_id_rs1=5'd1; if_id_rs2=5'd2; #10;

        id_ex_mem_read=1; id_ex_rd=5'd1;
        if_id_rs1=5'd1; if_id_rs2=5'd2; #10;

        id_ex_mem_read=1; id_ex_rd=5'd2;
        if_id_rs1=5'd1; if_id_rs2=5'd2; #10;

        id_ex_mem_read=1; id_ex_rd=5'd5;
        if_id_rs1=5'd1; if_id_rs2=5'd2; #10;

        id_ex_mem_read=1; id_ex_rd=5'd1;
        if_id_rs1=5'd1; if_id_rs2=5'd1; #10;

        $finish;
    end

    initial begin
        $monitor("time=%0t mem_read=%b rd=%d rs1=%d rs2=%d stall=%b flush=%b",
                  $time, id_ex_mem_read, id_ex_rd,
                  if_id_rs1, if_id_rs2, stall, flush_id_ex);
    end

endmodule
