
module reg_stack(read, address, w_value, r_value);

    input read;
    input [3:0] address;
    input [63:0] w_value;
    output reg [63:0] r_value;

    reg [15:0] reg_stk[63:0];

    always @(*)begin
        if(read == 1)
        begin
            r_value <= reg_stk[address];
        end
        if(read == 0)
        begin
            reg_stk[address] <= w_value;
        end
    end

endmodule