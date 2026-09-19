`timescale 1ns/1ps

module tb_add#(
    parameter TAPS = 8,
    parameter DATA_WIDTH = 16,
    parameter COEFF_WIDTH = 16,
    parameter WIDTH = DATA_WIDTH + COEFF_WIDTH
    )
    ();
    
    logic clk, rst_n;
    logic signed [WIDTH-1:0] products [TAPS];
    logic signed [($clog2(TAPS))+WIDTH-1:0] sum;
    
    add dut(
        .clk(clk),
        .rst_n(rst_n),
        .products(products),
        .sum(sum)
    );
    
    always #10 clk = ~clk; //50MHz
    
    initial begin
        //IN A TB WE ONLY DRIVE INPUTS NOT OUTPUTS. Hence sum should not be set to anything
        clk = 0;
        rst_n = 0; //active-low reset
        //sum = '0;
        products = '{default:0};
        #20;
        rst_n = 1;
        products = '{1073741824, -25215, 192, 0, 0, -15000, 1073676289, -1073709056};
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        $display("Sum equals: %d", sum);
        $finish;
    end
endmodule