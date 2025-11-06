`timescale 1ns / 1ps

module fetchtb;
    reg clk;
    reg [63:0] PC;

    wire [3:0] icode;
    wire [3:0] ifun;
    wire [3:0] rA;
    wire [3:0] rB; 
    wire [63:0] valC;
    wire [63:0] valP;

    fetch fetch(
      .clk(clk),
      .PC(PC),
      .icode(icode),
      .ifun(ifun),
      .rA(rA),
      .rB(rB),
      .valC(valC),
      .valP(valP)
    );
  
    //always #2 clk = ~clk;
    initial begin
      clk=0;
    end

    always@(*) begin 
        //clk=0;
        PC= 64'd0;
        $display("clk=%d PC=%d icode=%b ifun=%b rA=%b rB=%b,valC=%d,valP=%d\n",clk,PC,icode,ifun,rA,rB,valC,valP);
        
        clk = ~clk;
        #10;
        PC = valP;
        #10;
        $display("clk=%d PC=%d icode=%b ifun=%b rA=%b rB=%b,valC=%d,valP=%d\n",clk,PC,icode,ifun,rA,rB,valC,valP);
        
        clk = ~clk;
        #10;
        PC = valP;
        #10;
        $display("clk=%d PC=%d icode=%b ifun=%b rA=%b rB=%b,valC=%d,valP=%d\n",clk,PC,icode,ifun,rA,rB,valC,valP);
        
        clk = ~clk;
        #10;
        PC = valP;
        #10;
        $display("clk=%d PC=%d icode=%b ifun=%b rA=%b rB=%b,valC=%d,valP=%d\n",clk,PC,icode,ifun,rA,rB,valC,valP);
        
        clk = ~clk;
        #10;
        $finish;
    end 
    
endmodule