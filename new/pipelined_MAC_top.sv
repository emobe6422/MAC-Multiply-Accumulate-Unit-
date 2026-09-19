`timescale 1ns / 1ps

module pipelined_MAC_top#(
    parameter TAPS = 8,
    parameter DATA_WIDTH = 16,
    parameter COEFF_WIDTH = 16,
    parameter WIDTH = DATA_WIDTH + COEFF_WIDTH
)
(
    input logic clk, rst_n,
    input logic signed [DATA_WIDTH-1:0] data [TAPS],
    input logic signed [COEFF_WIDTH-1:0] coefficients [TAPS],
    output logic signed [($clog2(TAPS))+WIDTH-1:0] sum
    );
    
    logic signed [WIDTH-1:0] products [TAPS];
    
    multiply multiply(
        .clk(clk),
        .rst_n(rst_n),
        .data(data),
        .coefficients(coefficients),
        .products(products)
    );
    
    add add(
        .clk(clk),
        .rst_n(rst_n),
        .products(products),
        .sum(sum)
    );
endmodule