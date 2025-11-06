`timescale 1ns / 1ps

module memory(clk, icode, valA, valM, valP, valE, dmem_error);

    input clk;
    input [3:0] icode;
    input [63:0] valA;
    input [63:0] valE;
    input [63:0] valP;
    output reg [63:0] valM;
    output reg dmem_error;


    reg [63:0] memory[0:2048];

    reg [0:0] read;
    reg [63:0] address;
    reg [63:0] value;

initial begin
    valM = 64'b0;
    dmem_error = 0;
    //address = 64'b0;
    /*
    genvar i; //memiter
    generate for(i=0; i<2047; i=i+1)
    begin
        memory[i]=64'b0;
    end
    endgenerate
    */
end

//check for memory error
    always @(posedge clk) begin
        #10
        dmem_error=0;
        case(icode)
        
            4'b0100,4'b1010: begin // rmmovq, pushq
                read = 0;
                #2
                address = valE;
                value = valA;
            end
            4'b0101: begin //mrmovq
                read = 1;
                #2
                address = valE;
            end
            4'b1000 : begin //call
                read = 0;
                #2
                address = valE;
                value = valP;
            end
            4'b1011 : begin //popq
                read = 1;
                address = valA;
                $display("test_m");
            end
        endcase
        #100

        if (icode==4'b1001)begin
            read = 1;
            address = valA;
            //$display("test_m");
        end

        //case(icode)
        //
        //    4'b0100,4'b1010: begin // rmmovq, pushq
        //        #2
        //        memory[valE] = valA;
        //    end
        //    4'b0101: begin //mrmovq
        //        #2
        //        valM = memory[valE];
        //    end
        //    4'b1000 : begin //call
        //        #2
        //        memory[valE] = valP;
        //    end
        //    4'b1001, 4'b1011 : begin // ret, popq
        //        #2
        //        valM = memory[valA];
        //    end
        //endcase

    #100
        if(address>2047) begin
            dmem_error = 1;
            $display("RAM wrong location");
            $finish;
        end
    //end
    //always @(negedge clk) begin
        // read and write operations
        if (read == 0) begin
            #2
            memory[address] = value;
            //$display("Memblock value_written=%d, address=%d", value, address);
        end
        if(read == 1) begin
            #2
            valM = memory[address];
            //$display("Memblock value_read=%d", valM);  

        end

        //if((^valM === 1'bX)) begin
        //    valM = 64'b0;
        //end

        
    end
endmodule


