

create_mw_lib test.mw \
	-technology $tech_file \
	-mw_reference_library $mw_ref_libs \
	-open

import_designs ../synthesis/test_netlist.v \
	-format verilog -cel test -top test 
        
set_tlu_plus_files \
	-max_tluplus $tlup_max \
	-min_tluplus $tlup_min \
	-tech2itf_map  $tlup_map

current_design test 

read_sdc ../synthesis/test.sdc
source ./scripts/tluplus.tcl

#source ./scripts/layout.tcl

#source ./scripts/connect_pg.tcl
#source ./scripts/opt_ctrl.tcl

