
module iic_DW01_inc_0 ( A, SUM );
  input [8:0] A;
  output [8:0] SUM;

  wire   [8:2] carry;

  ah01d0 U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  ah01d0 U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ah01d0 U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ah01d0 U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ah01d0 U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ah01d0 U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ah01d0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  xr02d1 U2 ( .A1(carry[8]), .A2(A[8]), .Z(SUM[8]) );
  inv0d1 U1 ( .I(A[0]), .ZN(SUM[0]) );
endmodule


module iic ( clk, rst_n, REG_WR, IDAT, addr, sw1, sw2, sw3, sw4, scl, sda, 
        ackflag, sda_link, outdata );
  input [7:0] IDAT;
  input [2:0] addr;
  output [2:0] ackflag;
  output [7:0] outdata;
  input clk, rst_n, REG_WR, sw1, sw2, sw3, sw4;
  output scl, sda_link;
  inout sda;
  wire   N120, N121, N122, N123, N124, N125, N126, N127, N128, N129, N130,
         N131, N132, N133, N134, N135, N136, N137, N171, N172, N173, \num[2] ,
         sda_r, n217, n218, n220, n221, n222, n223, n225, n226, n228, n229,
         n230, n233, n234, n235, n236, n237, n247, n259, n260, n261, n262,
         n263, n264, n265, n266, n267, n268, n269, n270, n271, n272, n273,
         n274, n275, n276, n277, n278, n279, n280, n281, n282, n283, n284,
         n285, n286, n287, n288, n289, n290, n291, n292, n293, n294, n295,
         n296, n297, n298, n299, n300, n301, n302, n303, \r199/A[2] , n4, n5,
         n6, n7, n8, n9, n10, n11, n25, n27, n29, n32, n43, n44, n47, n50,
         n193, n196, n197, n201, n210, n216, n317, n318, n327, n328, n331,
         n341, n342, n343, n92, n94, n95, n96, n98, n99, n100, n101, n102,
         n103, n108, n109, n111, n113, n119, n120, n123, n124, n125, n126,
         n127, n128, n129, n130, n131, n132, n133, n134, n135, n136, n137,
         n138, n139, n140, n141, n142, n143, n144, n145, n146, n147, n148,
         n149, n150, n151, n152, n153, n154, n155, n156, n157, n158, n159,
         n160, n161, n162, n163, n165, n166, n167, n168, n169, n170, n171,
         n172, n173, n174, n175, n176, n178, n179, n180, n181, n182, n183,
         n184, n185, n186, n187, n188, n189, n190, n191, n192, n194, n195,
         n198, n199, n200, n202, n203, n204, n205, n207, n208, n209, n211,
         n212, n213, n214, n215, n219, n224, n227, n231, n232, n238, n239,
         n240, n241, n243, n244, n250, n251, n252, n253, n254, n255, n256,
         n257, n258, n304, n305, n306, n307, n308, n309, n311, n312, n313,
         n314, n315, n316, n319, n320, n321, n322, n323, n324, n325, n326,
         n329, n352, n353, n354, n355, n356, n357, n358, n359, n360, n361,
         n362, n363, n364, n365, n366, n367, n368, n369, n370, n371, n372,
         n373, n374, n375, n376, n377, n378, n379, n380, n381, n382, n383,
         n384, n385, n386, n387, n388, n389, n390, n391, n392, n393, n394,
         n395, n396, n397, n398, n399, n400, n401, n402, n403, n404, n405,
         n406, n407, n408, n409, n410, n411, n412, n413, n414, n415, n416,
         n417, n418, n419, n420, n421, n422, n423, n424, n425, n426, n427,
         n428, n429, n430, n431, n432, n433, n434, n435, n436, n437, n438,
         n439, n440, n441, n442, n443, n444, n445, n446, n447, n448, n449,
         n450, n451, n452, n453, n454, n455, n456, n457, n458, n459, n460,
         n461, n462, n463, n465, n466, n467, n468, n469, n470, n471, n472,
         n473, n474, n475, n476, n477, n478, n479, n480;
  wire   [8:0] cnt_delay;
  wire   [6:0] DEVICE;
  wire   [4:0] PAGEDATA_NUM;
  wire   [7:0] WRITE_DATA0;
  wire   [7:0] WRITE_DATA1;
  wire   [7:0] WRITE_DATA2;
  wire   [7:0] WRITE_DATA3;
  wire   [7:0] WRITE_DATA4;
  wire   [7:0] BYTE_ADDR;
  wire   [2:0] pagecnt;
  wire   [7:0] pagedata_r;
  wire   [16:0] cstate;
  wire   [7:0] db_r;
  wire   [7:0] read_data;
  wire   [7:0] DEVICE_WRITE;
  tri   sda;

  dfprb1 \cnt_reg[2]  ( .D(N173), .CP(clk), .SDN(n383), .Q(n326), .QN(n447) );
  dfcrn1 \cstate_reg[9]  ( .D(n289), .CP(clk), .CDN(n382), .QN(n229) );
  dfprb1 \cstate_reg[0]  ( .D(n295), .CP(clk), .SDN(n383), .Q(n327), .QN(n430)
         );
  dfcrn1 \cstate_reg[16]  ( .D(n296), .CP(clk), .CDN(n381), .QN(n225) );
  dfcrn1 \num_reg[3]  ( .D(n300), .CP(clk), .CDN(n382), .QN(n222) );
  dfcrn1 \num_reg[1]  ( .D(n298), .CP(clk), .CDN(n382), .QN(n220) );
  dfcrn1 \cstate_reg[5]  ( .D(n290), .CP(clk), .CDN(n382), .QN(n223) );
  dfcrn4 sda_link_reg ( .D(n279), .CP(clk), .CDN(n379), .QN(n217) );
  dfprb1 \cnt_reg[0]  ( .D(N171), .CP(clk), .SDN(n383), .Q(n318) );
  dfcrb1 \ackflag_reg[1]  ( .D(n280), .CP(clk), .CDN(n380), .Q(ackflag[1]), 
        .QN(n342) );
  dfcrb1 \ackflag_reg[2]  ( .D(n281), .CP(clk), .CDN(n379), .Q(ackflag[2]), 
        .QN(n343) );
  or04d1 U7 ( .A1(n160), .A2(n477), .A3(n270), .A4(sw3), .Z(n170) );
  nd02d2 U11 ( .A1(sw1), .A2(sw2), .ZN(n169) );
  nd02d2 U12 ( .A1(sw2), .A2(n158), .ZN(n190) );
  an02d1 U14 ( .A1(addr[2]), .A2(REG_WR), .Z(n204) );
  an03d1 U19 ( .A1(n142), .A2(n477), .A3(sw2), .Z(n171) );
  nd02d2 U26 ( .A1(sw4), .A2(sw2), .ZN(n270) );
  an04d1 U28 ( .A1(n251), .A2(n223), .A3(n229), .A4(n430), .Z(n241) );
  an02d1 U29 ( .A1(n142), .A2(n480), .Z(n145) );
  an04d1 U30 ( .A1(n228), .A2(n225), .A3(n238), .A4(n176), .Z(n251) );
  an03d1 U32 ( .A1(n253), .A2(n243), .A3(n223), .Z(n244) );
  an03d1 U33 ( .A1(n470), .A2(n471), .A3(n229), .Z(n253) );
  an04d1 U36 ( .A1(n256), .A2(n257), .A3(n258), .A4(n304), .Z(n191) );
  an02d1 U40 ( .A1(n237), .A2(n233), .Z(n322) );
  an02d1 U41 ( .A1(N128), .A2(n124), .Z(N137) );
  an02d1 U42 ( .A1(N127), .A2(n124), .Z(N136) );
  an02d1 U43 ( .A1(N126), .A2(n124), .Z(N135) );
  an02d1 U44 ( .A1(N125), .A2(n124), .Z(N134) );
  an02d1 U45 ( .A1(N124), .A2(n124), .Z(N133) );
  an02d1 U46 ( .A1(N123), .A2(n124), .Z(N132) );
  an02d1 U47 ( .A1(N122), .A2(n124), .Z(N131) );
  an02d1 U48 ( .A1(N121), .A2(n124), .Z(N130) );
  an02d1 U49 ( .A1(N120), .A2(n124), .Z(N129) );
  aor22d1 U125 ( .A1(\r199/A[2] ), .A2(pagedata_r[5]), .B1(n92), .B2(n433), 
        .Z(n9) );
  aor221d1 U126 ( .B1(WRITE_DATA4[5]), .B2(n374), .C1(WRITE_DATA2[5]), .C2(n94), .A(n95), .Z(n92) );
  aor22d1 U127 ( .A1(WRITE_DATA3[5]), .A2(n96), .B1(WRITE_DATA1[5]), .B2(n354), 
        .Z(n95) );
  aor22d1 U128 ( .A1(pagedata_r[4]), .A2(\r199/A[2] ), .B1(n98), .B2(n433), 
        .Z(n8) );
  aor221d1 U129 ( .B1(WRITE_DATA4[4]), .B2(n374), .C1(WRITE_DATA2[4]), .C2(n94), .A(n99), .Z(n98) );
  aor22d1 U130 ( .A1(WRITE_DATA3[4]), .A2(n96), .B1(WRITE_DATA1[4]), .B2(n354), 
        .Z(n99) );
  aor22d1 U131 ( .A1(pagedata_r[3]), .A2(\r199/A[2] ), .B1(n100), .B2(n433), 
        .Z(n7) );
  aor221d1 U132 ( .B1(WRITE_DATA4[3]), .B2(n374), .C1(WRITE_DATA2[3]), .C2(n94), .A(n101), .Z(n100) );
  aor22d1 U133 ( .A1(WRITE_DATA3[3]), .A2(n96), .B1(WRITE_DATA1[3]), .B2(n354), 
        .Z(n101) );
  aor22d1 U134 ( .A1(pagedata_r[2]), .A2(\r199/A[2] ), .B1(n102), .B2(n433), 
        .Z(n6) );
  aor221d1 U135 ( .B1(WRITE_DATA4[2]), .B2(n374), .C1(WRITE_DATA2[2]), .C2(n94), .A(n103), .Z(n102) );
  aor22d1 U136 ( .A1(WRITE_DATA3[2]), .A2(n96), .B1(WRITE_DATA1[2]), .B2(n354), 
        .Z(n103) );
  aor22d1 U139 ( .A1(pagedata_r[1]), .A2(\r199/A[2] ), .B1(n108), .B2(n433), 
        .Z(n5) );
  aor221d1 U140 ( .B1(WRITE_DATA4[1]), .B2(n374), .C1(WRITE_DATA2[1]), .C2(n94), .A(n109), .Z(n108) );
  aor22d1 U141 ( .A1(WRITE_DATA3[1]), .A2(n96), .B1(WRITE_DATA1[1]), .B2(n354), 
        .Z(n109) );
  aor22d1 U149 ( .A1(pagedata_r[0]), .A2(\r199/A[2] ), .B1(n119), .B2(n433), 
        .Z(n4) );
  aor221d1 U150 ( .B1(WRITE_DATA4[0]), .B2(n374), .C1(WRITE_DATA2[0]), .C2(n94), .A(n120), .Z(n119) );
  aor22d1 U151 ( .A1(WRITE_DATA3[0]), .A2(n96), .B1(WRITE_DATA1[0]), .B2(n354), 
        .Z(n120) );
  ora31d1 U154 ( .B1(n197), .B2(n196), .B3(n125), .A(scl), .Z(n123) );
  nd03d0 U155 ( .A1(n126), .A2(n127), .A3(n468), .ZN(n125) );
  aor22d1 U156 ( .A1(pagecnt[0]), .A2(n129), .B1(n130), .B2(n434), .Z(n302) );
  aor31d1 U157 ( .B1(n374), .B2(n433), .B3(n130), .A(n131), .Z(n301) );
  oan211d1 U158 ( .C1(n374), .C2(n442), .B(n441), .A(n433), .ZN(n131) );
  aon211d1 U159 ( .C1(n132), .C2(n133), .B(n222), .A(n134), .ZN(n300) );
  nd04d0 U160 ( .A1(n439), .A2(\num[2] ), .A3(n428), .A4(n222), .ZN(n134) );
  nr02d0 U164 ( .A1(n132), .A2(n427), .ZN(n137) );
  ora21d1 U165 ( .B1(n138), .B2(n428), .A(n136), .Z(n132) );
  aon211d1 U166 ( .C1(n139), .C2(n140), .B(n141), .A(n136), .ZN(n138) );
  aor211d1 U167 ( .C1(n142), .C2(n477), .A(n143), .B(n144), .Z(n136) );
  aor211d1 U168 ( .C1(n440), .C2(n140), .A(n372), .B(n145), .Z(n144) );
  ora31d1 U169 ( .B1(n425), .B2(n426), .B3(n451), .A(n222), .Z(n141) );
  oai22d1 U170 ( .A1(n146), .A2(n147), .B1(n442), .B2(n148), .ZN(n296) );
  aor222d1 U171 ( .A1(n149), .A2(n414), .B1(n150), .B2(n151), .C1(n429), .C2(
        n479), .Z(n295) );
  nr04d0 U173 ( .A1(n451), .A2(n154), .A3(n155), .A4(n140), .ZN(n150) );
  oai21d1 U174 ( .B1(n156), .B2(n414), .A(n269), .ZN(n294) );
  aor21d1 U175 ( .B1(n457), .B2(n445), .A(n157), .Z(n293) );
  aor22d1 U177 ( .A1(n153), .A2(n159), .B1(n436), .B2(n445), .Z(n291) );
  oai2222d1 U178 ( .A1(n152), .A2(n160), .B1(n442), .B2(n161), .C1(n445), .C2(
        n162), .D1(n223), .D2(n163), .ZN(n290) );
  oai322d1 U181 ( .C1(n160), .C2(n478), .C3(n450), .A1(n229), .A2(n163), .B1(
        n158), .B2(n165), .ZN(n289) );
  ora31d1 U182 ( .B1(n448), .B2(n166), .B3(n167), .A(n163), .Z(n288) );
  nr02d0 U183 ( .A1(n148), .A2(n168), .ZN(n167) );
  nr03d0 U184 ( .A1(n169), .A2(sw4), .A3(n160), .ZN(n166) );
  oan211d1 U185 ( .C1(n161), .C2(n168), .B(n170), .A(n450), .ZN(n287) );
  aor221d1 U186 ( .B1(n426), .B2(n169), .C1(n165), .C2(n160), .A(n159), .Z(
        n163) );
  aor221d1 U187 ( .B1(n452), .B2(n449), .C1(n424), .C2(n451), .A(n171), .Z(
        n286) );
  aor21d1 U188 ( .B1(n454), .B2(n449), .A(n173), .Z(n285) );
  nd03d0 U190 ( .A1(n176), .A2(n458), .A3(n353), .ZN(n172) );
  aor22d1 U191 ( .A1(pagecnt[1]), .A2(n129), .B1(n130), .B2(n178), .Z(n283) );
  nr02d0 U192 ( .A1(n442), .A2(n129), .ZN(n130) );
  aor222d1 U193 ( .A1(n426), .A2(n179), .B1(n341), .B2(n180), .C1(n443), .C2(
        ackflag[0]), .Z(n282) );
  aon211d1 U194 ( .C1(n181), .C2(n182), .B(n343), .A(n183), .ZN(n281) );
  nd04d0 U195 ( .A1(n343), .A2(n180), .A3(ackflag[0]), .A4(ackflag[1]), .ZN(
        n183) );
  aor31d1 U196 ( .B1(n180), .B2(ackflag[0]), .B3(n342), .A(n184), .Z(n280) );
  nr02d0 U197 ( .A1(n342), .A2(n181), .ZN(n184) );
  aoi21d1 U198 ( .B1(n341), .B2(n180), .A(n443), .ZN(n181) );
  ora31d1 U199 ( .B1(n455), .B2(n437), .B3(n425), .A(n179), .Z(n180) );
  nd04d0 U200 ( .A1(n444), .A2(n185), .A3(n186), .A4(n446), .ZN(n179) );
  nd03d0 U201 ( .A1(n147), .A2(n437), .A3(n478), .ZN(n186) );
  oaim22d1 U202 ( .A1(n187), .A2(n217), .B1(n188), .B2(n187), .ZN(n279) );
  aor211d1 U203 ( .C1(n436), .C2(n139), .A(n155), .B(n189), .Z(n188) );
  oaim22d1 U204 ( .A1(n168), .A2(n161), .B1(n426), .B2(n190), .ZN(n189) );
  aor21d1 U205 ( .B1(n191), .B2(n158), .A(n192), .Z(n168) );
  nd04d0 U207 ( .A1(n194), .A2(n444), .A3(n195), .A4(n198), .ZN(n187) );
  nr04d0 U208 ( .A1(n199), .A2(n448), .A3(n157), .A4(n429), .ZN(n198) );
  nr02d0 U209 ( .A1(n449), .A2(sw4), .ZN(n147) );
  aon211d1 U210 ( .C1(n435), .C2(n162), .B(n200), .A(n202), .ZN(n199) );
  nd04d0 U211 ( .A1(n437), .A2(sw1), .A3(n159), .A4(n270), .ZN(n202) );
  aoim22d1 U212 ( .A1(n457), .A2(n158), .B1(n148), .B2(n442), .Z(n195) );
  aor21d1 U213 ( .B1(n424), .B2(n425), .A(n145), .Z(n173) );
  nd03d0 U214 ( .A1(n476), .A2(n475), .A3(n204), .ZN(n278) );
  nd03d0 U215 ( .A1(addr[0]), .A2(n204), .A3(addr[1]), .ZN(n277) );
  nd03d0 U216 ( .A1(n204), .A2(n476), .A3(addr[1]), .ZN(n276) );
  nd03d0 U217 ( .A1(n204), .A2(n475), .A3(addr[0]), .ZN(n275) );
  nd03d0 U218 ( .A1(addr[0]), .A2(n475), .A3(n205), .ZN(n274) );
  nd03d0 U219 ( .A1(n476), .A2(n475), .A3(n205), .ZN(n273) );
  nd03d0 U220 ( .A1(addr[1]), .A2(n476), .A3(n205), .ZN(n272) );
  nd03d0 U221 ( .A1(addr[1]), .A2(addr[0]), .A3(n205), .ZN(n271) );
  an12d1 U222 ( .A2(REG_WR), .A1(addr[2]), .Z(n205) );
  aor222d1 U225 ( .A1(BYTE_ADDR[0]), .A2(n153), .B1(DEVICE_WRITE[0]), .B2(n429), .C1(WRITE_DATA0[0]), .C2(n437), .Z(n268) );
  aor222d1 U226 ( .A1(BYTE_ADDR[1]), .A2(n153), .B1(DEVICE_WRITE[1]), .B2(n429), .C1(WRITE_DATA0[1]), .C2(n437), .Z(n267) );
  aor222d1 U227 ( .A1(BYTE_ADDR[2]), .A2(n153), .B1(DEVICE_WRITE[2]), .B2(n429), .C1(WRITE_DATA0[2]), .C2(n437), .Z(n266) );
  aor222d1 U228 ( .A1(BYTE_ADDR[3]), .A2(n153), .B1(DEVICE_WRITE[3]), .B2(n429), .C1(WRITE_DATA0[3]), .C2(n437), .Z(n265) );
  aor222d1 U229 ( .A1(BYTE_ADDR[4]), .A2(n153), .B1(DEVICE_WRITE[4]), .B2(n429), .C1(WRITE_DATA0[4]), .C2(n437), .Z(n264) );
  aor222d1 U230 ( .A1(BYTE_ADDR[5]), .A2(n153), .B1(DEVICE_WRITE[5]), .B2(n429), .C1(WRITE_DATA0[5]), .C2(n437), .Z(n263) );
  aor222d1 U231 ( .A1(BYTE_ADDR[6]), .A2(n153), .B1(DEVICE_WRITE[6]), .B2(n429), .C1(WRITE_DATA0[6]), .C2(n437), .Z(n262) );
  aor222d1 U232 ( .A1(BYTE_ADDR[7]), .A2(n153), .B1(DEVICE_WRITE[7]), .B2(n429), .C1(WRITE_DATA0[7]), .C2(n437), .Z(n261) );
  nr04d0 U233 ( .A1(n454), .A2(n429), .A3(n425), .A4(n142), .ZN(n208) );
  aoi2222d1 U234 ( .A1(n209), .A2(n140), .B1(n451), .B2(n211), .C1(n426), .C2(
        n212), .D1(n149), .D2(n414), .ZN(n207) );
  nd03d0 U235 ( .A1(n442), .A2(n213), .A3(n214), .ZN(n211) );
  aoim22d1 U236 ( .A1(\num[2] ), .A2(n460), .B1(\num[2] ), .B2(n215), .Z(n214)
         );
  aoi2222d1 U237 ( .A1(n422), .A2(pagedata_r[5]), .B1(pagedata_r[6]), .B2(n421), .C1(n428), .C2(pagedata_r[4]), .D1(pagedata_r[7]), .D2(n420), .ZN(n215) );
  aoi2222d1 U238 ( .A1(pagedata_r[3]), .A2(n420), .B1(n428), .B2(pagedata_r[0]), .C1(pagedata_r[2]), .C2(n421), .D1(pagedata_r[1]), .D2(n422), .ZN(n219) );
  oai22d1 U239 ( .A1(n224), .A2(n427), .B1(\num[2] ), .B2(n227), .ZN(n212) );
  aoi2222d1 U240 ( .A1(db_r[5]), .A2(n422), .B1(db_r[6]), .B2(n421), .C1(
        db_r[4]), .C2(n428), .D1(db_r[7]), .D2(n420), .ZN(n227) );
  aoi2222d1 U241 ( .A1(db_r[1]), .A2(n422), .B1(db_r[2]), .B2(n421), .C1(
        db_r[0]), .C2(n428), .D1(db_r[3]), .D2(n420), .ZN(n224) );
  nr04d0 U242 ( .A1(n231), .A2(n232), .A3(n455), .A4(n171), .ZN(n259) );
  nd03d0 U243 ( .A1(n238), .A2(n459), .A3(n456), .ZN(n146) );
  aor31d1 U244 ( .B1(n318), .B2(n447), .B3(n149), .A(n429), .Z(n232) );
  nr04d0 U245 ( .A1(n419), .A2(n239), .A3(n459), .A4(n328), .ZN(n149) );
  aor221d1 U246 ( .B1(n454), .B2(n159), .C1(n140), .C2(n240), .A(n143), .Z(
        n231) );
  oai311d1 U247 ( .C1(n200), .C2(n194), .C3(n431), .A(n446), .B(n129), .ZN(
        n143) );
  aor22d1 U248 ( .A1(n442), .A2(n213), .B1(n161), .B2(n148), .Z(n129) );
  ora31d1 U252 ( .B1(n165), .B2(sw1), .B3(n480), .A(n161), .Z(n194) );
  nd04d0 U253 ( .A1(n353), .A2(n228), .A3(n230), .A4(n461), .ZN(n161) );
  aor21d1 U254 ( .B1(n222), .B2(n440), .A(n158), .Z(n240) );
  nd04d0 U255 ( .A1(cstate[4]), .A2(n241), .A3(n243), .A4(n470), .ZN(n162) );
  nd04d0 U256 ( .A1(cstate[2]), .A2(n241), .A3(n243), .A4(n471), .ZN(n203) );
  nd04d0 U257 ( .A1(n328), .A2(n456), .A3(n225), .A4(n419), .ZN(n175) );
  nd04d0 U258 ( .A1(n244), .A2(n228), .A3(n176), .A4(n430), .ZN(n239) );
  nd03d0 U264 ( .A1(n466), .A2(n447), .A3(n318), .ZN(n174) );
  aon211d1 U265 ( .C1(n159), .C2(n250), .B(n453), .A(n389), .ZN(n247) );
  nd03d0 U270 ( .A1(n251), .A2(n253), .A3(n254), .ZN(n160) );
  nr03d0 U271 ( .A1(n462), .A2(n327), .A3(n223), .ZN(n254) );
  nr03d0 U272 ( .A1(n318), .A2(n326), .A3(n466), .ZN(n159) );
  nr02d0 U274 ( .A1(n445), .A2(n165), .ZN(n142) );
  nr04d0 U276 ( .A1(n327), .A2(n229), .A3(cstate[4]), .A4(cstate[2]), .ZN(n255) );
  nr02d0 U277 ( .A1(n432), .A2(n461), .ZN(n176) );
  nr02d0 U279 ( .A1(n328), .A2(n331), .ZN(n238) );
  nr02d0 U280 ( .A1(n463), .A2(n329), .ZN(n243) );
  nr02d0 U281 ( .A1(n445), .A2(n256), .ZN(n192) );
  nr02d0 U282 ( .A1(n139), .A2(n200), .ZN(n158) );
  nd03d0 U283 ( .A1(n318), .A2(n447), .A3(n317), .ZN(n200) );
  nd03d0 U284 ( .A1(n431), .A2(n427), .A3(n420), .ZN(n139) );
  nr04d0 U285 ( .A1(n305), .A2(n306), .A3(PAGEDATA_NUM[4]), .A4(n307), .ZN(
        n256) );
  oan211d1 U286 ( .C1(pagecnt[1]), .C2(n352), .B(n308), .A(n467), .ZN(n307) );
  xr02d1 U289 ( .A1(PAGEDATA_NUM[3]), .A2(n312), .Z(n306) );
  nr02d0 U290 ( .A1(\r199/A[2] ), .A2(n309), .ZN(n305) );
  aoi21d1 U291 ( .B1(PAGEDATA_NUM[2]), .B2(n473), .A(n312), .ZN(n309) );
  nr02d0 U292 ( .A1(n473), .A2(PAGEDATA_NUM[2]), .ZN(n312) );
  nr02d0 U293 ( .A1(PAGEDATA_NUM[0]), .A2(PAGEDATA_NUM[1]), .ZN(n311) );
  aor22d1 U294 ( .A1(pagedata_r[7]), .A2(\r199/A[2] ), .B1(n313), .B2(n433), 
        .Z(n11) );
  aor221d1 U295 ( .B1(WRITE_DATA4[7]), .B2(n374), .C1(WRITE_DATA2[7]), .C2(n94), .A(n314), .Z(n313) );
  aor22d1 U296 ( .A1(WRITE_DATA3[7]), .A2(n96), .B1(WRITE_DATA1[7]), .B2(n354), 
        .Z(n314) );
  aor22d1 U297 ( .A1(pagedata_r[6]), .A2(\r199/A[2] ), .B1(n315), .B2(n433), 
        .Z(n10) );
  aor221d1 U298 ( .B1(WRITE_DATA4[6]), .B2(n374), .C1(WRITE_DATA2[6]), .C2(n94), .A(n316), .Z(n315) );
  aor22d1 U299 ( .A1(WRITE_DATA3[6]), .A2(n96), .B1(WRITE_DATA1[6]), .B2(n354), 
        .Z(n316) );
  aor311d1 U304 ( .C1(n319), .C2(n320), .C3(n321), .A(n235), .B(n128), .Z(N173) );
  nd04d0 U305 ( .A1(n322), .A2(n236), .A3(n127), .A4(n201), .ZN(n319) );
  nr03d0 U306 ( .A1(n128), .A2(n235), .A3(n321), .ZN(N172) );
  aoi21d1 U307 ( .B1(n322), .B2(n323), .A(n465), .ZN(n321) );
  aor211d1 U308 ( .C1(n324), .C2(n320), .A(n235), .B(n128), .Z(N171) );
  nd04d0 U309 ( .A1(n210), .A2(cnt_delay[8]), .A3(n126), .A4(n196), .ZN(n320)
         );
  nd03d0 U310 ( .A1(n127), .A2(n196), .A3(n126), .ZN(n324) );
  nr03d0 U311 ( .A1(n234), .A2(n237), .A3(n233), .ZN(n126) );
  nr02d0 U312 ( .A1(n210), .A2(cnt_delay[8]), .ZN(n127) );
  nr03d0 U314 ( .A1(n128), .A2(n237), .A3(n233), .ZN(n325) );
  nr04d0 U315 ( .A1(n201), .A2(n469), .A3(n210), .A4(n236), .ZN(n323) );
  iic_DW01_inc_0 add_150 ( .A({cnt_delay[8], n216, cnt_delay[6:4], n201, n197, 
        n196, n193}), .SUM({N128, N127, N126, N125, N124, N123, N122, N121, 
        N120}) );
  dfcrq1 \read_data_reg[7]  ( .D(n50), .CP(clk), .CDN(n379), .Q(read_data[7])
         );
  dfcrq1 \read_data_reg[6]  ( .D(n47), .CP(clk), .CDN(n379), .Q(read_data[6])
         );
  dfcrq1 \read_data_reg[5]  ( .D(n44), .CP(clk), .CDN(n379), .Q(read_data[5])
         );
  dfcrq1 \read_data_reg[4]  ( .D(n43), .CP(clk), .CDN(n379), .Q(read_data[4])
         );
  dfcrq1 \read_data_reg[3]  ( .D(n32), .CP(clk), .CDN(n379), .Q(read_data[3])
         );
  dfcrq1 \read_data_reg[2]  ( .D(n29), .CP(clk), .CDN(n379), .Q(read_data[2])
         );
  dfcrq1 \read_data_reg[1]  ( .D(n27), .CP(clk), .CDN(n379), .Q(read_data[1])
         );
  dfcrq1 \read_data_reg[0]  ( .D(n25), .CP(clk), .CDN(n379), .Q(read_data[0])
         );
  denrq1 \db_r_reg[0]  ( .D(n268), .ENN(n247), .CP(clk), .Q(db_r[0]) );
  denrq1 \db_r_reg[1]  ( .D(n267), .ENN(n247), .CP(clk), .Q(db_r[1]) );
  denrq1 \db_r_reg[2]  ( .D(n266), .ENN(n247), .CP(clk), .Q(db_r[2]) );
  denrq1 \db_r_reg[3]  ( .D(n265), .ENN(n247), .CP(clk), .Q(db_r[3]) );
  denrq1 \db_r_reg[4]  ( .D(n264), .ENN(n247), .CP(clk), .Q(db_r[4]) );
  denrq1 \db_r_reg[5]  ( .D(n263), .ENN(n247), .CP(clk), .Q(db_r[5]) );
  denrq1 \db_r_reg[6]  ( .D(n262), .ENN(n247), .CP(clk), .Q(db_r[6]) );
  denrq1 \db_r_reg[7]  ( .D(n261), .ENN(n247), .CP(clk), .Q(db_r[7]) );
  decrq1 \BYTE_ADDR_reg[7]  ( .D(IDAT[7]), .ENN(n274), .CP(clk), .CDN(n389), 
        .Q(BYTE_ADDR[7]) );
  decrq1 \BYTE_ADDR_reg[6]  ( .D(IDAT[6]), .ENN(n274), .CP(clk), .CDN(n389), 
        .Q(BYTE_ADDR[6]) );
  decrq1 \BYTE_ADDR_reg[5]  ( .D(IDAT[5]), .ENN(n274), .CP(clk), .CDN(n389), 
        .Q(BYTE_ADDR[5]) );
  decrq1 \BYTE_ADDR_reg[4]  ( .D(IDAT[4]), .ENN(n274), .CP(clk), .CDN(n389), 
        .Q(BYTE_ADDR[4]) );
  decrq1 \BYTE_ADDR_reg[3]  ( .D(IDAT[3]), .ENN(n274), .CP(clk), .CDN(n389), 
        .Q(BYTE_ADDR[3]) );
  decrq1 \BYTE_ADDR_reg[2]  ( .D(IDAT[2]), .ENN(n274), .CP(clk), .CDN(n389), 
        .Q(BYTE_ADDR[2]) );
  decrq1 \BYTE_ADDR_reg[1]  ( .D(IDAT[1]), .ENN(n274), .CP(clk), .CDN(n389), 
        .Q(BYTE_ADDR[1]) );
  decrq1 \BYTE_ADDR_reg[0]  ( .D(IDAT[0]), .ENN(n274), .CP(clk), .CDN(n388), 
        .Q(BYTE_ADDR[0]) );
  decrq1 \WRITE_DATA0_reg[3]  ( .D(IDAT[3]), .ENN(n271), .CP(clk), .CDN(n385), 
        .Q(WRITE_DATA0[3]) );
  decrq1 \WRITE_DATA0_reg[2]  ( .D(IDAT[2]), .ENN(n271), .CP(clk), .CDN(n388), 
        .Q(WRITE_DATA0[2]) );
  decrq1 \WRITE_DATA0_reg[1]  ( .D(IDAT[1]), .ENN(n271), .CP(clk), .CDN(n389), 
        .Q(WRITE_DATA0[1]) );
  decrq1 \WRITE_DATA0_reg[0]  ( .D(IDAT[0]), .ENN(n271), .CP(clk), .CDN(n389), 
        .Q(WRITE_DATA0[0]) );
  dfcrq1 \pagedata_r_reg[7]  ( .D(n11), .CP(clk), .CDN(n380), .Q(pagedata_r[7]) );
  dfcrq1 \pagedata_r_reg[6]  ( .D(n10), .CP(clk), .CDN(n381), .Q(pagedata_r[6]) );
  dfcrq1 \pagedata_r_reg[5]  ( .D(n9), .CP(clk), .CDN(n381), .Q(pagedata_r[5])
         );
  dfcrq1 \pagedata_r_reg[4]  ( .D(n8), .CP(clk), .CDN(n381), .Q(pagedata_r[4])
         );
  dfcrq1 \pagedata_r_reg[3]  ( .D(n7), .CP(clk), .CDN(n381), .Q(pagedata_r[3])
         );
  dfcrq1 \pagedata_r_reg[2]  ( .D(n6), .CP(clk), .CDN(n381), .Q(pagedata_r[2])
         );
  dfcrq1 \pagedata_r_reg[1]  ( .D(n5), .CP(clk), .CDN(n381), .Q(pagedata_r[1])
         );
  dfcrq1 \pagedata_r_reg[0]  ( .D(n4), .CP(clk), .CDN(n381), .Q(pagedata_r[0])
         );
  dfcrq1 \cnt_delay_reg[6]  ( .D(N135), .CP(clk), .CDN(n380), .Q(cnt_delay[6])
         );
  dfcrq1 \cnt_delay_reg[5]  ( .D(N134), .CP(clk), .CDN(n380), .Q(cnt_delay[5])
         );
  dfcrq1 \cnt_delay_reg[8]  ( .D(N137), .CP(clk), .CDN(n380), .Q(cnt_delay[8])
         );
  dfcrn1 \cstate_reg[10]  ( .D(n288), .CP(clk), .CDN(n382), .QN(n230) );
  dfcrq1 \cstate_reg[2]  ( .D(n293), .CP(clk), .CDN(n380), .Q(cstate[2]) );
  dfcrn1 \cstate_reg[11]  ( .D(n287), .CP(clk), .CDN(n381), .QN(n226) );
  dfcrn1 \cstate_reg[1]  ( .D(n294), .CP(clk), .CDN(n381), .QN(n218) );
  dfcrq1 \cstate_reg[4]  ( .D(n291), .CP(clk), .CDN(n381), .Q(cstate[4]) );
  dfcrq1 \pagecnt_reg[0]  ( .D(n302), .CP(clk), .CDN(n381), .Q(pagecnt[0]) );
  dfcrq1 \pagecnt_reg[1]  ( .D(n283), .CP(clk), .CDN(n380), .Q(pagecnt[1]) );
  dfcrq1 scl_r_reg ( .D(n303), .CP(clk), .CDN(n380), .Q(scl) );
  deprq1 sda_r_reg ( .D(n260), .ENN(n259), .CP(clk), .SDN(n389), .Q(sda_r) );
  dfcrn2 \num_reg[0]  ( .D(n299), .CP(clk), .CDN(n382), .QN(n221) );
  dfcrb4 \num_reg[2]  ( .D(n297), .CP(clk), .CDN(n380), .Q(\num[2] ), .QN(n427) );
  dfcrb1 \cnt_delay_reg[4]  ( .D(N133), .CP(clk), .CDN(n379), .Q(cnt_delay[4]), 
        .QN(n210) );
  dfcrb1 \cnt_delay_reg[3]  ( .D(N132), .CP(clk), .CDN(n382), .Q(n201), .QN(
        n234) );
  dfcrb1 \cnt_delay_reg[2]  ( .D(N131), .CP(clk), .CDN(n383), .Q(n197), .QN(
        n235) );
  dfcrb1 \cnt_delay_reg[1]  ( .D(N130), .CP(clk), .CDN(n382), .Q(n196), .QN(
        n236) );
  dfcrb1 \cnt_delay_reg[0]  ( .D(N129), .CP(clk), .CDN(n382), .Q(n193), .QN(
        n237) );
  dfcrb1 \cnt_delay_reg[7]  ( .D(N136), .CP(clk), .CDN(n383), .Q(n216), .QN(
        n233) );
  dfcrb1 \cnt_reg[1]  ( .D(N172), .CP(clk), .CDN(rst_n), .Q(n317), .QN(n466)
         );
  dfcrb1 \cstate_reg[3]  ( .D(n292), .CP(clk), .CDN(n380), .Q(n329), .QN(n413)
         );
  dfcrb1 \cstate_reg[14]  ( .D(n284), .CP(clk), .CDN(n382), .Q(n331), .QN(n419) );
  dfcrb1 \pagecnt_reg[2]  ( .D(n301), .CP(clk), .CDN(n382), .Q(\r199/A[2] ), 
        .QN(n433) );
  dfcrb1 \cstate_reg[12]  ( .D(n286), .CP(clk), .CDN(rst_n), .Q(n458), .QN(
        n228) );
  dfcrq1 \cstate_reg[13]  ( .D(n285), .CP(clk), .CDN(rst_n), .Q(n328) );
  decrq1 \DEVICE_WRITE_reg[7]  ( .D(DEVICE[6]), .ENN(n269), .CP(clk), .CDN(
        n388), .Q(DEVICE_WRITE[7]) );
  decrq1 \DEVICE_WRITE_reg[6]  ( .D(DEVICE[5]), .ENN(n269), .CP(clk), .CDN(
        n388), .Q(DEVICE_WRITE[6]) );
  decrq1 \DEVICE_WRITE_reg[5]  ( .D(DEVICE[4]), .ENN(n269), .CP(clk), .CDN(
        n387), .Q(DEVICE_WRITE[5]) );
  decrq1 \DEVICE_WRITE_reg[4]  ( .D(DEVICE[3]), .ENN(n269), .CP(clk), .CDN(
        n387), .Q(DEVICE_WRITE[4]) );
  decrq1 \DEVICE_WRITE_reg[3]  ( .D(DEVICE[2]), .ENN(n269), .CP(clk), .CDN(
        n387), .Q(DEVICE_WRITE[3]) );
  decrq1 \DEVICE_WRITE_reg[2]  ( .D(DEVICE[1]), .ENN(n269), .CP(clk), .CDN(
        n387), .Q(DEVICE_WRITE[2]) );
  decrq1 \DEVICE_WRITE_reg[1]  ( .D(DEVICE[0]), .ENN(n269), .CP(clk), .CDN(
        n387), .Q(DEVICE_WRITE[1]) );
  decrq1 \DEVICE_WRITE_reg[0]  ( .D(n270), .ENN(n269), .CP(clk), .CDN(n387), 
        .Q(DEVICE_WRITE[0]) );
  decrq1 \WRITE_DATA3_reg[7]  ( .D(IDAT[7]), .ENN(n276), .CP(clk), .CDN(n387), 
        .Q(WRITE_DATA3[7]) );
  decrq1 \WRITE_DATA3_reg[6]  ( .D(IDAT[6]), .ENN(n276), .CP(clk), .CDN(n387), 
        .Q(WRITE_DATA3[6]) );
  decrq1 \WRITE_DATA3_reg[5]  ( .D(IDAT[5]), .ENN(n276), .CP(clk), .CDN(n387), 
        .Q(WRITE_DATA3[5]) );
  decrq1 \WRITE_DATA3_reg[4]  ( .D(IDAT[4]), .ENN(n276), .CP(clk), .CDN(n387), 
        .Q(WRITE_DATA3[4]) );
  decrq1 \WRITE_DATA3_reg[3]  ( .D(IDAT[3]), .ENN(n276), .CP(clk), .CDN(n387), 
        .Q(WRITE_DATA3[3]) );
  decrq1 \WRITE_DATA3_reg[2]  ( .D(IDAT[2]), .ENN(n276), .CP(clk), .CDN(n387), 
        .Q(WRITE_DATA3[2]) );
  decrq1 \WRITE_DATA3_reg[1]  ( .D(IDAT[1]), .ENN(n276), .CP(clk), .CDN(n386), 
        .Q(WRITE_DATA3[1]) );
  decrq1 \WRITE_DATA3_reg[0]  ( .D(IDAT[0]), .ENN(n276), .CP(clk), .CDN(n386), 
        .Q(WRITE_DATA3[0]) );
  decrq1 \WRITE_DATA2_reg[7]  ( .D(IDAT[7]), .ENN(n275), .CP(clk), .CDN(n386), 
        .Q(WRITE_DATA2[7]) );
  decrq1 \WRITE_DATA2_reg[6]  ( .D(IDAT[6]), .ENN(n275), .CP(clk), .CDN(n386), 
        .Q(WRITE_DATA2[6]) );
  decrq1 \WRITE_DATA2_reg[5]  ( .D(IDAT[5]), .ENN(n275), .CP(clk), .CDN(n386), 
        .Q(WRITE_DATA2[5]) );
  decrq1 \WRITE_DATA2_reg[4]  ( .D(IDAT[4]), .ENN(n275), .CP(clk), .CDN(n386), 
        .Q(WRITE_DATA2[4]) );
  decrq1 \WRITE_DATA2_reg[3]  ( .D(IDAT[3]), .ENN(n275), .CP(clk), .CDN(n386), 
        .Q(WRITE_DATA2[3]) );
  decrq1 \WRITE_DATA2_reg[2]  ( .D(IDAT[2]), .ENN(n275), .CP(clk), .CDN(n386), 
        .Q(WRITE_DATA2[2]) );
  decrq1 \WRITE_DATA2_reg[1]  ( .D(IDAT[1]), .ENN(n275), .CP(clk), .CDN(n386), 
        .Q(WRITE_DATA2[1]) );
  decrq1 \WRITE_DATA2_reg[0]  ( .D(IDAT[0]), .ENN(n275), .CP(clk), .CDN(n386), 
        .Q(WRITE_DATA2[0]) );
  decrq1 \WRITE_DATA4_reg[7]  ( .D(IDAT[7]), .ENN(n277), .CP(clk), .CDN(n386), 
        .Q(WRITE_DATA4[7]) );
  decrq1 \WRITE_DATA4_reg[6]  ( .D(IDAT[6]), .ENN(n277), .CP(clk), .CDN(n386), 
        .Q(WRITE_DATA4[6]) );
  decrq1 \WRITE_DATA4_reg[5]  ( .D(IDAT[5]), .ENN(n277), .CP(clk), .CDN(n385), 
        .Q(WRITE_DATA4[5]) );
  decrq1 \WRITE_DATA4_reg[4]  ( .D(IDAT[4]), .ENN(n277), .CP(clk), .CDN(n385), 
        .Q(WRITE_DATA4[4]) );
  decrq1 \WRITE_DATA4_reg[3]  ( .D(IDAT[3]), .ENN(n277), .CP(clk), .CDN(n385), 
        .Q(WRITE_DATA4[3]) );
  decrq1 \WRITE_DATA4_reg[2]  ( .D(IDAT[2]), .ENN(n277), .CP(clk), .CDN(n385), 
        .Q(WRITE_DATA4[2]) );
  decrq1 \WRITE_DATA4_reg[1]  ( .D(IDAT[1]), .ENN(n277), .CP(clk), .CDN(n385), 
        .Q(WRITE_DATA4[1]) );
  decrq1 \WRITE_DATA4_reg[0]  ( .D(IDAT[0]), .ENN(n277), .CP(clk), .CDN(n385), 
        .Q(WRITE_DATA4[0]) );
  decrq1 \WRITE_DATA1_reg[7]  ( .D(IDAT[7]), .ENN(n278), .CP(clk), .CDN(n385), 
        .Q(WRITE_DATA1[7]) );
  decrq1 \WRITE_DATA1_reg[6]  ( .D(IDAT[6]), .ENN(n278), .CP(clk), .CDN(n385), 
        .Q(WRITE_DATA1[6]) );
  decrq1 \WRITE_DATA1_reg[5]  ( .D(IDAT[5]), .ENN(n278), .CP(clk), .CDN(n385), 
        .Q(WRITE_DATA1[5]) );
  decrq1 \WRITE_DATA1_reg[4]  ( .D(IDAT[4]), .ENN(n278), .CP(clk), .CDN(n385), 
        .Q(WRITE_DATA1[4]) );
  decrq1 \WRITE_DATA1_reg[3]  ( .D(IDAT[3]), .ENN(n278), .CP(clk), .CDN(n385), 
        .Q(WRITE_DATA1[3]) );
  decrq1 \WRITE_DATA1_reg[2]  ( .D(IDAT[2]), .ENN(n278), .CP(clk), .CDN(n384), 
        .Q(WRITE_DATA1[2]) );
  decrq1 \WRITE_DATA1_reg[1]  ( .D(IDAT[1]), .ENN(n278), .CP(clk), .CDN(n384), 
        .Q(WRITE_DATA1[1]) );
  decrq1 \WRITE_DATA1_reg[0]  ( .D(IDAT[0]), .ENN(n278), .CP(clk), .CDN(n384), 
        .Q(WRITE_DATA1[0]) );
  decrq1 \PAGEDATA_NUM_reg[4]  ( .D(IDAT[4]), .ENN(n272), .CP(clk), .CDN(n384), 
        .Q(PAGEDATA_NUM[4]) );
  decrq1 \PAGEDATA_NUM_reg[3]  ( .D(IDAT[3]), .ENN(n272), .CP(clk), .CDN(n384), 
        .Q(PAGEDATA_NUM[3]) );
  decrq1 \PAGEDATA_NUM_reg[2]  ( .D(IDAT[2]), .ENN(n272), .CP(clk), .CDN(n384), 
        .Q(PAGEDATA_NUM[2]) );
  decrq1 \PAGEDATA_NUM_reg[1]  ( .D(IDAT[1]), .ENN(n272), .CP(clk), .CDN(n384), 
        .Q(PAGEDATA_NUM[1]) );
  decrq1 \PAGEDATA_NUM_reg[0]  ( .D(IDAT[0]), .ENN(n272), .CP(clk), .CDN(n384), 
        .Q(PAGEDATA_NUM[0]) );
  decrq1 \outdata_r_reg[7]  ( .D(read_data[7]), .ENN(n423), .CP(clk), .CDN(
        n388), .Q(outdata[7]) );
  decrq1 \outdata_r_reg[6]  ( .D(read_data[6]), .ENN(n423), .CP(clk), .CDN(
        n388), .Q(outdata[6]) );
  decrq1 \outdata_r_reg[5]  ( .D(read_data[5]), .ENN(n423), .CP(clk), .CDN(
        n388), .Q(outdata[5]) );
  decrq1 \outdata_r_reg[4]  ( .D(read_data[4]), .ENN(n423), .CP(clk), .CDN(
        n388), .Q(outdata[4]) );
  decrq1 \outdata_r_reg[3]  ( .D(read_data[3]), .ENN(n423), .CP(clk), .CDN(
        n388), .Q(outdata[3]) );
  decrq1 \outdata_r_reg[2]  ( .D(read_data[2]), .ENN(n423), .CP(clk), .CDN(
        n388), .Q(outdata[2]) );
  decrq1 \outdata_r_reg[1]  ( .D(read_data[1]), .ENN(n423), .CP(clk), .CDN(
        n388), .Q(outdata[1]) );
  decrq1 \outdata_r_reg[0]  ( .D(read_data[0]), .ENN(n423), .CP(clk), .CDN(
        n388), .Q(outdata[0]) );
  decrq1 \DEVICE_reg[6]  ( .D(IDAT[6]), .ENN(n273), .CP(clk), .CDN(n384), .Q(
        DEVICE[6]) );
  decrq1 \DEVICE_reg[5]  ( .D(IDAT[5]), .ENN(n273), .CP(clk), .CDN(n384), .Q(
        DEVICE[5]) );
  decrq1 \DEVICE_reg[4]  ( .D(IDAT[4]), .ENN(n273), .CP(clk), .CDN(n384), .Q(
        DEVICE[4]) );
  decrq1 \DEVICE_reg[3]  ( .D(IDAT[3]), .ENN(n273), .CP(clk), .CDN(n384), .Q(
        DEVICE[3]) );
  decrq1 \DEVICE_reg[2]  ( .D(IDAT[2]), .ENN(n273), .CP(clk), .CDN(n383), .Q(
        DEVICE[2]) );
  decrq1 \DEVICE_reg[1]  ( .D(IDAT[1]), .ENN(n273), .CP(clk), .CDN(n383), .Q(
        DEVICE[1]) );
  decrq1 \DEVICE_reg[0]  ( .D(IDAT[0]), .ENN(n273), .CP(clk), .CDN(n383), .Q(
        DEVICE[0]) );
  decrq1 \WRITE_DATA0_reg[7]  ( .D(IDAT[7]), .ENN(n271), .CP(clk), .CDN(n383), 
        .Q(WRITE_DATA0[7]) );
  decrq1 \WRITE_DATA0_reg[6]  ( .D(IDAT[6]), .ENN(n271), .CP(clk), .CDN(n383), 
        .Q(WRITE_DATA0[6]) );
  decrq1 \WRITE_DATA0_reg[5]  ( .D(IDAT[5]), .ENN(n271), .CP(clk), .CDN(n383), 
        .Q(WRITE_DATA0[5]) );
  decrq1 \WRITE_DATA0_reg[4]  ( .D(IDAT[4]), .ENN(n271), .CP(clk), .CDN(n383), 
        .Q(WRITE_DATA0[4]) );
  dfcrb1 \ackflag_reg[0]  ( .D(n282), .CP(clk), .CDN(rst_n), .Q(ackflag[0]), 
        .QN(n341) );
  invtd2 sda_tri ( .I(n472), .EN(n217), .ZN(sda) );
  inv0d2 U3 ( .I(sw2), .ZN(n480) );
  aoi21d1 U4 ( .B1(PAGEDATA_NUM[1]), .B2(PAGEDATA_NUM[0]), .A(n311), .ZN(n352)
         );
  an04d1 U5 ( .A1(n225), .A2(n244), .A3(n238), .A4(n430), .Z(n353) );
  an02d1 U6 ( .A1(n434), .A2(n408), .Z(n354) );
  invbd7 U8 ( .I(n217), .ZN(sda_link) );
  nd02d1 U9 ( .A1(n147), .A2(n455), .ZN(n185) );
  nd02d2 U10 ( .A1(n429), .A2(n152), .ZN(n269) );
  clk2d2 U13 ( .CLK(n136), .CN(n438) );
  bufbd7 U15 ( .I(n378), .Z(n389) );
  inv0d2 U16 ( .I(n269), .ZN(n453) );
  aor21d4 U17 ( .B1(n437), .B2(n477), .A(n153), .Z(n250) );
  inv0d1 U18 ( .I(read_data[4]), .ZN(n366) );
  inv0d1 U20 ( .I(read_data[7]), .ZN(n368) );
  inv0d1 U21 ( .I(read_data[0]), .ZN(n370) );
  inv0d1 U22 ( .I(read_data[1]), .ZN(n358) );
  inv0d1 U23 ( .I(read_data[2]), .ZN(n360) );
  inv0d1 U24 ( .I(read_data[3]), .ZN(n356) );
  inv0d1 U25 ( .I(read_data[5]), .ZN(n362) );
  inv0d1 U27 ( .I(read_data[6]), .ZN(n364) );
  oan211d2 U31 ( .C1(n148), .C2(n200), .B(n373), .A(n431), .ZN(n372) );
  inv0d0 U34 ( .I(n179), .ZN(n443) );
  inv0d1 U35 ( .I(n185), .ZN(n448) );
  inv0d0 U37 ( .I(n163), .ZN(n450) );
  inv0d1 U38 ( .I(n158), .ZN(n445) );
  inv0d1 U39 ( .I(n192), .ZN(n442) );
  inv0d1 U50 ( .I(n391), .ZN(n428) );
  inv0d1 U51 ( .I(n146), .ZN(n455) );
  bufbd1 U52 ( .I(n375), .Z(n379) );
  bufbd1 U53 ( .I(n375), .Z(n380) );
  bufbd1 U54 ( .I(n375), .Z(n381) );
  bufbd1 U55 ( .I(n376), .Z(n382) );
  bufbd1 U56 ( .I(n376), .Z(n383) );
  bufbd1 U57 ( .I(n376), .Z(n384) );
  bufbd1 U58 ( .I(n377), .Z(n386) );
  bufbd1 U59 ( .I(n377), .Z(n387) );
  bufbd1 U60 ( .I(n378), .Z(n388) );
  bufbd1 U61 ( .I(n377), .Z(n385) );
  nd23d1 U62 ( .A1(n355), .A2(n270), .A3(sw3), .ZN(n152) );
  invbdk U63 ( .I(sw1), .ZN(n355) );
  nd02d1 U64 ( .A1(n111), .A2(n113), .ZN(n135) );
  inv0d1 U65 ( .I(n172), .ZN(n452) );
  inv0d0 U66 ( .I(n152), .ZN(n479) );
  bufbd7 U67 ( .I(rst_n), .Z(n378) );
  inv0d1 U68 ( .I(n160), .ZN(n437) );
  nd02d1 U69 ( .A1(n203), .A2(n162), .ZN(n140) );
  inv0d1 U70 ( .I(n311), .ZN(n473) );
  inv0d1 U71 ( .I(n304), .ZN(n467) );
  inv0d1 U72 ( .I(n416), .ZN(n429) );
  inv0d1 U73 ( .I(n161), .ZN(n451) );
  inv0d1 U74 ( .I(n159), .ZN(n449) );
  inv0d1 U75 ( .I(n203), .ZN(n457) );
  inv0d1 U76 ( .I(n200), .ZN(n440) );
  inv0d1 U77 ( .I(n175), .ZN(n454) );
  inv0d1 U78 ( .I(n239), .ZN(n456) );
  nd02d1 U79 ( .A1(n207), .A2(n208), .ZN(n260) );
  nd12d0 U80 ( .A1(n212), .A2(n139), .ZN(n209) );
  inv0d1 U81 ( .I(n129), .ZN(n441) );
  inv0d1 U82 ( .I(n324), .ZN(n465) );
  inv0d1 U83 ( .I(n128), .ZN(n468) );
  buffd1 U84 ( .I(rst_n), .Z(n377) );
  buffd1 U85 ( .I(rst_n), .Z(n375) );
  buffd1 U86 ( .I(rst_n), .Z(n376) );
  oaim22d1 U87 ( .A1(n356), .A2(n357), .B1(n399), .B2(n420), .ZN(n32) );
  an02d1 U88 ( .A1(n397), .A2(n405), .Z(n357) );
  oaim22d1 U89 ( .A1(n358), .A2(n359), .B1(n399), .B2(n422), .ZN(n27) );
  an02d1 U90 ( .A1(n397), .A2(n403), .Z(n359) );
  oaim22d1 U91 ( .A1(n360), .A2(n361), .B1(n399), .B2(n421), .ZN(n29) );
  an02d1 U92 ( .A1(n397), .A2(n404), .Z(n361) );
  oaim22d1 U93 ( .A1(n362), .A2(n363), .B1(n407), .B2(n422), .ZN(n44) );
  an02d1 U94 ( .A1(n403), .A2(n406), .Z(n363) );
  oaim22d1 U95 ( .A1(n364), .A2(n365), .B1(n407), .B2(n421), .ZN(n47) );
  an02d1 U96 ( .A1(n404), .A2(n406), .Z(n365) );
  oaim22d1 U97 ( .A1(n366), .A2(n367), .B1(n428), .B2(n407), .ZN(n43) );
  an02d1 U98 ( .A1(n400), .A2(n406), .Z(n367) );
  oaim22d1 U99 ( .A1(n368), .A2(n369), .B1(n420), .B2(n407), .ZN(n50) );
  an02d1 U100 ( .A1(n406), .A2(n405), .Z(n369) );
  oaim22d1 U101 ( .A1(n370), .A2(n371), .B1(n399), .B2(n428), .ZN(n25) );
  an02d1 U102 ( .A1(n397), .A2(n400), .Z(n371) );
  or03d1 U103 ( .A1(n165), .A2(sw2), .A3(n174), .Z(n373) );
  nd02d0 U104 ( .A1(n342), .A2(n180), .ZN(n182) );
  inv0d1 U105 ( .I(sda_r), .ZN(n472) );
  inv0d1 U106 ( .I(n243), .ZN(n462) );
  inv0d1 U107 ( .I(PAGEDATA_NUM[0]), .ZN(n474) );
  nd02d1 U108 ( .A1(n309), .A2(\r199/A[2] ), .ZN(n304) );
  nd02d1 U109 ( .A1(PAGEDATA_NUM[0]), .A2(pagecnt[0]), .ZN(n257) );
  nd02d1 U110 ( .A1(n352), .A2(pagecnt[1]), .ZN(n258) );
  inv0d1 U111 ( .I(cstate[2]), .ZN(n470) );
  inv0d1 U112 ( .I(n218), .ZN(n463) );
  inv0d1 U113 ( .I(n226), .ZN(n461) );
  inv0d1 U114 ( .I(cstate[4]), .ZN(n471) );
  an03d1 U115 ( .A1(n329), .A2(n241), .A3(n252), .Z(n153) );
  inv0d1 U116 ( .I(n219), .ZN(n460) );
  inv0d1 U117 ( .I(n225), .ZN(n459) );
  inv0d1 U118 ( .I(cnt_delay[8]), .ZN(n469) );
  an02d1 U119 ( .A1(pagecnt[1]), .A2(pagecnt[0]), .Z(n374) );
  nd02d1 U120 ( .A1(cnt_delay[6]), .A2(cnt_delay[5]), .ZN(n128) );
  nd03d0 U121 ( .A1(n323), .A2(n235), .A3(n325), .ZN(n124) );
  nd12d0 U122 ( .A1(n123), .A2(n124), .ZN(n303) );
  inv0d1 U123 ( .I(n220), .ZN(n395) );
  aor22d1 U124 ( .A1(n438), .A2(n395), .B1(n135), .B2(n439), .Z(n298) );
  mx02d0 U137 ( .I0(n438), .I1(n439), .S(n221), .Z(n299) );
  nd02d1 U138 ( .A1(n439), .A2(n427), .ZN(n133) );
  inv0d1 U142 ( .I(n221), .ZN(n396) );
  nd02d1 U143 ( .A1(n395), .A2(n396), .ZN(n391) );
  inv0d1 U144 ( .I(n133), .ZN(n390) );
  aor21d1 U145 ( .B1(n428), .B2(n390), .A(n137), .Z(n297) );
  nd04d0 U146 ( .A1(n223), .A2(n251), .A3(n243), .A4(n255), .ZN(n165) );
  inv0d1 U147 ( .I(n230), .ZN(n432) );
  nd04d0 U148 ( .A1(n226), .A2(n228), .A3(n353), .A4(n432), .ZN(n148) );
  inv0d1 U152 ( .I(n148), .ZN(n425) );
  nd03d0 U153 ( .A1(n251), .A2(n327), .A3(n244), .ZN(n416) );
  aor21d1 U161 ( .B1(n372), .B2(\num[2] ), .A(n429), .Z(n397) );
  nd02d1 U162 ( .A1(n391), .A2(n416), .ZN(n400) );
  nd02d1 U163 ( .A1(n148), .A2(n165), .ZN(n401) );
  nd03d0 U172 ( .A1(sda), .A2(n401), .A3(n397), .ZN(n392) );
  inv0d1 U176 ( .I(n392), .ZN(n399) );
  nd02d1 U179 ( .A1(n158), .A2(n191), .ZN(n213) );
  inv0d1 U180 ( .I(n145), .ZN(n393) );
  aon211d1 U189 ( .C1(n213), .C2(n442), .B(n148), .A(n393), .ZN(n394) );
  inv0d1 U206 ( .I(n394), .ZN(n423) );
  nd02d1 U223 ( .A1(n221), .A2(n395), .ZN(n113) );
  nd02d1 U224 ( .A1(n113), .A2(n416), .ZN(n403) );
  inv0d1 U249 ( .I(n113), .ZN(n422) );
  nd02d1 U250 ( .A1(n220), .A2(n396), .ZN(n111) );
  nd02d1 U251 ( .A1(n111), .A2(n416), .ZN(n404) );
  inv0d1 U259 ( .I(n111), .ZN(n421) );
  nd02d1 U260 ( .A1(n221), .A2(n220), .ZN(n398) );
  nd02d1 U261 ( .A1(n398), .A2(n416), .ZN(n405) );
  inv0d1 U262 ( .I(n398), .ZN(n420) );
  aor21d1 U263 ( .B1(n372), .B2(n427), .A(n429), .Z(n406) );
  nd03d0 U266 ( .A1(sda), .A2(n406), .A3(n401), .ZN(n402) );
  inv0d1 U267 ( .I(n402), .ZN(n407) );
  inv0d1 U268 ( .I(pagecnt[0]), .ZN(n434) );
  nd02d1 U269 ( .A1(pagecnt[1]), .A2(n434), .ZN(n417) );
  inv0d1 U273 ( .I(n417), .ZN(n96) );
  inv0d1 U275 ( .I(pagecnt[1]), .ZN(n408) );
  nd02d1 U278 ( .A1(pagecnt[0]), .A2(n408), .ZN(n418) );
  inv0d1 U287 ( .I(n418), .ZN(n94) );
  nd02d1 U288 ( .A1(pagecnt[1]), .A2(n352), .ZN(n409) );
  nd03d0 U300 ( .A1(n474), .A2(n434), .A3(n409), .ZN(n308) );
  inv0d1 U301 ( .I(n222), .ZN(n431) );
  aor22d1 U302 ( .A1(n449), .A2(n153), .B1(n457), .B2(n158), .Z(n292) );
  nd02d1 U303 ( .A1(n175), .A2(n172), .ZN(n154) );
  aor22d1 U313 ( .A1(n159), .A2(n154), .B1(n174), .B2(n149), .Z(n284) );
  inv0d1 U316 ( .I(n241), .ZN(n411) );
  inv0d1 U317 ( .I(n470), .ZN(n410) );
  nr03d0 U318 ( .A1(cstate[4]), .A2(n411), .A3(n410), .ZN(n412) );
  nd03d0 U319 ( .A1(n413), .A2(n463), .A3(n412), .ZN(n156) );
  inv0d1 U320 ( .I(n156), .ZN(n415) );
  inv0d1 U321 ( .I(n174), .ZN(n414) );
  nd02d1 U322 ( .A1(n415), .A2(n414), .ZN(n446) );
  inv0d1 U323 ( .I(n165), .ZN(n426) );
  inv0d1 U324 ( .I(n213), .ZN(n424) );
  inv0d1 U325 ( .I(n149), .ZN(n435) );
  inv0d1 U326 ( .I(n446), .ZN(n157) );
  inv0d1 U327 ( .I(n162), .ZN(n436) );
  nd04d0 U328 ( .A1(n416), .A2(n435), .A3(n156), .A4(n148), .ZN(n155) );
  nd02d1 U329 ( .A1(n418), .A2(n417), .ZN(n178) );
  nr04d0 U330 ( .A1(n455), .A2(n153), .A3(n437), .A4(n426), .ZN(n151) );
  nr03d0 U331 ( .A1(cstate[2]), .A2(n463), .A3(cstate[4]), .ZN(n252) );
  invbd2 U332 ( .I(n138), .ZN(n439) );
  invbd2 U333 ( .I(n173), .ZN(n444) );
  invbd2 U334 ( .I(addr[1]), .ZN(n475) );
  invbd2 U335 ( .I(addr[0]), .ZN(n476) );
  invbd2 U336 ( .I(sw1), .ZN(n477) );
  invbd2 U337 ( .I(n169), .ZN(n478) );
endmodule


module iic_top ( clk, rst_n, REG_WR, IDAT, addr, sw1, sw2, sw3, sw4, scl, sda, 
        ackflag, outdata );
  input [7:0] IDAT;
  input [2:0] addr;
  output [2:0] ackflag;
  output [7:0] outdata;
  input clk, rst_n, REG_WR, sw1, sw2, sw3, sw4;
  output scl;
  inout sda;
  wire   net_clk, net_rst_n, net_reg_wr, net_sw1, net_sw2, net_sw3, net_sw4,
         net_scl, net_sda_link, net_sda_i, n1, n2, n4, n5;
  wire   [7:0] net_IDAT;
  wire   [2:0] net_addr;
  wire   [2:0] net_ackflag;
  wire   [7:0] net_outdata;
  tri   sda;
  tri   net_sda;
  tri   net_sda_o;

  pc3d01 clk_pad ( .PAD(clk), .CIN(net_clk) );
  invtd1 net_sda_tri ( .I(n1), .EN(net_sda_link), .ZN(net_sda) );
  iic iic_instance ( .clk(net_clk), .rst_n(net_rst_n), .REG_WR(net_reg_wr), 
        .IDAT(net_IDAT), .addr(net_addr), .sw1(net_sw1), .sw2(net_sw2), .sw3(
        net_sw3), .sw4(net_sw4), .scl(net_scl), .sda(net_sda), .ackflag(
        net_ackflag), .sda_link(net_sda_link), .outdata(net_outdata) );
  pc3d01 rst_n_pad ( .PAD(rst_n), .CIN(net_rst_n) );
  pc3d01 REG_WR_pad ( .PAD(REG_WR), .CIN(net_reg_wr) );
  pc3d01 IDAT_pad_0 ( .PAD(IDAT[0]), .CIN(net_IDAT[0]) );
  pc3d01 IDAT_pad_1 ( .PAD(IDAT[1]), .CIN(net_IDAT[1]) );
  pc3d01 IDAT_pad_2 ( .PAD(IDAT[2]), .CIN(net_IDAT[2]) );
  pc3d01 IDAT_pad_3 ( .PAD(IDAT[3]), .CIN(net_IDAT[3]) );
  pc3d01 IDAT_pad_4 ( .PAD(IDAT[4]), .CIN(net_IDAT[4]) );
  pc3d01 IDAT_pad_5 ( .PAD(IDAT[5]), .CIN(net_IDAT[5]) );
  pc3d01 IDAT_pad_6 ( .PAD(IDAT[6]), .CIN(net_IDAT[6]) );
  pc3d01 IDAT_pad_7 ( .PAD(IDAT[7]), .CIN(net_IDAT[7]) );
  pc3d01 addr_pad_0 ( .PAD(addr[0]), .CIN(net_addr[0]) );
  pc3d01 addr_pad_1 ( .PAD(addr[1]), .CIN(net_addr[1]) );
  pc3d01 addr_pad_2 ( .PAD(addr[2]), .CIN(net_addr[2]) );
  pc3d01 sw1_pad ( .PAD(sw1), .CIN(net_sw1) );
  pc3d01 sw2_pad ( .PAD(sw2), .CIN(net_sw2) );
  pc3d01 sw3_pad ( .PAD(sw3), .CIN(net_sw3) );
  pc3d01 sw4_pad ( .PAD(sw4), .CIN(net_sw4) );
  pc3o05 outdata_pad_0 ( .I(net_outdata[0]), .PAD(outdata[0]) );
  pc3o05 outdata_pad_1 ( .I(net_outdata[1]), .PAD(outdata[1]) );
  pc3o05 outdata_pad_2 ( .I(net_outdata[2]), .PAD(outdata[2]) );
  pc3o05 outdata_pad_3 ( .I(net_outdata[3]), .PAD(outdata[3]) );
  pc3o05 outdata_pad_4 ( .I(net_outdata[4]), .PAD(outdata[4]) );
  pc3o05 outdata_pad_5 ( .I(net_outdata[5]), .PAD(outdata[5]) );
  pc3o05 outdata_pad_6 ( .I(net_outdata[6]), .PAD(outdata[6]) );
  pc3o05 outdata_pad_7 ( .I(net_outdata[7]), .PAD(outdata[7]) );
  pc3o05 ackflag_pad_0 ( .I(net_ackflag[0]), .PAD(ackflag[0]) );
  pc3o05 ackflag_pad_1 ( .I(net_ackflag[1]), .PAD(ackflag[1]) );
  pc3o05 ackflag_pad_2 ( .I(net_ackflag[2]), .PAD(ackflag[2]) );
  pc3o05 scl_pad ( .I(net_scl), .PAD(scl) );
  pc3b03 sda_pad ( .I(n4), .OEN(net_sda_link), .PAD(sda), .CIN(net_sda_i) );
  invtd1 net_sda_o_tri ( .I(n2), .EN(n5), .ZN(net_sda_o) );
  bufbdf U6 ( .I(net_sda_o), .Z(n4) );
  inv0d0 U7 ( .I(net_sda_link), .ZN(n5) );
  inv0d2 U8 ( .I(net_sda), .ZN(n2) );
  invbdk U9 ( .I(net_sda_i), .ZN(n1) );
endmodule

