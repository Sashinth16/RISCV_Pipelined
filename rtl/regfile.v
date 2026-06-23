`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2026 10:02:15
// Design Name: 
// Module Name: regfile
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


module regfile(
    input clk,
    input we,
    input [4:0]rs1,
    input [4:0]rs2,
    input [4:0]rd,
    input [31:0]wd,
    output [31:0]rd1,
    output [31:0]rd2
    );
    
    reg [31:0] regs [0:31];
    
    assign rd1 = (rs1 == 5'd0) ? 32'd0 : regs[rs1];
    assign rd2 = (rs2 == 5'd0) ? 32'd0 : regs[rs2];
    
    always @(posedge clk) begin 
        if(we) begin
            regs[rd] <= wd;
        end
    end
    
endmodule
