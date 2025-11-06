module sub(a,b,sum,c_out);
    input [63:0] a,b;
    output [63:0] sum;
    output c_out;
    
    wire [63:0]c;

    wire [63:0] neg_b;
    wire l = 1'b1;

    genvar j;
    generate for (j=0; j<64; j=j+1)
        begin
            not(neg_b[j], b[j]);
        end
    endgenerate

    full_adder a0(a[0],neg_b[0],l,sum[0],c[0]);

    genvar i;
    generate for(i=1; i<64; i=i+1)
        begin
            full_adder a1(a[i],neg_b[i],c[i-1],sum[i],c[i]);
        end
    endgenerate
    
    //full_adder a2(a[63],neg_b[63],c[62],sum[63],c_out);
    xor x1(overflow, c[62], c[63]);

endmodule

//module full_adder(a, b, c_in, out, c_out);
//    input a, b, c_in;
//    output out, c_out;
//    wire x,y,k;
//    xor(x, a, b);
//    xor(out, x, c_in);
//    and(y, a, b);
//    and(k, x, c_in);
//    or(c_out, k, y);
//endmodule


//module tb_sub;
//    reg [63:0] a, b;
//    wire [63:0] sum;
//    wire c_out;
//    sub uut(
//        .a(a),
//        .b(b),
//        .sum(sum),
//        .c_out(c_out)
//    );
//initial begin
//
//    $dumpfile("sub.vcd");
//    $dumpvars(0, tb_sub);
//        a = 64'b1101101101101101101101101101101101101101101101101101101101101101;
//        b = 64'b0010101010101010101010101010101010101010101010101010101010101010;
//        $monitor("Test Case 1: a=%b, b=%b, out=%b,c_out=%b", a, b, sum,c_out);
//        #10
//        a = 64'b1101101101101101101101101101101101101101101101101101101101101101;
//        b = 64'b1010101010101010101010101010101010101010101010101010101010101010;
//        $monitor("Test Case 2: a=%b, b=%b, out=%b,c_out=%b", a, b, sum,c_out);
//        #10
//        a = 64'b0111001110011100111001110011100111001110011100111001110011100;
//        b = 64'b1000111100001111000011110000111100001111000011110000111100000;
//        $monitor("Test Case 3: a=%b, b=%b, out=%b,c_out=%b", a, b, sum,c_out);
//        #10
//        a = 64'b0111001110011100111001110011100111001110011100111001110011100;
//        b = 64'b1000111100001111000011110000111100001111000011110000111100000;
//        $monitor("Test Case 4: a=%b, b=%b, out=%b,c_out=%b", a, b, sum,c_out);
//        #10
//        a = 64'b1111111111111111111111111111111111111111111111111111111111111110;
//        b = 64'b1111111111111111111111111111111111111111111111111111111111111110;
//        $monitor("Test Case 5: a=%b, b=%b, out=%b,c_out=%b", a, b, sum,c_out);
//        #10
//        a = 64'b0111111111111111111111111111111111111111111111111111111111111111;
//        b = 64'b0111111111111111111111111111111111111111111111111111111111111111;
//        $monitor("Test Case 6: a=%b, b=%b, out=%b,c_out=%b", a, b, sum,c_out);
//        #10
//        $finish;
//end
//endmodule