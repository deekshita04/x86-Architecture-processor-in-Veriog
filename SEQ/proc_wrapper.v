`timescale 1ns / 1ps

`include "fetch.v"
`include "decode.v"
`include "execute.v"
`include "memory.v"
`include "writeback.v"
`include "pc_update.v"

module proc_wrapper;

    reg clk;
    reg [63:0] PC;
    reg stat[0:2]; 

    wire [3:0] icode;
    wire [3:0] ifun;
    wire [3:0] rA;
    wire [3:0] rB; 
    wire [63:0] valC;
    wire [63:0] valP;
    wire instr_valid;
    wire dmem_error;
    wire [63:0] valA;
    wire [63:0] valB;
    wire [63:0] valE;
    wire [63:0] valM;
    wire cond;
    wire hlt;
    wire [63:0] updated_pc;

    wire [63:0] reg_mem0;
    wire [63:0] reg_mem1;
    wire [63:0] reg_mem2;
    wire [63:0] reg_mem3;
    wire [63:0] reg_mem4;
    wire [63:0] reg_mem5;
    wire [63:0] reg_mem6;
    wire [63:0] reg_mem7;
    wire [63:0] reg_mem8;
    wire [63:0] reg_mem9;
    wire [63:0] reg_mem10;
    wire [63:0] reg_mem11;
    wire [63:0] reg_mem12;
    wire [63:0] reg_mem13;
    wire [63:0] reg_mem14;

    wire sf;
    wire zf;
    wire of;


    fetch fetch(
    .clk(clk),
    .PC(PC),
    .icode(icode),
    .ifun(ifun),
    .rA(rA),
    .rB(rB),
    .valC(valC),
    .valP(valP),
    .instr_valid(instr_valid),
    .imem_error(imem_error),
    .hlt(hlt)
    );

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

    execute execute(
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

    memory memory(
    .clk(clk),
    .icode(icode),
    .valA(valA),
    .valE(valE),
    .valP(valP),
    .valM(valM),
    .dmem_error(dmem_error)
    );

    writeback wb(
    .clk(clk),
    .cond(cond),
    .icode(icode),
    .rA(rA),
    .rB(rB),
    .valE(valE),
    .valM(valM),
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

    pc_update pcup(
    .clk(clk),
    .icode(icode),
    .valP(valP),
    .valC(valC),
    .valM(valM),
    .cond(cond),
    .PC(updated_pc)
    );

    always #2000 clk=~clk;

    initial begin 
        $dumpfile("wrapper.vcd");
        stat[0] = 1'b0; //aok
        stat[1] = 1'b0; //inst_valid
        stat[2] = 1'b0; //halt

        clk = 0;
        PC = 64'b0;
    end

    always@(posedge clk)begin
        #30
        PC = updated_pc;
        if(hlt ==1)
        begin
            stat[0] = 1'b0; //aok
            stat[1] = 1'b0; //inst_valid
            stat[2] = 1'b1; //halt
        end

        else if(instr_valid==0)
        begin
            stat[0] = 1'b0; //aok
            stat[1] = 1'b1; //inst_valid
            stat[2] = 1'b0; //halt
        end

        else
        begin
            stat[0] = 1'b1; //aok
            stat[1] = 1'b0; //inst_valid
            stat[2] = 1'b0; //halt
        end

        if(stat[2]==1'b1)
        begin
            $finish;
        end
        $display("clk=%d icode=%d ifun=%d rA=%d rB=%d rsp=%d valA=%d valB=%d valE=%d valP=%d valC=%d valM=%d halt=%d PC=%d dmem_error=%d \n", clk, icode, ifun, rA, rB, reg_mem4, valA, valB, valE, valP, valC, valM, stat[2], PC, dmem_error);

    end


endmodule