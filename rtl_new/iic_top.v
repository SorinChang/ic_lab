
module iic_top(
  clk,rst_n,REG_WR,IDAT,addr,
  sw1,sw2,sw3,sw4,
  scl,sda,
  ackflag,
//  sda_link,
  outdata

);

input clk,rst_n,REG_WR;
input [7:0]IDAT;
input [2:0]addr;
input sw1,sw2,sw3,sw4;
output [7:0]outdata;
output [2:0]ackflag;
inout sda;
output scl;

wire net_sda_link;
wire net_clk,net_rst_n,net_reg_wr;
wire [7:0]net_IDAT;
wire [2:0]net_addr;
wire net_sw1,net_sw2,net_sw3,net_sw4;
wire [7:0]net_outdata;
wire [2:0]net_ackflag;
wire net_sda_i,net_sda_o,net_sda;
wire net_scl;
//insert top module

iic iic_instance(
 .clk(net_clk),.rst_n(net_rst_n),.REG_WR(net_reg_wr),
 .IDAT(net_IDAT),.addr(net_addr),
 .sw1(net_sw1),.sw2(net_sw2),.sw3(net_sw3),.sw4(net_sw4),
 .scl(net_scl),.sda(net_sda),.ackflag(net_ackflag),
 .sda_link(net_sda_link),.outdata(net_outdata)

);
//insert io pad
pc3d01 clk_pad(.PAD(clk),.CIN(net_clk));
pc3d01 rst_n_pad(.PAD(rst_n),.CIN(net_rst_n));
pc3d01 REG_WR_pad(.PAD(REG_WR),.CIN(net_reg_wr));

pc3d01 IDAT_pad_0(.PAD(IDAT[0]),.CIN(net_IDAT[0]));
pc3d01 IDAT_pad_1(.PAD(IDAT[1]),.CIN(net_IDAT[1]));
pc3d01 IDAT_pad_2(.PAD(IDAT[2]),.CIN(net_IDAT[2]));
pc3d01 IDAT_pad_3(.PAD(IDAT[3]),.CIN(net_IDAT[3]));
pc3d01 IDAT_pad_4(.PAD(IDAT[4]),.CIN(net_IDAT[4]));
pc3d01 IDAT_pad_5(.PAD(IDAT[5]),.CIN(net_IDAT[5]));
pc3d01 IDAT_pad_6(.PAD(IDAT[6]),.CIN(net_IDAT[6]));
pc3d01 IDAT_pad_7(.PAD(IDAT[7]),.CIN(net_IDAT[7]));

pc3d01 addr_pad_0(.PAD(addr[0]),.CIN(net_addr[0]));
pc3d01 addr_pad_1(.PAD(addr[1]),.CIN(net_addr[1]));
pc3d01 addr_pad_2(.PAD(addr[2]),.CIN(net_addr[2]));

pc3d01 sw1_pad(.PAD(sw1),.CIN(net_sw1));
pc3d01 sw2_pad(.PAD(sw2),.CIN(net_sw2));
pc3d01 sw3_pad(.PAD(sw3),.CIN(net_sw3));
pc3d01 sw4_pad(.PAD(sw4),.CIN(net_sw4));

pc3o05 outdata_pad_0(.I(net_outdata[0]),.PAD(outdata[0]));
pc3o05 outdata_pad_1(.I(net_outdata[1]),.PAD(outdata[1]));
pc3o05 outdata_pad_2(.I(net_outdata[2]),.PAD(outdata[2]));
pc3o05 outdata_pad_3(.I(net_outdata[3]),.PAD(outdata[3]));
pc3o05 outdata_pad_4(.I(net_outdata[4]),.PAD(outdata[4]));
pc3o05 outdata_pad_5(.I(net_outdata[5]),.PAD(outdata[5]));
pc3o05 outdata_pad_6(.I(net_outdata[6]),.PAD(outdata[6]));
pc3o05 outdata_pad_7(.I(net_outdata[7]),.PAD(outdata[7]));

pc3o05 ackflag_pad_0(.I(net_ackflag[0]),.PAD(ackflag[0]));
pc3o05 ackflag_pad_1(.I(net_ackflag[1]),.PAD(ackflag[1]));
pc3o05 ackflag_pad_2(.I(net_ackflag[2]),.PAD(ackflag[2]));

pc3o05 scl_pad(.I(net_scl),.PAD(scl));
assign net_sda=net_sda_link?'bz:net_sda_i;
assign net_sda_o=net_sda_link?net_sda:'bz;
pc3b03 sda_pad(.I(net_sda_o),.OEN(net_sda_link),.CIN(net_sda_i),.PAD(sda));
endmodule 
