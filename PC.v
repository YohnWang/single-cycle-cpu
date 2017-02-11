module PC(input rst,
		  input clk,
		  output reg[31:0] counter,
		  input[31:0] pc_next
		  );

always@(posedge clk or posedge rst)
begin 
	if(rst)
		counter<=0;
	else 
		counter<=pc_next;
end
endmodule