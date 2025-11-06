`timescale 1ns / 1ps

//`include "./alu/alu.v"

module execute(clk, valA, valB, valC, ifun, icode, sf, of, zf, valE, cond);

    input clk;
    input [63:0] valA;
    input [63:0] valB;
    input [63:0] valC;
    input [3:0] ifun;
    input [3:0] icode;
    output reg sf;
    output reg zf;
    output reg of;
    output reg [63:0] valE;
    output reg [0:0] cond;

    reg a_sf;
    reg b_sf;
    reg ans;
    

    always @(*) begin

        cond = 0;

        case(icode)

            4'b0010: begin // cmovxx
                #2
                valE = valA;

                case(ifun)
                    4'b0000:begin //rrmovq
                        #1
                        cond = 1;
                    end
                    4'b0001:begin //cmovle
                        if(sf==1 || zf==1)
                            #1
                            cond = 1;
                    end
                    4'b0010:begin // cmovl
                        if(sf==1)
                            #1
                            cond = 1;
                    end
                    4'b0011:begin // cmove
                        if(zf==1)
                            #1
                            cond = 1;
                    end
                    4'b0100:begin //cmovne
                        if(zf==0)
                            #1
                            cond = 1;
                    end
                    4'b0101:begin //comvge
                        if(sf==0 || zf ==1)
                            #1
                            cond = 1;
                    end
                    4'b0110:begin //cmovg
                        if(sf==0)
                            #1
                            cond = 1;
                    end
                endcase
            end

            4'b0011: begin //irmovq
                #2
                valE =  valC;
            end

            4'b0100, 4'b0101:begin //rmmovq, mrmovq
                #2;
                valE = valB+valC;
            end

            4'b0110:begin //opq
    
                case(ifun)
                    4'b0000:begin
                        ans = valA + valB;
                    end
                    4'b0001:begin
                        ans = valA - valB;
                    end
                    4'b0010:begin
                        ans = valA & valB;
                    end
                    4'b0011:begin
                        ans = valA ^ valB;
                    end
                endcase
                
                zf = (ans == 1'b0);
                sf = (ans < 1'b0); 
                a_sf = (valA < 1'b0);
                b_sf = (valB < 1'b0);
                of = (a_sf == b_sf) && (sf != a_sf);

                #2
                valE = ans;
            end

            4'b0111:begin//jXX

                case(ifun)
                    4'b0000:begin //jmp
                        #1
                        cond = 1;
                    end
                    4'b0001:begin //jle
                        if(sf==1 || zf==1)
                            #1
                            cond = 1;
                    end
                    4'b0010:begin // jl
                        if(sf==1)
                            #1
                            cond = 1;
                    end
                    4'b0011:begin // je
                        if(zf==1)
                            #1
                            cond = 1;
                    end
                    4'b0100:begin //jne
                        if(zf==0)
                            #1
                            cond = 1;
                    end
                    4'b0101:begin //jge
                        if(sf==0 || zf ==1)
                            #1
                            cond = 1;
                    end
                    4'b0110:begin //jg
                        if(sf==0)
                            #1
                            cond = 1;
                    end

                endcase
            end
            
            4'b1000, 4'b1010:begin // call, pushq
                #2
                valE = valB - 64'd8;
            end

            4'b1001, 4'b1011:begin // ret, popq
                #2
                valE = valB + 64'd8;
                //$display("test_ret_e %d", valE);
            end
        endcase
        
        //$display("Execute valE: %d\n", valE);
    end
endmodule        
