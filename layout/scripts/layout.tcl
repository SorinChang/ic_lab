
source ./scripts/setup.tcl

#floorplan
create_floorplan -left_io2core 20 -right_io2core 20 -top_io2core 20 -bottom_io2core 20 -core_height 100 -core_width 100 -start_first_row -keep_io_place -core_utilization 50 

source ./scripts/connect_pg.tcl
source ./scripts/opt_ctrl.tcl

#place pad
source ./scripts/pad_cell_cons.tcl
source ./scripts/connect_pg.tcl
source ./scripts/opt_ctrl.tcl

save_mw_cel test

# need to set the power net

# place
place_opt
source ./scripts/connect_pg.tcl
source ./scripts/opt_ctrl.tcl

save_mw_cel test

# clock tree
clock_opt
source ./scripts/connect_pg.tcl
source ./scripts/opt_ctrl.tcl

save_mw_cel test

#route
route_opt
source ./scripts/connect_pg.tcl
source ./scripts/opt_ctrl.tcl

save_mw_cel test

#finish




