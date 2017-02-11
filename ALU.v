module ALU(input wire[31:0] num_a,
		   input wire[31:0] num_b,
		   input wire[2:0]  func,
		   output reg[31:0] num_y,
		   output zero
		   );
always@(*)
begin
	case(func)
		3'b000:num_y=num_a&num_b;
		3'b001:num_y=num_a|num_b;
		3'b010:num_y=num_a+num_b;
		3'b011:num_y=num_a-num_a; //not used
		3'b100:num_y=num_a&~num_b;
		3'b101:num_y=num_a|~num_b;
		3'b110:num_y=num_a-num_b;
		3'b111:num_y=$signed(num_a)<$signed(num_b);
		default:;
	endcase
end		   

assign zero=(num_a==num_b);
		   
endmodule