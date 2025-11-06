`timescale 1ns / 1ps

module decode(clk, icode, rA, rB, valA, valB, reg_mem0, reg_mem1, reg_mem2, reg_mem3, reg_mem4, reg_mem5, reg_mem6, reg_mem7, reg_mem8, reg_mem9, reg_mem10, reg_mem11, reg_mem12, reg_mem13, reg_mem14);
    input clk;
    input [3:0] icode;
    input [3:0] rA;
    input [3:0] rB;
    output reg [63:0] valA;
    output reg [63:0] valB;
    input [63:0] reg_mem0;
    input [63:0] reg_mem1;
    input [63:0] reg_mem2;
    input [63:0] reg_mem3;
    input [63:0] reg_mem4;
    input [63:0] reg_mem5;
    input [63:0] reg_mem6;
    input [63:0] reg_mem7;
    input [63:0] reg_mem8;
    input [63:0] reg_mem9;
    input [63:0] reg_mem10;
    input [63:0] reg_mem11;
    input [63:0] reg_mem12;
    input [63:0] reg_mem13;
    input [63:0] reg_mem14;

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
        #5
        case(icode)
            4'b0010: begin // cmovxx
                #2
                valA = reg_mem[rA];
            end

            4'b0100, 4'b0110: begin // rmmov, opq
                #2
                valA = reg_mem[rA];
                #2
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
                valA = reg_mem[4]; 
                #2
                valB = reg_mem[4]; 
                //$display("test_ret_d %d %d", valA, valB);
            end

            4'b1010: begin//pushq
                #2
                valA = reg_mem[rA];
                #2
                valB = reg_mem[4]; 
            end
            

        endcase

        //$display("valA=%d, valB=%d", valA, valB);

        //$display("reg%d=%x, reg%d=%x", rA, reg_mem[rA], rB, reg_mem[rB]);
    end
    
endmodule
