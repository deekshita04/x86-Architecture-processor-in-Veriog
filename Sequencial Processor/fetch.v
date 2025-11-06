`timescale 1ns / 1ps

module fetch(clk, PC, icode, ifun, rA, rB, valC, valP, instr_valid, imem_error, hlt);
    
    input clk;
    input [63:0] PC;
    output reg [3:0] icode;
    output reg [3:0] ifun;
    output reg [3:0] rA;
    output reg [3:0] rB; 
    output reg [63:0] valC;
    output reg [63:0] valP;
    output reg instr_valid;
    output reg imem_error;
    output reg hlt;
    reg xflag;
    integer clockbreak;

    //reg [63:0] PC;
    reg [7:0] inst_stack[0:2048];

    reg [0:79]instruction;
    reg [0:79]revbyteinstr;
    reg [63:0]temppc;

    initial begin
        xflag=0;
        temppc=64'b0;
        clockbreak=0;
        /*
        inst_stack[ 0 ] = 8'b00110000;
        inst_stack[ 1 ] = 8'b11110101;
        inst_stack[ 2 ] = 8'b00000000;
        inst_stack[ 3 ] = 8'b00000001;
        inst_stack[ 4 ] = 8'b00000000;
        inst_stack[ 5 ] = 8'b00000000;
        inst_stack[ 6 ] = 8'b00000000;
        inst_stack[ 7 ] = 8'b00000000;
        inst_stack[ 8 ] = 8'b00000000;
        inst_stack[ 9 ] = 8'b00000000;
        inst_stack[ 10 ] = 8'b00110000;
        inst_stack[ 11 ] = 8'b11110100;
        inst_stack[ 12 ] = 8'b00000000;
        inst_stack[ 13 ] = 8'b00000001;
        inst_stack[ 14 ] = 8'b00000000;
        inst_stack[ 15 ] = 8'b00000000;
        inst_stack[ 16 ] = 8'b00000000;
        inst_stack[ 17 ] = 8'b00000000;
        inst_stack[ 18 ] = 8'b00000000;
        inst_stack[ 19 ] = 8'b00000000;
        inst_stack[ 20 ] = 8'b00000000;
        */
        
        inst_stack[ 0 ] = 8'b00110000;
        inst_stack[ 1 ] = 8'b11110100;
        inst_stack[ 2 ] = 8'b00000000;
        inst_stack[ 3 ] = 8'b00000010;
        inst_stack[ 4 ] = 8'b00000000;
        inst_stack[ 5 ] = 8'b00000000;
        inst_stack[ 6 ] = 8'b00000000;
        inst_stack[ 7 ] = 8'b00000000;
        inst_stack[ 8 ] = 8'b00000000;
        inst_stack[ 9 ] = 8'b00000000;
        inst_stack[ 10 ] = 8'b10000000;
        inst_stack[ 11 ] = 8'b00111000;
        inst_stack[ 12 ] = 8'b00000000;
        inst_stack[ 13 ] = 8'b00000000;
        inst_stack[ 14 ] = 8'b00000000;
        inst_stack[ 15 ] = 8'b00000000;
        inst_stack[ 16 ] = 8'b00000000;
        inst_stack[ 17 ] = 8'b00000000;
        inst_stack[ 18 ] = 8'b00000000;
        inst_stack[ 19 ] = 8'b00000000;
        inst_stack[ 24 ] = 8'b00001101;
        inst_stack[ 25 ] = 8'b00000000;
        inst_stack[ 26 ] = 8'b00001101;
        inst_stack[ 27 ] = 8'b00000000;
        inst_stack[ 28 ] = 8'b00001101;
        inst_stack[ 32 ] = 8'b11000000;
        inst_stack[ 33 ] = 8'b00000000;
        inst_stack[ 34 ] = 8'b11000000;
        inst_stack[ 35 ] = 8'b00000000;
        inst_stack[ 36 ] = 8'b11000000;
        inst_stack[ 40 ] = 8'b00000000;
        inst_stack[ 41 ] = 8'b00001011;
        inst_stack[ 42 ] = 8'b00000000;
        inst_stack[ 43 ] = 8'b00001011;
        inst_stack[ 44 ] = 8'b00000000;
        inst_stack[ 45 ] = 8'b00001011;
        inst_stack[ 48 ] = 8'b00000000;
        inst_stack[ 49 ] = 8'b10100000;
        inst_stack[ 50 ] = 8'b00000000;
        inst_stack[ 51 ] = 8'b10100000;
        inst_stack[ 52 ] = 8'b00000000;
        inst_stack[ 53 ] = 8'b10100000;
        inst_stack[ 56 ] = 8'b00110000;
        inst_stack[ 57 ] = 8'b11110111;
        inst_stack[ 58 ] = 8'b00011000;
        inst_stack[ 59 ] = 8'b00000000;
        inst_stack[ 60 ] = 8'b00000000;
        inst_stack[ 61 ] = 8'b00000000;
        inst_stack[ 62 ] = 8'b00000000;
        inst_stack[ 63 ] = 8'b00000000;
        inst_stack[ 64 ] = 8'b00000000;
        inst_stack[ 65 ] = 8'b00000000;
        inst_stack[ 66 ] = 8'b00110000;
        inst_stack[ 67 ] = 8'b11110110;
        inst_stack[ 68 ] = 8'b00000100;
        inst_stack[ 69 ] = 8'b00000000;
        inst_stack[ 70 ] = 8'b00000000;
        inst_stack[ 71 ] = 8'b00000000;
        inst_stack[ 72 ] = 8'b00000000;
        inst_stack[ 73 ] = 8'b00000000;
        inst_stack[ 74 ] = 8'b00000000;
        inst_stack[ 75 ] = 8'b00000000;
        inst_stack[ 76 ] = 8'b10000000;
        inst_stack[ 77 ] = 8'b01010110;
        inst_stack[ 78 ] = 8'b00000000;
        inst_stack[ 79 ] = 8'b00000000;
        inst_stack[ 80 ] = 8'b00000000;
        inst_stack[ 81 ] = 8'b00000000;
        inst_stack[ 82 ] = 8'b00000000;
        inst_stack[ 83 ] = 8'b00000000;
        inst_stack[ 84 ] = 8'b00000000;
        inst_stack[ 85 ] = 8'b10010000;
        inst_stack[ 86 ] = 8'b00110000;
        inst_stack[ 87 ] = 8'b11111000;
        inst_stack[ 88 ] = 8'b00001000;
        inst_stack[ 89 ] = 8'b00000000;
        inst_stack[ 90 ] = 8'b00000000;
        inst_stack[ 91 ] = 8'b00000000;
        inst_stack[ 92 ] = 8'b00000000;
        inst_stack[ 93 ] = 8'b00000000;
        inst_stack[ 94 ] = 8'b00000000;
        inst_stack[ 95 ] = 8'b00000000;
        inst_stack[ 96 ] = 8'b00110000;
        inst_stack[ 97 ] = 8'b11111001;
        inst_stack[ 98 ] = 8'b00000001;
        inst_stack[ 99 ] = 8'b00000000;
        inst_stack[ 100 ] = 8'b00000000;
        inst_stack[ 101 ] = 8'b00000000;
        inst_stack[ 102 ] = 8'b00000000;
        inst_stack[ 103 ] = 8'b00000000;
        inst_stack[ 104 ] = 8'b00000000;
        inst_stack[ 105 ] = 8'b00000000;
        inst_stack[ 106 ] = 8'b01100011;
        inst_stack[ 107 ] = 8'b00000000;
        inst_stack[ 108 ] = 8'b01100010;
        inst_stack[ 109 ] = 8'b01100110;
        inst_stack[ 110 ] = 8'b01110000;
        inst_stack[ 111 ] = 8'b10000111;
        inst_stack[ 112 ] = 8'b00000000;
        inst_stack[ 113 ] = 8'b00000000;
        inst_stack[ 114 ] = 8'b00000000;
        inst_stack[ 115 ] = 8'b00000000;
        inst_stack[ 116 ] = 8'b00000000;
        inst_stack[ 117 ] = 8'b00000000;
        inst_stack[ 118 ] = 8'b00000000;
        inst_stack[ 119 ] = 8'b01010000;
        inst_stack[ 120 ] = 8'b10100111;
        inst_stack[ 121 ] = 8'b00000000;
        inst_stack[ 122 ] = 8'b00000000;
        inst_stack[ 123 ] = 8'b00000000;
        inst_stack[ 124 ] = 8'b00000000;
        inst_stack[ 125 ] = 8'b00000000;
        inst_stack[ 126 ] = 8'b00000000;
        inst_stack[ 127 ] = 8'b00000000;
        inst_stack[ 128 ] = 8'b00000000;
        inst_stack[ 129 ] = 8'b01100000;
        inst_stack[ 130 ] = 8'b10100000;
        inst_stack[ 131 ] = 8'b01100000;
        inst_stack[ 132 ] = 8'b10000111;
        inst_stack[ 133 ] = 8'b01100001;
        inst_stack[ 134 ] = 8'b10010110;
        inst_stack[ 135 ] = 8'b01110100;
        inst_stack[ 136 ] = 8'b01110111;
        inst_stack[ 137 ] = 8'b00000000;
        inst_stack[ 138 ] = 8'b00000000;
        inst_stack[ 139 ] = 8'b00000000;
        inst_stack[ 140 ] = 8'b00000000;
        inst_stack[ 141 ] = 8'b00000000;
        inst_stack[ 142 ] = 8'b00000000;
        inst_stack[ 143 ] = 8'b00000000;
        inst_stack[ 144 ] = 8'b10010000;
        
        /*
        //nop
        inst_stack[0] = 8'b00010000;
        //irmovq
        inst_stack[1] = 8'b00110000;
        inst_stack[2] = 8'b11000001;
        inst_stack[3] = 8'b00100110;//valc
        inst_stack[4] = 8'b00000110;
        inst_stack[5] = 8'b00000000;
        inst_stack[6] = 8'b00000000;
        inst_stack[7] = 8'b00000000;
        inst_stack[8] = 8'b00000000;
        inst_stack[9] = 8'b00000000;
        inst_stack[10] = 8'b00000000;
        //cmov-movq
        inst_stack[11] = 8'b00100000;
        inst_stack[12] = 8'b00010010;
        //irmovq
        inst_stack[13] = 8'b00110000;
        inst_stack[14] = 8'b01100100;
        inst_stack[15] = 8'b00100000;//valc
        inst_stack[16] = 8'b00000000;
        inst_stack[17] = 8'b00000000;
        inst_stack[18] = 8'b00000000;
        inst_stack[19] = 8'b00000000;
        inst_stack[20] = 8'b00000000;
        inst_stack[21] = 8'b00000000;
        inst_stack[22] = 8'b00000000;
        //call
        inst_stack[23] = 8'b10000000;
        inst_stack[24] = 8'b00101101;
        inst_stack[25] = 8'b00000000;
        inst_stack[26] = 8'b00000000;
        inst_stack[27] = 8'b00000000;
        inst_stack[28] = 8'b00000000;
        inst_stack[29] = 8'b00000000;
        inst_stack[30] = 8'b00000000;
        inst_stack[31] = 8'b00000000;
        //nop
        inst_stack[32] = 8'b00010000;
        //halt
        inst_stack[33] = 8'b00000000;
        //opq
        inst_stack[34] = 8'b01100001;
        inst_stack[35] = 8'b00000010;
        //jXX
        inst_stack[36] = 8'b01110000;
        inst_stack[37] = 8'b00100001;//valC
        inst_stack[38] = 8'b00000000;
        inst_stack[39] = 8'b00000000;
        inst_stack[40] = 8'b00000000;
        inst_stack[41] = 8'b00000000;
        inst_stack[42] = 8'b00000000;
        inst_stack[43] = 8'b00000000;
        inst_stack[44] = 8'b00000000;
        //irrmovq
        inst_stack[45] = 8'b00110000;
        inst_stack[46] = 8'b00100111;
        inst_stack[47] = 8'b00101101;//valc
        inst_stack[48] = 8'b01011000;
        inst_stack[49] = 8'b00000000;
        inst_stack[50] = 8'b00000000;
        inst_stack[51] = 8'b00000000;
        inst_stack[52] = 8'b00000000;
        inst_stack[53] = 8'b00000000;
        inst_stack[54] = 8'b00000000;
        //rmmovq
        inst_stack[55] = 8'b01000000;
        inst_stack[56] = 8'b01110001;
        inst_stack[57] = 8'b00101100;
        inst_stack[58] = 8'b00000000;
        inst_stack[59] = 8'b00000000;
        inst_stack[60] = 8'b00000000;
        inst_stack[61] = 8'b00000000;
        inst_stack[62] = 8'b00000000;
        inst_stack[63] = 8'b00000000;
        inst_stack[64] = 8'b00000000;
        //mrmovq
        inst_stack[65] = 8'b01010000;
        inst_stack[66] = 8'b00011000;
        inst_stack[67] = 8'b00101100;
        inst_stack[68] = 8'b00000000;
        inst_stack[69] = 8'b00000000;
        inst_stack[70] = 8'b00000000;
        inst_stack[71] = 8'b00000000;
        inst_stack[72] = 8'b00000000;
        inst_stack[73] = 8'b00000000;
        inst_stack[74] = 8'b00000000;
        //ret
        inst_stack[75] = 8'b10010000;
        inst_stack[76] = 8'b00000000;*/

    end
    

    always@(*) begin

        //clockbreak=clockbreak+1;
        //if(clockbreak>200) begin
        //    hlt=0;
        //    valP=64'bX;
        //end
        //
        //temppc = PC;
        //if((^temppc === 1'bX)) begin
        //    xflag=1;
        //    $display("PC is undefined");
        //end

        instruction = {
            inst_stack[PC],
            inst_stack[PC+64'd1],
            inst_stack[PC+64'd2],
            inst_stack[PC+64'd3],
            inst_stack[PC+64'd4],
            inst_stack[PC+64'd5],
            inst_stack[PC+64'd6],
            inst_stack[PC+64'd7],
            inst_stack[PC+64'd8],
            inst_stack[PC+64'd9]
        };

        revbyteinstr = {
            inst_stack[PC+64'd9], // 0
            inst_stack[PC+64'd8], // 8
            inst_stack[PC+64'd7], // 16
            inst_stack[PC+64'd6],
            inst_stack[PC+64'd5],
            inst_stack[PC+64'd4],
            inst_stack[PC+64'd3],
            inst_stack[PC+64'd2],  // 56
            inst_stack[PC+64'd1],  // 64
            inst_stack[PC]         // 72
        };

        icode = instruction[0:3];
        ifun = instruction[4:7];

        if (icode > 4'b1011)
            instr_valid = 1'b0;
        else
            instr_valid = 1'b1;
		

        case (icode)
            4'b0000: begin // halt
                hlt = 1;
                valP = PC;
            end
            4'b0001, 4'b1001: begin // nop, ret
                valP = PC + 64'd1;
                //$display("test_ret_f");
            end
            4'b0010, 4'b0110, 4'b1010, 4'b1011: begin // cmovXX, opq, pushq, popq
                rA = instruction[8:11];
                rB = instruction[12:15];
                valP = PC + 64'd2;
            end
            4'b0011, 4'b0100, 4'b0101: begin // irmovq, rmmovq, mrmovq
                rA = instruction[8:11];
                rB = instruction[12:15];
                // FLIP BYTES 3-10
                //valC = instruction[16:79];
                valC = revbyteinstr[0:63];
                valP = PC + 64'd10;
            end
            4'b0111, 4'b1000: begin // jXX, call
                // FLIP BYTES 2-9
                //valC = instruction[8:71];
                valC = revbyteinstr[8:71];
                valP = PC + 64'd9;
            end
        endcase

        //if(xflag==1) begin
        //    hlt=1;
        //    //valP=2048;
        //end
        //PC = valP;
        //$monitor("clk=%d icode=%d ifun=%d rA=%d rB=%d PC=%d, valP=%d \n", clk, icode, ifun, rA, rB, PC, valP);
    end

endmodule

