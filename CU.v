module CU(input[5:0] op,
		  input[5:0] funct,
		  output reg memtoreg,
		  output reg memwrite,
		  output reg branch,
		  output reg[2:0] alucontrol,
		  output reg alusrc,
		  output reg regdst,
		  output reg regwrite,
		  output reg jump
);

always@(*)
begin 
	jump=0;
	case(op)
	6'b000000://r-type
		begin 
			{memtoreg,memwrite,branch,alusrc,regdst,regwrite}=6'b000011;
			case(funct)
			6'b100000:alucontrol=3'b010;//add
			6'b100010:alucontrol=3'b110;//sub
			6'b100100:alucontrol=3'b000;//and
			6'b100101:alucontrol=3'b001;//or
			6'b101010:alucontrol=3'b111;//stl
			endcase
		end
	6'b100011://lw
		begin 
			alucontrol=3'b010;//add
			{memtoreg,memwrite,branch,alusrc,regdst,regwrite}=6'b100101;
		end
	6'b101011://sw
		begin 
			alucontrol=3'b010;//add
			{memtoreg,memwrite,branch,alusrc,regdst,regwrite}=6'bx101x0;
		end
	6'b000100://beq
		begin 
			alucontrol=3'b110;//sub
			{memtoreg,memwrite,branch,alusrc,regdst,regwrite}=6'bx010x0;
		end
	6'b001000://addi
		begin 
			alucontrol=3'b010;//add
			{memtoreg,memwrite,branch,alusrc,regdst,regwrite}=6'b000101;
		end
	6'b000010://j
		begin 
			{memtoreg,memwrite,branch,alusrc,regdst,regwrite}=6'bx0xxx0;
			jump=1;
		end
	endcase
end


endmodule