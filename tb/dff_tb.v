`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2026 08:10:03
// Design Name: 
// Module Name: dff_tb
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


module dff_tb(

    );
    reg clk;
    reg rst,d;
    wire q;
    
    initial clk = 0;
    always #5 clk = ~clk;   // toggles every 5 time units → 10 time unit period
    
    dff uut(.rst(rst),.d(d),.clk(clk),.q(q));
    
    initial begin 
        rst = 1;d=0;#10;
        rst=0;d=1;#10;
        d=0;#10;
        d=1;#10;
        d=1;#10;
        d=0;#10;
        d=1;#10;
        rst=1;#10;
        rst=0;
        d=1;#10;
       
        $finish;
    end
    
    initial begin
        $monitor("time=%0t rst=%b d=%b q=%b", $time, rst, d, q);
    end
         
endmodule
