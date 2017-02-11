module selector5(input[4:0] in1,
				 input[4:0] in2,
				 input s,
				 output reg[4:0] out);

always@(*)
begin 
	if(s)
		out=in2;
	else 
		out=in1;
end
				 
endmodule