`timescale 1ns / 1ps

module clk_div
(
    input [27:0] divider,
    input n_CLK,
    input n_RST,
    output reg o_CLK
    );

    // Define local parameter for clock divider
    // divider = System Clock Frequency / (2 *  Divided Clock Frequency)
    // System Clock Frequency = 24 MHz
    // Target Frequency = 1 Hz

    reg [27:0] clk_cnt = 28'd0;
    
    always @ (posedge(n_CLK))
    begin
        // Reset input is high
        if(n_RST == 1'b1)
        begin
            clk_cnt <= 28'b0;
            o_CLK   <= 1'b0;
        end

        // Counter value equal is divider
        else if(clk_cnt == divider)
        begin
            clk_cnt <= 28'b0;
            o_CLK   <= ~o_CLK;
        end
        
        // Else state
        else
        begin
            clk_cnt <= clk_cnt + 1;
            o_CLK   <= o_CLK;
        end
    end

endmodule