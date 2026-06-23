`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2026 19:51:31
// Design Name: 
// Module Name: tb_alu
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


module tb_alu(

    );
    reg [31:0]a,b; 
    reg [2:0]alu_ctrl;
    wire zero;
    wire [31:0]result;
    
    alu uut(.a(a),.b(b),.alu_ctrl(alu_ctrl),.zero(zero),.result(result));
    
    initial begin 
    
    a=32'd10;b=32'd5;alu_ctrl=3'b000;#10;
    alu_ctrl=3'b001;#10;
    a=32'd1;b=32'd3;alu_ctrl=3'b010;#10;
    alu_ctrl=3'b011;#10;
    alu_ctrl=3'b100;#10;
    alu_ctrl=3'b101;#10;
    a=32'd5; b=32'd5; alu_ctrl=3'b001; #10;  // SUB: 5-5=0, zero should go HIGH
    
    $finish;
    
    end
    
    initial begin
        $monitor("time=%0t alu_ctrl=%b a=%d b=%d result=%d zero=%b", 
          $time, alu_ctrl, a, b, result, zero);
    end
endmodule
