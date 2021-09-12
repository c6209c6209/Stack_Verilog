/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Mon May 27 13:27:40 2019
/////////////////////////////////////////////////////////////


module queue ( clk, reset, go, cmd, r_num, ready, w_en, r_en, full, 
        almost_full, empty, almost_empty, error, w_num, addr );
  input [17:0] cmd;
  input [15:0] r_num;
  output [15:0] w_num;
  output [4:0] addr;
  input clk, reset, go;
  output ready, w_en, r_en, full, almost_full, empty, almost_empty, error;
  wire   popped, next_ready, next_full, next_almost_full, next_empty,
         next_almost_empty, N32, N33, N34, N35, N36, N39, N40, N41, N42, N59,
         N60, N61, N68, N69, N70, N71, N72, N73, N115, N116, N117, N118, N119,
         N120, N121, N122, N123, N124, N125, N126, N127, N128, N129, N130, n4,
         n10, n11, n12, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n27, n30, n31, n32, n36, n37, n40, n41, n42, n45, n46, n48, n49, n50,
         n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65,
         n66, n67, n68, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80,
         n81, n82, n83, n84, n85, n86, n93, n94, \sub_114_aco/B[0] , n97, n98,
         n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
         n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121,
         n122, n123, n124;
  wire   [5:0] count;
  wire   [4:0] head;
  wire   [4:0] tail;
  wire   [1:0] next_state;
  wire   [15:0] next_w_num;
  wire   [4:2] \add_123/carry ;
  wire   [6:0] \sub_114_aco/carry ;
  wire   [4:2] \r322/carry ;
  wire   [5:2] \r321/carry ;

  DFFRX1 \addr_reg[4]  ( .D(n79), .CK(clk), .RN(n111), .Q(addr[4]), .QN(n61)
         );
  DFFRX1 \addr_reg[1]  ( .D(n76), .CK(clk), .RN(n110), .Q(addr[1]), .QN(n60)
         );
  DFFRX1 \addr_reg[2]  ( .D(n74), .CK(clk), .RN(n110), .Q(addr[2]), .QN(n59)
         );
  DFFRX1 \addr_reg[3]  ( .D(n72), .CK(clk), .RN(n110), .Q(addr[3]), .QN(n58)
         );
  DFFRX1 \addr_reg[0]  ( .D(n71), .CK(clk), .RN(n110), .Q(addr[0]), .QN(n57)
         );
  DFFRX1 error_reg ( .D(n70), .CK(clk), .RN(n110), .Q(error) );
  DFFRX1 \head_reg[4]  ( .D(n80), .CK(clk), .RN(n111), .Q(head[4]), .QN(n66)
         );
  DFFRX1 \count_reg[5]  ( .D(n112), .CK(clk), .RN(n109), .Q(count[5]) );
  DFFRX1 \head_reg[1]  ( .D(n77), .CK(clk), .RN(n110), .Q(head[1]), .QN(n64)
         );
  DFFRX1 \head_reg[2]  ( .D(n75), .CK(clk), .RN(n110), .Q(head[2]), .QN(n63)
         );
  DFFRX1 \head_reg[3]  ( .D(n73), .CK(clk), .RN(n110), .Q(head[3]), .QN(n62)
         );
  DFFRX1 full_reg ( .D(next_full), .CK(clk), .RN(n109), .Q(full), .QN(n67) );
  DFFRX1 \head_reg[0]  ( .D(n78), .CK(clk), .RN(n110), .Q(head[0]), .QN(n65)
         );
  DFFRX1 \tail_reg[4]  ( .D(n81), .CK(clk), .RN(n111), .Q(tail[4]), .QN(n98)
         );
  DFFRX1 popped_reg ( .D(n86), .CK(clk), .RN(n111), .Q(popped), .QN(n99) );
  DFFRX1 \count_reg[4]  ( .D(n113), .CK(clk), .RN(n109), .Q(count[4]) );
  DFFRX1 \tail_reg[3]  ( .D(n82), .CK(clk), .RN(n111), .Q(tail[3]), .QN(n101)
         );
  DFFRX1 \tail_reg[1]  ( .D(n84), .CK(clk), .RN(n111), .Q(tail[1]), .QN(n102)
         );
  DFFRX1 \tail_reg[2]  ( .D(n83), .CK(clk), .RN(n111), .Q(tail[2]), .QN(n104)
         );
  DFFRX1 \tail_reg[0]  ( .D(n85), .CK(clk), .RN(n111), .Q(tail[0]), .QN(n105)
         );
  DFFRX1 \count_reg[1]  ( .D(n116), .CK(clk), .RN(n110), .Q(count[1]) );
  DFFRX1 \count_reg[2]  ( .D(n115), .CK(clk), .RN(n109), .Q(count[2]) );
  DFFRX1 \count_reg[3]  ( .D(n114), .CK(clk), .RN(n109), .Q(count[3]) );
  DFFRX1 \count_reg[0]  ( .D(n117), .CK(clk), .RN(n109), .Q(count[0]), .QN(
        n103) );
  DFFSX1 empty_reg ( .D(next_empty), .CK(clk), .SN(n111), .Q(empty), .QN(
        \sub_114_aco/B[0] ) );
  DFFSX1 \state_reg[1]  ( .D(next_state[1]), .CK(clk), .SN(n111), .Q(n68) );
  DFFSX1 ready_reg ( .D(next_ready), .CK(clk), .SN(n111), .Q(ready) );
  TLATNX1 \next_w_num_reg[15]  ( .D(N130), .GN(n97), .Q(next_w_num[15]) );
  TLATNX1 \next_w_num_reg[14]  ( .D(N129), .GN(n97), .Q(next_w_num[14]) );
  TLATNX1 \next_w_num_reg[13]  ( .D(N128), .GN(n97), .Q(next_w_num[13]) );
  TLATNX1 \next_w_num_reg[12]  ( .D(N127), .GN(n97), .Q(next_w_num[12]) );
  TLATNX1 \next_w_num_reg[11]  ( .D(N126), .GN(n97), .Q(next_w_num[11]) );
  TLATNX1 \next_w_num_reg[10]  ( .D(N125), .GN(n97), .Q(next_w_num[10]) );
  TLATNX1 \next_w_num_reg[9]  ( .D(N124), .GN(n97), .Q(next_w_num[9]) );
  TLATNX1 \next_w_num_reg[8]  ( .D(N123), .GN(n97), .Q(next_w_num[8]) );
  TLATNX1 \next_w_num_reg[7]  ( .D(N122), .GN(n97), .Q(next_w_num[7]) );
  TLATNX1 \next_w_num_reg[6]  ( .D(N121), .GN(n97), .Q(next_w_num[6]) );
  TLATNX1 \next_w_num_reg[5]  ( .D(N120), .GN(n97), .Q(next_w_num[5]) );
  TLATNX1 \next_w_num_reg[4]  ( .D(N119), .GN(n97), .Q(next_w_num[4]) );
  TLATNX1 \next_w_num_reg[3]  ( .D(N118), .GN(n97), .Q(next_w_num[3]) );
  TLATNX1 \next_w_num_reg[2]  ( .D(N117), .GN(n97), .Q(next_w_num[2]) );
  TLATNX1 \next_w_num_reg[1]  ( .D(N116), .GN(n97), .Q(next_w_num[1]) );
  TLATNX1 \next_w_num_reg[0]  ( .D(N115), .GN(n97), .Q(next_w_num[0]) );
  DFFRX1 r_en_reg ( .D(n94), .CK(clk), .RN(n110), .Q(r_en) );
  DFFSX1 \state_reg[0]  ( .D(next_state[0]), .CK(clk), .SN(n111), .Q(n97), 
        .QN(n93) );
  DFFRX1 w_en_reg ( .D(n93), .CK(clk), .RN(n110), .Q(w_en) );
  DFFRX1 almost_full_reg ( .D(next_almost_full), .CK(clk), .RN(n109), .Q(
        almost_full) );
  DFFRX1 almost_empty_reg ( .D(next_almost_empty), .CK(clk), .RN(n109), .Q(
        almost_empty) );
  DFFRX1 \w_num_reg[15]  ( .D(next_w_num[15]), .CK(clk), .RN(n109), .Q(
        w_num[15]) );
  DFFRX1 \w_num_reg[14]  ( .D(next_w_num[14]), .CK(clk), .RN(n109), .Q(
        w_num[14]) );
  DFFRX1 \w_num_reg[13]  ( .D(next_w_num[13]), .CK(clk), .RN(n109), .Q(
        w_num[13]) );
  DFFRX1 \w_num_reg[12]  ( .D(next_w_num[12]), .CK(clk), .RN(n109), .Q(
        w_num[12]) );
  DFFRX1 \w_num_reg[11]  ( .D(next_w_num[11]), .CK(clk), .RN(n108), .Q(
        w_num[11]) );
  DFFRX1 \w_num_reg[10]  ( .D(next_w_num[10]), .CK(clk), .RN(n108), .Q(
        w_num[10]) );
  DFFRX1 \w_num_reg[9]  ( .D(next_w_num[9]), .CK(clk), .RN(n108), .Q(w_num[9])
         );
  DFFRX1 \w_num_reg[8]  ( .D(next_w_num[8]), .CK(clk), .RN(n108), .Q(w_num[8])
         );
  DFFRX1 \w_num_reg[7]  ( .D(next_w_num[7]), .CK(clk), .RN(n108), .Q(w_num[7])
         );
  DFFRX1 \w_num_reg[6]  ( .D(next_w_num[6]), .CK(clk), .RN(n108), .Q(w_num[6])
         );
  DFFRX1 \w_num_reg[5]  ( .D(next_w_num[5]), .CK(clk), .RN(n108), .Q(w_num[5])
         );
  DFFRX1 \w_num_reg[4]  ( .D(next_w_num[4]), .CK(clk), .RN(n108), .Q(w_num[4])
         );
  DFFRX1 \w_num_reg[3]  ( .D(next_w_num[3]), .CK(clk), .RN(n108), .Q(w_num[3])
         );
  DFFRX1 \w_num_reg[2]  ( .D(next_w_num[2]), .CK(clk), .RN(n108), .Q(w_num[2])
         );
  DFFRX1 \w_num_reg[1]  ( .D(next_w_num[1]), .CK(clk), .RN(n108), .Q(w_num[1])
         );
  DFFRX1 \w_num_reg[0]  ( .D(next_w_num[0]), .CK(clk), .RN(n108), .Q(w_num[0])
         );
  AOI222XL U107 ( .A0(N34), .A1(n24), .B0(count[3]), .B1(n12), .C0(N71), .C1(
        n94), .Y(n20) );
  AOI222XL U108 ( .A0(N33), .A1(n24), .B0(count[2]), .B1(n12), .C0(N70), .C1(
        n94), .Y(n21) );
  AOI222XL U109 ( .A0(N69), .A1(n94), .B0(N32), .B1(n24), .C0(n12), .C1(
        count[1]), .Y(n19) );
  AOI222XL U110 ( .A0(N36), .A1(n24), .B0(count[5]), .B1(n12), .C0(N73), .C1(
        n94), .Y(n17) );
  XNOR2X1 U111 ( .A(\add_123/carry [4]), .B(head[4]), .Y(n100) );
  OAI21XL U112 ( .A0(n67), .A1(n97), .B0(n56), .Y(n12) );
  AOI222XL U113 ( .A0(N35), .A1(n24), .B0(count[4]), .B1(n12), .C0(N72), .C1(
        n94), .Y(n23) );
  AOI222XL U114 ( .A0(n103), .A1(n24), .B0(count[0]), .B1(n12), .C0(N68), .C1(
        n94), .Y(n22) );
  NOR2X1 U115 ( .A(n68), .B(n93), .Y(n94) );
  NOR3X1 U116 ( .A(n16), .B(n112), .C(n117), .Y(next_empty) );
  NAND4X1 U117 ( .A(n23), .B(n20), .C(n21), .D(n19), .Y(n16) );
  NOR4X1 U118 ( .A(n18), .B(n19), .C(n20), .D(n21), .Y(next_almost_full) );
  NAND3X1 U119 ( .A(n117), .B(n17), .C(n113), .Y(n18) );
  NOR3X1 U120 ( .A(n16), .B(n112), .C(n22), .Y(next_almost_empty) );
  NOR3X1 U121 ( .A(n16), .B(n117), .C(n17), .Y(next_full) );
  CLKINVX1 U122 ( .A(n50), .Y(n121) );
  CLKINVX1 U123 ( .A(n17), .Y(n112) );
  CLKINVX1 U124 ( .A(n23), .Y(n113) );
  CLKINVX1 U125 ( .A(n20), .Y(n114) );
  NOR2X1 U126 ( .A(n12), .B(n94), .Y(n4) );
  OAI2BB2XL U127 ( .B0(n101), .B1(n4), .A0N(N41), .A1N(n119), .Y(n82) );
  OAI2BB2XL U128 ( .B0(n104), .B1(n4), .A0N(N40), .A1N(n119), .Y(n83) );
  OAI2BB2XL U129 ( .B0(n102), .B1(n4), .A0N(N39), .A1N(n119), .Y(n84) );
  CLKINVX1 U130 ( .A(n22), .Y(n117) );
  NAND2X1 U131 ( .A(n55), .B(n94), .Y(n54) );
  NAND2X1 U132 ( .A(n99), .B(n14), .Y(n86) );
  CLKINVX1 U133 ( .A(n94), .Y(n120) );
  CLKINVX1 U134 ( .A(n21), .Y(n115) );
  CLKINVX1 U135 ( .A(n19), .Y(n116) );
  OAI31XL U136 ( .A0(head[2]), .A1(n14), .A2(n123), .B0(n40), .Y(n75) );
  OAI21XL U137 ( .A0(n41), .A1(n14), .B0(head[2]), .Y(n40) );
  AOI21X1 U138 ( .A0(n42), .A1(head[1]), .B0(n123), .Y(n41) );
  CLKINVX1 U139 ( .A(N60), .Y(n123) );
  OAI31XL U140 ( .A0(head[1]), .A1(n14), .A2(n124), .B0(n45), .Y(n77) );
  OAI21XL U141 ( .A0(n46), .A1(n14), .B0(head[1]), .Y(n45) );
  AOI21X1 U142 ( .A0(n42), .A1(head[2]), .B0(n124), .Y(n46) );
  CLKINVX1 U143 ( .A(N59), .Y(n124) );
  OAI31XL U144 ( .A0(head[4]), .A1(n14), .A2(n100), .B0(n30), .Y(n80) );
  OAI21XL U145 ( .A0(n31), .A1(n14), .B0(head[4]), .Y(n30) );
  AOI21X1 U146 ( .A0(n32), .A1(head[0]), .B0(n100), .Y(n31) );
  CLKINVX1 U147 ( .A(N61), .Y(n122) );
  CLKBUFX3 U148 ( .A(n118), .Y(n108) );
  CLKBUFX3 U149 ( .A(n118), .Y(n109) );
  CLKBUFX3 U150 ( .A(n118), .Y(n110) );
  CLKBUFX3 U151 ( .A(n118), .Y(n111) );
  XOR2X1 U152 ( .A(count[5]), .B(n106), .Y(N73) );
  NOR2X1 U153 ( .A(count[4]), .B(\sub_114_aco/carry [4]), .Y(n106) );
  NAND2X1 U154 ( .A(n68), .B(n93), .Y(n50) );
  ADDHXL U155 ( .A(count[1]), .B(count[0]), .CO(\r321/carry [2]), .S(N32) );
  ADDHXL U156 ( .A(count[2]), .B(\r321/carry [2]), .CO(\r321/carry [3]), .S(
        N33) );
  ADDHXL U157 ( .A(count[3]), .B(\r321/carry [3]), .CO(\r321/carry [4]), .S(
        N34) );
  NOR2X1 U158 ( .A(full), .B(n107), .Y(n24) );
  AOI21X1 U159 ( .A0(popped), .A1(n121), .B0(n27), .Y(n107) );
  ADDHXL U160 ( .A(count[4]), .B(\r321/carry [4]), .CO(\r321/carry [5]), .S(
        N35) );
  OAI21XL U161 ( .A0(n97), .A1(n99), .B0(n68), .Y(n56) );
  AOI2BB1X1 U162 ( .A0N(\sub_114_aco/B[0] ), .A1N(n120), .B0(n12), .Y(n55) );
  NOR2X1 U163 ( .A(n97), .B(n68), .Y(n27) );
  NOR3BXL U164 ( .AN(go), .B(n94), .C(n93), .Y(n15) );
  NAND2X1 U165 ( .A(\sub_114_aco/B[0] ), .B(n94), .Y(n14) );
  NOR3BXL U166 ( .AN(n68), .B(go), .C(n93), .Y(next_ready) );
  NOR3X1 U167 ( .A(n65), .B(n62), .C(n66), .Y(n42) );
  NOR3X1 U168 ( .A(n63), .B(n62), .C(n64), .Y(n32) );
  OAI2BB2XL U169 ( .B0(n98), .B1(n4), .A0N(N42), .A1N(n119), .Y(n81) );
  OAI2BB2XL U170 ( .B0(n105), .B1(n4), .A0N(n105), .A1N(n119), .Y(n85) );
  NAND2X1 U171 ( .A(n55), .B(n93), .Y(n53) );
  ADDHXL U172 ( .A(tail[1]), .B(tail[0]), .CO(\r322/carry [2]), .S(N39) );
  ADDHXL U173 ( .A(tail[2]), .B(\r322/carry [2]), .CO(\r322/carry [3]), .S(N40) );
  ADDHXL U174 ( .A(head[2]), .B(\add_123/carry [2]), .CO(\add_123/carry [3]), 
        .S(N60) );
  ADDHXL U175 ( .A(head[1]), .B(head[0]), .CO(\add_123/carry [2]), .S(N59) );
  NAND2BX1 U176 ( .AN(cmd[17]), .B(n15), .Y(next_state[1]) );
  NAND2BX1 U177 ( .AN(cmd[16]), .B(n15), .Y(next_state[0]) );
  OAI222XL U178 ( .A0(n105), .A1(n53), .B0(n65), .B1(n54), .C0(n57), .C1(n55), 
        .Y(n71) );
  OAI222XL U179 ( .A0(n101), .A1(n53), .B0(n62), .B1(n54), .C0(n58), .C1(n55), 
        .Y(n72) );
  OAI222XL U180 ( .A0(n104), .A1(n53), .B0(n63), .B1(n54), .C0(n59), .C1(n55), 
        .Y(n74) );
  OAI222XL U181 ( .A0(n102), .A1(n53), .B0(n64), .B1(n54), .C0(n60), .C1(n55), 
        .Y(n76) );
  OAI222XL U182 ( .A0(n98), .A1(n53), .B0(n66), .B1(n54), .C0(n61), .C1(n55), 
        .Y(n79) );
  OAI32X1 U183 ( .A0(head[3]), .A1(n14), .A2(n122), .B0(n62), .B1(n36), .Y(n73) );
  AOI2BB1X1 U184 ( .A0N(n37), .A1N(n122), .B0(n14), .Y(n36) );
  NOR4X1 U185 ( .A(n63), .B(n64), .C(n65), .D(n66), .Y(n37) );
  OAI221XL U186 ( .A0(popped), .A1(n50), .B0(\sub_114_aco/B[0] ), .B1(n120), 
        .C0(n52), .Y(n70) );
  AOI2BB2X1 U187 ( .B0(next_ready), .B1(error), .A0N(n97), .A1N(n67), .Y(n52)
         );
  OAI31XL U188 ( .A0(head[0]), .A1(n14), .A2(head[0]), .B0(n48), .Y(n78) );
  OAI21XL U189 ( .A0(n49), .A1(n14), .B0(head[0]), .Y(n48) );
  AOI21X1 U190 ( .A0(n32), .A1(head[4]), .B0(head[0]), .Y(n49) );
  CLKINVX1 U191 ( .A(n10), .Y(n119) );
  OAI31XL U192 ( .A0(n11), .A1(n101), .A2(n98), .B0(n4), .Y(n10) );
  NAND3X1 U193 ( .A(tail[1]), .B(tail[0]), .C(tail[2]), .Y(n11) );
  ADDHXL U194 ( .A(tail[3]), .B(\r322/carry [3]), .CO(\r322/carry [4]), .S(N41) );
  ADDHXL U195 ( .A(head[3]), .B(\add_123/carry [3]), .CO(\add_123/carry [4]), 
        .S(N61) );
  CLKINVX1 U196 ( .A(reset), .Y(n118) );
  AO22X1 U197 ( .A0(cmd[0]), .A1(n27), .B0(r_num[0]), .B1(n121), .Y(N115) );
  AO22X1 U198 ( .A0(cmd[1]), .A1(n27), .B0(r_num[1]), .B1(n121), .Y(N116) );
  AO22X1 U199 ( .A0(cmd[2]), .A1(n27), .B0(r_num[2]), .B1(n121), .Y(N117) );
  AO22X1 U200 ( .A0(cmd[3]), .A1(n27), .B0(r_num[3]), .B1(n121), .Y(N118) );
  AO22X1 U201 ( .A0(cmd[4]), .A1(n27), .B0(r_num[4]), .B1(n121), .Y(N119) );
  AO22X1 U202 ( .A0(cmd[5]), .A1(n27), .B0(r_num[5]), .B1(n121), .Y(N120) );
  AO22X1 U203 ( .A0(cmd[6]), .A1(n27), .B0(r_num[6]), .B1(n121), .Y(N121) );
  AO22X1 U204 ( .A0(cmd[7]), .A1(n27), .B0(r_num[7]), .B1(n121), .Y(N122) );
  AO22X1 U205 ( .A0(cmd[8]), .A1(n27), .B0(r_num[8]), .B1(n121), .Y(N123) );
  AO22X1 U206 ( .A0(cmd[9]), .A1(n27), .B0(r_num[9]), .B1(n121), .Y(N124) );
  AO22X1 U207 ( .A0(cmd[10]), .A1(n27), .B0(r_num[10]), .B1(n121), .Y(N125) );
  AO22X1 U208 ( .A0(cmd[11]), .A1(n27), .B0(r_num[11]), .B1(n121), .Y(N126) );
  AO22X1 U209 ( .A0(cmd[12]), .A1(n27), .B0(r_num[12]), .B1(n121), .Y(N127) );
  AO22X1 U210 ( .A0(cmd[13]), .A1(n27), .B0(r_num[13]), .B1(n121), .Y(N128) );
  AO22X1 U211 ( .A0(cmd[14]), .A1(n27), .B0(r_num[14]), .B1(n121), .Y(N129) );
  AO22X1 U212 ( .A0(cmd[15]), .A1(n27), .B0(r_num[15]), .B1(n121), .Y(N130) );
  XNOR2X1 U213 ( .A(\sub_114_aco/carry [4]), .B(count[4]), .Y(N72) );
  OR2X1 U214 ( .A(count[3]), .B(\sub_114_aco/carry [3]), .Y(
        \sub_114_aco/carry [4]) );
  XNOR2X1 U215 ( .A(\sub_114_aco/carry [3]), .B(count[3]), .Y(N71) );
  OR2X1 U216 ( .A(count[2]), .B(\sub_114_aco/carry [2]), .Y(
        \sub_114_aco/carry [3]) );
  XNOR2X1 U217 ( .A(\sub_114_aco/carry [2]), .B(count[2]), .Y(N70) );
  OR2X1 U218 ( .A(count[1]), .B(\sub_114_aco/carry [1]), .Y(
        \sub_114_aco/carry [2]) );
  XNOR2X1 U219 ( .A(\sub_114_aco/carry [1]), .B(count[1]), .Y(N69) );
  OR2X1 U220 ( .A(empty), .B(count[0]), .Y(\sub_114_aco/carry [1]) );
  XNOR2X1 U221 ( .A(count[0]), .B(empty), .Y(N68) );
  XOR2X1 U222 ( .A(\r321/carry [5]), .B(count[5]), .Y(N36) );
  XOR2X1 U223 ( .A(\r322/carry [4]), .B(tail[4]), .Y(N42) );
endmodule

