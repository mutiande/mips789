/******************************************************************
 *                                                                * 
 *    Author: Liwei                                               * 
 *                                                                * 
 *    This file is part of the "mips789" project.                 * 
 *    Downloaded from:                                            * 
 *    http://www.opencores.org/pdownloads.cgi/list/mips789        * 
 *                                                                * 
 *    If you encountered any problem, please contact me via       * 
 *    Email:mcupro@opencores.org  or mcupro@163.com               * 
 *                                                                * 
 ******************************************************************/

`include "include.h"
/*
module mem_array
    (
        input clk,
        input [31:0] pc_i,
        output [31:0] ins_o,
        input [3:0] wren,
        input [31:0]din,
        input [31:0]wr_addr_i,
        input [31:0]rd_addr_i,
        output [31:0]dout
    );
    wire [29:0] rd_addr,pc,wr_addr;
    wire [31:0]dout_w;
    assign dout = dout_w;
    assign rd_addr=rd_addr_i[31:2];
    assign wr_addr=wr_addr_i[31:2];
    assign pc= pc_i[31:2];	 
	
	   
 
 `ifdef DEBUG

    sim_syn_ram3 ram3 (
                     .data(din[31:31-7]),
                     .wraddress(wr_addr),
                     .rdaddress_a(pc),
                     .rdaddress_b(rd_addr),
                     .wren(wren[3]),
                     .clock(clk),
                     .qa(ins_o[31:31-7]),
                     .qb(dout_w[31:31-7])
                 );

    sim_syn_ram2 ram2(
                     .data(din[31-8:31-8-7]),
                     .wraddress(wr_addr),
                     .rdaddress_a(pc),
                     .rdaddress_b(rd_addr),
                     .wren(wren[2]),
                     .clock(clk),
                     .qa(ins_o[31-8:31-8-7]),
                     .qb(dout_w[31-8:31-7-8])
                 );

    sim_syn_ram1 ram1(
                     .data(din[31-16:31-16-7]),
                     .wraddress(wr_addr),
                     .rdaddress_a(pc),
                     .rdaddress_b(rd_addr),
                     .wren(wren[1]),
                     .clock(clk),
                     .qa(ins_o[31-16:31-7-16]),
                     .qb(dout_w[31-16:31-7-16])
                 );

    sim_syn_ram0 ram0(
                     .data(din[31-24:31-7-24]),
                     .wraddress(wr_addr),
                     .rdaddress_a(pc),
                     .rdaddress_b(rd_addr),
                     .wren(wren[0]),
                     .clock(clk),
                     .qa(ins_o[31-24:31-7-24]),
                     .qb(dout_w[31-24:31-7-24])
                 );


 `else            
    ram4096x8_3 ram3(
                    .data_a(32'b0),
                    .wren_a(1'b0),
                    .address_a(32'b0),
                    .data_b(din[31:24]),
                    .address_b(wr_addr),
                    .wren_b(wren[3]),
                    .clock(clk),
                    .q_a(ins_o[31:24]),
                    .q_b(dout_w[31:24])
                );

    ram4096x8_2 ram2(
                    .data_a(32'b0),
                    .wren_a(1'b0),
                    .address_a(32'b0),
                    .data_b(din[23:16]),
                    .address_b(wr_addr),
                    .wren_b(wren[2]),
                    .clock(clk),
                    .q_a(ins_o[23:16]),
                    .q_b(dout_w[23:16])
                );

    ram4096x8_1 ram1(
                    .data_a(32'b0),
                    .wren_a(1'b0),
                    .address_a(32'b0),
                    .data_b(din[15:8]),
                    .address_b(wr_addr),
                    .wren_b(wren[1]),
                    .clock(clk),
                    .q_a(ins_o[15:8]),
                    .q_b(dout_w[15:8])
                );

    ram4096x8_0 ram0(
                    .data_a(32'b0),
                    .wren_a(1'b0),
                    .address_a(32'b0),
                    .data_b(din[7:0]),
                    .address_b(wr_addr),
                    .wren_b(wren[0]),
                    .clock(clk),
                    .q_a(ins_o[7:0]),
                    .q_b(dout_w[7:0])
                );
// `endif

endmodule
			 		   */  


