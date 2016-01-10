# Create corners and P/G pads
create_cell {cornerll cornerlr cornerul cornerur} pfrelr
create_cell {vss1left vss1right vss1top vss1bottom} pv0i
create_cell {vdd1left vdd1right vdd1top vdd1bottom} pvdi
create_cell {vss2left vss2right vss2top vss2bottom} pv0a
create_cell {vdd2left vdd2right vdd2top vdd2bottom} pvda

# Define corner pad locations
set_pad_physical_constraints -pad_name "cornerul" -side 1
set_pad_physical_constraints -pad_name "cornerur" -side 2
set_pad_physical_constraints -pad_name "cornerlr" -side 3
set_pad_physical_constraints -pad_name "cornerll" -side 4

# Define signal and PG  pad locations

# Left side
#set_pad_physical_constraints -pad_name "clk_pad" -side 1 -order 1
#set_pad_physical_constraints -pad_name "rst_n_pad" -side 1 -order 2
set_pad_physical_constraints -pad_name "REG_WR_pad" -side 1 -order 1
set_pad_physical_constraints -pad_name "IDAT_pad_0" -side 1 -order 2
set_pad_physical_constraints -pad_name "IDAT_pad_1" -side 1 -order 3
set_pad_physical_constraints -pad_name "IDAT_pad_2" -side 1 -order 4
set_pad_physical_constraints -pad_name "IDAT_pad_3" -side 1 -order 5
set_pad_physical_constraints -pad_name "IDAT_pad_4" -side 1 -order 6
set_pad_physical_constraints -pad_name "IDAT_pad_5" -side 1 -order 7
set_pad_physical_constraints -pad_name "IDAT_pad_6" -side 1 -order 8
set_pad_physical_constraints -pad_name "IDAT_pad_7" -side 1 -order 9
set_pad_physical_constraints -pad_name "vdd2left" -side 1 -order 10
set_pad_physical_constraints -pad_name "vdd1left" -side 1 -order 11
set_pad_physical_constraints -pad_name "vss1left" -side 1 -order 12
set_pad_physical_constraints -pad_name "vss2left" -side 1 -order 13

# Top side
set_pad_physical_constraints -pad_name "addr_pad_0" -side 2 -order 1
set_pad_physical_constraints -pad_name "addr_pad_1" -side 2 -order 2
set_pad_physical_constraints -pad_name "addr_pad_2" -side 2 -order 3
set_pad_physical_constraints -pad_name "sw1_pad" -side 2 -order 4
set_pad_physical_constraints -pad_name "sw2_pad" -side 2 -order 5
set_pad_physical_constraints -pad_name "sw3_pad" -side 2 -order 6
set_pad_physical_constraints -pad_name "sw4_pad" -side 2 -order 7
set_pad_physical_constraints -pad_name "clk_pad" -side 2 -order 8
set_pad_physical_constraints -pad_name "rst_n_pad" -side 2 -order 9
set_pad_physical_constraints -pad_name "vdd2top" -side 2 -order 10
set_pad_physical_constraints -pad_name "vdd1top" -side 2 -order 11
set_pad_physical_constraints -pad_name "vss1top" -side 2 -order 12
set_pad_physical_constraints -pad_name "vss2top" -side 2 -order 13

# Right side
set_pad_physical_constraints -pad_name "outdata_pad_0" -side 3 -order 1
set_pad_physical_constraints -pad_name "outdata_pad_1" -side 3 -order 2
set_pad_physical_constraints -pad_name "outdata_pad_2" -side 3 -order 3
set_pad_physical_constraints -pad_name "outdata_pad_3" -side 3 -order 4
set_pad_physical_constraints -pad_name "outdata_pad_4" -side 3 -order 5
set_pad_physical_constraints -pad_name "outdata_pad_5" -side 3 -order 6
set_pad_physical_constraints -pad_name "outdata_pad_6" -side 3 -order 7
set_pad_physical_constraints -pad_name "outdata_pad_7" -side 3 -order 8
#set_pad_physical_constraints -pad_name "scl_pad" -side 3 -order 8

set_pad_physical_constraints -pad_name "vdd2right" -side 3 -order 10
set_pad_physical_constraints -pad_name "vdd1right" -side 3 -order 11
set_pad_physical_constraints -pad_name "vss1right" -side 3 -order 12
set_pad_physical_constraints -pad_name "vss2right" -side 3 -order 13

# Bottom side

set_pad_physical_constraints -pad_name "scl_pad" -side 4 -order 1
set_pad_physical_constraints -pad_name "sda_pad" -side 4 -order 2
set_pad_physical_constraints -pad_name "ackflag_pad_0" -side 4 -order 3
set_pad_physical_constraints -pad_name "ackflag_pad_1" -side 4 -order 4
set_pad_physical_constraints -pad_name "ackflag_pad_2" -side 4 -order 5
set_pad_physical_constraints -pad_name "vdd2bottom" -side 4 -order 10
set_pad_physical_constraints -pad_name "vdd1bottom" -side 4 -order 11
set_pad_physical_constraints -pad_name "vss1bottom" -side 4 -order 12
set_pad_physical_constraints -pad_name "vss2bottom" -side 4 -order 13
