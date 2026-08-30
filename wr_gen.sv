class wr_gen;
wr_tx tx;
	task run();
	case (fifo_common::test_name)
		"FULL":begin
			writes(`FIFO_SIZE+1);
		end
		"EMPTY":begin
			writes(`FIFO_SIZE);
		end
		"OVERFLOW":begin
			writes(`FIFO_SIZE+2);
		end
		"UNDERFLOW":begin
			writes(`FIFO_SIZE);
		end
		"CONCURRENT":begin
			writes(fifo_common::N);	
		end
		default:begin
			$display("none of the above write testcases");
		end
		endcase
	
	endtask

	task writes(input int N);
		repeat(N)begin
			fifo_common::wr_gencount=N;
			tx=new();
			assert(tx.randomize());
			fifo_common::wr_gen2bfm.put(tx);
		//	tx.print("wr_gen");
		end
	endtask
	
endclass
