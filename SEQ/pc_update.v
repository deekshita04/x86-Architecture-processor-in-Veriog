`timescale 1ns / 1ps

module pc_update(clk, icode, valP, valC, cond, valM, PC);

    input clk;
    input [3:0] icode;
    input [63:0] valP;
    input [63:0] valC;
    input [63:0] valM;
    input wire cond;
    output reg [63:0] PC;

    always @(*) begin
        #250
        case(icode)

            4'b0000, 4'b0001, 4'b0010, 4'b0011, 4'b0100, 4'b0101, 4'b0110, 4'b1010, 4'b1011: begin //halt, nop, cmovxx, irmov, rmmov, mrmov, opq, pushq, popq
                #5
                PC = valP;
            end

            4'b0111:begin //jXX
                if(cond == 1)
                    #5
                    PC = valC;
                else
                    #5
                    PC = valP;
            end

            4'b1000:begin //call
                #5
                PC = valC;
            end

            4'b1001:begin //ret
                #10
                PC = valM;
                //$display("Pc = %d, valm=%d",PC, valM);
            end
        endcase

        if((^PC === 1'bX) && clk==1 ) begin
                $display("PC reached undefined");
                $finish;
        end
    end
endmodule
