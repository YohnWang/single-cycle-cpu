module register(input clk,
				input [4:0] A1,
				input [4:0] A2,
				input [4:0] A3,
				output [31:0] RD1,
				output [31:0] RD2,
				input WE3,
				input [31:0] WD3
				);
				
reg[31:0] reg_saving[31:0];

assign RD1=A1?reg_saving[A1]:0;
assign RD2=A2?reg_saving[A2]:0;

always @(posedge clk)
begin 
	if(WE3)
		reg_saving[A3]<=WD3;
	else 
		;
end

endmodule