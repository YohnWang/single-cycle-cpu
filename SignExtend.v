module SignExtend(input[15:0] in,
				  output reg[31:0] out);

always@(*)
begin 
	out=$signed(in);
end
				  
endmodule