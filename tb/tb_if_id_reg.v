`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2026 07:37:50
// Design Name: 
// Module Name: tb_if_id_reg
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


module tb_if_id_reg(

    );
    reg rst,clk;
    reg stall,flush;
    reg [31:0] instr_in,pc_in;
    wire [31:0] instr_out,pc_out;
    
    if_id_reg uut(.rst(rst),.clk(clk),.flush(flush),.stall(stall),.instr_in(instr_in),.pc_in(pc_in),.pc_out(pc_out),.instr_out(instr_out));
    
    
    initial clk =0;
    always #5 clk = ~clk;
    
    initial begin
        rst=1;#10;
        rst=0;instr_in=32'hAAA;pc_in=32'hBBB;#10
        flush=1;#10;
        flush=0;#20;
        instr_in=32'h108;pc_in=32'hF24;#10;
        stall=1;instr_in=32'hD13;pc_in=32'hE65;#10;
        stall=0;#10;
        rst=1;#10;
        stall=1;flush=1;#10;rst=0;
        stall=0;instr_in=32'hAAAA;pc_in=32'h645;#10;
        flush=0;#20;
        
        $finish;
        
        
    end 
    
    initial begin
        $monitor("time=%0t rst=%b flush=%b stall=%b pc_in=%h instr_in=%h pc_out=%h instr_out=%h",
          $time, rst, flush, stall, pc_in, instr_in, pc_out, instr_out);
    end
endmodule
