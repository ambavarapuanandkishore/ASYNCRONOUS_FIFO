class fifo_env;
	wr_agent wagent;
	rd_agent ragent;
	fifo_sbd sbd;
	task run();
	//	$display("fifo_env is happened");
			wagent=new();
			ragent=new();
			sbd=new();
		fork
			wagent.run();
			ragent.run();
			sbd.wr_run();
			sbd.rd_run();

		join
	endtask

endclass
