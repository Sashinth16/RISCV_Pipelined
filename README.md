# RISCV_Pipelined

A 5-stage pipelined RV32I RISC-V processor designed and verified in Verilog from scratch.  
Built as a flagship project for CDC internship placements — IIT Kharagpur, EE 2nd Year.

---

## Project Overview

This project implements a complete 32-bit RISC-V processor starting from individual building blocks (ALU, register file, program counter) through a working single-cycle CPU, and finally a fully pipelined 5-stage implementation with hazard detection, data forwarding, and hardware performance counters.

Every module was independently designed, testbenched, and waveform-verified in Xilinx Vivado before integration.

---

## Architecture

### Single-Cycle Datapath
```
PC → IMEM → Control Unit + Regfile + ImmGen → ALU → DMEM → Writeback → PC+4
```

### 5-Stage Pipeline
```
IF → IF/ID → ID → ID/EX → EX → EX/MEM → MEM → MEM/WB → WB
          ↑                  ↑
     Hazard Unit        Forwarding Unit
```

**Supported Instructions:** ADD · ADDI · LW · SW · BEQ

---

## Synthesis Results — Xilinx Artix-7 (xc7a35tcpg236-1)

| Resource | Used | Available | Utilization |
|---|---|---|---|
| Slice LUTs | 185 | 20,800 | 0.89% |
| Flip Flops | 180 | 41,600 | 0.43% |
| Block RAM | 0 | 50 | 0.00% |
| DSPs | 0 | 90 | 0.00% |
| Clock Buffers | 1 | 32 | 3.13% |

- Critical path delay: **7.634 ns**
- Estimated Fmax: **~131 MHz**
- Timing violations: **0**
- Register file inferred as **Distributed RAM (RAM32M × 12)**
- Total cells: **450**

### Per-Module Cell Count

| Module | Cells |
|---|---|
| `id_ex_reg` | 113 |
| `mem_wb_reg` | 73 |
| `ex_mem_reg` | 59 |
| `pc` | 44 |
| `regfile` | 46 |
| `if_id_reg` | 39 |
| `alu` | 8 |
| **Total** | **450** |

---

## Performance (Simulation)

| Metric | Value |
|---|---|
| CPI — no stalls | 1.00 |
| CPI — with load-use stall | 1.33 |
| Pipeline latency | 4 cycles |
| Writeback throughput | 1 instruction/cycle (steady state) |
| Stall cycles (2-stall test) | 2 / 10 cycles = 20% overhead |

### Verified simulation output (pipelined CPU):
```
time=45ns  rd_wb=1  alu_result=0x00000005  ← ADDI x1,x0,5   ✅
time=55ns  rd_wb=2  alu_result=0x0000000a  ← ADDI x2,x0,10  ✅
time=65ns  rd_wb=3  alu_result=0x0000000f  ← ADD  x3,x1,x2  ✅ (forwarding confirmed)
```

---

## RTL Component Summary (Post-Synthesis)

```
32-bit Adders:    4
32-bit XORs:      1
32-bit Registers: 12
5-bit Registers:   5
1-bit Registers:  14
32-bit Muxes:     12  (forwarding, writeback, PC source, ALU source)
```

---

## Module List

### Stage 1 — Building Blocks
| Module | Description |
|---|---|
| `and_gate.v` | 2-input combinational AND gate |
| `dff.v` | D flip-flop with synchronous reset |
| `mux2to1.v` | 2:1 multiplexer |
| `register_n.v` | Parameterized N-bit register |
| `counter_4bit.v` | 4-bit up counter with synchronous reset |
| `decoder_3to8.v` | 3-to-8 one-hot decoder |

### Stage 2 — CPU Core Pieces
| Module | Description |
|---|---|
| `alu.v` | 32-bit ALU: ADD, SUB, AND, OR, XOR, SLT + zero flag |
| `regfile.v` | 32×32-bit register file, 2 read ports, 1 write port, x0 hardwired to 0 |
| `pc.v` | 32-bit program counter with synchronous reset |
| `imem.v` | ROM-style instruction memory, byte-to-word address conversion |
| `imm_gen.v` | Immediate generator: I-type, S-type, B-type encodings |
| `control_unit.v` | Opcode → 8 control signals (reg_write, alu_src, mem_read, mem_write, mem_to_reg, branch, alu_op, imm_sel) |
| `dmem.v` | Data memory: clocked write, combinational read |

### Stage 3 — Single-Cycle CPU
| Module | Description |
|---|---|
| `cpu_singlecycle.v` | Complete RV32I single-cycle datapath, all modules integrated |

### Stage 4 — 5-Stage Pipeline
| Module | Description |
|---|---|
| `if_id_reg.v` | Pipeline register: IF → ID (stall + flush support) |
| `id_ex_reg.v` | Pipeline register: ID → EX (stall + flush support) |
| `ex_mem_reg.v` | Pipeline register: EX → MEM (flush support) |
| `mem_wb_reg.v` | Pipeline register: MEM → WB |
| `hazard_unit.v` | Load-use hazard detection, stall insertion |
| `forwarding_unit.v` | EX and MEM forwarding, EX priority over MEM |
| `branch_predictor.v` | Static not-taken branch predictor |
| `cpu_pipelined.v` | Full 5-stage pipelined integration |

### Stage 5 — Measurement
| Module | Description |
|---|---|
| `perf_counters.v` | Hardware performance counters: cycles, instructions, stalls, CPI×100 |

---

## Repository Structure

```
RISCV_Pipelined/
    rtl/           ← all design files (.v)
    tb/            ← all testbench files (tb_*.v)
    docs/          ← synthesis reports, waveform screenshots
    README.md
```

---

## Tools

- **Xilinx Vivado 2025.2** — simulation, synthesis, implementation
- **Target FPGA** — Xilinx Artix-7 xc7a35tcpg236-1
- **Language** — Verilog HDL (IEEE 1364-2001)

---

## Key Design Decisions

**Why RV32I?** Open-source ISA with no license fees. Increasingly used in industry (Qualcomm, Intel, NVIDIA). Fixed 32-bit instruction width simplifies decode logic.

**Why pipelined?** Single-cycle CPU forces the clock period to match the slowest instruction (LW). Pipelining overlaps execution of multiple instructions, achieving ~1 instruction/cycle throughput in the steady state.

**Why forwarding over stalling?** Forwarding resolves most RAW hazards in 0 extra cycles by routing results directly from pipeline registers back to the ALU. Only load-use hazards require one stall cycle (data isn't available until after MEM stage).

**Why distributed RAM for register file?** Vivado automatically inferred the 32×32-bit array as RAM32M primitives — more area-efficient than 1024 individual flip-flops.

---

## CV Statement

> *"Designed and verified a 5-stage pipelined RV32I RISC-V processor in Verilog with hazard detection, data forwarding unit, and static branch prediction. Synthesized on Xilinx Artix-7 (xc7a35tcpg236-1) — 185 LUTs and 180 flip-flops (<1% utilization), critical path 7.634 ns, estimated Fmax ~131 MHz. Implemented hardware performance counters measuring CPI. Register file inferred as distributed RAM by synthesis tool. Simulated and verified on Xilinx Vivado with full testbench coverage for all 22 modules."*

---

## Author

**Sashinth M K**  
B.Tech, Electrical Engineering  
IIT Kharagpur  
CDC Internship Cycle 2025–26
