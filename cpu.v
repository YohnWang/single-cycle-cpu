`timescale 1ns/100ps
module cpu;

reg code_en;
reg data_en;
reg clk;
reg pc_rst;
wire[31:0] pc_output;
wire[31:0] pc_next,pc_branch_next,pc_real_next,pc_real_next_after_jump;
wire[31:0] instr;
wire[31:0] srcA,srcB;
wire[2:0] aluctrl;
wire[31:0] aluresult;
wire reg_write;
wire reg_dst;
wire[4:0] wire_of_A3;
wire[31:0] wire_of_RD2;
wire ALUSrc;
wire[31:0] SignImm;
//
wire wire_of_PCSrc;
wire wire_of_branch;
wire wire_of_zero;

wire[31:0] wire_of_ram_RD,wire_of_reg_WD3;
wire wire_of_ram_we;
wire wire_of_mem_to_reg;
wire wire_of_jump;

//inst
PC  pc(pc_rst,clk,pc_output,pc_real_next_after_jump);
PCPlus4 pc_plus(pc_output,pc_next);
ROM code_rom(pc_output,instr,code_en);
RAM data_ram(data_en,clk,aluresult,wire_of_ram_we,wire_of_RD2,wire_of_ram_RD);
ALU alu(srcA,srcB,aluctrl,aluresult,wire_of_zero);
register reg_array(clk,instr[25:21],instr[20:16],wire_of_A3,srcA,wire_of_RD2,reg_write,wire_of_reg_WD3);
CU ctrl_unit(instr[31:26],instr[5:0],wire_of_mem_to_reg,
			 wire_of_ram_we,wire_of_branch,aluctrl,
			 ALUSrc,reg_dst,reg_write,wire_of_jump);
PCBranch pc_branch(SignImm,pc_next,pc_branch_next);

//assistant
selector5 selector_reg(instr[20:16],instr[15:11],reg_dst,wire_of_A3);
selector32 selector_alu(wire_of_RD2,SignImm,ALUSrc,srcB);
SignExtend sign_extend(instr[15:0],SignImm);
selector32 selector_pc(pc_next,pc_branch_next,wire_of_PCSrc,pc_real_next);
and and_PCSrc(wire_of_PCSrc,wire_of_zero,wire_of_branch);
selector32 selector_reg_WD3(aluresult,wire_of_ram_RD,wire_of_mem_to_reg,wire_of_reg_WD3);
selectorjmp selector_jmp(pc_real_next,instr[25:0],wire_of_jump,pc_real_next_after_jump);
initial //clock 
begin 
	clk=0;
	forever 
	begin :Lable
		#1 clk=~clk;
	end
end


initial 
begin 
	pc_rst=0;
	#10
	//initialize pc 
	pc_rst=1;
	#10
	pc_rst=1;
	//enable rom and ram
	data_en=1;
	code_en=1;
	#10
	//run 
	pc_rst=0;
	$monitor("ALU result=%d",aluresult);

end


endmodule