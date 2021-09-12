`define PUSH 2'b00
`define POP 2'b01
`define PUSHPREV 2'b10
`define IDLE 2'b11

module queue(clk,reset,go,cmd,r_num,ready,w_en,r_en,full,almost_full,empty,almost_empty,error,w_num,addr);
	input clk,reset,go;
	input [17:0]cmd;
	input [15:0]r_num;

	output ready;
	output w_en,r_en;
	output full,almost_full,empty,almost_empty,error;
	output [15:0]w_num;
	output [4:0]addr;

	reg [1:0]state, next_state;
	reg [5:0]count, next_count;
	reg [4:0]head, next_head;
	reg [4:0]tail, next_tail;
	reg ready, next_ready;
	reg w_en, next_w_en;
	reg r_en, next_r_en;
	reg full, next_full, almost_full, next_almost_full;
	reg empty, next_empty, almost_empty, next_almost_empty;
	reg error, next_error;
	reg [15:0]w_num, next_w_num;
	reg popped, next_popped;
	reg [4:0]addr, next_addr;
	wire [15:0]prev_pop;

	assign prev_pop = r_num;

	always@(posedge reset or posedge clk)begin
		if(reset == 1'b1)begin
			state <= `IDLE;
			count <= 6'b0;
			head <= 5'b0;
			tail <= 5'b0;
			ready <= 1'b1;
			w_en <= 1'b0;
			r_en <= 1'b0;
			full <= 1'b0;
			almost_full <= 1'b0;
			empty <= 1'b1;
			almost_empty <= 1'b0;
			error <= 0;
			w_num <= 16'b0;
			popped <= 0;
			addr <= 5'b0;
		end
		else begin
			state <= next_state;
			count <= next_count;
			head <= next_head;
			tail <= next_tail;
			ready <= next_ready;
			w_en <= next_w_en;
			r_en <= next_r_en;
			full <= next_full;
			almost_full <= next_almost_full;
			empty <= next_empty;
			almost_empty <= next_almost_empty;
			error <= next_error;
			w_num <= next_w_num;
			popped <= next_popped;
			addr <= next_addr;
		end
	end

	always@(*)begin
		next_state = state;
		next_w_en = w_en;
		next_r_en = r_en;
		next_ready = ready;
		next_count = count;
		next_head = head;
		next_tail = tail;
		next_error = error;
		next_popped = popped;
		next_addr = addr;
		case(state)
			`PUSH:begin
				next_state = `IDLE;
				next_w_en = 1'b1;
				next_r_en = 1'b0;
				next_ready = 1'b0;
				next_w_num = cmd[15:0];
				if(full == 1'b1)begin
					next_error = 1'b1;
				end
				else begin
					next_count = count + 1;
					next_error = 1'b0;
					next_addr = tail;
					
					if(tail == 5'd31)begin
						next_tail = 5'd0;
					end
					else begin
						next_tail = tail + 1;
					end
				end
			end
			`POP:begin
				next_state = `IDLE;
				next_w_en = 1'b0;
				next_r_en = 1'b1;
				next_ready = 1'b0;
				if(empty == 1'b1)begin
					next_error = 1'b1;
				end
				else begin
					next_count = count - 1;
					next_error = 1'b0;
					next_popped = 1'b1;
					next_addr = head;

					if(head == 5'd31)begin
						next_head = 5'd0;
					end
					else begin
						next_head = head + 1;
					end
				end
			end
			`PUSHPREV:begin
				next_state = `IDLE;
				next_w_en = 1'b1;
				next_r_en = 1'b0;
				next_ready = 1'b0;
				next_w_num = prev_pop;
				if(full == 1'b1 || popped == 1'b0)begin
					next_error = 1'b1;
				end
				else begin
					next_count = count + 1;
					next_error = 1'b0;
					next_addr = tail;

					if(tail == 5'd31)begin
						next_tail = 5'd0;
					end
					else begin
						next_tail = tail + 1;
					end
				end
			end
			`IDLE:begin
				next_w_en = 1'b0;
				next_r_en = 1'b0;
				if (go == 1'b1)begin
					next_ready = 1'b0;
					case(cmd[17:16])
						`PUSH:begin
							next_state = `PUSH;
						end
						`POP:begin
							next_state = `POP;
						end
						`PUSHPREV:begin
							next_state = `PUSHPREV;
						end
						`IDLE:begin
							next_state = `IDLE;
						end
					endcase
					next_error = 1'b0;
				end
				else begin
					next_state = `IDLE;
					next_ready = 1'b1;
				end
			end
		endcase
		if(next_count == 6'd32)begin
			next_full = 1'b1;
			next_almost_full = 1'b0;
			next_empty = 1'b0;
			next_almost_empty = 1'b0;
		end
		else if(next_count == 6'd31)begin
			next_full = 1'b0;
			next_almost_full = 1'b1;
			next_empty = 1'b0;
			next_almost_empty = 1'b0;
		end
		else if(next_count == 6'b1)begin
			next_full = 1'b0;
			next_almost_full = 1'b0;
			next_empty = 1'b0;
			next_almost_empty = 1'b1;
		end
		else if(next_count == 6'b0)begin
			next_full = 1'b0;
			next_almost_full = 1'b0;
			next_empty = 1'b1;
			next_almost_empty = 1'b0;
		end
		else begin
			next_full = 1'b0;
			next_almost_full = 1'b0;
			next_empty = 1'b0;
			next_almost_empty = 1'b0;
		end
	end
endmodule
