
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
  inv0d1 U1 ( .I(A[0]), .ZN(SUM[0]) );
  xr02d1 U2 ( .A1(carry[8]), .A2(A[8]), .Z(SUM[8]) );
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
         sda_r, N672, N673, N675, N676, N677, N684, n16, n17, n18, n19, n20,
         n21, n23, n24, n26, n28, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n45, n46, n48, n49, n52, n53, n54, n56, n58, n61,
         n62, n63, n68, n69, n70, n71, n72, n73, n76, n77, n78, n79, n80, n82,
         n83, n85, n86, n89, n90, n91, n92, n94, n95, n96, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n111, n112,
         n113, n115, n117, n119, n120, n121, n124, n125, n126, n127, n130,
         n131, n133, n134, n137, n138, n139, n141, n142, n145, n146, n147,
         n148, n149, n150, n151, n153, n154, n155, n158, n159, n160, n162,
         n163, n166, n168, n170, n174, n176, n177, n180, n182, n183, n184,
         n185, n186, n187, n188, n189, n192, n195, n198, n199, n200, n202,
         n203, n204, n205, n206, n207, n208, n209, n211, n212, n213, n215,
         n217, n218, n219, n220, n221, n222, n223, n224, n225, n226, n227,
         n228, n229, n230, n231, n232, n233, n234, n235, n236, n237, n238,
         n239, n240, n241, n242, n243, n244, n245, n246, n247, n248, n249,
         n250, n251, n252, n253, n254, n255, n256, n257, n258, n259, n260,
         n261, n262, n263, n264, n265, n266, n267, n268, n269, n270, n271,
         n272, n273, n274, n275, n276, n277, n278, n279, n280, n281, n282,
         n283, n284, n285, n286, n287, n288, n289, n290, n291, n292, n293,
         n294, n295, n296, n297, n298, n299, n300, n301, n302, n303,
         \r199/A[2] , n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n22, n25, n27, n29, n43, n44, n47, n50, n51, n55, n57, n59, n60,
         n64, n65, n66, n67, n74, n75, n81, n84, n87, n88, n93, n97, n110,
         n114, n116, n118, n122, n123, n128, n129, n132, n135, n136, n140,
         n143, n144, n152, n156, n157, n161, n164, n165, n167, n169, n171,
         n172, n173, n175, n178, n179, n181, n190, n191, n193, n194, n196,
         n197, n201, n210, n214, n216, n304, n305, n306, n307, n308, n309,
         n310, n311, n312, n313, n314, n315, n316, n317, n318, n319, n320,
         n321, n322, n323, n324, n325, n326, n327, n328, n329, n330, n331,
         n332, n333, n334, n335, n336, n337, n338, n339, n340, n341, n342,
         n343, n344, n345, n346, n347, n348, n349, n350, n351, n352, n353,
         n354, n355, n356, n357, n358, n359, n360, n361, n362, n363, n364,
         n365, n366, n367, n368, n369, n370, n371, n372, n373, n374, n375,
         n376, n377, n378, n379, n380, n381, n382, n383, n384, n385, n386,
         n387, n388, n389, n390, n391, n392, n393, n394, n395, n396, n397,
         n398, n399, n400, n401, n402, n403, n404, n405, n406, n407, n408,
         n409, n410, n411, n412, n413, n414, n415, n416;
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

  dfprb1 \cnt_reg[2]  ( .D(N173), .CP(clk), .SDN(n325), .QN(n215) );
  dfprb1 \cnt_reg[0]  ( .D(N171), .CP(clk), .SDN(n326), .Q(n374), .QN(n248) );
  dfprb1 \cstate_reg[0]  ( .D(n295), .CP(clk), .SDN(n327), .Q(n390), .QN(n257)
         );
  invtd1 sda_tri ( .I(n409), .EN(n217), .ZN(sda) );
  aor21d1 U6 ( .B1(n16), .B2(n17), .A(n18), .Z(n238) );
  aor21d1 U7 ( .B1(n19), .B2(n16), .A(n18), .Z(n239) );
  aor21d1 U8 ( .B1(n20), .B2(n16), .A(n18), .Z(n240) );
  aor21d1 U9 ( .B1(n21), .B2(n16), .A(n18), .Z(n241) );
  ora21d1 U10 ( .B1(n395), .B2(n23), .A(n16), .Z(n18) );
  aor21d1 U11 ( .B1(n16), .B2(n17), .A(n24), .Z(n242) );
  aor21d1 U13 ( .B1(n19), .B2(n16), .A(n24), .Z(n243) );
  aor21d1 U14 ( .B1(n20), .B2(n16), .A(n24), .Z(n244) );
  aor21d1 U15 ( .B1(n21), .B2(n16), .A(n24), .Z(n245) );
  ora21d1 U16 ( .B1(n23), .B2(\num[2] ), .A(n16), .Z(n24) );
  aon211d1 U17 ( .C1(n359), .C2(n26), .B(n382), .A(n333), .ZN(n247) );
  aor21d1 U19 ( .B1(n28), .B2(n413), .A(n30), .Z(n26) );
  aor221d1 U20 ( .B1(WRITE_DATA2[7]), .B2(n31), .C1(WRITE_DATA4[7]), .C2(n32), 
        .A(n33), .Z(n249) );
  aor22d1 U21 ( .A1(WRITE_DATA3[7]), .A2(n34), .B1(WRITE_DATA1[7]), .B2(n35), 
        .Z(n33) );
  aor221d1 U22 ( .B1(WRITE_DATA2[6]), .B2(n31), .C1(WRITE_DATA4[6]), .C2(n32), 
        .A(n36), .Z(n250) );
  aor22d1 U23 ( .A1(WRITE_DATA3[6]), .A2(n34), .B1(WRITE_DATA1[6]), .B2(n35), 
        .Z(n36) );
  aor221d1 U24 ( .B1(WRITE_DATA2[5]), .B2(n31), .C1(WRITE_DATA4[5]), .C2(n32), 
        .A(n37), .Z(n251) );
  aor22d1 U25 ( .A1(WRITE_DATA3[5]), .A2(n34), .B1(WRITE_DATA1[5]), .B2(n35), 
        .Z(n37) );
  aor221d1 U26 ( .B1(WRITE_DATA2[4]), .B2(n31), .C1(WRITE_DATA4[4]), .C2(n32), 
        .A(n38), .Z(n252) );
  aor22d1 U27 ( .A1(WRITE_DATA3[4]), .A2(n34), .B1(WRITE_DATA1[4]), .B2(n35), 
        .Z(n38) );
  aor221d1 U28 ( .B1(WRITE_DATA2[3]), .B2(n31), .C1(WRITE_DATA4[3]), .C2(n32), 
        .A(n39), .Z(n253) );
  aor22d1 U29 ( .A1(WRITE_DATA3[3]), .A2(n34), .B1(WRITE_DATA1[3]), .B2(n35), 
        .Z(n39) );
  aor221d1 U30 ( .B1(WRITE_DATA2[2]), .B2(n31), .C1(WRITE_DATA4[2]), .C2(n32), 
        .A(n40), .Z(n254) );
  aor22d1 U31 ( .A1(WRITE_DATA3[2]), .A2(n34), .B1(WRITE_DATA1[2]), .B2(n35), 
        .Z(n40) );
  aor221d1 U32 ( .B1(WRITE_DATA2[1]), .B2(n31), .C1(WRITE_DATA4[1]), .C2(n32), 
        .A(n41), .Z(n255) );
  aor22d1 U33 ( .A1(WRITE_DATA3[1]), .A2(n34), .B1(WRITE_DATA1[1]), .B2(n35), 
        .Z(n41) );
  aor221d1 U34 ( .B1(WRITE_DATA2[0]), .B2(n31), .C1(WRITE_DATA4[0]), .C2(n32), 
        .A(n42), .Z(n256) );
  aor22d1 U35 ( .A1(WRITE_DATA3[0]), .A2(n34), .B1(WRITE_DATA1[0]), .B2(n35), 
        .Z(n42) );
  nr02d0 U36 ( .A1(pagecnt[0]), .A2(pagecnt[1]), .ZN(n35) );
  nd03d0 U37 ( .A1(n411), .A2(n410), .A3(n45), .ZN(n278) );
  nd03d0 U38 ( .A1(addr[0]), .A2(n45), .A3(addr[1]), .ZN(n277) );
  nd03d0 U39 ( .A1(n45), .A2(n411), .A3(addr[1]), .ZN(n276) );
  nd03d0 U40 ( .A1(n45), .A2(n410), .A3(addr[0]), .ZN(n275) );
  nd03d0 U42 ( .A1(addr[0]), .A2(n410), .A3(n46), .ZN(n274) );
  nd03d0 U43 ( .A1(n411), .A2(n410), .A3(n46), .ZN(n273) );
  nd03d0 U45 ( .A1(addr[1]), .A2(n411), .A3(n46), .ZN(n272) );
  nd03d0 U47 ( .A1(addr[1]), .A2(addr[0]), .A3(n46), .ZN(n271) );
  an12d1 U48 ( .A2(REG_WR), .A1(addr[2]), .Z(n46) );
  aor222d1 U49 ( .A1(WRITE_DATA0[0]), .A2(n28), .B1(BYTE_ADDR[0]), .B2(n30), 
        .C1(DEVICE_WRITE[0]), .C2(n383), .Z(n268) );
  aor222d1 U50 ( .A1(WRITE_DATA0[1]), .A2(n28), .B1(BYTE_ADDR[1]), .B2(n30), 
        .C1(DEVICE_WRITE[1]), .C2(n383), .Z(n267) );
  aor222d1 U51 ( .A1(WRITE_DATA0[2]), .A2(n28), .B1(BYTE_ADDR[2]), .B2(n30), 
        .C1(DEVICE_WRITE[2]), .C2(n383), .Z(n266) );
  aor222d1 U52 ( .A1(WRITE_DATA0[3]), .A2(n28), .B1(BYTE_ADDR[3]), .B2(n30), 
        .C1(DEVICE_WRITE[3]), .C2(n383), .Z(n265) );
  aor222d1 U53 ( .A1(WRITE_DATA0[4]), .A2(n28), .B1(BYTE_ADDR[4]), .B2(n30), 
        .C1(DEVICE_WRITE[4]), .C2(n383), .Z(n264) );
  aor222d1 U54 ( .A1(WRITE_DATA0[5]), .A2(n28), .B1(BYTE_ADDR[5]), .B2(n30), 
        .C1(DEVICE_WRITE[5]), .C2(n383), .Z(n263) );
  aor222d1 U55 ( .A1(WRITE_DATA0[6]), .A2(n28), .B1(BYTE_ADDR[6]), .B2(n30), 
        .C1(DEVICE_WRITE[6]), .C2(n383), .Z(n262) );
  aor222d1 U56 ( .A1(WRITE_DATA0[7]), .A2(n28), .B1(BYTE_ADDR[7]), .B2(n30), 
        .C1(DEVICE_WRITE[7]), .C2(n383), .Z(n261) );
  nr04d0 U58 ( .A1(n368), .A2(n383), .A3(n385), .A4(n52), .ZN(n49) );
  aoi2222d1 U59 ( .A1(n53), .A2(n54), .B1(n387), .B2(n56), .C1(n379), .C2(n58), 
        .D1(n384), .D2(n365), .ZN(n48) );
  oai221d1 U60 ( .B1(\num[2] ), .B2(n61), .C1(n62), .C2(n395), .A(n63), .ZN(
        n56) );
  aoi2222d1 U61 ( .A1(pagedata_r[2]), .A2(n397), .B1(pagedata_r[1]), .B2(n400), 
        .C1(pagedata_r[3]), .C2(n401), .D1(pagedata_r[0]), .D2(n398), .ZN(n62)
         );
  aoi2222d1 U62 ( .A1(pagedata_r[6]), .A2(n397), .B1(pagedata_r[5]), .B2(n400), 
        .C1(pagedata_r[7]), .C2(n401), .D1(pagedata_r[4]), .D2(n398), .ZN(n61)
         );
  oai22d1 U64 ( .A1(n69), .A2(n395), .B1(\num[2] ), .B2(n70), .ZN(n58) );
  aoi2222d1 U65 ( .A1(db_r[6]), .A2(n397), .B1(db_r[5]), .B2(n400), .C1(
        db_r[7]), .C2(n401), .D1(db_r[4]), .D2(n398), .ZN(n70) );
  aoi2222d1 U66 ( .A1(db_r[2]), .A2(n397), .B1(db_r[1]), .B2(n400), .C1(
        db_r[3]), .C2(n401), .D1(db_r[0]), .D2(n398), .ZN(n69) );
  nr04d0 U70 ( .A1(n71), .A2(n72), .A3(n383), .A4(n73), .ZN(n259) );
  aor22d1 U71 ( .A1(n54), .A2(n371), .B1(n372), .B2(n222), .Z(n72) );
  nd04d0 U73 ( .A1(n77), .A2(n78), .A3(n79), .A4(n80), .ZN(n71) );
  nd03d0 U74 ( .A1(n215), .A2(n374), .A3(n384), .ZN(n78) );
  ora21d1 U75 ( .B1(n379), .B2(n385), .A(sda), .Z(n258) );
  oaim22d1 U76 ( .A1(n82), .A2(n217), .B1(n83), .B2(n82), .ZN(n279) );
  aor211d1 U77 ( .C1(n366), .C2(n387), .A(n85), .B(n86), .Z(n83) );
  aor221d1 U78 ( .B1(n377), .B2(n396), .C1(n379), .C2(n89), .A(n90), .Z(n86)
         );
  nd04d0 U80 ( .A1(n246), .A2(n378), .A3(n94), .A4(n95), .ZN(n82) );
  nr04d0 U81 ( .A1(n383), .A2(n96), .A3(n362), .A4(n98), .ZN(n95) );
  ora211d1 U82 ( .C1(n99), .C2(n100), .A(n28), .B(sw1), .Z(n98) );
  nr02d0 U83 ( .A1(sw2), .A2(n101), .ZN(n99) );
  aoim22d1 U84 ( .A1(n102), .A2(n103), .B1(n89), .B2(n104), .Z(n94) );
  aor31d1 U88 ( .B1(n109), .B2(n407), .B3(ackflag[0]), .A(n111), .Z(n280) );
  nr02d0 U89 ( .A1(n112), .A2(n407), .ZN(n111) );
  aon211d1 U90 ( .C1(n112), .C2(n113), .B(n408), .A(n115), .ZN(n281) );
  nd04d0 U91 ( .A1(ackflag[1]), .A2(ackflag[0]), .A3(n109), .A4(n408), .ZN(
        n115) );
  aoi21d1 U95 ( .B1(n109), .B2(n406), .A(n117), .ZN(n112) );
  aor222d1 U96 ( .A1(n379), .A2(n360), .B1(n109), .B2(n406), .C1(n117), .C2(
        ackflag[0]), .Z(n282) );
  ora31d1 U98 ( .B1(n28), .B2(n385), .B3(n73), .A(n360), .Z(n109) );
  nr04d0 U100 ( .A1(n119), .A2(n120), .A3(n362), .A4(n96), .ZN(n117) );
  nr03d0 U102 ( .A1(n361), .A2(n381), .A3(n124), .ZN(n120) );
  aor22d1 U103 ( .A1(pagecnt[1]), .A2(n125), .B1(n126), .B2(n127), .Z(n283) );
  aor221d1 U107 ( .B1(n384), .B2(n130), .C1(n131), .C2(n359), .A(n357), .Z(
        n284) );
  aor21d1 U110 ( .B1(n52), .B2(n101), .A(n119), .Z(n285) );
  aor21d1 U111 ( .B1(n133), .B2(n385), .A(n108), .Z(n119) );
  nr02d0 U112 ( .A1(n134), .A2(sw2), .ZN(n108) );
  aor221d1 U113 ( .B1(n131), .B2(n101), .C1(n133), .C2(n387), .A(n367), .Z(
        n286) );
  oan211d1 U117 ( .C1(n137), .C2(n138), .B(n139), .A(n358), .ZN(n287) );
  nr02d0 U119 ( .A1(n358), .A2(n141), .ZN(n288) );
  ora311d1 U120 ( .C1(sw4), .C2(n381), .C3(n124), .A(n121), .B(n142), .Z(n141)
         );
  aor21d1 U123 ( .B1(N684), .B2(n371), .A(n370), .Z(n138) );
  oai322d1 U125 ( .C1(n381), .C2(n414), .C3(n358), .A1(n371), .A2(n145), .B1(
        n229), .B2(n146), .ZN(n289) );
  oai2222d1 U129 ( .A1(n223), .A2(n146), .B1(n137), .B2(n147), .C1(n89), .C2(
        n105), .D1(n381), .D2(n148), .ZN(n290) );
  aor211d1 U131 ( .C1(n412), .C2(n379), .A(n149), .B(n150), .Z(n146) );
  aor22d1 U133 ( .A1(n377), .A2(n89), .B1(n30), .B2(n359), .Z(n291) );
  aor22d1 U136 ( .A1(n376), .A2(n371), .B1(n30), .B2(n101), .Z(n292) );
  aor21d1 U137 ( .B1(n376), .B2(n89), .A(n96), .Z(n293) );
  nd04d0 U140 ( .A1(n154), .A2(n155), .A3(n130), .A4(n405), .ZN(n153) );
  aor221d1 U142 ( .B1(n415), .B2(n383), .C1(n384), .C2(n365), .A(n151), .Z(
        n295) );
  nr03d0 U143 ( .A1(n28), .A2(n379), .A3(n149), .ZN(n151) );
  nr04d0 U145 ( .A1(n30), .A2(n385), .A3(n387), .A4(n52), .ZN(n159) );
  nr03d0 U148 ( .A1(cstate[2]), .A2(n219), .A3(cstate[4]), .ZN(n162) );
  nr04d0 U149 ( .A1(n73), .A2(n131), .A3(n90), .A4(n54), .ZN(n158) );
  aor311d1 U150 ( .C1(n155), .C2(n405), .C3(n154), .A(n383), .B(n384), .Z(n90)
         );
  nd04d0 U154 ( .A1(n160), .A2(n225), .A3(n227), .A4(n394), .ZN(n106) );
  nd03d0 U159 ( .A1(sw1), .A2(n416), .A3(sw3), .ZN(n148) );
  aor22d1 U162 ( .A1(n370), .A2(n385), .B1(n73), .B2(n361), .Z(n296) );
  nr02d0 U164 ( .A1(n101), .A2(sw4), .ZN(n100) );
  nd03d0 U165 ( .A1(n215), .A2(n373), .A3(n248), .ZN(n101) );
  aor31d1 U168 ( .B1(n398), .B2(n395), .B3(n364), .A(n176), .Z(n297) );
  nr02d0 U169 ( .A1(n177), .A2(n395), .ZN(n176) );
  aor22d1 U170 ( .A1(n363), .A2(n402), .B1(n364), .B2(n180), .Z(n298) );
  aor22d1 U174 ( .A1(n363), .A2(n399), .B1(n364), .B2(n221), .Z(n299) );
  aon211d1 U176 ( .C1(n177), .C2(n183), .B(n222), .A(n184), .ZN(n300) );
  nd04d0 U177 ( .A1(n364), .A2(n398), .A3(\num[2] ), .A4(n222), .ZN(n184) );
  ora21d1 U181 ( .B1(n185), .B2(n398), .A(n182), .Z(n177) );
  aon211d1 U186 ( .C1(n396), .C2(n54), .B(n186), .A(n182), .ZN(n185) );
  nd04d0 U187 ( .A1(n77), .A2(n187), .A3(n76), .A4(n23), .ZN(n182) );
  aor22d1 U189 ( .A1(n102), .A2(n385), .B1(n365), .B2(n91), .Z(n188) );
  nr02d0 U190 ( .A1(n145), .A2(sw2), .ZN(n91) );
  aor21d1 U192 ( .B1(sw2), .B2(n189), .A(n134), .Z(n187) );
  aoi311d1 U194 ( .C1(n102), .C2(n107), .C3(n222), .A(n369), .B(n96), .ZN(n77)
         );
  nd03d0 U198 ( .A1(n232), .A2(n374), .A3(n215), .ZN(n130) );
  aor21d1 U199 ( .B1(n412), .B2(n379), .A(n387), .Z(n107) );
  ora31d1 U203 ( .B1(n385), .B2(n379), .B3(n387), .A(n222), .Z(n186) );
  nd03d0 U206 ( .A1(n223), .A2(n388), .A3(n380), .ZN(n145) );
  nd04d0 U208 ( .A1(n257), .A2(n168), .A3(n218), .A4(n155), .ZN(n166) );
  nd03d0 U212 ( .A1(n192), .A2(n404), .A3(cstate[4]), .ZN(n105) );
  nd03d0 U213 ( .A1(n192), .A2(n403), .A3(cstate[2]), .ZN(n104) );
  nr03d0 U217 ( .A1(n389), .A2(n386), .A3(n392), .ZN(n174) );
  aor31d1 U220 ( .B1(n32), .B2(n231), .B3(n126), .A(n198), .Z(n301) );
  oan211d1 U221 ( .C1(n32), .C2(n147), .B(n369), .A(n231), .ZN(n198) );
  aor22d1 U225 ( .A1(pagecnt[0]), .A2(n125), .B1(n126), .B2(n375), .Z(n302) );
  nr02d0 U227 ( .A1(n147), .A2(n125), .ZN(n126) );
  aor21d1 U228 ( .B1(n137), .B2(n92), .A(n63), .Z(n125) );
  nr02d0 U229 ( .A1(n370), .A2(n133), .ZN(n63) );
  nr03d0 U238 ( .A1(n222), .A2(\num[2] ), .A3(n21), .ZN(n68) );
  nd04d0 U240 ( .A1(n163), .A2(n226), .A3(n228), .A4(n386), .ZN(n92) );
  nd04d0 U242 ( .A1(n163), .A2(n228), .A3(n230), .A4(n392), .ZN(n137) );
  nr03d0 U245 ( .A1(n393), .A2(n391), .A3(n394), .ZN(n195) );
  nd04d0 U254 ( .A1(n355), .A2(n202), .A3(n236), .A4(n235), .ZN(n199) );
  aor311d1 U257 ( .C1(n203), .C2(n204), .C3(n205), .A(n235), .B(n206), .Z(N173) );
  nd03d0 U258 ( .A1(n207), .A2(n236), .A3(n208), .ZN(n203) );
  nr03d0 U259 ( .A1(n206), .A2(n235), .A3(n205), .ZN(N172) );
  aoi21d1 U260 ( .B1(n208), .B2(n209), .A(n350), .ZN(n205) );
  nr02d0 U262 ( .A1(n349), .A2(n356), .ZN(n208) );
  aor211d1 U265 ( .C1(n211), .C2(n204), .A(n235), .B(n206), .Z(N171) );
  nd03d0 U266 ( .A1(cnt_delay[8]), .A2(n212), .A3(n213), .ZN(n204) );
  nr03d0 U267 ( .A1(cnt_delay[4]), .A2(n234), .A3(n236), .ZN(n213) );
  nr03d0 U270 ( .A1(cnt_delay[8]), .A2(n234), .A3(n354), .ZN(n207) );
  nr02d0 U282 ( .A1(n233), .A2(n237), .ZN(n212) );
  an02d1 U41 ( .A1(addr[2]), .A2(REG_WR), .Z(n45) );
  or02d1 U63 ( .A1(n58), .A2(n68), .Z(n53) );
  or02d1 U104 ( .A1(n31), .A2(n34), .Z(n127) );
  or04d1 U118 ( .A1(n413), .A2(n381), .A3(n270), .A4(sw3), .Z(n139) );
  or03d1 U132 ( .A1(n151), .A2(n91), .A3(n359), .Z(n150) );
  an04d1 U146 ( .A1(n160), .A2(n224), .A3(n225), .A4(n391), .Z(n52) );
  an04d1 U151 ( .A1(n163), .A2(n226), .A3(n230), .A4(n389), .Z(n131) );
  an04d1 U166 ( .A1(n160), .A2(n224), .A3(n227), .A4(n393), .Z(n73) );
  an03d1 U167 ( .A1(n170), .A2(n174), .A3(n257), .Z(n160) );
  an04d1 U195 ( .A1(n154), .A2(n365), .A3(n155), .A4(n405), .Z(n96) );
  an03d1 U214 ( .A1(n218), .A2(n219), .A3(n154), .Z(n192) );
  an04d1 U215 ( .A1(n257), .A2(n168), .A3(n223), .A4(n229), .Z(n154) );
  an02d1 U216 ( .A1(n174), .A2(n195), .Z(n168) );
  an03d1 U230 ( .A1(n147), .A2(n371), .A3(N684), .Z(n133) );
  an03d1 U235 ( .A1(n374), .A2(n373), .A3(n215), .Z(n102) );
  an03d1 U244 ( .A1(n170), .A2(n195), .A3(n257), .Z(n163) );
  an04d1 U249 ( .A1(n218), .A2(n223), .A3(n229), .A4(n155), .Z(n170) );
  an03d1 U250 ( .A1(n404), .A2(n403), .A3(n219), .Z(n155) );
  an02d1 U269 ( .A1(n212), .A2(n207), .Z(n202) );
  an02d1 U272 ( .A1(N128), .A2(n200), .Z(N137) );
  an02d1 U273 ( .A1(N127), .A2(n200), .Z(N136) );
  an02d1 U274 ( .A1(N126), .A2(n200), .Z(N135) );
  an02d1 U275 ( .A1(N125), .A2(n200), .Z(N134) );
  an02d1 U276 ( .A1(N124), .A2(n200), .Z(N133) );
  an02d1 U277 ( .A1(N123), .A2(n200), .Z(N132) );
  an02d1 U278 ( .A1(N122), .A2(n200), .Z(N131) );
  an02d1 U279 ( .A1(N121), .A2(n200), .Z(N130) );
  an02d1 U280 ( .A1(N120), .A2(n200), .Z(N129) );
  an04d1 U285 ( .A1(cnt_delay[8]), .A2(cnt_delay[4]), .A3(n234), .A4(n351), 
        .Z(n209) );
  iic_DW01_inc_0 add_150 ( .A({cnt_delay[8], n356, cnt_delay[6:4], n353, n352, 
        n351, n349}), .SUM({N128, N127, N126, N125, N124, N123, N122, N121, 
        N120}) );
  denrq1 \db_r_reg[0]  ( .D(n268), .ENN(n247), .CP(clk), .Q(db_r[0]) );
  denrq1 \db_r_reg[1]  ( .D(n267), .ENN(n247), .CP(clk), .Q(db_r[1]) );
  denrq1 \db_r_reg[2]  ( .D(n266), .ENN(n247), .CP(clk), .Q(db_r[2]) );
  denrq1 \db_r_reg[3]  ( .D(n265), .ENN(n247), .CP(clk), .Q(db_r[3]) );
  denrq1 \db_r_reg[4]  ( .D(n264), .ENN(n247), .CP(clk), .Q(db_r[4]) );
  denrq1 \db_r_reg[5]  ( .D(n263), .ENN(n247), .CP(clk), .Q(db_r[5]) );
  denrq1 \db_r_reg[6]  ( .D(n262), .ENN(n247), .CP(clk), .Q(db_r[6]) );
  denrq1 \db_r_reg[7]  ( .D(n261), .ENN(n247), .CP(clk), .Q(db_r[7]) );
  deprq1 sda_r_reg ( .D(n260), .ENN(n259), .CP(clk), .SDN(n333), .Q(sda_r) );
  dfcrb1 \cnt_delay_reg[4]  ( .D(N133), .CP(clk), .CDN(rst_n), .Q(cnt_delay[4]), .QN(n354) );
  dfcrb1 \cnt_delay_reg[5]  ( .D(N134), .CP(clk), .CDN(n323), .Q(cnt_delay[5])
         );
  dfcrb1 scl_r_reg ( .D(n303), .CP(clk), .CDN(n323), .Q(scl) );
  dfcrb1 \cstate_reg[2]  ( .D(n293), .CP(clk), .CDN(n325), .Q(cstate[2]), .QN(
        n404) );
  dfcrb1 \cstate_reg[4]  ( .D(n291), .CP(clk), .CDN(n325), .Q(cstate[4]), .QN(
        n403) );
  dfcrb1 \cnt_delay_reg[6]  ( .D(N135), .CP(clk), .CDN(n323), .Q(cnt_delay[6])
         );
  dfcrb1 \cnt_delay_reg[8]  ( .D(N137), .CP(clk), .CDN(n323), .Q(cnt_delay[8])
         );
  dfcrb1 \pagecnt_reg[1]  ( .D(n283), .CP(clk), .CDN(n325), .Q(pagecnt[1]), 
        .QN(n345) );
  dfcrb1 \pagecnt_reg[0]  ( .D(n302), .CP(clk), .CDN(n325), .Q(pagecnt[0]), 
        .QN(n375) );
  dfcrb1 \ackflag_reg[0]  ( .D(n282), .CP(clk), .CDN(n325), .Q(ackflag[0]), 
        .QN(n406) );
  dfcrb1 \ackflag_reg[1]  ( .D(n280), .CP(clk), .CDN(n325), .Q(ackflag[1]), 
        .QN(n407) );
  dfcrb1 \ackflag_reg[2]  ( .D(n281), .CP(clk), .CDN(n325), .Q(ackflag[2]), 
        .QN(n408) );
  dfcrb1 \num_reg[2]  ( .D(n297), .CP(clk), .CDN(n325), .Q(\num[2] ), .QN(n395) );
  dfcrb1 \cnt_reg[1]  ( .D(N172), .CP(clk), .CDN(rst_n), .Q(n373), .QN(n232)
         );
  dfcrb1 \cnt_delay_reg[3]  ( .D(N132), .CP(clk), .CDN(n323), .Q(n353), .QN(
        n234) );
  dfcrb1 \cnt_delay_reg[2]  ( .D(N131), .CP(clk), .CDN(n323), .Q(n352), .QN(
        n235) );
  dfcrb1 \cnt_delay_reg[1]  ( .D(N130), .CP(clk), .CDN(n323), .Q(n351), .QN(
        n236) );
  dfcrb1 \cnt_delay_reg[0]  ( .D(N129), .CP(clk), .CDN(n324), .Q(n349), .QN(
        n237) );
  dfcrb1 \cstate_reg[3]  ( .D(n292), .CP(clk), .CDN(n325), .QN(n219) );
  dfcrb1 \cstate_reg[14]  ( .D(n284), .CP(clk), .CDN(n324), .Q(n394), .QN(n224) );
  dfcrb1 \cnt_delay_reg[7]  ( .D(N136), .CP(clk), .CDN(n323), .Q(n356), .QN(
        n233) );
  dfcrb1 \pagecnt_reg[2]  ( .D(n301), .CP(clk), .CDN(n323), .Q(\r199/A[2] ), 
        .QN(n231) );
  dfcrb1 \cstate_reg[13]  ( .D(n285), .CP(clk), .CDN(n324), .Q(n391), .QN(n227) );
  dfcrb1 \cstate_reg[16]  ( .D(n296), .CP(clk), .CDN(n324), .Q(n393), .QN(n225) );
  dfcrb1 \cstate_reg[12]  ( .D(n286), .CP(clk), .CDN(n324), .Q(n389), .QN(n228) );
  dfcrb1 \cstate_reg[10]  ( .D(n288), .CP(clk), .CDN(n324), .Q(n386), .QN(n230) );
  dfcrb1 \cstate_reg[1]  ( .D(n294), .CP(clk), .CDN(n324), .Q(n405), .QN(n218)
         );
  dfcrb1 \cstate_reg[11]  ( .D(n287), .CP(clk), .CDN(n324), .Q(n392), .QN(n226) );
  dfcrb1 \cstate_reg[5]  ( .D(n290), .CP(clk), .CDN(n323), .QN(n223) );
  dfcrb1 sda_link_reg ( .D(n279), .CP(clk), .CDN(n325), .QN(n217) );
  dfcrb1 \cstate_reg[9]  ( .D(n289), .CP(clk), .CDN(n324), .Q(n388), .QN(n229)
         );
  dfcrb1 \num_reg[1]  ( .D(n298), .CP(clk), .CDN(n324), .Q(n402), .QN(n220) );
  dfcrb1 \num_reg[0]  ( .D(n299), .CP(clk), .CDN(n324), .Q(n399), .QN(n221) );
  dfcrb1 \num_reg[3]  ( .D(n300), .CP(clk), .CDN(n324), .QN(n222) );
  mx02d0 \pagedata_r_reg[7]/U4  ( .I0(n249), .I1(pagedata_r[7]), .S(
        \r199/A[2] ), .Z(n317) );
  dfcrq1 \pagedata_r_reg[7]  ( .D(n317), .CP(clk), .CDN(rst_n), .Q(
        pagedata_r[7]) );
  mx02d0 \pagedata_r_reg[6]/U4  ( .I0(n250), .I1(pagedata_r[6]), .S(
        \r199/A[2] ), .Z(n316) );
  dfcrq1 \pagedata_r_reg[6]  ( .D(n316), .CP(clk), .CDN(n327), .Q(
        pagedata_r[6]) );
  mx02d0 \pagedata_r_reg[5]/U4  ( .I0(n251), .I1(pagedata_r[5]), .S(
        \r199/A[2] ), .Z(n315) );
  dfcrq1 \pagedata_r_reg[5]  ( .D(n315), .CP(clk), .CDN(n327), .Q(
        pagedata_r[5]) );
  mx02d0 \pagedata_r_reg[4]/U4  ( .I0(n252), .I1(pagedata_r[4]), .S(
        \r199/A[2] ), .Z(n314) );
  dfcrq1 \pagedata_r_reg[4]  ( .D(n314), .CP(clk), .CDN(n327), .Q(
        pagedata_r[4]) );
  mx02d0 \pagedata_r_reg[3]/U4  ( .I0(n253), .I1(pagedata_r[3]), .S(
        \r199/A[2] ), .Z(n313) );
  dfcrq1 \pagedata_r_reg[3]  ( .D(n313), .CP(clk), .CDN(n327), .Q(
        pagedata_r[3]) );
  mx02d0 \pagedata_r_reg[2]/U4  ( .I0(n254), .I1(pagedata_r[2]), .S(
        \r199/A[2] ), .Z(n312) );
  dfcrq1 \pagedata_r_reg[2]  ( .D(n312), .CP(clk), .CDN(n327), .Q(
        pagedata_r[2]) );
  mx02d0 \pagedata_r_reg[1]/U4  ( .I0(n255), .I1(pagedata_r[1]), .S(
        \r199/A[2] ), .Z(n311) );
  dfcrq1 \pagedata_r_reg[1]  ( .D(n311), .CP(clk), .CDN(n328), .Q(
        pagedata_r[1]) );
  mx02d0 \pagedata_r_reg[0]/U4  ( .I0(n256), .I1(pagedata_r[0]), .S(
        \r199/A[2] ), .Z(n310) );
  dfcrq1 \pagedata_r_reg[0]  ( .D(n310), .CP(clk), .CDN(n328), .Q(
        pagedata_r[0]) );
  mx02d0 \outdata_r_reg[7]/U4  ( .I0(read_data[7]), .I1(outdata[7]), .S(n246), 
        .Z(n309) );
  dfcrq1 \outdata_r_reg[7]  ( .D(n309), .CP(clk), .CDN(n326), .Q(outdata[7])
         );
  mx02d0 \outdata_r_reg[6]/U4  ( .I0(read_data[6]), .I1(outdata[6]), .S(n246), 
        .Z(n308) );
  dfcrq1 \outdata_r_reg[6]  ( .D(n308), .CP(clk), .CDN(n327), .Q(outdata[6])
         );
  mx02d0 \outdata_r_reg[5]/U4  ( .I0(read_data[5]), .I1(outdata[5]), .S(n246), 
        .Z(n307) );
  dfcrq1 \outdata_r_reg[5]  ( .D(n307), .CP(clk), .CDN(n326), .Q(outdata[5])
         );
  mx02d0 \outdata_r_reg[4]/U4  ( .I0(read_data[4]), .I1(outdata[4]), .S(n246), 
        .Z(n306) );
  dfcrq1 \outdata_r_reg[4]  ( .D(n306), .CP(clk), .CDN(n326), .Q(outdata[4])
         );
  mx02d0 \outdata_r_reg[3]/U4  ( .I0(read_data[3]), .I1(outdata[3]), .S(n246), 
        .Z(n305) );
  dfcrq1 \outdata_r_reg[3]  ( .D(n305), .CP(clk), .CDN(n326), .Q(outdata[3])
         );
  mx02d0 \outdata_r_reg[2]/U4  ( .I0(read_data[2]), .I1(outdata[2]), .S(n246), 
        .Z(n304) );
  dfcrq1 \outdata_r_reg[2]  ( .D(n304), .CP(clk), .CDN(n326), .Q(outdata[2])
         );
  mx02d0 \outdata_r_reg[1]/U4  ( .I0(read_data[1]), .I1(outdata[1]), .S(n246), 
        .Z(n216) );
  dfcrq1 \outdata_r_reg[1]  ( .D(n216), .CP(clk), .CDN(n326), .Q(outdata[1])
         );
  mx02d0 \outdata_r_reg[0]/U4  ( .I0(read_data[0]), .I1(outdata[0]), .S(n246), 
        .Z(n214) );
  dfcrq1 \outdata_r_reg[0]  ( .D(n214), .CP(clk), .CDN(n326), .Q(outdata[0])
         );
  mx02d0 \WRITE_DATA3_reg[7]/U4  ( .I0(IDAT[7]), .I1(WRITE_DATA3[7]), .S(n276), 
        .Z(n210) );
  dfcrq1 \WRITE_DATA3_reg[7]  ( .D(n210), .CP(clk), .CDN(n332), .Q(
        WRITE_DATA3[7]) );
  mx02d0 \WRITE_DATA3_reg[6]/U4  ( .I0(IDAT[6]), .I1(WRITE_DATA3[6]), .S(n276), 
        .Z(n201) );
  dfcrq1 \WRITE_DATA3_reg[6]  ( .D(n201), .CP(clk), .CDN(n332), .Q(
        WRITE_DATA3[6]) );
  mx02d0 \WRITE_DATA3_reg[5]/U4  ( .I0(IDAT[5]), .I1(WRITE_DATA3[5]), .S(n276), 
        .Z(n197) );
  dfcrq1 \WRITE_DATA3_reg[5]  ( .D(n197), .CP(clk), .CDN(n332), .Q(
        WRITE_DATA3[5]) );
  mx02d0 \WRITE_DATA3_reg[4]/U4  ( .I0(IDAT[4]), .I1(WRITE_DATA3[4]), .S(n276), 
        .Z(n196) );
  dfcrq1 \WRITE_DATA3_reg[4]  ( .D(n196), .CP(clk), .CDN(n332), .Q(
        WRITE_DATA3[4]) );
  mx02d0 \WRITE_DATA3_reg[3]/U4  ( .I0(IDAT[3]), .I1(WRITE_DATA3[3]), .S(n276), 
        .Z(n194) );
  dfcrq1 \WRITE_DATA3_reg[3]  ( .D(n194), .CP(clk), .CDN(n332), .Q(
        WRITE_DATA3[3]) );
  mx02d0 \WRITE_DATA3_reg[2]/U4  ( .I0(IDAT[2]), .I1(WRITE_DATA3[2]), .S(n276), 
        .Z(n193) );
  dfcrq1 \WRITE_DATA3_reg[2]  ( .D(n193), .CP(clk), .CDN(n332), .Q(
        WRITE_DATA3[2]) );
  mx02d0 \WRITE_DATA3_reg[1]/U4  ( .I0(IDAT[1]), .I1(WRITE_DATA3[1]), .S(n276), 
        .Z(n191) );
  dfcrq1 \WRITE_DATA3_reg[1]  ( .D(n191), .CP(clk), .CDN(n332), .Q(
        WRITE_DATA3[1]) );
  mx02d0 \WRITE_DATA3_reg[0]/U4  ( .I0(IDAT[0]), .I1(WRITE_DATA3[0]), .S(n276), 
        .Z(n190) );
  dfcrq1 \WRITE_DATA3_reg[0]  ( .D(n190), .CP(clk), .CDN(n331), .Q(
        WRITE_DATA3[0]) );
  mx02d0 \WRITE_DATA2_reg[7]/U4  ( .I0(IDAT[7]), .I1(WRITE_DATA2[7]), .S(n275), 
        .Z(n181) );
  dfcrq1 \WRITE_DATA2_reg[7]  ( .D(n181), .CP(clk), .CDN(n331), .Q(
        WRITE_DATA2[7]) );
  mx02d0 \WRITE_DATA2_reg[6]/U4  ( .I0(IDAT[6]), .I1(WRITE_DATA2[6]), .S(n275), 
        .Z(n179) );
  dfcrq1 \WRITE_DATA2_reg[6]  ( .D(n179), .CP(clk), .CDN(n331), .Q(
        WRITE_DATA2[6]) );
  mx02d0 \WRITE_DATA2_reg[5]/U4  ( .I0(IDAT[5]), .I1(WRITE_DATA2[5]), .S(n275), 
        .Z(n178) );
  dfcrq1 \WRITE_DATA2_reg[5]  ( .D(n178), .CP(clk), .CDN(n331), .Q(
        WRITE_DATA2[5]) );
  mx02d0 \WRITE_DATA2_reg[4]/U4  ( .I0(IDAT[4]), .I1(WRITE_DATA2[4]), .S(n275), 
        .Z(n175) );
  dfcrq1 \WRITE_DATA2_reg[4]  ( .D(n175), .CP(clk), .CDN(n328), .Q(
        WRITE_DATA2[4]) );
  mx02d0 \WRITE_DATA2_reg[3]/U4  ( .I0(IDAT[3]), .I1(WRITE_DATA2[3]), .S(n275), 
        .Z(n173) );
  dfcrq1 \WRITE_DATA2_reg[3]  ( .D(n173), .CP(clk), .CDN(n331), .Q(
        WRITE_DATA2[3]) );
  mx02d0 \WRITE_DATA2_reg[2]/U4  ( .I0(IDAT[2]), .I1(WRITE_DATA2[2]), .S(n275), 
        .Z(n172) );
  dfcrq1 \WRITE_DATA2_reg[2]  ( .D(n172), .CP(clk), .CDN(n331), .Q(
        WRITE_DATA2[2]) );
  mx02d0 \WRITE_DATA2_reg[1]/U4  ( .I0(IDAT[1]), .I1(WRITE_DATA2[1]), .S(n275), 
        .Z(n171) );
  dfcrq1 \WRITE_DATA2_reg[1]  ( .D(n171), .CP(clk), .CDN(n331), .Q(
        WRITE_DATA2[1]) );
  mx02d0 \WRITE_DATA2_reg[0]/U4  ( .I0(IDAT[0]), .I1(WRITE_DATA2[0]), .S(n275), 
        .Z(n169) );
  dfcrq1 \WRITE_DATA2_reg[0]  ( .D(n169), .CP(clk), .CDN(n331), .Q(
        WRITE_DATA2[0]) );
  mx02d0 \WRITE_DATA4_reg[7]/U4  ( .I0(IDAT[7]), .I1(WRITE_DATA4[7]), .S(n277), 
        .Z(n167) );
  dfcrq1 \WRITE_DATA4_reg[7]  ( .D(n167), .CP(clk), .CDN(n333), .Q(
        WRITE_DATA4[7]) );
  mx02d0 \WRITE_DATA4_reg[6]/U4  ( .I0(IDAT[6]), .I1(WRITE_DATA4[6]), .S(n277), 
        .Z(n165) );
  dfcrq1 \WRITE_DATA4_reg[6]  ( .D(n165), .CP(clk), .CDN(n333), .Q(
        WRITE_DATA4[6]) );
  mx02d0 \WRITE_DATA4_reg[5]/U4  ( .I0(IDAT[5]), .I1(WRITE_DATA4[5]), .S(n277), 
        .Z(n164) );
  dfcrq1 \WRITE_DATA4_reg[5]  ( .D(n164), .CP(clk), .CDN(n333), .Q(
        WRITE_DATA4[5]) );
  mx02d0 \WRITE_DATA4_reg[4]/U4  ( .I0(IDAT[4]), .I1(WRITE_DATA4[4]), .S(n277), 
        .Z(n161) );
  dfcrq1 \WRITE_DATA4_reg[4]  ( .D(n161), .CP(clk), .CDN(n332), .Q(
        WRITE_DATA4[4]) );
  mx02d0 \WRITE_DATA4_reg[3]/U4  ( .I0(IDAT[3]), .I1(WRITE_DATA4[3]), .S(n277), 
        .Z(n157) );
  dfcrq1 \WRITE_DATA4_reg[3]  ( .D(n157), .CP(clk), .CDN(n332), .Q(
        WRITE_DATA4[3]) );
  mx02d0 \WRITE_DATA4_reg[2]/U4  ( .I0(IDAT[2]), .I1(WRITE_DATA4[2]), .S(n277), 
        .Z(n156) );
  dfcrq1 \WRITE_DATA4_reg[2]  ( .D(n156), .CP(clk), .CDN(n331), .Q(
        WRITE_DATA4[2]) );
  mx02d0 \WRITE_DATA4_reg[1]/U4  ( .I0(IDAT[1]), .I1(WRITE_DATA4[1]), .S(n277), 
        .Z(n152) );
  dfcrq1 \WRITE_DATA4_reg[1]  ( .D(n152), .CP(clk), .CDN(n332), .Q(
        WRITE_DATA4[1]) );
  mx02d0 \WRITE_DATA4_reg[0]/U4  ( .I0(IDAT[0]), .I1(WRITE_DATA4[0]), .S(n277), 
        .Z(n144) );
  dfcrq1 \WRITE_DATA4_reg[0]  ( .D(n144), .CP(clk), .CDN(n332), .Q(
        WRITE_DATA4[0]) );
  mx02d0 \WRITE_DATA1_reg[7]/U4  ( .I0(IDAT[7]), .I1(WRITE_DATA1[7]), .S(n278), 
        .Z(n143) );
  dfcrq1 \WRITE_DATA1_reg[7]  ( .D(n143), .CP(clk), .CDN(n326), .Q(
        WRITE_DATA1[7]) );
  mx02d0 \WRITE_DATA1_reg[6]/U4  ( .I0(IDAT[6]), .I1(WRITE_DATA1[6]), .S(n278), 
        .Z(n140) );
  dfcrq1 \WRITE_DATA1_reg[6]  ( .D(n140), .CP(clk), .CDN(n332), .Q(
        WRITE_DATA1[6]) );
  mx02d0 \WRITE_DATA1_reg[5]/U4  ( .I0(IDAT[5]), .I1(WRITE_DATA1[5]), .S(n278), 
        .Z(n136) );
  dfcrq1 \WRITE_DATA1_reg[5]  ( .D(n136), .CP(clk), .CDN(n333), .Q(
        WRITE_DATA1[5]) );
  mx02d0 \WRITE_DATA1_reg[4]/U4  ( .I0(IDAT[4]), .I1(WRITE_DATA1[4]), .S(n278), 
        .Z(n135) );
  dfcrq1 \WRITE_DATA1_reg[4]  ( .D(n135), .CP(clk), .CDN(n333), .Q(
        WRITE_DATA1[4]) );
  mx02d0 \WRITE_DATA1_reg[3]/U4  ( .I0(IDAT[3]), .I1(WRITE_DATA1[3]), .S(n278), 
        .Z(n132) );
  dfcrq1 \WRITE_DATA1_reg[3]  ( .D(n132), .CP(clk), .CDN(n333), .Q(
        WRITE_DATA1[3]) );
  mx02d0 \WRITE_DATA1_reg[2]/U4  ( .I0(IDAT[2]), .I1(WRITE_DATA1[2]), .S(n278), 
        .Z(n129) );
  dfcrq1 \WRITE_DATA1_reg[2]  ( .D(n129), .CP(clk), .CDN(n333), .Q(
        WRITE_DATA1[2]) );
  mx02d0 \WRITE_DATA1_reg[1]/U4  ( .I0(IDAT[1]), .I1(WRITE_DATA1[1]), .S(n278), 
        .Z(n128) );
  dfcrq1 \WRITE_DATA1_reg[1]  ( .D(n128), .CP(clk), .CDN(n333), .Q(
        WRITE_DATA1[1]) );
  mx02d0 \WRITE_DATA1_reg[0]/U4  ( .I0(IDAT[0]), .I1(WRITE_DATA1[0]), .S(n278), 
        .Z(n123) );
  dfcrq1 \WRITE_DATA1_reg[0]  ( .D(n123), .CP(clk), .CDN(n333), .Q(
        WRITE_DATA1[0]) );
  mx02d0 \PAGEDATA_NUM_reg[4]/U4  ( .I0(IDAT[4]), .I1(PAGEDATA_NUM[4]), .S(
        n272), .Z(n122) );
  dfcrq1 \PAGEDATA_NUM_reg[4]  ( .D(n122), .CP(clk), .CDN(n329), .Q(
        PAGEDATA_NUM[4]) );
  mx02d0 \PAGEDATA_NUM_reg[3]/U4  ( .I0(IDAT[3]), .I1(PAGEDATA_NUM[3]), .S(
        n272), .Z(n118) );
  dfcrq1 \PAGEDATA_NUM_reg[3]  ( .D(n118), .CP(clk), .CDN(n329), .Q(
        PAGEDATA_NUM[3]) );
  mx02d0 \PAGEDATA_NUM_reg[2]/U4  ( .I0(IDAT[2]), .I1(PAGEDATA_NUM[2]), .S(
        n272), .Z(n116) );
  dfcrq1 \PAGEDATA_NUM_reg[2]  ( .D(n116), .CP(clk), .CDN(n329), .Q(
        PAGEDATA_NUM[2]) );
  mx02d0 \PAGEDATA_NUM_reg[1]/U4  ( .I0(IDAT[1]), .I1(PAGEDATA_NUM[1]), .S(
        n272), .Z(n114) );
  dfcrq1 \PAGEDATA_NUM_reg[1]  ( .D(n114), .CP(clk), .CDN(n329), .Q(
        PAGEDATA_NUM[1]) );
  mx02d0 \PAGEDATA_NUM_reg[0]/U4  ( .I0(IDAT[0]), .I1(PAGEDATA_NUM[0]), .S(
        n272), .Z(n110) );
  dfcrq1 \PAGEDATA_NUM_reg[0]  ( .D(n110), .CP(clk), .CDN(n329), .Q(
        PAGEDATA_NUM[0]) );
  mx02d0 \DEVICE_reg[6]/U4  ( .I0(IDAT[6]), .I1(DEVICE[6]), .S(n273), .Z(n97)
         );
  dfcrq1 \DEVICE_reg[6]  ( .D(n97), .CP(clk), .CDN(n330), .Q(DEVICE[6]) );
  mx02d0 \DEVICE_reg[5]/U4  ( .I0(IDAT[5]), .I1(DEVICE[5]), .S(n273), .Z(n93)
         );
  dfcrq1 \DEVICE_reg[5]  ( .D(n93), .CP(clk), .CDN(n330), .Q(DEVICE[5]) );
  mx02d0 \DEVICE_reg[4]/U4  ( .I0(IDAT[4]), .I1(DEVICE[4]), .S(n273), .Z(n88)
         );
  dfcrq1 \DEVICE_reg[4]  ( .D(n88), .CP(clk), .CDN(n330), .Q(DEVICE[4]) );
  mx02d0 \DEVICE_reg[3]/U4  ( .I0(IDAT[3]), .I1(DEVICE[3]), .S(n273), .Z(n87)
         );
  dfcrq1 \DEVICE_reg[3]  ( .D(n87), .CP(clk), .CDN(n330), .Q(DEVICE[3]) );
  mx02d0 \DEVICE_reg[2]/U4  ( .I0(IDAT[2]), .I1(DEVICE[2]), .S(n273), .Z(n84)
         );
  dfcrq1 \DEVICE_reg[2]  ( .D(n84), .CP(clk), .CDN(n330), .Q(DEVICE[2]) );
  mx02d0 \DEVICE_reg[1]/U4  ( .I0(IDAT[1]), .I1(DEVICE[1]), .S(n273), .Z(n81)
         );
  dfcrq1 \DEVICE_reg[1]  ( .D(n81), .CP(clk), .CDN(n330), .Q(DEVICE[1]) );
  mx02d0 \DEVICE_reg[0]/U4  ( .I0(IDAT[0]), .I1(DEVICE[0]), .S(n273), .Z(n75)
         );
  dfcrq1 \DEVICE_reg[0]  ( .D(n75), .CP(clk), .CDN(n330), .Q(DEVICE[0]) );
  mx02d0 \DEVICE_WRITE_reg[7]/U4  ( .I0(DEVICE[6]), .I1(DEVICE_WRITE[7]), .S(
        n269), .Z(n74) );
  dfcrq1 \DEVICE_WRITE_reg[7]  ( .D(n74), .CP(clk), .CDN(n328), .Q(
        DEVICE_WRITE[7]) );
  mx02d0 \DEVICE_WRITE_reg[6]/U4  ( .I0(DEVICE[5]), .I1(DEVICE_WRITE[6]), .S(
        n269), .Z(n67) );
  dfcrq1 \DEVICE_WRITE_reg[6]  ( .D(n67), .CP(clk), .CDN(n328), .Q(
        DEVICE_WRITE[6]) );
  mx02d0 \DEVICE_WRITE_reg[5]/U4  ( .I0(DEVICE[4]), .I1(DEVICE_WRITE[5]), .S(
        n269), .Z(n66) );
  dfcrq1 \DEVICE_WRITE_reg[5]  ( .D(n66), .CP(clk), .CDN(n328), .Q(
        DEVICE_WRITE[5]) );
  mx02d0 \DEVICE_WRITE_reg[4]/U4  ( .I0(DEVICE[3]), .I1(DEVICE_WRITE[4]), .S(
        n269), .Z(n65) );
  dfcrq1 \DEVICE_WRITE_reg[4]  ( .D(n65), .CP(clk), .CDN(n328), .Q(
        DEVICE_WRITE[4]) );
  mx02d0 \DEVICE_WRITE_reg[3]/U4  ( .I0(DEVICE[2]), .I1(DEVICE_WRITE[3]), .S(
        n269), .Z(n64) );
  dfcrq1 \DEVICE_WRITE_reg[3]  ( .D(n64), .CP(clk), .CDN(n328), .Q(
        DEVICE_WRITE[3]) );
  mx02d0 \DEVICE_WRITE_reg[2]/U4  ( .I0(DEVICE[1]), .I1(DEVICE_WRITE[2]), .S(
        n269), .Z(n60) );
  dfcrq1 \DEVICE_WRITE_reg[2]  ( .D(n60), .CP(clk), .CDN(n328), .Q(
        DEVICE_WRITE[2]) );
  mx02d0 \DEVICE_WRITE_reg[1]/U4  ( .I0(DEVICE[0]), .I1(DEVICE_WRITE[1]), .S(
        n269), .Z(n59) );
  dfcrq1 \DEVICE_WRITE_reg[1]  ( .D(n59), .CP(clk), .CDN(n328), .Q(
        DEVICE_WRITE[1]) );
  mx02d0 \DEVICE_WRITE_reg[0]/U4  ( .I0(n270), .I1(DEVICE_WRITE[0]), .S(n269), 
        .Z(n57) );
  dfcrq1 \DEVICE_WRITE_reg[0]  ( .D(n57), .CP(clk), .CDN(n328), .Q(
        DEVICE_WRITE[0]) );
  mx02d0 \WRITE_DATA0_reg[7]/U4  ( .I0(IDAT[7]), .I1(WRITE_DATA0[7]), .S(n271), 
        .Z(n55) );
  dfcrq1 \WRITE_DATA0_reg[7]  ( .D(n55), .CP(clk), .CDN(n329), .Q(
        WRITE_DATA0[7]) );
  mx02d0 \WRITE_DATA0_reg[6]/U4  ( .I0(IDAT[6]), .I1(WRITE_DATA0[6]), .S(n271), 
        .Z(n51) );
  dfcrq1 \WRITE_DATA0_reg[6]  ( .D(n51), .CP(clk), .CDN(n329), .Q(
        WRITE_DATA0[6]) );
  mx02d0 \WRITE_DATA0_reg[5]/U4  ( .I0(IDAT[5]), .I1(WRITE_DATA0[5]), .S(n271), 
        .Z(n50) );
  dfcrq1 \WRITE_DATA0_reg[5]  ( .D(n50), .CP(clk), .CDN(n329), .Q(
        WRITE_DATA0[5]) );
  mx02d0 \WRITE_DATA0_reg[4]/U4  ( .I0(IDAT[4]), .I1(WRITE_DATA0[4]), .S(n271), 
        .Z(n47) );
  dfcrq1 \WRITE_DATA0_reg[4]  ( .D(n47), .CP(clk), .CDN(n329), .Q(
        WRITE_DATA0[4]) );
  mx02d0 \WRITE_DATA0_reg[3]/U4  ( .I0(IDAT[3]), .I1(WRITE_DATA0[3]), .S(n271), 
        .Z(n44) );
  dfcrq1 \WRITE_DATA0_reg[3]  ( .D(n44), .CP(clk), .CDN(n329), .Q(
        WRITE_DATA0[3]) );
  mx02d0 \WRITE_DATA0_reg[2]/U4  ( .I0(IDAT[2]), .I1(WRITE_DATA0[2]), .S(n271), 
        .Z(n43) );
  dfcrq1 \WRITE_DATA0_reg[2]  ( .D(n43), .CP(clk), .CDN(n329), .Q(
        WRITE_DATA0[2]) );
  mx02d0 \WRITE_DATA0_reg[1]/U4  ( .I0(IDAT[1]), .I1(WRITE_DATA0[1]), .S(n271), 
        .Z(n29) );
  dfcrq1 \WRITE_DATA0_reg[1]  ( .D(n29), .CP(clk), .CDN(n329), .Q(
        WRITE_DATA0[1]) );
  mx02d0 \WRITE_DATA0_reg[0]/U4  ( .I0(IDAT[0]), .I1(WRITE_DATA0[0]), .S(n271), 
        .Z(n27) );
  dfcrq1 \WRITE_DATA0_reg[0]  ( .D(n27), .CP(clk), .CDN(n328), .Q(
        WRITE_DATA0[0]) );
  mx02d0 \BYTE_ADDR_reg[7]/U4  ( .I0(IDAT[7]), .I1(BYTE_ADDR[7]), .S(n274), 
        .Z(n25) );
  dfcrq1 \BYTE_ADDR_reg[7]  ( .D(n25), .CP(clk), .CDN(n331), .Q(BYTE_ADDR[7])
         );
  mx02d0 \BYTE_ADDR_reg[6]/U4  ( .I0(IDAT[6]), .I1(BYTE_ADDR[6]), .S(n274), 
        .Z(n22) );
  dfcrq1 \BYTE_ADDR_reg[6]  ( .D(n22), .CP(clk), .CDN(n331), .Q(BYTE_ADDR[6])
         );
  mx02d0 \BYTE_ADDR_reg[5]/U4  ( .I0(IDAT[5]), .I1(BYTE_ADDR[5]), .S(n274), 
        .Z(n15) );
  dfcrq1 \BYTE_ADDR_reg[5]  ( .D(n15), .CP(clk), .CDN(n331), .Q(BYTE_ADDR[5])
         );
  mx02d0 \BYTE_ADDR_reg[4]/U4  ( .I0(IDAT[4]), .I1(BYTE_ADDR[4]), .S(n274), 
        .Z(n14) );
  dfcrq1 \BYTE_ADDR_reg[4]  ( .D(n14), .CP(clk), .CDN(n330), .Q(BYTE_ADDR[4])
         );
  mx02d0 \BYTE_ADDR_reg[3]/U4  ( .I0(IDAT[3]), .I1(BYTE_ADDR[3]), .S(n274), 
        .Z(n13) );
  dfcrq1 \BYTE_ADDR_reg[3]  ( .D(n13), .CP(clk), .CDN(n330), .Q(BYTE_ADDR[3])
         );
  mx02d0 \BYTE_ADDR_reg[2]/U4  ( .I0(IDAT[2]), .I1(BYTE_ADDR[2]), .S(n274), 
        .Z(n12) );
  dfcrq1 \BYTE_ADDR_reg[2]  ( .D(n12), .CP(clk), .CDN(n330), .Q(BYTE_ADDR[2])
         );
  mx02d0 \BYTE_ADDR_reg[1]/U4  ( .I0(IDAT[1]), .I1(BYTE_ADDR[1]), .S(n274), 
        .Z(n11) );
  dfcrq1 \BYTE_ADDR_reg[1]  ( .D(n11), .CP(clk), .CDN(n330), .Q(BYTE_ADDR[1])
         );
  mx02d0 \BYTE_ADDR_reg[0]/U4  ( .I0(IDAT[0]), .I1(BYTE_ADDR[0]), .S(n274), 
        .Z(n10) );
  dfcrq1 \BYTE_ADDR_reg[0]  ( .D(n10), .CP(clk), .CDN(n330), .Q(BYTE_ADDR[0])
         );
  mx02d0 \read_data_reg[7]/U4  ( .I0(n258), .I1(read_data[7]), .S(n245), .Z(n9) );
  dfcrq1 \read_data_reg[7]  ( .D(n9), .CP(clk), .CDN(n327), .Q(read_data[7])
         );
  mx02d0 \read_data_reg[6]/U4  ( .I0(n258), .I1(read_data[6]), .S(n244), .Z(n8) );
  dfcrq1 \read_data_reg[6]  ( .D(n8), .CP(clk), .CDN(n327), .Q(read_data[6])
         );
  mx02d0 \read_data_reg[5]/U4  ( .I0(n258), .I1(read_data[5]), .S(n243), .Z(n7) );
  dfcrq1 \read_data_reg[5]  ( .D(n7), .CP(clk), .CDN(n327), .Q(read_data[5])
         );
  mx02d0 \read_data_reg[4]/U4  ( .I0(n258), .I1(read_data[4]), .S(n242), .Z(n6) );
  dfcrq1 \read_data_reg[4]  ( .D(n6), .CP(clk), .CDN(n327), .Q(read_data[4])
         );
  mx02d0 \read_data_reg[3]/U4  ( .I0(n258), .I1(read_data[3]), .S(n241), .Z(n5) );
  dfcrq1 \read_data_reg[3]  ( .D(n5), .CP(clk), .CDN(n326), .Q(read_data[3])
         );
  mx02d0 \read_data_reg[2]/U4  ( .I0(n258), .I1(read_data[2]), .S(n240), .Z(n4) );
  dfcrq1 \read_data_reg[2]  ( .D(n4), .CP(clk), .CDN(n326), .Q(read_data[2])
         );
  mx02d0 \read_data_reg[1]/U4  ( .I0(n258), .I1(read_data[1]), .S(n239), .Z(n3) );
  dfcrq1 \read_data_reg[1]  ( .D(n3), .CP(clk), .CDN(n326), .Q(read_data[1])
         );
  mx02d0 \read_data_reg[0]/U4  ( .I0(n258), .I1(read_data[0]), .S(n238), .Z(n2) );
  dfcrq1 \read_data_reg[0]  ( .D(n2), .CP(clk), .CDN(n325), .Q(read_data[0])
         );
  invbd7 U3 ( .I(n217), .ZN(sda_link) );
  inv0d1 U4 ( .I(n117), .ZN(n360) );
  inv0d1 U5 ( .I(n146), .ZN(n358) );
  nd02d1 U12 ( .A1(n412), .A2(n368), .ZN(n80) );
  inv0d1 U18 ( .I(n107), .ZN(n378) );
  inv0d1 U44 ( .I(n134), .ZN(n368) );
  nd02d1 U46 ( .A1(n383), .A2(n148), .ZN(n269) );
  inv0d1 U57 ( .I(n182), .ZN(n363) );
  inv0d1 U67 ( .I(n100), .ZN(n361) );
  inv0d1 U68 ( .I(n189), .ZN(n412) );
  inv0d1 U69 ( .I(n121), .ZN(n362) );
  bufbd1 U72 ( .I(n322), .Z(n333) );
  inv0d1 U79 ( .I(n148), .ZN(n415) );
  inv0d1 U85 ( .I(n89), .ZN(n371) );
  nd02d1 U86 ( .A1(n379), .A2(n371), .ZN(n134) );
  inv0d1 U87 ( .I(n147), .ZN(n370) );
  inv0d1 U92 ( .I(n125), .ZN(n369) );
  inv0d1 U93 ( .I(n17), .ZN(n398) );
  inv0d1 U94 ( .I(n138), .ZN(n366) );
  bufbd1 U97 ( .I(n319), .Z(n323) );
  bufbd1 U99 ( .I(n319), .Z(n324) );
  bufbd1 U101 ( .I(n319), .Z(n325) );
  bufbd1 U105 ( .I(n321), .Z(n329) );
  bufbd1 U106 ( .I(n321), .Z(n330) );
  bufbd1 U108 ( .I(n320), .Z(n328) );
  bufbd1 U109 ( .I(n321), .Z(n331) );
  bufbd1 U114 ( .I(n322), .Z(n332) );
  bufbd1 U115 ( .I(n320), .Z(n327) );
  bufbd1 U116 ( .I(n320), .Z(n326) );
  nd02d1 U121 ( .A1(n100), .A2(n73), .ZN(n121) );
  nd02d1 U122 ( .A1(sw1), .A2(sw2), .ZN(n124) );
  nd02d1 U124 ( .A1(sw4), .A2(sw2), .ZN(n270) );
  inv0d1 U126 ( .I(n185), .ZN(n364) );
  nd02d1 U127 ( .A1(sw2), .A2(n413), .ZN(n189) );
  inv0d1 U128 ( .I(sw1), .ZN(n413) );
  nd02d1 U130 ( .A1(n19), .A2(n20), .ZN(n180) );
  inv0d1 U134 ( .I(n269), .ZN(n382) );
  inv0d1 U135 ( .I(n270), .ZN(n416) );
  aoim21d1 U138 ( .B1(n92), .B2(n63), .A(n108), .ZN(n246) );
  nd12d0 U139 ( .A1(n91), .A2(n92), .ZN(n85) );
  nd02d1 U141 ( .A1(n366), .A2(n385), .ZN(n142) );
  inv0d1 U144 ( .I(n80), .ZN(n367) );
  nd02d1 U147 ( .A1(n269), .A2(n153), .ZN(n294) );
  inv0d1 U152 ( .I(addr[1]), .ZN(n410) );
  inv0d1 U153 ( .I(addr[0]), .ZN(n411) );
  bufbd1 U155 ( .I(rst_n), .Z(n322) );
  inv0d1 U156 ( .I(n92), .ZN(n385) );
  nd02d1 U157 ( .A1(n104), .A2(n105), .ZN(n54) );
  nd02d1 U158 ( .A1(n68), .A2(n102), .ZN(n89) );
  inv0d1 U160 ( .I(n145), .ZN(n379) );
  inv0d1 U161 ( .I(n137), .ZN(n387) );
  inv0d1 U163 ( .I(n106), .ZN(n384) );
  nd02d1 U171 ( .A1(N677), .A2(n371), .ZN(n147) );
  inv0d1 U172 ( .I(n28), .ZN(n381) );
  nd02d1 U173 ( .A1(n102), .A2(n54), .ZN(n76) );
  nd02d1 U175 ( .A1(n158), .A2(n159), .ZN(n149) );
  inv0d1 U178 ( .I(n16), .ZN(n383) );
  nd02d1 U179 ( .A1(n48), .A2(n49), .ZN(n260) );
  inv0d1 U180 ( .I(n334), .ZN(n337) );
  inv0d1 U182 ( .I(n101), .ZN(n359) );
  inv0d1 U183 ( .I(n105), .ZN(n377) );
  inv0d1 U184 ( .I(n130), .ZN(n365) );
  inv0d1 U185 ( .I(n68), .ZN(n396) );
  inv0d1 U188 ( .I(n104), .ZN(n376) );
  nd02d1 U191 ( .A1(n399), .A2(n402), .ZN(n17) );
  inv0d1 U193 ( .I(n19), .ZN(n400) );
  inv0d1 U196 ( .I(n21), .ZN(n401) );
  inv0d1 U197 ( .I(n20), .ZN(n397) );
  nd02d1 U200 ( .A1(n52), .A2(n359), .ZN(n79) );
  inv0d1 U201 ( .I(n79), .ZN(n357) );
  nd02d1 U202 ( .A1(n105), .A2(n106), .ZN(n103) );
  nr02d0 U204 ( .A1(n375), .A2(n345), .ZN(n32) );
  inv0d1 U205 ( .I(n211), .ZN(n350) );
  nd02d1 U207 ( .A1(n202), .A2(n351), .ZN(n211) );
  inv0d1 U209 ( .I(n206), .ZN(n355) );
  bufbd1 U210 ( .I(rst_n), .Z(n321) );
  bufbd1 U211 ( .I(rst_n), .Z(n320) );
  bufbd1 U218 ( .I(rst_n), .Z(n319) );
  inv0d1 U219 ( .I(n76), .ZN(n372) );
  nd02d1 U222 ( .A1(n222), .A2(n188), .ZN(n23) );
  inv0d1 U223 ( .I(n124), .ZN(n414) );
  nd02d1 U224 ( .A1(n364), .A2(n395), .ZN(n183) );
  nd02d1 U226 ( .A1(n109), .A2(n407), .ZN(n113) );
  inv0d1 U231 ( .I(sda_r), .ZN(n409) );
  nd03d0 U232 ( .A1(n168), .A2(n390), .A3(n170), .ZN(n16) );
  an03d1 U233 ( .A1(n154), .A2(n218), .A3(n162), .Z(n30) );
  nr03d0 U234 ( .A1(n388), .A2(n223), .A3(n166), .ZN(n28) );
  nd02d1 U236 ( .A1(n220), .A2(n221), .ZN(n21) );
  aoi21d1 U237 ( .B1(PAGEDATA_NUM[2]), .B2(n337), .A(n335), .ZN(n318) );
  inv0d1 U239 ( .I(n166), .ZN(n380) );
  inv0d1 U241 ( .I(n338), .ZN(n347) );
  inv0d1 U243 ( .I(N673), .ZN(n348) );
  inv0d1 U246 ( .I(N672), .ZN(n346) );
  inv0d1 U247 ( .I(PAGEDATA_NUM[0]), .ZN(N672) );
  nd02d1 U248 ( .A1(n221), .A2(n402), .ZN(n19) );
  nd02d1 U251 ( .A1(n220), .A2(n399), .ZN(n20) );
  nd04d0 U252 ( .A1(n209), .A2(n355), .A3(n212), .A4(n235), .ZN(n200) );
  nd02d1 U253 ( .A1(cnt_delay[6]), .A2(cnt_delay[5]), .ZN(n206) );
  nr02d0 U255 ( .A1(n345), .A2(pagecnt[0]), .ZN(n34) );
  nr02d0 U256 ( .A1(n375), .A2(pagecnt[1]), .ZN(n31) );
  oaim21d1 U261 ( .B1(scl), .B2(n199), .A(n200), .ZN(n303) );
  nr02d0 U263 ( .A1(PAGEDATA_NUM[1]), .A2(PAGEDATA_NUM[0]), .ZN(n334) );
  aor21d1 U264 ( .B1(PAGEDATA_NUM[1]), .B2(PAGEDATA_NUM[0]), .A(n334), .Z(N673) );
  nr02d0 U268 ( .A1(n337), .A2(PAGEDATA_NUM[2]), .ZN(n335) );
  xr02d1 U271 ( .A1(PAGEDATA_NUM[3]), .A2(n335), .Z(N675) );
  an12d1 U281 ( .A2(n335), .A1(PAGEDATA_NUM[3]), .Z(n336) );
  xr02d1 U283 ( .A1(PAGEDATA_NUM[4]), .A2(n336), .Z(N676) );
  an02d0 U284 ( .A1(n318), .A2(\r199/A[2] ), .Z(n344) );
  nr02d0 U286 ( .A1(n346), .A2(pagecnt[0]), .ZN(n338) );
  nd02d0 U287 ( .A1(n338), .A2(n345), .ZN(n339) );
  aoi222d1 U288 ( .A1(\r199/A[2] ), .A2(n318), .B1(n339), .B2(n348), .C1(
        pagecnt[1]), .C2(n347), .ZN(n341) );
  nr02d0 U289 ( .A1(\r199/A[2] ), .A2(n318), .ZN(n340) );
  or04d0 U290 ( .A1(n341), .A2(n340), .A3(N676), .A4(N675), .Z(N677) );
  nd02d0 U291 ( .A1(pagecnt[0]), .A2(n346), .ZN(n342) );
  aoi22d1 U292 ( .A1(n342), .A2(n345), .B1(n342), .B2(N673), .ZN(n343) );
  nr03d0 U293 ( .A1(n344), .A2(N677), .A3(n343), .ZN(N684) );
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
         net_scl, net_sda_link, net_sda_i, n1, n2, n4;
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
  pc3b03 sda_pad ( .I(net_sda_o), .OEN(net_sda_link), .PAD(sda), .CIN(
        net_sda_i) );
  invtd4 net_sda_o_tri ( .I(n2), .EN(n4), .ZN(net_sda_o) );
  inv0d0 U6 ( .I(net_sda_link), .ZN(n4) );
  inv0d1 U7 ( .I(net_sda), .ZN(n2) );
  inv0d1 U8 ( .I(net_sda_i), .ZN(n1) );
endmodule

