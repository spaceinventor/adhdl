###############################################################################
## Copyright (C) 2021-2024 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

create_bd_port -dir O -from 15 -to 0 pwm_out
# create_bd_port -dir O pwm_out_1
# create_bd_port -dir O pwm_out_2
# create_bd_port -dir O pwm_out_3
# create_bd_port -dir O pwm_out_4
# create_bd_port -dir O pwm_out_5
# create_bd_port -dir O pwm_out_6
# create_bd_port -dir O pwm_out_7
# create_bd_port -dir O pwm_out_8
# create_bd_port -dir O pwm_out_9
# create_bd_port -dir O pwm_out_10
# create_bd_port -dir O pwm_out_11
# create_bd_port -dir O pwm_out_12
# create_bd_port -dir O pwm_out_13
# create_bd_port -dir O pwm_out_14
# create_bd_port -dir O pwm_out_15


ad_ip_instance axi_clkgen clkgen
ad_ip_parameter clkgen CONFIG.CLK0_DIV 5
ad_ip_parameter clkgen CONFIG.VCO_DIV 1
ad_ip_parameter clkgen CONFIG.VCO_MUL 8

ad_ip_instance axi_pwm_gen pwm
ad_ip_parameter pwm CONFIG.N_PWMS 16

ad_ip_instance xlconcat pwm_concat
ad_ip_parameter pwm_concat CONFIG.NUM_PORTS 16


ad_connect $sys_cpu_clk clkgen/clk
ad_connect pl_clk clkgen/clk_0

ad_connect pl_clk pwm/ext_clk
ad_connect $sys_cpu_clk pwm/s_axi_aclk
ad_connect sys_cpu_resetn pwm/s_axi_aresetn

# external pwm connections
ad_connect pwm/pwm_0    pwm_concat/In0
ad_connect pwm/pwm_1    pwm_concat/In1
ad_connect pwm/pwm_2    pwm_concat/In2
ad_connect pwm/pwm_3    pwm_concat/In3
ad_connect pwm/pwm_4    pwm_concat/In4
ad_connect pwm/pwm_5    pwm_concat/In5
ad_connect pwm/pwm_6    pwm_concat/In6
ad_connect pwm/pwm_7    pwm_concat/In7
ad_connect pwm/pwm_8    pwm_concat/In8
ad_connect pwm/pwm_9    pwm_concat/In9
ad_connect pwm/pwm_10   pwm_concat/In10
ad_connect pwm/pwm_11   pwm_concat/In11
ad_connect pwm/pwm_12   pwm_concat/In12
ad_connect pwm/pwm_13   pwm_concat/In13
ad_connect pwm/pwm_14   pwm_concat/In14
ad_connect pwm/pwm_15   pwm_concat/In15

ad_connect pwm_concat/dout pwm_out

ad_cpu_interconnect 0x44a70000 clkgen
ad_cpu_interconnect 0x44b00000 pwm
