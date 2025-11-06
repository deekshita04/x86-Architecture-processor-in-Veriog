`timescale 1ns / 1ps

 module writeback(
    input clk,
    input cond,
    input [3:0] icode,
    input [3:0] rA,
    input [3:0] rB,
    input [63:0] valE,
    input [63:0] valM,
    output reg [63:0] reg_mem0,
    output reg [63:0] reg_mem1,
    output reg [63:0] reg_mem2,
    output reg [63:0] reg_mem3,
    output reg [63:0] reg_mem4,
    output reg [63:0] reg_mem5,
    output reg [63:0] reg_mem6,
    output reg [63:0] reg_mem7,
    output reg [63:0] reg_mem8,
    output reg [63:0] reg_mem9,
    output reg [63:0] reg_mem10,
    output reg [63:0] reg_mem11,
    output reg [63:0] reg_mem12,
    output reg [63:0] reg_mem13,
    output reg [63:0] reg_mem14
    );

    reg [63:0] reg_mem[0:14];

    //always @(*) begin
    //    reg_mem[0] <= reg_mem0;
    //    reg_mem[1] <= reg_mem1;
    //    reg_mem[2] <= reg_mem2;
    //    reg_mem[3] <= reg_mem3;
    //    reg_mem[4] <= reg_mem4;
    //    reg_mem[5] <= reg_mem5;
    //    reg_mem[6] <= reg_mem6;
    //    reg_mem[7] <= reg_mem7;
    //    reg_mem[8] <= reg_mem8;
    //    reg_mem[9] <= reg_mem9;
    //    reg_mem[10] <=reg_mem10;
    //    reg_mem[11] <=reg_mem11;
    //    reg_mem[12] <=reg_mem12;
    //    reg_mem[13] <=reg_mem13;
    //    reg_mem[14] <=reg_mem14;
    //end

    //always @(*) begin
    //    reg_mem[0] <= reg_mem0;
    //    reg_mem[1] <= reg_mem1;
    //    reg_mem[2] <= reg_mem2;
    //    reg_mem[3] <= reg_mem3;
    //    reg_mem[4] <= reg_mem4;
    //    reg_mem[5] <= reg_mem5;
    //    reg_mem[6] <= reg_mem6;
    //    reg_mem[7] <= reg_mem7;
    //    reg_mem[8] <= reg_mem8;
    //    reg_mem[9] <= reg_mem9;
    //    reg_mem[10] <=reg_mem10;
    //    reg_mem[11] <=reg_mem11;
    //    reg_mem[12] <=reg_mem12;
    //    reg_mem[13] <=reg_mem13;
    //    reg_mem[14] <=reg_mem14;
    //end
    always @(posedge clk) begin
        case(icode)

            4'b0010: begin // cmovxx
                if(cond == 1'b1) begin
                    reg_mem[rB]=valE;
                    //$display("test1");
                end
            end

            4'b0011: begin//irmovq
                reg_mem[rB]=valE;
                //$display("test2");
            end

            4'b0110: begin//opq
                reg_mem[rB]=valE;
                //$display("test2");
            end

            4'b0101: begin//mrmovq
                reg_mem[rA]=valM;
                //$display("test3");
            end

            4'b1000, 4'b1001, 4'b1010: begin//call, ret, pushq
                reg_mem[4]=valE;
                //$display("test_r %d", reg_mem[4]);
            end

            4'b1011: begin//popq
                reg_mem[4]<=valE;
                reg_mem[rA]<=valM;
                //$display("test5");
            end

        endcase
    end
    always @(negedge clk) begin
        reg_mem0 <= reg_mem[0];
        reg_mem1 <= reg_mem[1];
        reg_mem2 <= reg_mem[2];
        reg_mem3 <= reg_mem[3];
        reg_mem4 <= reg_mem[4];
        reg_mem5 <= reg_mem[5];
        reg_mem6 <= reg_mem[6];
        reg_mem7 <= reg_mem[7];
        reg_mem8 <= reg_mem[8];
        reg_mem9 <= reg_mem[9];
        reg_mem10 <= reg_mem[10];
        reg_mem11 <= reg_mem[11];
        reg_mem12 <= reg_mem[12];
        reg_mem13 <= reg_mem[13];
        reg_mem14 <= reg_mem[14];

        $display(" rax=%d, rcx=%d, rdx=%d, rbx=%d, rsp=%d, rbp=%d, rsi=%d, rdi=%d, r8=%d, r9=%d, r10=%d, r11=%d, r12=%d, r13=%d, r14=%d\n", reg_mem[0],reg_mem[1],reg_mem[2],reg_mem[3],reg_mem[4],reg_mem[5],reg_mem[6],reg_mem[7],reg_mem[8],reg_mem[9],reg_mem[10],reg_mem[11],reg_mem[12],reg_mem[13],reg_mem[14]);

    end

 endmodule