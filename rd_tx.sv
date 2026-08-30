class rd_tx;
	 	rand bit rd_en;
		bit [`WIDTH-1:0]rdata;
		bit empty;
		bit underflow;

	function void print(input string str="rd_tx");
	$display("-------------%0s-----------time=%0t",str,$time);
	$display("rd=%b",rd_en);
	$display("rdata=%0d",rdata);
	$display("empty=%0d",empty);
	$display("underflow=%b",underflow);
	endfunction
	
	constraint rd_c {
		rd_en == 1'b1;
	}

endclass
