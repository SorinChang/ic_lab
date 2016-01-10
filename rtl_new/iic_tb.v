// Copyright (C) 1991-2011 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// *****************************************************************************
// This file contains a Verilog test bench template that is freely editable to  
// suit user's needs .Comments are provided in each section to help the user    
// fill out necessary details.                                                  
// *****************************************************************************
// Generated on "11/14/2015 15:34:44"
                                                                                
// Verilog Test Bench template for design : iic
// 
// Simulation tool : ModelSim-Altera (Verilog)
// 

`timescale 1ns/ 100 ps
module iic_vlg_tst();
// constants                                           
// general purpose registers
//reg eachvec;
// test vector input registers
reg REG_WR;
reg [7:0]IDA;
reg [2:0] addr;
reg clk;
reg rst_n;
reg treg_sda;
reg sw1;
reg sw2;
reg sw3;
reg sw4;
// wires                                               
wire [2:0]  ackflag;
wire [7:0]  outdata;
wire scl;
wire sda;
wire sda_link;

// assign statements (if any)                          
//assign sda = sda_link ? sda:1'bz;
iic u1 (
// port map - connection between master ports and signals/registers   
	.REG_WR(REG_WR),
	.IDAT(IDAT),
	.addr(addr),
	.ackflag(ackflag),
	.clk(clk),
	.outdata(outdata),
	.rst_n(rst_n),
	.scl(scl),
	.sda(sda),
	.sw1(sw1),
	.sw2(sw2),
	.sw3(sw3),
	.sw4(sw4),
	.sda_link(sda_link)
);
initial
begin                                                  
// code that executes only once                        
// insert code here --> begin                          
	clk<=0;
	rst_n<=0;
	sw1<=1;
	sw2<=1;
	sw3<=1;
	sw4<=1;
	/*DEVICE<=7'b1010_100;
	WRITE_DATA0<= 8'b1010_0101;
	WRITE_DATA1<=0;
	WRITE_DATA2<=0;
	WRITE_DATA3<=8'b0101_0101;
	WRITE_DATA4<=0;
	PAGEDATA_NUM<=3;
	BYTE_ADDR<=8'b0001_0010;
	*/	
	#400
	rst_n<=1;
	sw3<=0;
// --> end                                             
$display("Running testbench");                       
end                                                    
always                                                 
// optional sensitivity list                           
// @(event1 or event2 or .... eventn)                  
begin                                                  
// code executes for every event on sensitivity list   
// insert code here --> begin                          
#20 clk<=~clk;                                                       
//@eachvec;                                              
// --> end                                             
end                                                    
endmodule

