module RAM(input en,
		   input clk,
		   input [31:0] address,
		   input we,
		   input [31:0] wd,
		   output [31:0] rd);

reg[31:0] memory_saving[255:0];

assign rd=en?memory_saving[address]:32'hzzzzzzzz;	

always @(posedge clk or negedge clk)
begin
	if(en&&we)
		memory_saving[address]<=wd;
	else
		;
end	   

		   
endmodule
		   