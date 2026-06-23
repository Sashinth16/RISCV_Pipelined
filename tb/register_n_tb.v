`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2026 12:24:13
// Design Name: 
// Module Name: register_n_tb
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


module register_n_tb(

    );
    reg [7:0]d;
    wire [7:0]q;
    reg rst;
    reg clk;
    
    initial clk=0;
    always #5 clk=~clk;
    
    register_n uut(.rst(rst),.clk(clk),.d(d),.q(q));
    
    initial begin
    
    rst=1;d=8'hA;#10;
    rst=0;
    d=8'hAA;#10;
    d=8'h8A;#10;
    d=8'hFF;#10;
    rst=1;d=8'h16;#10;
    rst=0;#5;
    d=8'h88;#10;
    
    $finish;
    end
    
    initial begin
        $monitor("time=%0t rst=%b d=%h q=%h", $time, rst, d, q);
    end
    
endmodule
