`timescale 1ns / 1ps
//`include "reg_stk.v"

module decode_wb(clk, icode, rA, rB, cond, valA, valB, valE, valM, reg_mem0, reg_mem1, reg_mem2, reg_mem3, reg_mem4, reg_mem5, reg_mem6, reg_mem7, reg_mem8, reg_mem9, reg_mem10, reg_mem11, reg_mem12, reg_mem13, reg_mem14);
    input clk;
    input [3:0] icode;
    input [3:0] rA;
    input [3:0] rB;
    input cond;

    output reg [63:0] valA;
    output reg [63:0] valB;
    input [63:0] valE;
    input[63:0] valM;
    
    output reg [63:0] reg_mem0;
    output reg [63:0] reg_mem1;
    output reg [63:0] reg_mem2;
    output reg [63:0] reg_mem3;
    output reg [63:0] reg_mem4;
    output reg [63:0] reg_mem5;
    output reg [63:0] reg_mem6;
    output reg [63:0] reg_mem7;
    output reg [63:0] reg_mem8;
    output reg [63:0] reg_mem9;
    output reg [63:0] reg_mem10;
    output reg [63:0] reg_mem11;
    output reg [63:0] reg_mem12;
    output reg [63:0] reg_mem13;
    output reg [63:0] reg_mem14;

    reg [63:0] reg_mem[0:14];

    initial begin
	reg_mem[0]=64'd0;
    reg_mem[1]=64'd0;
    reg_mem[2]=64'd0;
    reg_mem[3]=64'd0;
    reg_mem[4]=64'd0;
    reg_mem[5]=64'd0;
    reg_mem[6]=64'd0;
    reg_mem[7]=64'd0;
    reg_mem[8]=64'd0;
    reg_mem[9]=64'd0;
    reg_mem[10]=64'd0;
    reg_mem[11]=64'd0;
    reg_mem[12]=64'd0;
    reg_mem[13]=64'd0;
    reg_mem[14]=64'd0;
    end

    always @(*) begin

        reg_mem[0] <= reg_mem0;
        reg_mem[1] <= reg_mem1;
        reg_mem[2] <= reg_mem2;
        reg_mem[3] <= reg_mem3;
        reg_mem[4] <= reg_mem4;
        reg_mem[5] <= reg_mem5;
        reg_mem[6] <= reg_mem6;
        reg_mem[7] <= reg_mem7;
        reg_mem[8] <= reg_mem8;
        reg_mem[9] <= reg_mem9;
        reg_mem[10] <=reg_mem10;
        reg_mem[11] <=reg_mem11;
        reg_mem[12] <=reg_mem12;
        reg_mem[13] <=reg_mem13;
        reg_mem[14] <=reg_mem14;
    
        case(icode)
            4'b0010: begin // cmovxx
                #2
                valA = reg_mem[rA];
            end

            4'b0100, 4'b0110: begin // rmmov, opq
                #2
                valA = reg_mem[rA];
                valB = reg_mem[rB];
            end


            4'b0101: begin//mrmov
                #2
                valB = reg_mem[rB];
            end

            4'b1000: begin//call
            #2
                valB = reg_mem[4];
            end

            4'b1001, 4'b1011: begin//ret, popq
            #2
                valA=reg_mem[4]; 
                valB=reg_mem[4]; 
                
            end

            4'b1010: begin//pushq
            #2
                valA=reg_mem[rA];
                valB=reg_mem[4]; 
            end
        endcase

    end

    always @(negedge clk) begin
        case(icode)

            4'b0010: begin // cmovxx
                #5
                if(cond == 1)
                    reg_mem[rB]=valE;
            end

            4'b0011, 4'b0110: begin//irmovq, opq
                #5
                reg_mem[rB]=valE;
            end

            4'b0101: begin//mrmovq
                #5
                reg_mem[rA]=valM;
            end

            4'b1000, 4'b1001, 4'b1010: begin//call, ret, pushq
                #5
                reg_mem[4]=valE;
            end

            4'b1011: begin//popq
                #5
                reg_mem[4]=valE;
                reg_mem[rA]=valM;
            end

        endcase

        #15 
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
    end

endmodule
