# RISCV_Pipelined

5-Stage Pipelined RV32I RISC-V Processor implemented in Verilog.  
Built as a flagship project for CDC internship placements.

## Tools
- Xilinx Vivado — simulation and synthesis
- OpenLane + SKY130 PDK — open source ASIC flow (planned)

## Build Progress

### Stage 1 — Building Blocks
- [x] and_gate
- [x] dff
- [x] mux2to1
- [x] register_n
- [x] counter_4bit
- [x] decoder_3to8

### Stage 2 — CPU Core Pieces
- [x] alu
- [x] regfile
- [x] pc
- [x] imem
- [x] imm_gen
- [x] control_unit
- [x] dmem

### Stage 3 — Single Cycle CPU
- [x] cpu_singlecycle

### Stage 4 — Pipeline
- [x] if_id_reg
- [x] id_ex_reg
- [x] ex_mem_reg
- [x] mem_wb_reg
- [ ] hazard_unit
- [ ] forwarding_unit
- [ ] branch_predictor
- [ ] cpu_pipelined

### Stage 5 — Measurement + Silicon
- [ ] perf_counters
- [ ] Vivado synthesis report
- [ ] OpenLane ASIC flow → GDS

## Architecture
*(Block diagram coming soon)*

## Target
CDC Internship — VLSI / Digital Design  
IIT Kharagpur, EE 2nd Year
