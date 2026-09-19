`timescale 1ns / 1ps
module tb_multiply();

  localparam DATA_WIDTH  = 16;
  localparam COEFF_WIDTH = 16;
  localparam TAPS        = 8;
  
  logic clk, rst_n;
  logic signed [DATA_WIDTH-1:0] data [TAPS];
  logic signed [COEFF_WIDTH-1:0] coefficients [TAPS];
  logic signed [(DATA_WIDTH+COEFF_WIDTH-1):0] products [TAPS]; 
  
  multiply dut(
    .clk(clk),
    .rst_n(rst_n),
    .data(data),
    .coefficients(coefficients),
    .products(products)
  );
  
  always #10 clk = ~clk; //50MHz
  
  initial begin
    clk = 0;
    rst_n = 0;
    data         = '{default: 0};
    coefficients = '{default: 0};
    products = '{default: 0};
    //then lets wait 20ns
    #20;
    rst_n = 1;
    
    //Test 1:
    //@(posedge clk);
    //@(posedge clk); need to wait an extra clock cycle!
    data         = '{-32768, 5043, 16, 0, 0, 3, 32767, 32767};
    coefficients = '{-32768, -5, 12, 216, 14, -5000, 32767, -32768};
    
    //Test 2:
    
    @(posedge clk);
    @(posedge clk);
    
    $display("products: %d,  %d,  %d,  %d,  %d,  %d,  %d, %d", products[0], products[1], products[2], products[3], products[4], products[5], products[6], products[7]);
    $finish;
  end
endmodule