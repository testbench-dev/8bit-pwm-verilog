#!/usr/bin/env bash
set -e
# Compile RTL + test-bench
xvlog -sv ../rtl/pwm8.sv ../sim/tb_pwm8.sv
# Elaborate & run
xelab tb_pwm8 -R
