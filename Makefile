IVERILOG ?= iverilog
VVP      ?= vvp

.PHONY: all sim clean

all: sim

sim:
	$(IVERILOG) -o counter_sim counter.v counter_tb.v
	$(VVP) counter_sim

clean:
	rm -f counter_sim counter_output.vcd *.vvp
