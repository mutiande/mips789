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
module ext(
        input [31:0] ins_i ,
        output reg [31:0] res ,
        input [2:0]ctl
    );

    wire [25:0] instr25_0;
    assign instr25_0 = ins_i[25:0] ;

    wire[15:0] sign = {
            instr25_0[15],instr25_0[15],instr25_0[15],instr25_0[15],
            instr25_0[15],instr25_0[15],instr25_0[15],instr25_0[15],
            instr25_0[15],instr25_0[15],instr25_0[15],instr25_0[15],
            instr25_0[15],instr25_0[15],instr25_0[15],instr25_0[15]};

    always @ (*)
    case (ctl)
        `EXT_SIGN    :res ={sign,instr25_0[15:0]};//sign
        `EXT_UNSIGN  :res ={16'b0,instr25_0[15:0]};//zeroext
        `EXT_J       :res ={4'b0,instr25_0[25:0],2'b0};//jmp
        `EXT_B       :res ={sign[13:0],instr25_0[15:0],2'B0};//brach
        `EXT_SA      :res ={27'b0,instr25_0[10:6]} ;//sll,srl
        `EXT_S2H     :res ={instr25_0[15:0],16'B0};//shift to high
        default: res=0;
    endcase
endmodule


module compare (
        input [31:0] s,
        input [31:0] t,
        input [2:0]ctl,
        output reg res
    );
    always @ (*)
    case  (ctl)
        `CMP_BEQ:   res = (s==t);
        `CMP_BNE:   res = (s!=t);
        `CMP_BLTZ:  res = s[31];
        `CMP_BGTZ:  res = ~s[31] && (|s[30:0]);
        `CMP_BLEZ:  res = s[31] |(~|s);
        `CMP_BGEZ:  res = ~s[31];
        default res=1'B0;
    endcase
endmodule


module pc_gen(
        input [2:0]ctl,
        output reg   [31:0]pc_next,
        input [3:0] pc_prectl,
        input check,
        input [31:0]s,
        input [31:0]pc,
        input [31:0]zz_spc,
        input [31:0]imm,
        input [31:0]irq
    );

    wire [32:0] br_addr = pc + imm ;

    always @ (*)
        if(pc_prectl == `PC_IGN )
        begin
            case (ctl)
                `PC_RET 	:	pc_next = zz_spc ;
                `PC_J		:	pc_next ={pc[31:28],imm[27:0]};
                `PC_JR		: 	pc_next = s;
                `PC_BC		: 	pc_next = (check)?({br_addr[31:0]}):(pc+4);
                `PC_NEXT	:	pc_next = pc+ 4 ;
                default 		pc_next = pc + 4;
            endcase
        end
        else
        begin
            case (pc_prectl)
                `PC_KEP 	: pc_next=pc;
                `PC_IRQ 	: pc_next=irq;
                `PC_RST 	: pc_next='d0;
                default		  pc_next =0;
            endcase
        end

endmodule



module reg_array(
        data,
        wraddress,
        rdaddress_a,
        rdaddress_b,
        wren,
        clock,
        qa,
        qb,
        rd_clk_cls
    );

    input	[31:0]  data;
    input	[4:0]  wraddress;
    input	[4:0]  rdaddress_a;
    input	[4:0]  rdaddress_b;

    reg	[31:0]  r_data;
    reg	[4:0]  r_wraddress;
    reg	[4:0]  r_rdaddress_a;
    reg	[4:0]  r_rdaddress_b;
    input rd_clk_cls;
    input	wren;
    reg r_wren;
    input	clock;
    output	[31:0]  qa;
    output	[31:0]  qb;
    reg [31:0]reg_bank[0:31];

    assign qa=(r_rdaddress_a==0)?0:
           ((r_wraddress==r_rdaddress_a)&&(1==r_wren))?r_data:
           reg_bank[r_rdaddress_a];

    assign qb=(r_rdaddress_b==0)?0:
           ((r_wraddress==r_rdaddress_b)&&(1==r_wren))?r_data:
           reg_bank[r_rdaddress_b];

    always@(posedge clock)
        if (~rd_clk_cls)
        begin
            r_rdaddress_a <=rdaddress_a;
            r_rdaddress_b<=rdaddress_b;
        end

    always@(posedge clock)
    begin
        r_data <=data;
        r_wraddress<=wraddress;
        r_wren<=wren;
    end
    always@(posedge clock)
        if (r_wren)
            reg_bank[r_wraddress] <= r_data ;
endmodule
