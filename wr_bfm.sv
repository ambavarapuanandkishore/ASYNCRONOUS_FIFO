class wr_bfm;
wr_tx tx;

virtual fifo_intrf vif;
	task run();
	//	$display("write bfm is happened");
	vif=tb.pif;

	forever begin
		fifo_common::wr_gen2bfm.get(tx);
		drive_tx(tx);
	//	tx.print("wr_bfm");
		fifo_common::wr_bfmcount++;
	end
	endtask

	task drive_tx(wr_tx tx);
		@(vif.wr_bfm_cb);
		vif.wr_bfm_cb.wr_en <=  tx.wr_en;
		vif.wr_bfm_cb.wdata <=  tx.wdata;
		tx.full				 =  vif.wr_bfm_cb.full;
		tx.overflow 		 = 	vif.wr_bfm_cb.overflow;

	@(vif.wr_bfm_cb);
	vif.wr_bfm_cb.wr_en <= 0;
	vif.wr_bfm_cb.wdata <= 0;
	endtask
endclass
