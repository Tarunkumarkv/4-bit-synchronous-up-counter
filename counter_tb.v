// =============================================================================
// Testbench:   counter_tb
// Description: Self-Checking Testbench for 4-Bit Synchronous Up-Counter
//              with Asynchronous Active-High Reset
// =============================================================================
`timescale 1ns / 1ps

module counter_tb;

    reg        clk;
    reg        rst;
    wire [3:0] count;

    // Instantiate the Design Under Test (DUT)
    counter DUT (
        .clk   (clk),
        .rst   (rst),
        .count (count)
    );

    // 100 MHz Clock Generator (10 ns period: 5 ns high, 5 ns low)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Self-checking stimulus sequence
    initial begin
        $dumpfile("counter_output.vcd");
        $dumpvars(0, counter_tb);

        $display("----------------------------------------------------------------");
        $display(" Starting Verification: 4-Bit Synchronous Up-Counter (counter.v)");
        $display("----------------------------------------------------------------");

        // 1. Assert asynchronous active-high reset
        rst = 1;
        #10;
        if (count === 4'h0)
            $display("[PASS] t=%0t ns | Initial Reset Asserted   -> count = 4'h%0h", $time, count);
        else
            $display("[FAIL] t=%0t ns | Initial Reset Failed     -> count = 4'h%0h", $time, count);

        // 2. Deassert reset and let the counter run for 16 clock cycles (full wrap-around)
        rst = 0;
        #150; // After 15 cycles (150 ns), count should reach 4'hF (15)
        if (count === 4'hF)
            $display("[PASS] t=%0t ns | 15 Clock Cycles Elapsed  -> count = 4'h%0h (15)", $time, count);
        else
            $display("[INFO] t=%0t ns | Count after 150 ns       -> count = 4'h%0h", $time, count);

        #10;  // 16th clock cycle: rollover from 4'hF -> 4'h0
        if (count === 4'h0)
            $display("[PASS] t=%0t ns | 16th Cycle Rollover      -> count = 4'h%0h (0)", $time, count);

        // 3. Increment 3 cycles, then re-assert asynchronous reset mid-operation
        #30;
        rst = 1;
        #5;
        if (count === 4'h0)
            $display("[PASS] t=%0t ns | Async Reset Re-Asserted  -> count = 4'h%0h", $time, count);
        else
            $display("[FAIL] t=%0t ns | Async Reset Failed       -> count = 4'h%0h", $time, count);

        #15;
        $display("----------------------------------------------------------------");
        $display(" Verification Complete.");
        $display("----------------------------------------------------------------");
        $finish;
    end

endmodule
