interface fifo_intrf(input reg wr_clk,rd_clk,res);
	bit wr_en,rd_en;
	bit[`WIDTH-1:0]wdata,rdata;
	bit full,overflow,empty,underflow;
	
	clocking wr_bfm_cb @(posedge wr_clk);
		default input #0 output #1;
		input full,overflow;
		output wr_en,wdata;
	endclocking 


	clocking rd_bfm_cb @(posedge rd_clk);
		default input #0 output #1;
		input  empty,underflow,rdata;
		output rd_en;
	endclocking
	clocking wr_mon_cb @(posedge wr_clk);
		default input #1;
		input wr_en,wdata,full,overflow;
	endclocking
	clocking rd_mon_cb @(posedge rd_clk);
		default input #1;
		input rd_en,rdata,empty,underflow;
	endclocking
endinterface
