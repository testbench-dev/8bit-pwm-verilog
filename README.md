# 8bit-pwm-verilog
8-bit PWM Generator in Verilog-2001 with glitch-free double-buffered duty update, self-checking testbench, and Vivado 2024.2 WebPACK scripts &amp; PPA reports.
## Overview

This repository provides a lightweight, synthesizable 8-bit Pulse-Width Modulator (PWM) core written in Verilog-2001, complete with:

- **Glitch-free duty updates** via double-buffered registers  
- **Self-checking testbench** that verifies 25 %, 50 %, and 90 % duty cycles  
- **Vivado 2024.2 WebPACK** scripts for simulation, synthesis, and implementation  


Whether you’re just learning RTL design or need a drop-in PWM IP for an FPGA project, this repo shows a complete end-to-end flow from code to timing.
