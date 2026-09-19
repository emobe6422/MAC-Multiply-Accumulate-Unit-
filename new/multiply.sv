`timescale 1ns/1ps

module multiply #(
    parameter TAPS = 8,
    parameter DATA_WIDTH = 16,
    parameter COEFF_WIDTH = 16,
    parameter WIDTH = DATA_WIDTH + COEFF_WIDTH
)
(

//signed btw! sv infers as unsigned right off rip. Keep as unsigned for now tho for funsies
    input logic clk,
    input logic rst_n,
    input logic signed [DATA_WIDTH-1:0] data [TAPS],
    input logic signed [COEFF_WIDTH-1:0] coefficients [TAPS],
    //one extra bit in the unsigned case to account for the highest possible #
    output logic signed [WIDTH-1:0] products [TAPS]  
    //Adding [TAPS] at the end ... Boils down to the difference between packed/unpacked arrays
);

    genvar i;
    
    generate
        for (i = 0; i < TAPS; i++) begin : multi_unit //WE NEED TO ASSIGN A NAME FOR INDIVIDUALLY ADDRESSING EACH UNIT
            always_ff @ (posedge clk) begin
                //initial assigment 
                if (!rst_n) begin
                    products[i] <= 0;
                end else begin
                    products[i] <= coefficients[i]*data[i];
                end
            end
         end
    endgenerate
endmodule