// counter_tb.v - Testbench for the 4-bit Up-Counter
`timescale 1ns / 1ps

module counter_tb;

// 1. Declare signals for connecting to the design (DUT)
reg clk;
reg rst;
wire [3:0] count;

// 2. Instantiate the Design Under Test (DUT)
counter DUT (
    .clk(clk),
    .rst(rst),
    .count(count)
);

// 3. Clock Generator (runs continuously)
initial begin
    clk = 0;
    // Clock period is 10ns (5ns high, 5ns low)
    forever #5 clk = ~clk; 
end

// 4. Test Stimulus (applies inputs once)
initial begin
    // Dump all signals into a file for GTKWave
    $dumpfile("counter_output.vcd"); // Creates the Value Change Dump file
    $dumpvars(0, counter_tb);        // Dumps all variables in this module and below

    // --- Test Sequence ---
    rst = 1;  // ASSERT Reset (Start with reset active)
    #10;      // Wait 10ns (2 clock half-cycles)

    rst = 0;  // DEASSERT Reset
    #150;     // Let the counter run for 15 clock cycles (15 * 10ns = 150ns)

    rst = 1;  // Re-ASSERT Reset to check if it works again
    #20;

    $finish;  // Terminate the simulation
end

endmodule
