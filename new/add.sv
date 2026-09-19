`timescale 1ns / 1ps

module add#(
    parameter TAPS = 8,
    parameter DATA_WIDTH = 16,
    parameter COEFF_WIDTH = 16,
    parameter WIDTH = DATA_WIDTH + COEFF_WIDTH
)
(
    input logic clk, rst_n,
    input logic signed [WIDTH-1:0] products [TAPS],
    output logic signed [($clog2(TAPS))+WIDTH-1:0] sum
);
    logic signed [WIDTH:0] one_1, one_2, one_3, one_4;
    logic signed [WIDTH+1:0] two_1, two_2;
    
    always_ff @ (posedge clk) begin
        if (!rst_n) begin
            one_1 <= '0;
            one_2 <= '0;
            one_3 <= '0;
            one_4 <= '0;
        end else begin
            one_1 <= products[0] + products[1];
            one_2 <= products[2] + products[3];
            one_3 <= products[4] + products[5];
            one_4 <= products[6] + products[7];
        end
    end
    always_ff @ (posedge clk) begin
        if (!rst_n) begin
            two_1 <= '0;
            two_2 <= '0;
        end else begin
            two_1 <= one_1 + one_2;
            two_2 <= one_3 + one_4;
        end
    end
    always_ff @ (posedge clk) begin
        if (!rst_n) begin
            sum <= '0;
        end else begin
            sum <= two_1 + two_2;
        end
    end
endmodule
