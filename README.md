# 8bit-pwm-verilog
8-bit PWM Generator in Verilog-2001 with glitch-free double-buffered duty update, self-checking testbench, and Vivado 2024.2 WebPACK scripts &amp;.
## Overview

This repository provides a lightweight, synthesizable 8-bit Pulse-Width Modulator (PWM) core written in Verilog-2001, complete with:

## Features

- **8-bit resolution**: 256 duty-cycle steps (0 … 255)  
- **Glitch-free updates**: double-buffered duty register  
- **Pure Verilog-2001 RTL** (no SV dependencies)  
- **Self-checking testbench**: verifies 25 %, 50 %, 90 % duty automatically  
- **Vivado scripts** for batch sim, synth, impl, reports  
- **Compact PPA** on Artix-7 (xc7a35t): small area, positive slack, sub-watt power  

---

| Category       | Metric                 | Value                          |
|---------------|------------------------|--------------------------------|
| **Area**       | Slice LUTs             | 14 (0.07 %)                    |
|                | Slice Registers        | 24 (0.06 %)                    |
|                | Bonded IOB             | 12 (5.71 %)                    |
|                | BUFGCTRL               | 1 (3.13 %)                     |
| **Performance**| Worst Negative Slack   | ∞ (no clock constraint applied)|
| **Power**      | Total Power            | 0.145 W (30 % of device)       |




Whether you’re just learning RTL design or need a drop-in PWM IP for an FPGA project, this repo shows a complete end-to-end flow from code to timing.
