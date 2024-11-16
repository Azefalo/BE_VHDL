# Clock signal
set_property -dict { PACKAGE_PIN W5  IOSTANDARD LVCMOS33 } [get_ports CLK100MHZ]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK100MHZ]

# Switches
set_property -dict { PACKAGE_PIN V17  IOSTANDARD LVCMOS33 } [get_ports B[0]]
set_property -dict { PACKAGE_PIN V16  IOSTANDARD LVCMOS33 } [get_ports B[1]]
set_property -dict { PACKAGE_PIN W16  IOSTANDARD LVCMOS33 } [get_ports B[2]]
set_property -dict { PACKAGE_PIN W17  IOSTANDARD LVCMOS33 } [get_ports B[3]]
set_property -dict { PACKAGE_PIN W15  IOSTANDARD LVCMOS33 } [get_ports B[4]]
set_property -dict { PACKAGE_PIN V15  IOSTANDARD LVCMOS33 } [get_ports B[5]]
set_property -dict { PACKAGE_PIN W14  IOSTANDARD LVCMOS33 } [get_ports B[6]]
set_property -dict { PACKAGE_PIN W13  IOSTANDARD LVCMOS33 } [get_ports B[7]]

set_property -dict { PACKAGE_PIN V2  IOSTANDARD LVCMOS33 } [get_ports A[0]]
set_property -dict { PACKAGE_PIN T3  IOSTANDARD LVCMOS33 } [get_ports A[1]]
set_property -dict { PACKAGE_PIN T2  IOSTANDARD LVCMOS33 } [get_ports A[2]]
set_property -dict { PACKAGE_PIN R3  IOSTANDARD LVCMOS33 } [get_ports A[3]]
set_property -dict { PACKAGE_PIN W2  IOSTANDARD LVCMOS33 } [get_ports A[4]]
set_property -dict { PACKAGE_PIN U1  IOSTANDARD LVCMOS33 } [get_ports A[5]]
set_property -dict { PACKAGE_PIN T1  IOSTANDARD LVCMOS33 } [get_ports A[6]]
set_property -dict { PACKAGE_PIN R2  IOSTANDARD LVCMOS33 } [get_ports A[7]]

# LEDs
set_property -dict { PACKAGE_PIN U16  IOSTANDARD LVCMOS33 } [get_ports res[0]]
set_property -dict { PACKAGE_PIN E19  IOSTANDARD LVCMOS33 } [get_ports res[1]]
set_property -dict { PACKAGE_PIN U19  IOSTANDARD LVCMOS33 } [get_ports res[2]]
set_property -dict { PACKAGE_PIN V19  IOSTANDARD LVCMOS33 } [get_ports res[3]]
set_property -dict { PACKAGE_PIN W18  IOSTANDARD LVCMOS33 } [get_ports res[4]]
set_property -dict { PACKAGE_PIN U15  IOSTANDARD LVCMOS33 } [get_ports res[5]]
set_property -dict { PACKAGE_PIN U14  IOSTANDARD LVCMOS33 } [get_ports res[6]]
set_property -dict { PACKAGE_PIN V14  IOSTANDARD LVCMOS33 } [get_ports res[7]]
set_property -dict { PACKAGE_PIN V13  IOSTANDARD LVCMOS33 } [get_ports res[8]]
set_property -dict { PACKAGE_PIN V3   IOSTANDARD LVCMOS33 } [get_ports res[9]]
set_property -dict { PACKAGE_PIN W3   IOSTANDARD LVCMOS33 } [get_ports res[10]]
set_property -dict { PACKAGE_PIN U3   IOSTANDARD LVCMOS33 } [get_ports res[11]]
set_property -dict { PACKAGE_PIN P3   IOSTANDARD LVCMOS33 } [get_ports res[12]]
set_property -dict { PACKAGE_PIN N3   IOSTANDARD LVCMOS33 } [get_ports res[13]]
set_property -dict { PACKAGE_PIN P1   IOSTANDARD LVCMOS33 } [get_ports res[14]]
set_property -dict { PACKAGE_PIN L1   IOSTANDARD LVCMOS33 } [get_ports res[15]]

# Control signals
set_property -dict { PACKAGE_PIN U18  IOSTANDARD LVCMOS33 } [get_ports Ctrl_Alu[1]]
set_property -dict { PACKAGE_PIN W19  IOSTANDARD LVCMOS33 } [get_ports Ctrl_Alu[2]]
set_property -dict { PACKAGE_PIN U17  IOSTANDARD LVCMOS33 } [get_ports Ctrl_Alu[0]]

# Pmod Header JA
# Uncomment as needed
# set_property -dict { PACKAGE_PIN J1  IOSTANDARD LVCMOS33 } [get_ports JA[0]]
# set_property -dict { PACKAGE_PIN L2  IOSTANDARD LVCMOS33 } [get_ports JA[1]]
# ... continue for other JA pins

# Pmod Header JB
# Uncomment as needed
# set_property -dict { PACKAGE_PIN A14  IOSTANDARD LVCMOS33 } [get_ports JB[0]]
# set_property -dict { PACKAGE_PIN A16  IOSTANDARD LVCMOS33 } [get_ports JB[1]]
# ... continue for other JB pins

# Pmod Header JC
# Uncomment as needed
# set_property -dict { PACKAGE_PIN K17  IOSTANDARD LVCMOS33 } [get_ports JC[0]]
# set_property -dict { PACKAGE_PIN M18  IOSTANDARD LVCMOS33 } [get_ports JC[1]]
# ... continue for other JC pins

# Pmod Header JXADC
set_property -dict { PACKAGE_PIN J3  IOSTANDARD LVCMOS33 } [get_ports vauxp6]
set_property -dict { PACKAGE_PIN L3  IOSTANDARD LVCMOS33 } [get_ports vauxp14]
set_property -dict { PACKAGE_PIN M2  IOSTANDARD LVCMOS33 } [get_ports vauxp7]
set_property -dict { PACKAGE_PIN N2  IOSTANDARD LVCMOS33 } [get_ports vauxp15]
set_property -dict { PACKAGE_PIN K3  IOSTANDARD LVCMOS33 } [get_ports vauxn6]
set_property -dict { PACKAGE_PIN M3  IOSTANDARD LVCMOS33 } [get_ports vauxn14]
set_property -dict { PACKAGE_PIN M1  IOSTANDARD LVCMOS33 } [get_ports vauxn7]
set_property -dict { PACKAGE_PIN N1  IOSTANDARD LVCMOS33 } [get_ports vauxn15]
