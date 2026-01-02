# verilog-datapath
Basic datapath integrating Register File and ALU in Verilog

## Components
- Register File: 2-read, 1-write with synchronous write and asynchronous read
- ALU: Supports arithmetic, logical, shift, and comparison operations
- Datapath Top: Connects Register File outputs to ALU inputs

## Features
- Parameterized data width
- ALU flags: Zero, Carry, Overflow
- Verified via simulation

## Testbench
- Writes operands to registers
- Reads operands and performs ALU operations (ADD, SUB)
- Waveform confirms correct datapath behavior

## Files
- alu.v
- regfile.v
- datapath_top.v
- tb_datapath.v
- waveform.png

## Author
Renuka Poojala
