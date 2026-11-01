# Single-Cycle RISC-V Processor — Up to Execute Stage

An academic project implementing a single-cycle RISC-V datapath up to the **Execute (EXE) stage**, developed using **AMD Vivado**.

## Project Scope

| Stage | Function |
|-------|----------|
| Instruction Fetch (IF) | Fetches the instruction using the program counter |
| Instruction Decode (ID) | Decodes the instruction, reads registers, and generates immediate values and control signals |
| Execute (EXE) | Performs ALU operations on the selected operands |

Memory access and write-back are outside the scope of this submission. These stages describe the instruction flow within a single-cycle design, not separate pipeline stages.

## Project Files

- `RISCV_single_cycle/RISCV_single_cycle.xpr` — Vivado project.
- `RISCV_single_cycle/RISCV_single_cycle.srcs/sources_1/new/` — Design source files.

## Opening the Project

Open `RISCV_single_cycle.xpr` in Vivado to inspect the design sources and elaborated schematic.
