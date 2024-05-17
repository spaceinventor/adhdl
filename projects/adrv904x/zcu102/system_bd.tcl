###############################################################################
## Copyright (C) 2024 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

## ADC FIFO depth in samples per converter
set adc_fifo_samples_per_converter [expr 32*1024]
## DAC FIFO depth in samples per converter
set dac_fifo_samples_per_converter [expr 32*1024]

source $ad_hdl_dir/projects/common/zcu102/zcu102_system_bd.tcl
source $ad_hdl_dir/projects/scripts/adi_pd.tcl

set mem_init_sys_path [get_env_param ADI_PROJECT_DIR ""]mem_init_sys.txt;

#system ID
ad_ip_parameter axi_sysid_0 CONFIG.ROM_ADDR_BITS 9
ad_ip_parameter rom_sys_0 CONFIG.PATH_TO_FILE "[pwd]/$mem_init_sys_path"
ad_ip_parameter rom_sys_0 CONFIG.ROM_ADDR_BITS 9

sysid_gen_sys_init_file

source ../common/adrv904x_bd.tcl

ad_ip_parameter util_adrv904x_xcvr CONFIG.CPLL_CFG0 0x1fa
ad_ip_parameter util_adrv904x_xcvr CONFIG.CPLL_CFG1 0x23
ad_ip_parameter util_adrv904x_xcvr CONFIG.CPLL_CFG2 0x2
ad_ip_parameter util_adrv904x_xcvr CONFIG.CPLL_FBDIV 2
ad_ip_parameter util_adrv904x_xcvr CONFIG.A_TXDIFFCTRL 0xC
ad_ip_parameter util_adrv904x_xcvr CONFIG.RXCDR_CFG0 0x3
ad_ip_parameter util_adrv904x_xcvr CONFIG.RXCDR_CFG2_GEN2 0x269
ad_ip_parameter util_adrv904x_xcvr CONFIG.RXCDR_CFG2_GEN4 0x164
ad_ip_parameter util_adrv904x_xcvr CONFIG.RXCDR_CFG3 0x12
ad_ip_parameter util_adrv904x_xcvr CONFIG.RXCDR_CFG3_GEN2 0x12
ad_ip_parameter util_adrv904x_xcvr CONFIG.RXCDR_CFG3_GEN3 0x12
ad_ip_parameter util_adrv904x_xcvr CONFIG.RXCDR_CFG3_GEN4 0x12
ad_ip_parameter util_adrv904x_xcvr CONFIG.CH_HSPMUX 0x6868
ad_ip_parameter util_adrv904x_xcvr CONFIG.PREIQ_FREQ_BST 1
ad_ip_parameter util_adrv904x_xcvr CONFIG.RXPI_CFG0 0x4
ad_ip_parameter util_adrv904x_xcvr CONFIG.RXPI_CFG1 0x0
ad_ip_parameter util_adrv904x_xcvr CONFIG.TXPI_CFG 0x0
ad_ip_parameter util_adrv904x_xcvr CONFIG.TX_PI_BIASSET 3

ad_ip_parameter util_adrv904x_xcvr CONFIG.POR_CFG 0x0
ad_ip_parameter util_adrv904x_xcvr CONFIG.QPLL_FBDIV 33
ad_ip_parameter util_adrv904x_xcvr CONFIG.QPLL_CFG0 0x333c
ad_ip_parameter util_adrv904x_xcvr CONFIG.QPLL_CFG4 0x45
ad_ip_parameter util_adrv904x_xcvr CONFIG.PPF0_CFG 0xF00
ad_ip_parameter util_adrv904x_xcvr CONFIG.QPLL_CP 0xFF
ad_ip_parameter util_adrv904x_xcvr CONFIG.QPLL_CP_G3 0xF
ad_ip_parameter util_adrv904x_xcvr CONFIG.QPLL_LPF 0x31D

ad_ip_parameter util_adrv904x_xcvr CONFIG.RX_CLK25_DIV 20
ad_ip_parameter util_adrv904x_xcvr CONFIG.TX_CLK25_DIV 20
ad_ip_parameter util_adrv904x_xcvr CONFIG.RX_PMA_CFG 0x280A
ad_ip_parameter util_adrv904x_xcvr CONFIG.RXDFE_KH_CFG2 {0x2631} 
ad_ip_parameter util_adrv904x_xcvr CONFIG.RXDFE_KH_CFG3 {0x411C} 
ad_ip_parameter util_adrv904x_xcvr CONFIG.RX_WIDEMODE_CDR {"01"} 
ad_ip_parameter util_adrv904x_xcvr CONFIG.RX_XMODE_SEL {"0"} 
ad_ip_parameter util_adrv904x_xcvr CONFIG.TXPI_CFG0 {0x0000} 
ad_ip_parameter util_adrv904x_xcvr CONFIG.TXPI_CFG1 {0x0000} 
