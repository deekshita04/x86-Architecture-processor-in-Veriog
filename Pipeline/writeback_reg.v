module writeback_reg(clk,stat_m,icode_m,valA_m,valB_m,rA_m,rB_m,valc_m,valp_m,valE_m,valM_m,stat_w,icode_w,ifun_w,valA_w,valB_w,valc_w,valp_w,valE_w,rA_w,rB_w,valM_w);
input clk;
input [2:0]stat_m;
input [3:0]icode_m;
input [3:0]ifun_m;
input cnd_m;
input [63:0]valA_m;
input [63:0]valB_m;
input [63:0]valc_m;
input [63:0]valE_m;
input [63:0]valM_m;
input [3:0]rA_m;
input [3:0]rB_m;
input [63:0]valp_m;
output reg[2:0]stat_w;
output reg[3:0]icode_w;
output reg [3:0]ifun_w;
output reg cnd_w;
output reg [3:0]rA_w;
output reg [3:0]rB_w;
output reg [63:0]valA_w;
output reg [63:0]valB_w;
output reg [63:0]valc_w;
output reg [63:0]valE_w;
output reg [63:0]valM_w;
output reg [63:0]valp_w;

always @(posedge clk) begin

    stat_w <= stat_m;
    icode_w <= icode_m;
    ifun_w <= ifun_m;
    rA_w <= rA_m;
    rB_w <= rB_m;
    valA_w <= valA_m;
    valB_w <= valB_m;
    valc_w <= valc_m;
    valE_w <= valE_m;
    valM_w <= valM_m;
    valp_w <= valp_m;
end
endmodule
