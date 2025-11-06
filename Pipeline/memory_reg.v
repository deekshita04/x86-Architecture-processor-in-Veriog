module memory_reg(clk,stat_e,icode_e,ifun_e,cnd_e,valE_e,valA_e,valB_e,valc_e,valp_e,rA_e,rB_e,stat_m,icode_m,ifun_m,valp_m,valc_m,valA_m,valB_m,valE_m,cnd_m,rA_m,rB_m);
input clk;
input [2:0]stat_e;
input [3:0]icode_e;
input [3:0]ifun_e;
input [3:0]rA_e;
input [3:0]rB_e;
input cnd_e;
input [63:0]valA_e;
input [63:0]valB_e;
input [63:0]valc_e;
input [63:0]valp_e;
input [63:0]valE_e;
output reg [2:0]stat_m;
output reg [3:0]icode_m;
output reg [3:0]ifun_m;
output reg [3:0]rA_m;
output reg [3:0]rB_m;
output reg cnd_m;
output reg [63:0]valA_m;
output reg [63:0]valB_m;
output reg [63:0]valc_m;
output reg [63:0]valp_m;
output reg [63:0]valE_m;

always @(posedge clk) begin
    stat_m <= stat_e;
    icode_m <= icode_e;
    ifun_m <= ifun_e;
    rA_m <= rA_e;
    rB_m <= rB_e;
    cnd_m <= cnd_e;
    valA_m <= valA_e;
    valB_m <= valB_e;
    valp_m <= valp_e;
    valc_m <= valc_e;
    valE_m <= valE_e;
end
endmodule