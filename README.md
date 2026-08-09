# 4-Bit Synchronous Up-Counter (RTL-to-GDS)

## 📌 Overview
This project features the design and implementation of a fundamental digital block: a 4-bit synchronous up-counter with an active-high reset. Beyond the RTL design, this repository serves as a demonstration of executing a complete physical design flow, taking a behavioral Verilog model all the way down to a GDSII layout.

## 📁 Repository Structure
*   `counter.v`: The RTL implementation of the up-counter.
*   `counter_tb.v`: The design verification testbench to validate state transitions and reset functionality.
*   `counter_sim`: Compiled simulation executable output.
*   `.gitignore`: Prevents unnecessary EDA tool log files and temporary artifacts from cluttering the repository.

## 🚀 Simulation Instructions
Ensure Icarus Verilog is installed on your system to run the simulation:

```bash
iverilog -o counter_sim counter.v counter_tb.v
vvp counter_sim
