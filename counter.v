// counter.v - 4-bit Synchronous Up-Counter with Asynchronous Reset
`timescale 1ns / 1ps

module counter (
    input clk,     // Clock input
    input rst,     // Asynchronous Reset (Active High)
    output reg [3:0] count // 4-bit output
);

// This block executes on every rising edge of the clock (posedge clk)
// OR on the rising edge of the reset (posedge rst).
always @(posedge clk or posedge rst) begin
    if (rst) begin
        // If reset is HIGH, set the count to 0 (Asynchronous Reset)
        count <= 4'h0;
    end
    else begin
        // If reset is LOW, increment the counter on clock edge
        // The counter rolls over from 15 (4'hF) back to 0 (4'h0) automatically.
        count <= count + 1'b1;
    end
end

endmodule
