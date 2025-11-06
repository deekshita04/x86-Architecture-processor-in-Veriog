`timescale 1ns / 1ps

module writeback_tb;

    reg clk;
    reg [3:0] icode;
    reg [3:0] rA;
    reg [3:0] rB;
    reg [63:0] valE;
    reg [63:0] valM;
    wire [63:0] regmem0;
    wire [63:0] regmem1;
    wire [63:0] regmem2;
    wire [63:0] regmem3;
    wire [63:0] regmem4;
    wire [63:0] regmem5;
    wire [63:0] regmem6;
    wire [63:0] regmem7;
    wire [63:0] regmem8;
    wire [63:0] regmem9;
    wire [63:0] regmem10;
    wire [63:0] regmem11;
    wire [63:0] regmem12;
    wire [63:0] regmem13;
    wire [63:0] regmem14;

    reg cond;

    writeback wb (
        .clk(clk),
        .cond(cond),
        .icode(icode),
        .rA(rA),
        .rB(rB),
        .valE(valE),
        .valM(valM),
        .reg_mem0(regmem0),
        .reg_mem1(regmem1),
        .reg_mem2(regmem2),
        .reg_mem3(regmem3),
        .reg_mem4(regmem4),
        .reg_mem5(regmem5),
        .reg_mem6(regmem6),
        .reg_mem7(regmem7),
        .reg_mem8(regmem8),
        .reg_mem9(regmem9),
        .reg_mem10(regmem10),
        .reg_mem11(regmem11),
        .reg_mem12(regmem12),
        .reg_mem13(regmem13),
        .reg_mem14(regmem14)
    );

    always #5 clk = ~clk; // Toggle the clock every 5 time units

    initial begin

        // Test case 1: cmovxx
        clk = 0; 
        #10; 
        icode = 4'b0010;
        rA = 4'b0100;
        rB = 4'b0011;
        valE = 64'h9834020A0943CE39;
        valM = 64'h43090382A903293D;
        cond = 0;
        clk=1;
        #10;
        $display("Test Case 1: cmovxx - rA=%d, rB=%d, valE=%d, valM=%d", rA, rB, valE, valM);
        $display("rax=%d, rcx=%d, rdx=%d, rbx=%d, rsp=%d, rbp=%d, rsi=%d, rdi=%d, r8=%d, r9=%d, r10=%d, r11=%d, r12=%d, r13=%d, r14=%d", regmem0,regmem1,regmem2,regmem3,regmem4,regmem5,regmem6,regmem7,regmem8,regmem9,regmem10,regmem11,regmem12,regmem13,regmem14);

        #10

        // Test case 2: cmovxx
        clk = 0; 
        #10; 
        icode = 4'b0010;
        rA = 4'b1011;
        rB = 4'b0110;
        valE = 64'h834020347D9347FF;
        valM = 64'h984057203740293C;
        cond = 1;
        clk=1;
        #10;
        $display("Test Case 2: cmovxx - rA=%d, rB=%d, valE=%d, valM=%d", rA, rB, valE, valM);
        $display("rax=%d, rcx=%d, rdx=%d, rbx=%d, rsp=%d, rbp=%d, rsi=%d, rdi=%d, r8=%d, r9=%d, r10=%d, r11=%d, r12=%d, r13=%d, r14=%d", regmem0,regmem1,regmem2,regmem3,regmem4,regmem5,regmem6,regmem7,regmem8,regmem9,regmem10,regmem11,regmem12,regmem13,regmem14);

        #10

        // Test case 3: irmovq
        clk = 0; 
        #10; 
        icode = 4'b0011;
        rA = 4'b1000;
        rB = 4'b0000;
        valE = 64'h879235DD801E9891;
        valM = 64'h7402366AA9821FF7;
        cond = 0; // Set cond to 0 for irmovq
        clk=1;
        #10;
        $display("Test Case 3: irmovq - rA=%d, rB=%d, valE=%d, valM=%d", rA, rB, valE, valM);
        $display("rax=%d, rcx=%d, rdx=%d, rbx=%d, rsp=%d, rbp=%d, rsi=%d, rdi=%d, r8=%d, r9=%d, r10=%d, r11=%d, r12=%d, r13=%d, r14=%d", regmem0,regmem1,regmem2,regmem3,regmem4,regmem5,regmem6,regmem7,regmem8,regmem9,regmem10,regmem11,regmem12,regmem13,regmem14);

        #10
        // Test case 4: mrmovq
        clk = 0; 
        #10; 
        icode = 4'b0101;
        rA = 4'b1010;
        rB = 4'b1100;
        valE = 64'h7634969324610231;
        valM = 64'h7412BB126AAA832E;
        cond = 0; // Set cond to 0 for mrmovq
        clk=1;
        #10;
        $display("Test Case 4: mrmovq - rA=%d, rB=%d, valE=%d, valM=%d", rA, rB, valE, valM);
        $display("rax=%d, rcx=%d, rdx=%d, rbx=%d, rsp=%d, rbp=%d, rsi=%d, rdi=%d, r8=%d, r9=%d, r10=%d, r11=%d, r12=%d, r13=%d, r14=%d", regmem0,regmem1,regmem2,regmem3,regmem4,regmem5,regmem6,regmem7,regmem8,regmem9,regmem10,regmem11,regmem12,regmem13,regmem14);

        #10;
        // Test case 5: call
        icode = 4'b1000;
        rA = 4'b0010;
        rB = 4'b0110;
        valE = 64'h1D87493F90742776;
        valM = 64'h4876543210FEDCB4;
        cond = 0; // Set cond to 0 for call
        clk=1;
        #15
        $display("Test Case 5: call - rA=%d, rB=%d, valE=%d, valM=%d", rA, rB, valE, valM);
        $display("rax=%d, rcx=%d, rdx=%d, rbx=%d, rsp=%d, rbp=%d, rsi=%d, rdi=%d, r8=%d, r9=%d, r10=%d, r11=%d, r12=%d, r13=%d, r14=%d", regmem0,regmem1,regmem2,regmem3,regmem4,regmem5,regmem6,regmem7,regmem8,regmem9,regmem10,regmem11,regmem12,regmem13,regmem14);
        
        #10;
        // Test case 6: popq
        clk = 0; 
        #10; 
        icode = 4'b1011;
        rA = 4'b0001;
        rB = 4'b0100;
        valE = 64'h10139371237D719B;
        valM = 64'h9876543210FEDCB7;
        cond = 0; // Set cond to 0 for popq
        clk=1;
        #10;
        $display("Test Case 6: popq - rA=%d, rB=%d, valE=%d, valM=%d", rA, rB, valE, valM);
        $display("rax=%d, rcx=%d, rdx=%d, rbx=%d, rsp=%d, rbp=%d, rsi=%d, rdi=%d, r8=%d, r9=%d, r10=%d, r11=%d, r12=%d, r13=%d, r14=%d", regmem0,regmem1,regmem2,regmem3,regmem4,regmem5,regmem6,regmem7,regmem8,regmem9,regmem10,regmem11,regmem12,regmem13,regmem14);

        $finish;
    end

endmodule
