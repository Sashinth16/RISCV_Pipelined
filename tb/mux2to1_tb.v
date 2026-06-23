`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2026 12:05:15
// Design Name: 
// Module Name: mux2to1_tb
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


module mux2to1_tb(

    );
    reg a,b,sel;
    wire y;
    
    mux2to1 uut (.sel(sel),.a(a),.b(b),.y(y));
    
    initial begin 
        sel = 0;a=1;b=0;#10;
        a=0;b=1;#10;
        sel=1;#10;
        
        $finish;
    end
    
    initial begin
        $monitor("time=%0t sel=%b a=%b b=%b y=%b", $time, sel, a, b, y);
    end
      
    
    
    
endmodule
