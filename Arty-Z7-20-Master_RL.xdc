## =============================================================================
## arty_z7_video.xdc - Video Experiment pin map
## =============================================================================
##   BTN0 -> JB3 (T11)     BTN1 -> JB4 (T10)
##   SW0  -> JA2 (Y19)     SW1  -> JA3 (Y16)
##   BTN2 -> JA4 (Y17)     BTN3 -> JA7 (U18)
##   LD0  -> JB1 (W14)     LD1  -> JB2 (Y14)
##   LD2  -> JB5 (V16)     LD3  -> JB6 (W16)
##   LD4  -> JB7 (V12)     LD5  -> JB8 (W13)
## =============================================================================

## Clock - 125 MHz onboard oscillator
set_property -dict { PACKAGE_PIN H16  IOSTANDARD LVCMOS33 } [get_ports { clk }]
create_clock -add -name sys_clk_pin -period 8.000 -waveform {0 4} [get_ports { clk }]
create_clock -period 13.468 -name dvi_clk [get_ports hdmi_rx_clk_p]

## Buttons
set_property -dict { PACKAGE_PIN T11  IOSTANDARD LVCMOS33 } [get_ports { btn[0] }]
set_property -dict { PACKAGE_PIN T10  IOSTANDARD LVCMOS33 } [get_ports { btn[1] }]
set_property -dict { PACKAGE_PIN Y17  IOSTANDARD LVCMOS33 } [get_ports { btn[2] }]
set_property -dict { PACKAGE_PIN U18  IOSTANDARD LVCMOS33 } [get_ports { btn[3] }]

## Switches
set_property -dict { PACKAGE_PIN Y19  IOSTANDARD LVCMOS33 } [get_ports { sw[0] }]
set_property -dict { PACKAGE_PIN Y16  IOSTANDARD LVCMOS33 } [get_ports { sw[1] }]

## LEDs
set_property -dict { PACKAGE_PIN W14  IOSTANDARD LVCMOS33 } [get_ports { led[0] }]
set_property -dict { PACKAGE_PIN Y14  IOSTANDARD LVCMOS33 } [get_ports { led[1] }]
set_property -dict { PACKAGE_PIN V16  IOSTANDARD LVCMOS33 } [get_ports { led[2] }]
set_property -dict { PACKAGE_PIN W16  IOSTANDARD LVCMOS33 } [get_ports { led[3] }]
set_property -dict { PACKAGE_PIN V12  IOSTANDARD LVCMOS33 } [get_ports { led[4] }]
set_property -dict { PACKAGE_PIN W13  IOSTANDARD LVCMOS33 } [get_ports { led[5] }]

## Onboard LEDs (optional) - same info as LD0-5 above, visible standing at the board
#set_property -dict { PACKAGE_PIN R14  IOSTANDARD LVCMOS33 } [get_ports { onboard_led[0] }]
#set_property -dict { PACKAGE_PIN P14  IOSTANDARD LVCMOS33 } [get_ports { onboard_led[1] }]
#set_property -dict { PACKAGE_PIN N16  IOSTANDARD LVCMOS33 } [get_ports { onboard_led[2] }]
#set_property -dict { PACKAGE_PIN M14  IOSTANDARD LVCMOS33 } [get_ports { onboard_led[3] }]
#set_property -dict { PACKAGE_PIN L15  IOSTANDARD LVCMOS33 } [get_ports { onboard_led4 }]
#set_property -dict { PACKAGE_PIN G14  IOSTANDARD LVCMOS33 } [get_ports { onboard_led5 }]

## HDMI RX Signals
#set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_cec }]; #IO_L13N_T2_MRCC_35 Sch=HDMI_RX_CEC
set_property -dict { PACKAGE_PIN P19   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_clk_n }]; #IO_L13N_T2_MRCC_34 Sch=HDMI_RX_CLK_N
set_property -dict { PACKAGE_PIN N18   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_clk_p }]; #IO_L13P_T2_MRCC_34 Sch=HDMI_RX_CLK_P
set_property -dict { PACKAGE_PIN W20   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_d_n[0] }]; #IO_L16N_T2_34 Sch=HDMI_RX_D0_N
set_property -dict { PACKAGE_PIN V20   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_d_p[0] }]; #IO_L16P_T2_34 Sch=HDMI_RX_D0_P
set_property -dict { PACKAGE_PIN U20   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_d_n[1] }]; #IO_L15N_T2_DQS_34 Sch=HDMI_RX_D1_N
set_property -dict { PACKAGE_PIN T20   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_d_p[1] }]; #IO_L15P_T2_DQS_34 Sch=HDMI_RX_D1_P
set_property -dict { PACKAGE_PIN P20   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_d_n[2] }]; #IO_L14N_T2_SRCC_34 Sch=HDMI_RX_D2_N
set_property -dict { PACKAGE_PIN N20   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_d_p[2] }]; #IO_L14P_T2_SRCC_34 Sch=HDMI_RX_D2_P
#set_property -dict { PACKAGE_PIN T19   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_hpd }]; #IO_25_34 Sch=HDMI_RX_HPD
#set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_scl }]; #IO_L11P_T1_SRCC_34 Sch=HDMI_RX_SCL
#set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_sda }]; #IO_L11N_T1_SRCC_34 Sch=HDMI_RX_SDA

## HDMI TX Signals
#set_property -dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_cec }]; #IO_L19N_T3_VREF_35 Sch=HDMI_TX_CEC
set_property -dict { PACKAGE_PIN L17   IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_clk_n }]; #IO_L11N_T1_SRCC_35 Sch=HDMI_TX_CLK_N
set_property -dict { PACKAGE_PIN L16   IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_clk_p }]; #IO_L11P_T1_SRCC_35 Sch=HDMI_TX_CLK_P
set_property -dict { PACKAGE_PIN K18   IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_d_n[0] }]; #IO_L12N_T1_MRCC_35 Sch=HDMI_TX_D0_N
set_property -dict { PACKAGE_PIN K17   IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_d_p[0] }]; #IO_L12P_T1_MRCC_35 Sch=HDMI_TX_D0_P
set_property -dict { PACKAGE_PIN J19   IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_d_n[1] }]; #IO_L10N_T1_AD11N_35 Sch=HDMI_TX_D1_N
set_property -dict { PACKAGE_PIN K19   IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_d_p[1] }]; #IO_L10P_T1_AD11P_35 Sch=HDMI_TX_D1_P
set_property -dict { PACKAGE_PIN H18   IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_d_n[2] }]; #IO_L14N_T2_AD4N_SRCC_35 Sch=HDMI_TX_D2_N
set_property -dict { PACKAGE_PIN J18   IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_d_p[2] }]; #IO_L14P_T2_AD4P_SRCC_35 Sch=HDMI_TX_D2_P
#set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_hpdn }]; #IO_0_34 Sch=HDMI_TX_HDPN
#set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_scl }]; #IO_L8P_T1_AD10P_35 Sch=HDMI_TX_SCL
#set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_sda }]; #IO_L8N_T1_AD10N_35 Sch=HDMI_TX_SDA

## Timing - buttons/switches come from off-chip, LEDs are indicators only
set_false_path -from [get_ports { btn[*] sw[*] }]
#set_false_path -to   [get_ports { led[*] onboard_led[*] onboard_led4 onboard_led5 }]

set_input_delay  -clock [get_clocks sys_clk_pin] -max 0 [get_ports { btn[*] sw[*] }]
#set_output_delay -clock [get_clocks sys_clk_pin] -max 0 [get_ports { led[*] onboard_led[*] onboard_led4 onboard_led5 }]
