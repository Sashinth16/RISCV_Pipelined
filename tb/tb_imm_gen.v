`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2026 21:56:42
// Design Name: 
// Module Name: tb_imm_gen
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


module tb_imm_gen(

    );
    reg [2:0]imm_sel;
    reg [31:0]instr;
    wire [31:0]imm_out;
    
    imm_gen uut(.imm_sel(imm_sel),.instr(instr),.imm_out(imm_out));
    
    initial begin
        instr  = 32'h00500093;
        imm_sel = 3'b000;#10;

        instr  = 32'h00A00113;
        imm_sel = 3'b000;#10;
        
        $finish;
        
    end
    
    initial begin
        $monitor("time=%0t imm_sel=%b instr=%h imm_out=%d", $time, imm_sel, instr, imm_out);
    end
endmodule
