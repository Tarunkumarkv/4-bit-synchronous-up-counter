# 4-Bit Synchronous Up-Counter (`counter.v`)

**Synthesizable 4-Bit Binary Up-Counter with Asynchronous Active-High Reset in Verilog-2001 HDL**

**Standard:** `Verilog-2001 HDL` &nbsp;·&nbsp; **Verification:** `Self-Checking Testbench (iverilog + GTKWave)` &nbsp;·&nbsp; [**Engineering Portfolio — tarunkumarkv.github.io ↗**](https://tarunkumarkv.github.io)

---

## Overview

This repository contains the RTL implementation and self-checking verification testbench for a foundational sequential digital block: a **4-bit synchronous binary up-counter with an asynchronous active-high reset** (`always @(posedge clk or posedge rst)`).

The design increments synchronously on every rising edge of `clk` across all 16 binary states (`4'h0` to `4'hF`), wraps cleanly back to `4'h0` on overflow, and clears immediately to `4'h0` whenever `rst` is asserted high.

---

## Port Specification & State Behavior

| Port | Direction | Width | Polarity / Domain | Description |
| :--- | :---: | :---: | :--- | :--- |
| **`clk`** | `input` | `1-bit` | Rising-edge (`posedge clk`) | System clock driving synchronous state transitions (`100 MHz` / `10 ns` in testbench) |
| **`rst`** | `input` | `1-bit` | Active-High (`posedge rst`) | Asynchronous reset clearing `count` immediately to `4'h0` |
| **`count`** | `output reg` | `4-bit` (`[3:0]`) | Registered DFF output | Binary count output (`4'h0` / `0000₂` through `4'hF` / `1111₂`) |

### Next-State Transition Truth Table

| `rst` | `clk` Edge | Current `count[3:0]` | Next `count[3:0]` | Operation |
| :---: | :---: | :---: | :---: | :--- |
| **`1`** | Any (`Async`) | `4'hX` | **`4'h0` (`0000`)** | Asynchronous Active-High Clear |
| **`0`** | `↑` (`posedge`) | `4'h0` .. `4'hE` | **`count + 1'b1`** | Synchronous Binary Increment |
| **`0`** | `↑` (`posedge`) | `4'hF` (`1111`) | **`4'h0` (`0000`)** | Synchronous Overflow Wrap-Around |
| **`0`** | Steady / `↓` | `count` | **`count`** | Hold State |

---

## Simulation & Waveform Verification (`iverilog` + `GTKWave`)

The self-checking testbench [`counter_tb.v`](counter_tb.v) drives a `100 MHz` (`10 ns` period) clock and verifies:
1. Initial asynchronous reset assertion (`rst = 1 → count == 4'h0`).
2. 15-cycle synchronous count progression (`4'h0 → 4'hF`) and 16th-cycle wrap-around (`4'hF → 4'h0`).
3. Mid-cycle asynchronous reset assertion (`rst = 1 → immediate clear to 4'h0`).

### Quickstart

```bash
# Option 1: Run via Makefile
make sim

# Option 2: Compile and run directly with Icarus Verilog
iverilog -o counter_sim counter.v counter_tb.v
vvp counter_sim

# Open the VCD waveform in GTKWave
gtkwave counter_output.vcd
```

---

## Repository Structure

```text
4-bit-synchronous-up-counter/
├── .gitignore       # Excludes compiled simulation binaries and VCD dumps
├── Makefile         # One-command iverilog build & verification target
├── README.md        # Port specification, state table & simulation guide
├── counter.v        # Synthesizable 4-bit synchronous up-counter RTL
└── counter_tb.v     # Self-checking testbench with VCD dump
```
