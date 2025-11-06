module fetch_reg(clk,predit_pc,predit_pc_f);
input clk;
input [63:0]predit_pc;
output reg [63:0]predit_pc_f;

 always @(posedge clk) begin
    predit_pc_f=predit_pc;
 end
endmodule