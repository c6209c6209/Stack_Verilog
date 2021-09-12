module queue(clk,reset,go,cmd,r_num,ready,w_en,r_en,full,almost_full,empty,almost_empty,error,w_num,addr);
	input clk,reset,go;
	input [17:0]cmd;
	input [15:0]r_num;

	output ready;
	output w_en,r_en;
	output full,almost_full,empty,almost_empty,error;
	output [15:0]w_num;
	output [4:0]addr;

endmodule
