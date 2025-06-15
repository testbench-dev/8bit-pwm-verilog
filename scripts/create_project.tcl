# create_project.tcl – batch synth + impl + reports
create_project pwm8 . -part xc7a35ticsg324-1L -force
set_property target_language SystemVerilog [current_project]

add_files ../rtl/pwm8.sv
update_compile_order -fileset sources_1

create_clock -period 4 [current_fileset]      ;# 250 MHz target

launch_runs synth_1 -jobs 4
wait_on_run synth_1

launch_runs impl_1 -to_step report_timing_summary -jobs 4
wait_on_run impl_1

report_utilization    -file util_report.txt
report_timing_summary -file timing_report.txt

quit
