
`include "./alu/add.v"
`include "./alu/sub.v"
`include "./alu/and.v"
`include "./alu/xor.v"


module alu(control, A, B, out, overflow);

    input wire [1:0] control;
    input [63:0] A;
    input [63:0] B;
    output reg [63:0] out;
    output wire overflow;
    wire overflow1, overflow2, overflow3;

    output reg flag;

    wire signed [63:0] add_out;
    wire signed [63:0] sub_out;
    wire signed [63:0] and_out;
    wire signed [63:0] xor_out;
    //reg signed [63:0] ansfinal;
    //reg overflowfinal;

    add add1(A, B, add_out, overflow1);
    sub sub1(A, B, sub_out, overflow2);
    and_vector and1(A, B, and_out, overflow3);
    xor_vector xor1(A, B, xor_out, overflow3);

    //flag=0

    always@* begin
        case(control)
            2'b00:begin
                out = add_out;
                flag = overflow1;
            end
            2'b01:begin
                out = sub_out;
                flag = overflow2;
            end
            2'b10:begin
                out = and_out;
                flag = overflow3;
            end
            2'b11:begin
                out = xor_out;
                flag = overflow3;
            end
        endcase

    end

    assign overflow = flag;

endmodule

