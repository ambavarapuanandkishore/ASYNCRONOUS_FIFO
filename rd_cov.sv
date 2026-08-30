class rd_cov;
rd_tx tx;


covergroup rd_cg;
	coverpoint tx.rd_en{
		bins rd_en={1'b1};
	}
endgroup	


function new();
	rd_cg=new();
endfunction

	task run();
	
	forever begin
		fifo_common::rd_mon2cov.get(tx);
		rd_cg.sample();
		tx.print("rd_cov");
		end
	endtask


endclass 
