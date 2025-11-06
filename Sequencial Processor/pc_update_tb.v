`timescale 1ns / 1ps

module pc_update_tb;

    reg clk;
    reg [3:0] icode;
    reg [63:0] valP;
    reg [63:0] valC;
    reg [63:0] valM;
    reg cond;
    wire [63:0] PC;

    pc_update dut (
        .clk(clk),
        .icode(icode),
        .valP(valP),
        .valC(valC),
        .valM(valM),
        .cond(cond),
        .PC(PC)
    );

    initial begin
        $dumpfile("pcupdate.vcd");
        $dumpvars(0, pc_update_tb); 
       
        // Test case 1: nop
        icode = 4'b0001;
        valP = 64'h9834020A0943CE39;
        valM = 64'h43090382A903293D;
        valC = 64'h834020347D9347FF;
        #10;
        $display("Test Case 1: icode=%b, valP=%h, valM=%h, valC=%h, PC=%h", icode, valP, valM, valC, PC);
        #10

        // Test case 2: JXX (cond=1)
        icode = 4'b0111;
        cond = 1;
        valP = 64'h984057203740293C;
        valC = 64'h879235DD801E9891;
        valM = 64'h7402366AA9821FF7;
        #10;
        $display("Test Case 2: icode=%b, valP=%h, valM=%h, valC=%h, PC=%h", icode, valP, valM, valC, PC);
        #10

        // Test case 3: JXX (cond=0)
        cond = 0;
        valP = 64'h7634969324610231;
        valM = 64'h7412BB126AAA832E;
        valC = 64'hDD87493F90742776;
        #10;
        $display("Test Case 3: icode=%b, valP=%h, valM=%h, valC=%h, PC=%h", icode, valP, valM, valC, PC);
        #10
        // Test case 4: CALL
        icode = 4'b1000;
        valP = 64'h9876543210FEDCB4;
        valC = 64'h1234567890ABCDE7;
        valM = 64'h9876543210FEDCB7;
        #10;
        $display("Test Case 4: icode=%b, valP=%h, valM=%h, valC=%h, PC=%h", icode, valP, valM, valC, PC);
        #10

        // Test case 5: RET
        icode = 4'b1001;
        valP = 64'h9834020A0943CE39;
        valM = 64'h43090382A903293D;
        valC = 64'h834020347D9347FF;
        #10;
        $display("Test Case 5: icode=%b, valP=%h, valM=%h, valC=%h, PC=%h", icode, valP, valM, valC, PC);

        #10;
        $finish;
    end

endmodule
