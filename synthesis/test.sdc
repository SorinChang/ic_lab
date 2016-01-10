###################################################################

# Created by write_sdc on Wed Nov  4 10:14:41 2015

###################################################################
set sdc_version 1.9

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
set_wire_load_mode enclosed
set_driving_cell -lib_cell buffd1 [get_ports rst_b]
set_driving_cell -lib_cell buffd1 [get_ports cnt_en]
set_load -pin_load 2 [get_ports cnt_end]
create_clock [get_ports clk]  -period 10  -waveform {0 5}
set_clock_uncertainty 0.35  [get_clocks clk]
set_input_delay -clock clk  -max 2  [get_ports rst_b]
set_input_delay -clock clk  -max 2  [get_ports cnt_en]
set_output_delay -clock clk  -max 2  [get_ports cnt_end]
