
# ad40xx_fmc SPI interface

set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS25 IOB TRUE} [get_ports ad40xx_spi_sdo]       ; ## H07  FMC_LPC_LA02_P
set_property -dict {PACKAGE_PIN N19 IOSTANDARD LVCMOS25 IOB TRUE} [get_ports ad40xx_spi_sdi]       ; ## D08  FMC_LPC_LA01_CC_P
set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVCMOS25 IOB TRUE} [get_ports ad40xx_spi_sclk]      ; ## G06  FMC_LPC_LA00_CC_P
set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVCMOS25 IOB TRUE} [get_ports ad40xx_spi_cs]        ; ## G07  FMC_LPC_LA00_CC_N

set_property -dict {PACKAGE_PIN P22 IOSTANDARD LVCMOS25} [get_ports ad40xx_amp_pd]                 ; ## G10  FMC_LPC_LA03_N
set_property -dict {PACKAGE_PIN N20 IOSTANDARD LVCMOS25} [get_ports ad7944_turbo]                  ; ## D09  FMC_LA01_CC_N



# NOTE: clk_fpga_0 is the first PL fabric clock, also called $sys_cpu_clk

create_generated_clock -name spi_clk -source [get_pins -filter name=~*CLKIN1 -of [get_cells -hier -filter name=~*spi_clkgen*i_mmcm]] -master_clock clk_fpga_0 [get_pins -filter name=~*CLKOUT0 -of [get_cells -hier -filter name=~*spi_clkgen*i_mmcm]]

## There is a multi-cycle path between the axi_spi_engine's SDO_FIFO and the
# execution's shift register, because we load new data into the shift register
# in every DATA_WIDTH's x 8 cycle. (worst case scenario)
# Set a multi-cycle delay of 8 spi_clk cycle, slightly over constraining the path.

set_multicycle_path -setup 8 -to [get_cells -hierarchical -filter {NAME=~*/data_sdo_shift_reg[*]}] -from [get_clocks spi_clk]
set_multicycle_path -hold  7 -to [get_cells -hierarchical -filter {NAME=~*/data_sdo_shift_reg[*]}] -from [get_clocks spi_clk]

set_multicycle_path -setup 8 -to [get_cells -hierarchical -filter {NAME=~*/execution/inst/left_aligned_reg*}] -from [get_clocks spi_clk]
set_multicycle_path -hold  7 -to [get_cells -hierarchical -filter {NAME=~*/execution/inst/left_aligned_reg*}] -from [get_clocks spi_clk]

# ad7944 constraints, assuming 3.3v 
# pcb delays assume max 10cm of traces @er_eff of about 3 -> ~0.6ns
set max_pulsar_clk_freq 80; # actually ad7944 does more than 111MHz, but this is not achievable in the current project
set spi_clk_freq 160
set min_pulsar_div [expr $spi_clk_freq / $max_pulsar_clk_freq]
set edge_list [list $min_pulsar_div [expr 2*$min_pulsar_div] [expr 3*$min_pulsar_div]]
create_generated_clock -name sclk -edges $edge_list -source [get_pins -filter name=~*CLKOUT0 -of [get_cells -hier -filter name=~*spi_clkgen*i_mmcm]] [get_pins -filter name=~*sclk -of [get_cells -hier -filter name=~*spi_pulsar_adc*pulsar_adc_execution]]
set fwd_sclk sclk

set_multicycle_path $min_pulsar_div -setup -start -from [get_clocks spi_clk] -to [get_clocks $fwd_sclk]
set_multicycle_path [expr $min_pulsar_div-1] -hold -from [get_clocks spi_clk] -to [get_clocks $fwd_sclk]

set_multicycle_path $min_pulsar_div -setup -from [get_clocks $fwd_sclk] -to [get_clocks spi_clk]
set_multicycle_path [expr $min_pulsar_div-1] -hold -end -from [get_clocks $fwd_sclk] -to [get_clocks spi_clk]

# tpd 137.4146 141.6582  145.5966 ps/in 149.1836 ps/in
set max_pcb_fpga_to_pulsar_sclk_delay 0.6
set min_pcb_fpga_to_pulsar_sclk_delay 0

set max_pulsar_sdo_fpga_sdi_tco 4; #7944 
set min_pulsar_sdo_fpga_sdi_tco 2; #7944
set max_pcb_pulsar_sdo_to_fpga_sdi_delay 0.6
set min_pcb_pulsar_sdo_to_fpga_sdi_delay 0

set max_pulsar_sdi_setup 2; #7944
set max_pulsar_sdi_hold 3; #7944
set max_pcb_fpga_sdo_to_pulsar_sdi_delay 0.6

# set max_pulsar_cs_setup FIXME
# set max_pulsar_cs_hold FIXME
# set max_pcb_fpga_to_pulsar_cs_delay FIXME

set_input_delay  -clock [get_clocks $fwd_sclk] -clock_fall -min [expr $min_pcb_pulsar_sdo_to_fpga_sdi_delay +$min_pulsar_sdo_fpga_sdi_tco + $min_pcb_fpga_to_pulsar_sclk_delay]  [get_ports ad40xx_spi_sdi]
set_input_delay  -clock [get_clocks $fwd_sclk] -clock_fall -max [expr $max_pcb_pulsar_sdo_to_fpga_sdi_delay +$max_pulsar_sdo_fpga_sdi_tco + $max_pcb_fpga_to_pulsar_sclk_delay]  [get_ports ad40xx_spi_sdi]
set_output_delay -clock [get_clocks $fwd_sclk] -clock_fall -min [expr $max_pcb_fpga_sdo_to_pulsar_sdi_delay - $max_pulsar_sdi_hold - $max_pcb_fpga_to_pulsar_sclk_delay]        [get_ports ad40xx_spi_sdo]
set_output_delay -clock [get_clocks $fwd_sclk] -clock_fall -max [expr $max_pulsar_sdi_setup + $max_pcb_fpga_sdo_to_pulsar_sdi_delay-$min_pcb_fpga_to_pulsar_sclk_delay]          [get_ports ad40xx_spi_sdo]
# set_output_delay -clock $fwd_sclk -min [expr 0 -($max_pulsar_cs_hold+$max_pcb_fpga_to_pulsar_cs_delay-$min_pcb_fpga_to_pulsar_sclk_delay)] [get_ports ad40xx_spi_cs]
# set_output_delay -clock $fwd_sclk -max [$max_pulsar_cs_setup + $max_pcb_fpga_to_pulsar_cs_delay-$min_pcb_fpga_to_pulsar_sclk_delay]        [get_ports ad40xx_spi_cs]