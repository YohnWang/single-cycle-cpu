module selectorjmp(input[31:0] in1,
				 input[25:0] in2,
				 input isjmp,
				 output reg[31:0] out);

always@(*)
begin 
	if(isjmp)
		out={{4{1'b0}},in2,{2{1'b0}}};
	else 
		out=in1;
end
				 
endmodule
    
	
	
	
	
	
		
		
		
		