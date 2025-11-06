module decoder_block (
    input [1:0] A,
    output out1,
    output out2,
    output out3,
    output out4
);
and gate1 (out1, ~A[0], ~A[1]);
and gate2 (out2, A[0], ~A[1]);
and gate3 (out3, ~A[0], A[1]);
and gate4 (out4, A[0], A[1]);

endmodule


module testbench_decoder;
  reg [1:0] A;
  wire out1, out2, out3, out4;
  decoder_block uut (
    .A(A),
    .out1(out1),
    .out2(out2),
    .out3(out3),
    .out4(out4)
  );
  initial begin
    $dumpfile("decoder.vcd");
    $dumpvars(0, testbench_decoder);
    
    A = 2'b00; 
    $display("Test Case 1: A = %b", A);
    #10;
    $display("out1 = %b, out2 = %b, out3 = %b, out4 = %b", out1, out2, out3, out4);
    A = 2'b10;
    $display("Test Case 2: A = %b", A);
    #10;
    $display("out1 = %b, out2 = %b, out3 = %b, out4 = %b", out1, out2, out3, out4);
    $finish;
  end
endmodule