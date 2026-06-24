`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2026 11:12:01
// Design Name: 
// Module Name: tb_branch_predictor
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


module tb_branch_predictor;

    reg  branch, zero;
    wire taken;

    branch_predictor uut (
        .branch(branch),
        .zero  (zero),
        .taken (taken)
    );

    initial begin
        branch=0; zero=0; #10;  
        branch=1; zero=0; #10;  
        branch=0; zero=1; #10;  
        branch=1; zero=1; #10;  
        $finish;
    end

    initial begin
        $monitor("time=%0t branch=%b zero=%b taken=%b",
                  $time, branch, zero, taken);
    end

endmodule
