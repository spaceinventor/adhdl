###############################################################################
## Copyright (C) 2021-2023 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

## Pmod Header JA
set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33   IOB TRUE } [get_ports { pwm_out[0] }]; #IO_L17P_T2_34 Sch=ja_p[1]
set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33   IOB TRUE } [get_ports { pwm_out[1] }]; #IO_L17N_T2_34 Sch=ja_n[1]
set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33   IOB TRUE } [get_ports { pwm_out[2] }]; #IO_L7P_T1_34 Sch=ja_p[2]
set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33   IOB TRUE } [get_ports { pwm_out[3] }]; #IO_L7N_T1_34 Sch=ja_n[2]
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33   IOB TRUE } [get_ports { pwm_out[4] }]; #IO_L12P_T1_MRCC_34 Sch=ja_p[3]
set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33   IOB TRUE } [get_ports { pwm_out[5] }]; #IO_L12N_T1_MRCC_34 Sch=ja_n[3]
set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33   IOB TRUE } [get_ports { pwm_out[6] }]; #IO_L22P_T3_34 Sch=ja_p[4]
set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33   IOB TRUE } [get_ports { pwm_out[7] }]; #IO_L22N_T3_34 Sch=ja_n[4]

# Pmod Header JB
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33   IOB TRUE } [get_ports { pwm_out[8] }]; #IO_L8P_T1_34 Sch=jb_p[1]
set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS33   IOB TRUE } [get_ports { pwm_out[9] }]; #IO_L8N_T1_34 Sch=jb_n[1]
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33   IOB TRUE } [get_ports { pwm_out[10] }]; #IO_L1P_T0_34 Sch=jb_p[2]
set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33   IOB TRUE } [get_ports { pwm_out[11] }]; #IO_L1N_T0_34 Sch=jb_n[2]
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33   IOB TRUE } [get_ports { pwm_out[12] }]; #IO_L18P_T2_34 Sch=jb_p[3]
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33   IOB TRUE } [get_ports { pwm_out[13] }]; #IO_L18N_T2_34 Sch=jb_n[3]
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33   IOB TRUE } [get_ports { pwm_out[14] }]; #IO_L4P_T0_34 Sch=jb_p[4]
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33   IOB TRUE } [get_ports { pwm_out[15] }]; #IO_L4N_T0_34 Sch=jb_n[4]

