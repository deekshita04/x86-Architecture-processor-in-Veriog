module enable_64(input [63:0] A , input [63:0] B , input enable , output [63:0] out_A , output [63:0] out_B);
genvar i;
generate
    for(i=0 ; i<64 ; i=i+1)
    begin
        and gate1(out_A[i],A[i],enable);
        and gate2(out_B[i],B[i],enable);
    end
endgenerate
endmodule

module enable_64_tb;

reg [63:0] A, B;
reg enable;
wire [63:0] out_A;
wire [63:0] out_B;

enable_64 uut (
    .out_A(out_A),
    .out_B(out_B),
    .enable(enable),
    .A(A),
    .B(B)
);

initial begin

    $dumpfile("enable.vcd");
    $dumpvars(0, enable_64_tb);

    A = 64'b0101010101010101010101010101010101010101010101010101010101010101;
    B = 64'b1010101010101010101010101010101011111111111111111111111111111111;
    enable=1'b0;

    $display("A = %b", A);
    $display("B = %b", B);

    #10;

    $display("out_A= %b\n", out_A);
    $display("out_B= %b\n", out_B);

    #10

    A = 64'b0101010101010101010101010101010101010101010101010101010101010101;
    B = 64'b0101010101010101010101010101010101010101010101010101010101010101;
    enable=1'b1;

    $display("A = %b", A);
    $display("B = %b", B);

    #10;

    $display("out_A = %b\n", out_A);
    $display("out_B= %b\n", out_B);


    $finish;

end

endmodule