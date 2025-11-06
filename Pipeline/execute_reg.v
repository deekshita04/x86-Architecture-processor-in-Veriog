module execute_reg(clk,stat_d,icode_d,ifun_d,valc_d,valp_d,valA_d,valB_d,rA_d,rB_d,stat_e,icode_e,ifun_e,valA_e,valB_e,rA_e,rB_e,valp_e,valc_e);
input clk;
input [2:0]stat_d;
input [3:0]icode_d;
input [3:0]ifun_d;
input [3:0]rA_d;
input [3:0]rB_d;
input [63:0]valA_d;
input [63:0]valB_d;
input [63:0]valc_d;
input [63:0]valp_d;
output reg[2:0]stat_e;
output reg[3:0]icode_e;
output reg[3:0]ifun_e;
output reg[3:0]rA_e;
output reg [3:0]rB_e;
output reg[63:0]valc_e;
output reg[63:0]valp_e;
output reg[63:0]valA_e;
output reg [63:0]valB_e;

always @(posedge clk) begin

    stat_e <= stat_d;
    icode_e <= icode_d;
    ifun_e <= ifun_d;
    rA_e <= rA_d;
    rB_e <= rB_d;
    valc_e <= valc_d;
    valp_e <= valp_d;
    valA_e <= valA_d;
    valB_e <= valB_d;
end
endmodule

