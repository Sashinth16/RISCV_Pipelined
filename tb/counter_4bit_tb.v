`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2026 13:00:01
// Design Name: 
// Module Name: counter_4bit_tb
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


module counter_4bit_tb(

    );
    reg clk;
    reg rst;
    wire [3:0]count;
    
    counter_4bit uut (.clk(clk),.rst(rst),.count(count));
    
    initial clk =0;
    always #5 clk =~clk;
    
    initial begin
    rst =1;#10;
    rst=0;#70;
    rst=1;#20;
    rst=0;#240;
    
    $finish;
    end
    
    initial begin
        $monitor("time=%0t rst=%b count=%b", $time, rst, count);
    end
    
endmodule
