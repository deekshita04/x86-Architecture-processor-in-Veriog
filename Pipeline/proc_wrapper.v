`timescale 1ns / 1ps

`include "fetch_reg.v"
`include "decode_reg.v"
`include "execute_reg.v"
`include "memory_reg.v"
`include "writeback_reg.v"
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

    wire [63:0] updated_pc;
    wire [63:0] predit_pc_f;

    wire [2:0]stat_f;
    wire [3:0]icode_f;
    wire [3:0]ifun_f;
    wire[3:0]rA_f;
    wire [3:0]rB_f;
    wire [63:0]valc_f;
    wire [63:0]valp_f;
    wire instr_valid;
    wire imem_error;
    wire hlt;

    wire [2:0]stat_d;
    wire [3:0]icode_d;
    wire [3:0]ifun_d;
    wire [3:0]rA_d;
    wire [3:0]rB_d;
    wire [63:0]valA_d;
    wire [63:0]valB_d;
    wire [63:0]valc_d;
    wire [63:0]valp_d;

    wire [2:0]stat_e;
    wire [3:0]icode_e;
    wire [3:0]ifun_e;
    wire [3:0]rA_e;
    wire [3:0]rB_e;
    wire [63:0]valc_e;
    wire [63:0]valp_e;
    wire [63:0]valA_e;
    wire [63:0]valB_e;
    wire [63:0]valE_e;
    wire cnd_e;

    wire [2:0]stat_m;
    wire [3:0]icode_m;
    wire [3:0]ifun_m;
    wire [3:0]rA_m;
    wire [3:0]rB_m;
    wire cnd_m;
    wire [63:0]valA_m;
    wire [63:0]valB_m;
    wire [63:0]valc_m;
    wire [63:0]valp_m;
    wire [63:0]valE_m;
    wire [63:0]valM_m;

    wire [2:0]stat_w;
    wire [3:0]icode_w;
    wire cnd_w;
    wire [3:0]rA_w;
    wire [3:0]rB_w;
    wire [63:0]valA_w;
    wire [63:0]valB_w;
    wire [63:0]valc_w;
    wire [63:0]valE_w;
    wire [63:0]valM_w;
    wire [63:0]valp_w;


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

    fetch_reg freg(
        .clk(clk),
        .predit_pc(valp_f),
        .predit_pc_f(predit_pc_f)
    );

    decode_reg dreg(
        .clk(clk),

        .stat_f(stat_f),
        .icode_f(icode_f),
        .ifun_f(ifun_f),
        .rA_f(rA_f),
        .rB_f(rB_f),
        .valc_f(valc_f),
        .valp_f(valp_f),

        .stat_d(stat_d),
        .icode_d(icode_d),
        .ifun_d(ifun_d),
        .rA_d(rA_d),
        .rB_d(rB_d),
        .valc_d(valc_d),
        .valp_d(valp_d)
    );

    execute_reg ereg(
        .clk(clk),

        .stat_d(stat_d),
        .icode_d(icode_d),
        .ifun_d(ifun_d),
        .rA_d(rA_d),
        .rB_d(rB_d),
        .valA_d(valA_d),
        .valB_d(valB_d),
        .valc_d(valc_d),
        .valp_d(valp_d),

        .stat_e(stat_e),
        .icode_e(icode_e),
        .ifun_e(ifun_e),
        .rA_e(rA_e),
        .rB_e(rB_e),
        .valA_e(valA_e),
        .valB_e(valB_e),
        .valc_e(valc_e),
        .valp_e(valp_e)
    );

    memory_reg mreg(
        .clk(clk),

        .stat_e(stat_e),
        .icode_e(icode_e),
        .ifun_e(ifun_e),
        .rA_e(rA_e),
        .rB_e(rB_e),
        .cnd_e(cnd_e),
        .valA_e(valA_e),
        .valB_e(valB_e),
        .valc_e(valc_e),
        .valp_e(valp_e),
        .valE_e(valE_e),

        .stat_m(stat_m),
        .icode_m(icode_m),
        .ifun_m(ifun_m),
        .rA_m(rA_m),
        .rB_m(rB_m),
        .cnd_m(cnd_m),
        .valA_m(valA_m),
        .valB_m(valB_m),
        .valc_m(valc_m),
        .valp_m(valp_m),
        .valE_m(valE_m)
    );

    writeback_reg wreg(
        .clk(clk),

        .stat_m(stat_m),
        .icode_m(icode_m),
        .valA_m(valA_m),
        .valB_m(valB_m),
        .valc_m(valc_m),
        .valE_m(valE_m),
        .valM_m(valM_m),
        .rA_m(rA_m),
        .rB_m(rB_m),
        .valp_m(valp_m),

        .stat_w(stat_w),
        .icode_w(icode_w),
        .rA_w(rA_w),
        .rB_w(rB_w),
        .valA_w(valA_w),
        .valB_w(valB_w),
        .valc_w(valc_w),
        .valE_w(valE_w),
        .valM_w(valM_w),
        .valp_w(valp_w)
    );

    pc_update pcup(
    .clk(clk),

    .icode(icode_w),
    .valP(predit_pc_f),
    .valC(valc_w),
    .valM(valM_w),
    .cond(cnd_w),
    .PC(updated_pc)
    );


    fetch fetch(
    .clk(clk),

    .PC(PC),
    .icode(icode_f),
    .ifun(ifun_f),
    .rA(rA_f),
    .rB(rB_f),
    .valC(valc_f),
    .valP(valp_f),
    .instr_valid(instr_valid),
    .imem_error(imem_error),
    .hlt(hlt)
    );

    decode decode(
    .clk(clk),
    .icode(icode_d),
    .rA(rA_d),
    .rB(rB_d),
    .valA(valA_d),
    .valB(valB_d),
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
    .valA(valA_e),
    .valB(valB_e),
    .valC(valc_e),
    .ifun(ifun_e),
    .icode(icode_e),
    .sf(sf),
    .zf(zf),
    .of(of),
    .valE(valE_e),
    .cond(cond_e)
    );

    memory memory(
    .clk(clk),
    .icode(icode_m),
    .valA(valA_m),
    .valE(valE_m),
    .valP(valp_m),
    .valM(valM_m),
    .dmem_error(dmem_error)
    );

    writeback wb(
    .clk(clk),
    .cond(cond_w),
    .icode(icode_w),
    .rA(rA_w),
    .rB(rB_w),
    .valE(valE_w),
    .valM(valM_w),
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

    always #2000 clk=~clk;

    initial begin 
        $dumpfile("wrapper.vcd");
        stat[0] = 1'b0; //aok
        stat[1] = 1'b0; //inst_valid
        stat[2] = 1'b0; //halt
        $monitor(" f=%d d=%d e=%d m=%d wb=%d",icode_f,icode_d, icode_e, icode_m, icode_w);

        clk = 0;
        PC = 64'b0;
    end
    
    

    always@(*)begin
        PC = updated_pc;
    end
    always@(*)begin
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
    end
    always@(*)begin
        if(stat[2]==1'b1)
        begin
            $finish;
        end
        //$display("clk=%d icode=%d ifun=%d rA=%d rB=%d rsp=%d valA=%d valB=%d valE=%d valP=%d valC=%d halt=%d PC=%d dmem_error=%d \n", clk, icode, ifun, rA, rB, reg_mem4, valA, valB, valE, valP, valC, stat[2], PC, dmem_error);
        //$display("clk=%d f=%d d=%d e=%d m=%d wb=%d",clk,icode_f,icode_d, icode_e, icode_m, icode_w);
        //$display("0=%d 1=%d 2=%d 3=%d 4=%d zf=%d sf=%d of=%d\2n",reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,zf,sf,of);
    end


endmodule