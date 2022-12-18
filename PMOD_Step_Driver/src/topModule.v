`timescale 1ns / 1ps

module topModule(
    input CLK,                  // 24MHz clock pin 35
    input a_Button,             // Control Button A pin 14 
    input b_Button,             // Control Button B pin 15
    output [2:0] o_LED,         // RGB Led pins R:18 G:16 B:17
    output [3:0] o_Motor        // Motor Output pins 38, 39, 40, 41
    );

    // Instantiated modules signals
    wire dv_CLK;
    wire mt_CLK;
    wire mt_aBtn;
    wire mt_bBtn;
    wire [3:0] stepSig;

    // A Button state
    reg aPressed, aPrev, aLast;
    reg bPressed, bPrev, bLast;

    // A button State
    reg a_btnState = 1'b0;
    // B Button state
    reg b_btnState = 1'b0;

    // Stepper driver frequency started at 24MHz/2400 Hz = 10 KHz
    // if you press a B button on the TangNano FPGA Kit, stepper driver frequency is increase
    reg [27:0] freqSelect = 28'd24000;
    reg dirSelect = 1'b0;

    // Clock Stability Signal
    reg  clkState;
    
    // Main button control block
    always @ (posedge(CLK))
    begin
        aPrev <= mt_aBtn;
        bPrev <= mt_bBtn;

        // Structure used to detect that button A is pressed only once
        if(aPrev != aLast && aPrev == 1'b0)
        begin
            a_btnState <= ~a_btnState;
            freqSelect = freqSelect + 48000;
        end

        // Structure used to detect that button B is pressed only once
        if(bPrev != bLast && bPrev == 1'b0)
        begin
            b_btnState <= ~b_btnState;
        end

        dirSelect <= b_btnState;
        
        bLast <= bPrev;
        aLast <= aPrev;
    end

    // Assign the state on kit LEDs
    assign o_LED[0] = a_btnState;
    assign o_LED[1] = b_btnState;
    assign o_LED[2] = dv_CLK;
    
    // Assign the stepper signals on board
    assign o_Motor = stepSig;

    // Button A metastabilizer module
    sig_stabilizer aBtnMetastability(   
        .clk(CLK),
        .btn(a_Button),
        .out(mt_aBtn)
    );

    // Button B metastabilizer module
    sig_stabilizer bBtnMetastability(
        .clk(CLK),
        .btn(b_Button),
        .out(mt_bBtn)
    );

    // Clock divider module for metastabilizer frequency
    clk_div mtClkDivier(
        .divider(28'd2),
        .n_CLK(CLK),
        .n_RST(1'b0),
        .o_CLK(mt_CLK)
    );

    // Clock divider module for stepper frequency
    clk_div clkDivider(
        .divider(freqSelect),
        .n_CLK(CLK),
        .n_RST(1'b0),
        .o_CLK(dv_CLK)
    );

    // Stepper motor driver module
    stepper_driver myStep(
        .rst(1'b0),
        .dir(dirSelect),
        .clk(dv_CLK),
        .en(1'b1),
        .signal(stepSig)
    );

endmodule