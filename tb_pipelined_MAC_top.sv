`timescale 1ns / 1ps

module tb_pipelined_MAC_top#(
    parameter TAPS = 8,
    parameter DATA_WIDTH = 16,
    parameter COEFF_WIDTH = 16,
    parameter WIDTH = DATA_WIDTH + COEFF_WIDTH
)
();
    //drive the inputs, not the outputs;
    logic clk, rst_n;
    logic signed [DATA_WIDTH-1:0] data [TAPS];
    logic signed [COEFF_WIDTH-1:0] coefficients [TAPS];
    logic signed [($clog2(TAPS))+WIDTH-1:0] sum;
    

    pipelined_MAC_top dut(
        .clk(clk),
        .rst_n(rst_n),
        .data(data),
        .coefficients(coefficients),
        .sum(sum)
    );
    
    always #10 clk = ~clk; //50MHz
    
    initial begin
        clk = 0;
        rst_n = 0; //active-low reset
        data         = '{default: 0};
        coefficients = '{default: 0};
        @(posedge clk);
        rst_n = 1;
        data         = '{-32768, 5043, 16, 0, 0, 3, 32767, 32767};
        coefficients = '{-32768, -5, 12, 216, 14, -5000, 32767, -32768};
        //Need to wait 4 posedges to get final result (3 for add , 1 for mult)
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        $display("Sum: %d", sum);
        $finish;
    end
endmodule
