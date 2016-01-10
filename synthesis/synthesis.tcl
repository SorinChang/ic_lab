


analyze -format verilog ../rtl_new/iic_all.v 
elaborate iic_top

uniquify
current_design iic_top

link

source ./constraints.tcl

compile  -map_effort medium 

write_file -hierarchy -format verilog -output ./iic_netlist.v
write_sdc ./iic.sdc
