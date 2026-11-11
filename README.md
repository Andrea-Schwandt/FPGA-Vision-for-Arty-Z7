# FPGA-Vision-for-Arty-Z7
This repository is based on Marco Winzker's FPGA Vision and FPGA FIR Filter repositories (https://github.com/Marco-Winzker)

## Instructions:

To setup a project for the lane detection or FIR filter, please follow these steps:
1. install the board files from digilent (see https://digilent.com/reference/programmable-logic/guides/vitis-unified-installation for instructions)
2. download and implement the ip-cores from digilent (https://github.com/Digilent/vivado-library)
3. download the files from this repository and unpack them
4. setup a project for the lane detection and/or one for the FIR filter
5. add the corresponding VHDL files to your project
6. add the Arty-Z7-20-Master_RL.xdc from this repository (root) to your constraints
7. go to the tcl console in Vivado, go into the "FPGA-Vision-for-Arty-Z7-main" directory with *cd "x:/your_path/FPGA-Vision-for-Arty-Z7-main"* and execute
   * *source ../scripts/ip/clk_wiz_0.tcl*
   * *source ../scripts/ip/dvi2rgb_0.tcl*
   * *source ../scripts/ip/rgb2dvi_0.tcl*
  
   * and for the lane detection you need to execute *source ../scripts/ip/blk_mem_gen_0.tcl* as well
8. check, if all dependencies are resolved and run synthesis, implementation and generate bitfile. You will find you bitstream under "X:\your_project_directory\lane\lane.runs\impl_1\FPGA_Vision_arty_z7.bit"
9. go to https://fpga-vision-test-lab.h-brs.de/, register or, if already registered, sign in and access the video experiment from the Arty Z7 lab, upload your bitfile and test it with real hardware!
