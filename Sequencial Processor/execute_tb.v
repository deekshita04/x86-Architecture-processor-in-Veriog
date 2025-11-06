`timescale 1ns / 1ps

module execute_tb;

    reg clk;
    reg [63:0] valA;
    reg [63:0] valB;
    reg [63:0] valC;
    reg [3:0] ifun;
    reg [3:0] icode;
    wire sf;
    wire zf;
    wire of;
    wire [63:0] valE;
    wire [0:0] cond;

    execute dut (
        .clk(clk),
        .valA(valA),
        .valB(valB),
        .valC(valC),
        .ifun(ifun),
        .icode(icode),
        .sf(sf),
        .zf(zf),
        .of(of),
        .valE(valE),
        .cond(cond)
    );

    always #5 clk=~clk;

    initial begin

        // Test case 1: irmovq
        clk=0;
        #10;
        icode = 4'b0011;
        valA = 64'h1122334455667788;
        valB = 64'h99AABBCCDDEEFF00;
        valC = 64'hAA11223344556677;
        ifun = 4'b0000;
        //sf = 0;
        //zf = 0;
        //of = 0;
        clk=1;
        #10;
        $display("Test Case 1:irmovq valA=%d, valB=%d, valC=%d, valE=%d, cond=%d",valA, valB, valC, valE, cond);

        // Test case 2: opq
        clk=0;
        #10;
        icode = 4'b0110;
        valA = 64'h1122334455667788;
        valB = 64'h99AABBCCDDEEFF00;
        valC = 64'hAA11223344556677;
        ifun = 4'b0000; // add
        //sf = 1;
        //zf = 0;
        //of = 0;
        clk=1;
        #10;
        $display("Test Case 2:opq add valA=%d, valB=%d, valC=%d, valE=%d, cond=%d",valA, valB, valC, valE, cond);

        #10;

        // Test case 3: cmovxx
        clk=0;
        #10;
        icode = 4'b0010;
        valA = 64'h019282A9729F982C;
        valB = 64'h0281578827B25D62;
        valC = 64'h82028736A627E816;
        ifun = 4'b0001; // cmovle
        //sf = 1;
        //zf = 1;
        //of = 0;
        clk=1;
        #10;
        $display("Test Case 3:cmovle valA=%d, valB=%d, valC=%d, valE=%d, cond=%d",valA, valB, valC, valE, cond);

        // Test case 4: jxx
        clk=0;
        #10;
        icode = 4'b0111;
        valA = 64'h1122334455667788;
        valB = 64'h99AABBCCDDEEFF00;
        valC = 64'hAA11223344556677;
        ifun = 4'b0001; // jle
        //sf = 0;
        //zf = 0;
        //of = 0;
        clk=1;
        #10;
        $display("Test Case 4:jle valA=%d, valB=%d, valC=%d, valE=%d, cond=%d",valA, valB, valC, valE, cond);

        // Test case 5: call
        clk=0;
        #10;
        icode = 4'b1000;
        valA = 64'h1122334455667788;
        valB = 64'h99AABBCCDDEEFF09;
        valC = 64'hAA11223344556677;
        ifun = 4'b0000; // call
        //sf = 0;
        //zf = 0;
        //of = 0;
        clk=1;
        #10;
        $display("Test Case 5:call valA=%d, valB=%d, valC=%d, valE=%d, cond=%d",valA, valB, valC, valE, cond);

        #10;
        $finish;
    end

endmodule
