`timescale 1ns / 1ps

module dataMem_tb;

    reg clk;
    reg [3:0] icode;
    reg [63:0] valA;
    reg [63:0] valE;
    reg [63:0] valP;
    wire [63:0] valM;
    wire [0:0] dmem_error;

    memory dut (
        .clk(clk),
        .icode(icode),
        .valA(valA),
        .valE(valE),
        .valP(valP),
        .valM(valM),
        .dmem_error(dmem_error)
    );

    //always #5 clk = ~clk;

    initial begin
        $dumpfile("memory.vcd");
        $dumpvars(0, dataMem_tb);    
        clk = 0;
        valA = 0;
        valE = 0;
        valP = 0;
        icode = 0;


        // Test case 1: rmmovq or pushq
        clk=0;
        #10;
        valA = 64'h48E9230AF28C4B74;
        valE = 64'h00000000000002FF;
        valP = 64'h9463197C93D8910A;
        icode = 4'b0100;//4'b1010
        clk=1;
        #10;
        $display("Test Case 1: rmmovq operation - valA: %h, valP: %h, valE: %h, valM: %h, dmem error: %d", valA, valP, valE, valM, dmem_error);

        // Test case 2: mrmovq
        clk=0;
        #10;
        valA = 64'h48E9230AF28C4B74;
        valE = 64'h00000000000002FF;
        valP = 64'h9463197C93D8910A;
        icode = 4'b0101;
        clk=1;
        #10;
        $display("Test Case 2: mrmovq operation - valA: %h, valP: %h, valE: %h, valM: %h, dmem error: %d", valA, valP, valE, valM, dmem_error);

        // Test case 3: call
        clk=0;
        #100;
        valA = 64'h48E9230AF28C4B74;
        valE = 64'h0000000000000374;
        valP = 64'h9463197C93D8910A;
        icode = 4'b1000;
        clk=1;
        #100;
        $display("Test Case 3: call operation - valA: %h, valP: %h, valE: %h, valM: %h, dmem error: %d", valA, valP, valE, valM, dmem_error);

        // Test case 4: ret or popq
        clk=0;
        #100;
        valA = 64'h0000000000000374;
        valE = 64'h0941858AC02818FF;
        valP = 64'h9463197C93D8910A;
        icode = 4'b1001;
        clk=1;
        #100;
        $display("Test Case 4: ret operation - valA: %h, valP: %h, valE: %h, valM: %h, dmem error: %d", valA, valP, valE, valM, dmem_error);

        #100;
        $finish;
    end


endmodule
