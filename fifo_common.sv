`define WIDTH 8
`define FIFO_SIZE 16
`define PTR_WIDTH $clog2(`FIFO_SIZE)
class fifo_common;
	static int N;
	static string test_name;
	static mailbox wr_gen2bfm=new();
	static mailbox rd_gen2bfm=new();
	static int wr_gencount;
	static int wr_bfmcount;
	static mailbox wr_mon2cov=new();
	static mailbox rd_mon2cov=new();
	static mailbox wr_mon2sbd=new();
	static mailbox rd_mon2sbd=new();
	static int matchings;
	static int mismatchings;
endclass
