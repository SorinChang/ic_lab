
module test_DW01_inc_0 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  ah01d0 U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ah01d0 U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ah01d0 U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ah01d0 U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ah01d0 U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ah01d0 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  inv0d1 U1 ( .I(A[0]), .ZN(SUM[0]) );
  xr02d1 U2 ( .A1(carry[7]), .A2(A[7]), .Z(SUM[7]) );
endmodule


module test ( clk, rst_b, cnt_en, cnt_end );
  input clk, rst_b, cnt_en;
  output cnt_end;
  wire   N2, N3, N4, N5, N6, N7, N8, N9, n2, n3, n5, n6, n7, n8, n9, n10, n11,
         n12, n13;
  wire   [7:0] cnt;

  or02d1 U4 ( .A1(cnt[7]), .A2(cnt[6]), .Z(n3) );
  nd04d0 U6 ( .A1(cnt[3]), .A2(cnt[2]), .A3(cnt[1]), .A4(cnt[0]), .ZN(n2) );
  test_DW01_inc_0 add_32 ( .A(cnt), .SUM({N9, N8, N7, N6, N5, N4, N3, N2}) );
  mx02d0 \cnt_reg[7]/U4  ( .I0(N9), .I1(cnt[7]), .S(n13), .Z(n12) );
  dfcrq1 \cnt_reg[7]  ( .D(n12), .CP(clk), .CDN(rst_b), .Q(cnt[7]) );
  mx02d0 \cnt_reg[6]/U4  ( .I0(N8), .I1(cnt[6]), .S(n13), .Z(n11) );
  dfcrq1 \cnt_reg[6]  ( .D(n11), .CP(clk), .CDN(rst_b), .Q(cnt[6]) );
  mx02d0 \cnt_reg[5]/U4  ( .I0(N7), .I1(cnt[5]), .S(n13), .Z(n10) );
  dfcrq1 \cnt_reg[5]  ( .D(n10), .CP(clk), .CDN(rst_b), .Q(cnt[5]) );
  mx02d0 \cnt_reg[4]/U4  ( .I0(N6), .I1(cnt[4]), .S(n13), .Z(n9) );
  dfcrq1 \cnt_reg[4]  ( .D(n9), .CP(clk), .CDN(rst_b), .Q(cnt[4]) );
  mx02d0 \cnt_reg[3]/U4  ( .I0(N5), .I1(cnt[3]), .S(n13), .Z(n8) );
  dfcrq1 \cnt_reg[3]  ( .D(n8), .CP(clk), .CDN(rst_b), .Q(cnt[3]) );
  mx02d0 \cnt_reg[2]/U4  ( .I0(N4), .I1(cnt[2]), .S(n13), .Z(n7) );
  dfcrq1 \cnt_reg[2]  ( .D(n7), .CP(clk), .CDN(rst_b), .Q(cnt[2]) );
  mx02d0 \cnt_reg[1]/U4  ( .I0(N3), .I1(cnt[1]), .S(n13), .Z(n6) );
  dfcrq1 \cnt_reg[1]  ( .D(n6), .CP(clk), .CDN(rst_b), .Q(cnt[1]) );
  mx02d0 \cnt_reg[0]/U4  ( .I0(N2), .I1(cnt[0]), .S(n13), .Z(n5) );
  dfcrq1 \cnt_reg[0]  ( .D(n5), .CP(clk), .CDN(rst_b), .Q(cnt[0]) );
  inv0d1 U7 ( .I(cnt_en), .ZN(n13) );
  nr04da U8 ( .A1(n2), .A2(n3), .A3(cnt[5]), .A4(cnt[4]), .ZN(cnt_end) );
endmodule

