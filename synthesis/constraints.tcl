#
# Written by : DC-Transcript, Version 2003.06-SP1 -- Aug 15, 2003
# Date       : Thu Oct  9 07:39:56 2003
#

#
# Translation of script: example.scr
#

#/* example.scr */

#/* Set the current_design */
current_design iic_top 
link

#/* Reset all constraints */
reset_design

#/* Create clock object */
create_clock -period 100 [find port clk]
set_dont_touch_network [find clock clk]
set_clock_uncertainty 0.35 [find clock clk]

#/* Setting constraints on input ports */
set_driving_cell  -lib_cell buffd1 [remove_from_collection [all_inputs] [find port clk]]

set_input_delay 2.0 -max -clock clk [remove_from_collection [all_inputs] [find port clk]]
set_output_delay 2.0 -max -clock clk [all_outputs]

#/* Setting load constraint on output ports */
set_load 2 [all_outputs]

#/* Set the wire load model */
set_wire_load_mode enclosed 
#set_wire_load_model -name 8000 

#/* Attempt Area Recovery */
#set_max_area 0

