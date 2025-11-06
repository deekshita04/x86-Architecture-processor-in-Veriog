module decode_reg(clk,stat_f,icode_f,ifun_f,rA_f,rB_f,valc_f,valp_f,stat_d,icode_d,ifun_d,rA_d,rB_d,valc_d,valp_d);
input clk;
input [2:0]stat_f;
input [3:0]icode_f;
input [3:0]ifun_f;
input[3:0]rA_f;
input [3:0]rB_f;
input [63:0]valc_f;
input [63:0]valp_f;
output reg [2:0]stat_d;
output reg [3:0]icode_d;
output reg [3:0]ifun_d;
output reg [3:0]rA_d;
output reg [3:0]rB_d;
output reg [63:0]valc_d;
output reg [63:0]valp_d;

 always @(posedge clk) begin

    stat_d <= stat_f;
    icode_d <= icode_f;
    ifun_d <= ifun_f;
    rA_d <= rA_f;
    rB_d <= rB_f;
    valc_d <= valc_f;
    valp_d <= valp_f;
 
 end
endmodule