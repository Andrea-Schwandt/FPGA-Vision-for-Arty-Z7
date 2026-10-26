##################################################################
# CHECK VIVADO VERSION
##################################################################

set scripts_vivado_version 2026.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
  catch {common::send_msg_id "IPS_TCL-100" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_ip_tcl to create an updated script."}
  return 1
}

##################################################################
# START
##################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source all_FPGA_Vision_ips_sharp.tcl
# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
  create_project sharp sharp -part xc7z020clg400-1
  set_property BOARD_PART digilentinc.com:arty-z7-20:part0:1.1 [current_project]
  set_property target_language VHDL [current_project]
  set_property simulator_language Mixed [current_project]
}

##################################################################
# CHECK IPs
##################################################################

set bCheckIPs 1
set bCheckIPsPassed 1
if { $bCheckIPs == 1 } {
  set list_check_ips { xilinx.com:ip:clk_wiz:6.0 digilentinc.com:ip:dvi2rgb:2.0 digilentinc.com:ip:rgb2dvi:1.4 }
  set list_ips_missing ""
  common::send_msg_id "IPS_TCL-1001" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

  foreach ip_vlnv $list_check_ips {
  set ip_obj [get_ipdefs -all $ip_vlnv]
  if { $ip_obj eq "" } {
    lappend list_ips_missing $ip_vlnv
    }
  }

  if { $list_ips_missing ne "" } {
    catch {common::send_msg_id "IPS_TCL-105" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
    set bCheckIPsPassed 0
  }
}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "IPS_TCL-102" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 1
}

##################################################################
# CREATE IP clk_wiz_0
##################################################################

set clk_wiz_0 [create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name clk_wiz_0]

# User Parameters
set_property -dict [list \
  CONFIG.CLKIN1_JITTER_PS {80.0} \
  CONFIG.CLKOUT1_DRIVES {BUFG} \
  CONFIG.CLKOUT1_JITTER {109.241} \
  CONFIG.CLKOUT1_PHASE_ERROR {96.948} \
  CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {200.000} \
  CONFIG.CLKOUT2_DRIVES {BUFG} \
  CONFIG.CLKOUT3_DRIVES {BUFG} \
  CONFIG.CLKOUT4_DRIVES {BUFG} \
  CONFIG.CLKOUT5_DRIVES {BUFG} \
  CONFIG.CLKOUT6_DRIVES {BUFG} \
  CONFIG.CLKOUT7_DRIVES {BUFG} \
  CONFIG.MMCM_BANDWIDTH {OPTIMIZED} \
  CONFIG.MMCM_CLKFBOUT_MULT_F {8} \
  CONFIG.MMCM_CLKIN1_PERIOD {8.000} \
  CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
  CONFIG.MMCM_CLKOUT0_DIVIDE_F {5} \
  CONFIG.MMCM_COMPENSATION {ZHOLD} \
  CONFIG.MMCM_DIVCLK_DIVIDE {1} \
  CONFIG.PLL_CLKIN_PERIOD {8.000} \
  CONFIG.PRIMITIVE {PLL} \
  CONFIG.PRIM_IN_FREQ {125.000} \
  CONFIG.USE_RESET {false} \
] [get_ips clk_wiz_0]

# Runtime Parameters
set_property -dict { 
  GENERATE_SYNTH_CHECKPOINT {1}
} $clk_wiz_0

##################################################################

##################################################################
# CREATE IP dvi2rgb_0
##################################################################

set dvi2rgb_0 [create_ip -name dvi2rgb -vendor digilentinc.com -library ip -version 2.0 -module_name dvi2rgb_0]

# User Parameters
set_property -dict [list \
  CONFIG.kClkRange {3} \
  CONFIG.kEmulateDDC {false} \
] [get_ips dvi2rgb_0]

# Runtime Parameters
set_property -dict { 
  GENERATE_SYNTH_CHECKPOINT {1}
} $dvi2rgb_0

##################################################################

##################################################################
# CREATE IP rgb2dvi_0
##################################################################

set rgb2dvi_0 [create_ip -name rgb2dvi -vendor digilentinc.com -library ip -version 1.4 -module_name rgb2dvi_0]

# User Parameters
set_property CONFIG.kClkRange {3} [get_ips rgb2dvi_0]

# Runtime Parameters
set_property -dict { 
  GENERATE_SYNTH_CHECKPOINT {1}
} $rgb2dvi_0

##################################################################

