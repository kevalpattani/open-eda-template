| Tool Name | Domain / Category | Primary Purpose | Source in Flake |
| :--- | :--- | :--- | :--- |
| `librelane` | ASIC Flow Orchestration | Drives the end-to-end RTL-to-GDSII tapeout flow | `librelane-shell` base |
| `yosys` | RTL Synthesis | Translates Verilog RTL into gate-level netlists | `librelane-shell` base |
| `openroad` | Physical Design (ASIC) | Automated floorplanning, placement, CTS, and routing | `librelane-shell` base |
| `opensta` | Timing Signoff | Static Timing Analysis (setup/hold slack, critical paths) | `librelane-shell` base |
| `iverilog` | Digital Simulation | IEEE-1364 event-driven Verilog logic simulator | `extra-packages` |
| `verilator` | Digital Simulation | High-speed C++/SystemC compilation of Verilog designs | `extra-packages` |
| `gtkwave` | Verification / Debug | Graphical waveform viewer for `.vcd` and `.fst` traces | `extra-packages` |
| `cocotb` | Digital Verification | Coroutine-based Python testbench environment | `extra-python-packages` |
| `nextpnr` | FPGA Implementation | Timing-driven place-and-route for FPGAs | `extra-packages` |
| `icestorm` | FPGA Tooling | Low-level bitstream packing/analysis for Lattice iCE40 | `extra-packages` |
| `trellis` | FPGA Tooling | Device database and bitstream generation for Lattice ECP5 | `extra-packages` |
| `openfpgaloader` | Hardware Programming | Universal JTAG/SPI bitstream flashing utility for dev boards | `extra-packages` |
| `xschem` | Schematic Capture | Hierarchical schematic editor for analog and mixed-signal VLSI | `extra-packages` |
| `xterm` | System Utility | Terminal emulator invoked by `xschem` for simulation runs | `extra-packages` |
| `ngspice` | Analog Simulation | General-purpose circuit simulation engine (SPICE) | `extra-packages` |
| `openvaf-r` | Model Compilation | Verilog-A compiler for compact semiconductor device models | `extra-packages` |
| `klayout` | Mask Layout / DRC | High-performance GDSII/OASIS viewer and DRC verification | `extra-packages` |
| `magic` | Mask Layout / DRC | VLSI layout editor, extraction, and real-time DRC checker | `extra-packages` |
| `netgen` | Physical Verification | Layout Versus Schematic (LVS) comparison tool | `extra-packages` |
