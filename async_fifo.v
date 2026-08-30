`define WIDTH 8
`define FIFO_SIZE 16
`define PTR_WIDTH $clog2(`FIFO_SIZE)
module asyn_fifo(res,wr_clk,rd_clk,wr_en,rd_en,wdata,rdata,empty,full,underflow,overflow);
	input res,wr_clk,rd_clk,wr_en,rd_en;
	input [`WIDTH-1:0]wdata;
	output reg [`WIDTH-1:0]rdata;
	output reg empty,full,overflow,underflow;
	
	reg [`PTR_WIDTH-1:0]wr_ptr, rd_ptr, wr_ptr_rd_clk, rd_ptr_wr_clk;
	reg wr_toggle_f, rd_toggle_f, wr_toggle_f_rd_clk, rd_toggle_f_wr_clk;


	reg [`WIDTH-1:0]fifo[`FIFO_SIZE-1:0];
	integer i;

	always @(posedge wr_clk)begin
		if(res==1)begin
			rdata       =0;
			empty       =1;
			full        =0;
			overflow    =0;
			underflow   =0;
			wr_ptr      =0;
			rd_ptr      =0;
			wr_toggle_f =0;
			rd_toggle_f =0;
			wr_toggle_f_rd_clk = 0;
			rd_toggle_f_wr_clk = 0;

			for(i=0;i<`FIFO_SIZE-1;i=i+1) fifo[i]=0;
		end
		else begin
			//write
			if(wr_en==1)begin
				if(full==1)overflow=1;
				else begin
					fifo[wr_ptr] =wdata;
					if(wr_ptr==`FIFO_SIZE-1)begin
						wr_ptr=0;
						wr_toggle_f=~wr_toggle_f;
					end
					else wr_ptr=wr_ptr+1;
				end
			end
		end
	end

	always @(posedge rd_clk)begin
		if(res==0)begin
			if(rd_en==1)begin
				if(empty==1)underflow=1;
				else begin
					rdata=fifo[rd_ptr];
					if(rd_ptr==`FIFO_SIZE-1)begin
						rd_ptr=0;
						rd_toggle_f=~rd_toggle_f;
					end
					else rd_ptr=rd_ptr+1;
				end
			end	
		end
	end

	always@(posedge wr_clk)begin
		rd_ptr_wr_clk      <= rd_ptr;
		rd_toggle_f_wr_clk <= rd_toggle_f;
	end

	always @(posedge rd_clk)begin
		wr_ptr_rd_clk      <= wr_ptr;
		wr_toggle_f_rd_clk <= wr_toggle_f;
	end


	always @(*)begin
		if(wr_ptr==rd_ptr_wr_clk && wr_toggle_f!=rd_toggle_f_wr_clk)full=1;
		else full=0;
	end

	always @(*)begin
		if(rd_ptr==wr_ptr_rd_clk && rd_toggle_f == wr_toggle_f_rd_clk)empty=1;
		else empty=0;
	end
endmodule
