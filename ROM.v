module ROM(input [31:0] address,
           output [31:0] value,
		   input cs);

reg[31:0] memory_saving[1023:0];

initial
begin
    $readmemh("code.txt",memory_saving);
end

assign value=cs?memory_saving[address>>2]:32'hzzzzzzzz;

endmodule
