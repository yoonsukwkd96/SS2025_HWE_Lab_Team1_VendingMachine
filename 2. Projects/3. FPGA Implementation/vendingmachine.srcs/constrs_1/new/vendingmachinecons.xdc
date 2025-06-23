# Clock input (used for digit switching)
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports { clk }];
create_clock -add -name sys_clk_pin -period 20.00 -waveform {0 10} [get_ports {clk}];
# reset
set_property PACKAGE_PIN V10 [get_ports {reset}]
set_property IOSTANDARD LVCMOS33 [get_ports {reset}]
# buttons
set_property PACKAGE_PIN N17 [get_ports {BTNC}]
set_property IOSTANDARD LVCMOS33 [get_ports {BTNC}]
set_property PACKAGE_PIN M18 [get_ports {BTNU}]
set_property IOSTANDARD LVCMOS33 [get_ports {BTNU}]
set_property PACKAGE_PIN P17 [get_ports {BTNL}]
set_property IOSTANDARD LVCMOS33 [get_ports {BTNL}]
set_property PACKAGE_PIN M17 [get_ports {BTNR}]
set_property IOSTANDARD LVCMOS33 [get_ports {BTNR}]
set_property PACKAGE_PIN P18 [get_ports {BTND}]
set_property IOSTANDARD LVCMOS33 [get_ports {BTND}]
# sw
set_property PACKAGE_PIN J15 [get_ports {SW[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[0]}]
set_property PACKAGE_PIN L16 [get_ports {SW[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[1]}]
set_property PACKAGE_PIN M13 [get_ports {SW[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[2]}]
# LED 
set_property PACKAGE_PIN V11 [get_ports {LED[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[0]}]
set_property PACKAGE_PIN V12 [get_ports {LED[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[1]}]
set_property PACKAGE_PIN V14 [get_ports {LED[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[2]}]
set_property PACKAGE_PIN V15 [get_ports {LED[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[3]}]
# 7  SEG[6:0]
# 7 段数码管段选 SEG[6:0]
set_property PACKAGE_PIN L18 [get_ports {SEG[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[0]}]
set_property PACKAGE_PIN T11 [get_ports {SEG[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[1]}]
set_property PACKAGE_PIN P15 [get_ports {SEG[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[2]}]
set_property PACKAGE_PIN K13 [get_ports {SEG[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[3]}]
set_property PACKAGE_PIN K16 [get_ports {SEG[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[4]}]
set_property PACKAGE_PIN R10 [get_ports {SEG[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[5]}]
set_property PACKAGE_PIN T10 [get_ports {SEG[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEG[6]}]
# Anode control 
set_property -dict { PACKAGE_PIN J17 IOSTANDARD LVCMOS33 } [get_ports { AN[7] }];  
set_property -dict { PACKAGE_PIN J18 IOSTANDARD LVCMOS33 } [get_ports { AN[6] }]; 
set_property -dict { PACKAGE_PIN T9  IOSTANDARD LVCMOS33 } [get_ports { AN[5] }];  
set_property -dict { PACKAGE_PIN J14 IOSTANDARD LVCMOS33 } [get_ports { AN[4] }];
set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports { AN[3] }];
set_property -dict { PACKAGE_PIN T14 IOSTANDARD LVCMOS33 } [get_ports { AN[2] }];
set_property -dict { PACKAGE_PIN K2  IOSTANDARD LVCMOS33 } [get_ports { AN[1] }];
set_property -dict { PACKAGE_PIN U13 IOSTANDARD LVCMOS33 } [get_ports { AN[0] }];
#  dp
set_property PACKAGE_PIN H15 [get_ports {dp}]
set_property IOSTANDARD LVCMOS33 [get_ports {dp}]