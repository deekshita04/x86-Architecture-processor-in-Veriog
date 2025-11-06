`timescale 1ns / 1ps

module decode_tb;

    reg clk;
    reg [3:0] icode;
    reg [3:0] rA;
    reg [3:0] rB;
    wire [63:0] valA;
    wire [63:0] valB;
    reg [63:0] reg_mem0;
    reg [63:0] reg_mem1;
    reg [63:0] reg_mem2;
    reg [63:0] reg_mem3;
    reg [63:0] reg_mem4;
    reg [63:0] reg_mem5;
    reg [63:0] reg_mem6;
    reg [63:0] reg_mem7;
    reg [63:0] reg_mem8;
    reg [63:0] reg_mem9;
    reg [63:0] reg_mem10;
    reg [63:0] reg_mem11;
    reg [63:0] reg_mem12;
    reg [63:0] reg_mem13;
    reg [63:0] reg_mem14;


    decode decode(
    .clk(clk),
    .icode(icode),
    .rA(rA),
    .rB(rB),
    .valA(valA),
    .valB(valB),
    .reg_mem0(reg_mem0),
    .reg_mem1(reg_mem1),
    .reg_mem2(reg_mem2),
    .reg_mem3(reg_mem3),
    .reg_mem4(reg_mem4),
    .reg_mem5(reg_mem5),
    .reg_mem6(reg_mem6),
    .reg_mem7(reg_mem7),
    .reg_mem8(reg_mem8),
    .reg_mem9(reg_mem9),
    .reg_mem10(reg_mem10),
    .reg_mem11(reg_mem11),
    .reg_mem12(reg_mem12),
    .reg_mem13(reg_mem13),
    .reg_mem14(reg_mem14)
    );

    always #5 clk = ~clk;

    initial begin
        clk=0;
        #10;

        // Test case 1: cmovxx
        icode = 4'b0010;
        rA = 4'b0000;
        rB = 4'b0010;
        reg_mem0 = 8'b01101001;
        reg_mem1 = 8'b00110101;
        reg_mem2 = 8'b00111110;
        reg_mem3 = 8'b11011001;
        reg_mem4 = 8'b00101011;
        reg_mem5 = 8'b11110010;
        reg_mem6 = 8'b01010111;
        reg_mem7 = 8'b00011010;
        reg_mem8 = 8'b10000100;
        reg_mem9 = 8'b11100110;
        reg_mem10 = 8'b01101001;
        reg_mem11 = 8'b00110101;
        reg_mem12 = 8'b00111110;
        reg_mem13 = 8'b11011001;
        reg_mem14 = 8'b00101011;
        #10;
        $display("Test Case 1: cmovxx, rA=%d, rb=%d, valA=%d, valB=%d",rA, rB, valA, valB);

        
        #10;
        #10;
        // Test case 2: mrmov
        icode = 4'b0101;
        rA = 4'b0001;
        rB = 4'b0110;
        reg_mem0 = 8'b01101001;
        reg_mem1 = 8'b00110101;
        reg_mem2 = 8'b00111110;
        reg_mem3 = 8'b11011001;
        reg_mem4 = 8'b00101011;
        reg_mem5 = 8'b11110010;
        reg_mem6 = 8'b01010111;
        reg_mem7 = 8'b00011010;
        reg_mem8 = 8'b10000100;
        reg_mem9 = 8'b11100110;
        reg_mem10 = 8'b01101001;
        reg_mem11 = 8'b00110101;
        reg_mem12 = 8'b00111110;
        reg_mem13 = 8'b11011001;
        reg_mem14 = 8'b00101011;
        #10;
        $display("Test Case 2: mrmov,rA=%d, rb=%d, valA=%d, valB=%d",rA, rB, valA, valB);
        #10;

        // Test case 3: rmmov
        icode = 4'b0100;
        rA = 4'b0100;
        rB = 4'b0011;
        reg_mem0 = 8'b01101001;
        reg_mem1 = 8'b00110101;
        reg_mem2 = 8'b00111110;
        reg_mem3 = 8'b11011001;
        reg_mem4 = 8'b00101011;
        reg_mem5 = 8'b11110010;
        reg_mem6 = 8'b01010111;
        reg_mem7 = 8'b00011010;
        reg_mem8 = 8'b10000100;
        reg_mem9 = 8'b11100110;
        reg_mem10 = 8'b01101001;
        reg_mem11 = 8'b00110101;
        reg_mem12 = 8'b00111110;
        reg_mem13 = 8'b11011001;
        reg_mem14 = 8'b00101011;
        #10;
        $display("Test Case 3: rmmov, rA=%d, rb=%d, valA=%d, valB=%d",rA, rB, valA, valB);
        #10;

        // Test case 4: call
        icode = 4'b1000;
        rA = 4'b0111;
        rB = 4'b0110;
        reg_mem0 = 8'b01101001;
        reg_mem1 = 8'b00110101;
        reg_mem2 = 8'b00111110;
        reg_mem3 = 8'b11011001;
        reg_mem4 = 8'b00101011;
        reg_mem5 = 8'b11110010;
        reg_mem6 = 8'b01010111;
        reg_mem7 = 8'b00011010;
        reg_mem8 = 8'b10000100;
        reg_mem9 = 8'b11100110;
        reg_mem10 = 8'b01101001;
        reg_mem11 = 8'b00110101;
        reg_mem12 = 8'b00111110;
        reg_mem13 = 8'b11011001;
        reg_mem14 = 8'b00101011;       
        #10;
        $display("Test Case 4: call, rA=%d, rb=%d, valA=%d, valB=%d",rA, rB, valA, valB);
        #10;

        // Test case 5: ret
        icode = 4'b1001;
        rA = 4'b0100;
        rB = 4'b1010;
        reg_mem0 = 8'b01101001;
        reg_mem1 = 8'b00110101;
        reg_mem2 = 8'b00111110;
        reg_mem3 = 8'b11011001;
        reg_mem4 = 8'b00101011;
        reg_mem5 = 8'b11110010;
        reg_mem6 = 8'b01010111;
        reg_mem7 = 8'b00011010;
        reg_mem8 = 8'b10000100;
        reg_mem9 = 8'b11100110;
        reg_mem10 = 8'b01101001;
        reg_mem11 = 8'b00110101;
        reg_mem12 = 8'b00111110;
        reg_mem13 = 8'b11011001;
        reg_mem14 = 8'b00101011;
        #10;
        $display("Test Case 5: ret, rA=%d, rb=%d, valA=%d, valB=%d",rA, rB, valA, valB);
        #10;

        // Test case 6: push
        icode = 4'b1010;
        rA = 4'b1001;
        rB = 4'b1100;
        reg_mem0 = 8'b01101001;
        reg_mem1 = 8'b00110101;
        reg_mem2 = 8'b00111110;
        reg_mem3 = 8'b11011001;
        reg_mem4 = 8'b00101011;
        reg_mem5 = 8'b11110010;
        reg_mem6 = 8'b01010111;
        reg_mem7 = 8'b00011010;
        reg_mem8 = 8'b10000100;
        reg_mem9 = 8'b11100110;
        reg_mem10 = 8'b01101001;
        reg_mem11 = 8'b00110101;
        reg_mem12 = 8'b00111110;
        reg_mem13 = 8'b11011001;
        reg_mem14 = 8'b00101011;
        #10;
        $display("Test Case 6: push, rA=%d, rb=%d, valA=%d, valB=%d",rA, rB, valA, valB);

        icode = 4'b0110;
        rA = 4'b0110;
        rB = 4'b1001;
        reg_mem0 = 8'b01101001;
        reg_mem1 = 8'b00110101;
        reg_mem2 = 8'b00111110;
        reg_mem3 = 8'b11011001;
        reg_mem4 = 8'b00101011;
        reg_mem5 = 8'b11110010;
        reg_mem6 = 8'b01010111;
        reg_mem7 = 8'b00011010;
        reg_mem8 = 8'b10000100;
        reg_mem9 = 8'b11100110;
        reg_mem10 = 8'b01101001;
        reg_mem11 = 8'b00110101;
        reg_mem12 = 8'b00111110;
        reg_mem13 = 8'b11011001;
        reg_mem14 = 8'b00101011;
        #10
        $display("Test Case 6: opq, rA=%d, rb=%d, valA=%d, valB=%d",rA, rB, valA, valB);




        #10;
        $finish;
    end

endmodule


