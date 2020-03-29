transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/ece385git/lab4/lab4_bit {C:/ece385git/lab4/lab4_bit/Synchronizers.sv}
vlog -sv -work work +incdir+C:/ece385git/lab4/lab4_bit {C:/ece385git/lab4/lab4_bit/Router.sv}
vlog -sv -work work +incdir+C:/ece385git/lab4/lab4_bit {C:/ece385git/lab4/lab4_bit/Reg_8.sv}
vlog -sv -work work +incdir+C:/ece385git/lab4/lab4_bit {C:/ece385git/lab4/lab4_bit/HexDriver.sv}
vlog -sv -work work +incdir+C:/ece385git/lab4/lab4_bit {C:/ece385git/lab4/lab4_bit/Control.sv}
vlog -sv -work work +incdir+C:/ece385git/lab4/lab4_bit {C:/ece385git/lab4/lab4_bit/compute.sv}
vlog -sv -work work +incdir+C:/ece385git/lab4/lab4_bit {C:/ece385git/lab4/lab4_bit/Register_unit.sv}
vlog -sv -work work +incdir+C:/ece385git/lab4/lab4_bit {C:/ece385git/lab4/lab4_bit/Processor.sv}

vlog -sv -work work +incdir+C:/ece385git/lab4/lab4_bit {C:/ece385git/lab4/lab4_bit/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 1000 ns
