`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2026 16:04:38
// Design Name: 
// Module Name: tb_pc
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


module tb_pc(

    );
    reg clk,rst;
    reg [31:0]pc_next;
    wire [31:0]pc_out;
    
    pc uut(.rst(rst),.clk(clk),.pc_next(pc_next),.pc_out(pc_out));
    
    initial clk =0;
    always #5 clk=~clk;
    
    initial begin 
        rst = 1;#10;
        rst =0 ;pc_next=32'd4;#10;
        pc_next=32'd8;#10;
        pc_next = 32'hABCD;#10;
        rst =1;#20;
        
        $finish;
          
    end
    
    initial begin 
        $monitor("time=%0t rst=%b pc_next=%h pc_out=%h", $time, rst, pc_next, pc_out);
    end
endmodule
