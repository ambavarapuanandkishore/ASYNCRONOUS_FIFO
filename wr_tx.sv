class wr_tx;
	rand bit wr_en;
	rand bit [`WIDTH-1:0]wdata;
		bit full;
		bit overflow;

	function void print(input string str="wr_tx");
	$display("-------------%0s----------time=%0t",str,$time);
	$display("wr=%b",wr_en);
	$display("wdata=%0d",wdata);
	$display("full=%b",full);
	$display("overflow=%b",overflow);
	endfunction
	
	constraint wr_c{
		wr_en==1'b1;
	}
endclass
