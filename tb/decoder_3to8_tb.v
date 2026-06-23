`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2026 19:18:25
// Design Name: 
// Module Name: decoder_3to8_tb
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

module tb_decoder_3to8;

    reg  [2:0] sel;
    wire [7:0] y;

    decoder_3to8 uut (
        .sel(sel),
        .y(y)
    );

    initial begin
        sel = 3'b000; #10;
        sel = 3'b001; #10;
        sel = 3'b010; #10;
        sel = 3'b011; #10;
        sel = 3'b100; #10;
        sel = 3'b101; #10;
        sel = 3'b110; #10;
        sel = 3'b111; #10;

        $finish;
    end

    initial begin
        $monitor("time=%0t sel=%b y=%b", $time, sel, y);
    end


endmodule
