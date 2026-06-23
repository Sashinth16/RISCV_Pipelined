`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2026 20:59:33
// Design Name: 
// Module Name: tb_imem
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


module tb_imem(

    );
    reg [31:0]addr;
    wire [31:0]instr;
    
    imem uut (
    .addr(addr),
    .instr(instr)
);
    
    initial begin
        addr=32'd8;#10;
        addr=32'd17;#10;
        addr=32'd13;#10;
        addr=32'd3;#10;
        
        $finish;
        
    end
    
    initial begin
        $monitor("time=%0t,addr=%d,instr=%h",$time,addr,instr);
    end
endmodule
