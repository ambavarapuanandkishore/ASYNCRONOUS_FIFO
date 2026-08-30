vlog list.svh
vopt tb +cover=fcbest -o wrong_tc
vsim -coverage wrong_tc +test_name=wrong_tc; 
do exclusion.do
coverage save -onexit wrong_tc.ucdb
add wave -r sim:/tb/pif/*
run -all

