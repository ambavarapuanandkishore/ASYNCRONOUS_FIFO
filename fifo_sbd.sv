class fifo_sbd;
	wr_tx w_t;
	rd_tx r_t;
	int que[$];
	int data;
	task wr_run();
		forever begin
			fifo_common::wr_mon2sbd.get(w_t);

			if(w_t.wr_en==1)que.push_back(w_t.wdata);
		end
	endtask

	task rd_run();
		forever begin
			fifo_common::rd_mon2sbd.get(r_t);
			if(r_t.rd_en==1)begin
				if(que.size()!=0)begin
					data=que.pop_front();
					if(r_t.rdata==data)fifo_common::matchings++;
					else fifo_common::mismatchings++;
				end
			end
		end
	endtask
endclass
