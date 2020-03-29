transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/ece385git/lab4/lab4_adders {C:/ece385git/lab4/lab4_adders/ripple_adder.sv}
vlog -sv -work work +incdir+C:/ece385git/lab4/lab4_adders {C:/ece385git/lab4/lab4_adders/hexdriver.sv}
vlog -sv -work work +incdir+C:/ece385git/lab4/lab4_adders {C:/ece385git/lab4/lab4_adders/lab4_adders_toplevel.sv}

