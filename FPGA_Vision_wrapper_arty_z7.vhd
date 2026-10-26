----------------------------------------------------------------------------------
-- Company: Hochschule Bonn-Rhein-Sieg
-- Engineer: Andrea Schwandt
-- 
-- Create Date: 26.08.2026 10:00:00
-- Design Name: 
-- Module Name: FPGA_Vision_arty_z7 - Shell
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 1.0 - File tested
-- Additional Comments:
-- FPGA Vision Remote Lab http://h-brs.de/fpga-vision-lab
-- FPGA Vision Course VHDL files of Marco Winzker adapted to nexys a7 by Andrea Schwandt
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned architecture
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FPGA_Vision_arty_z7 is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (3 downto 0);
           sw : in STD_LOGIC_VECTOR (1 downto 0);
           hdmi_tx_clk_n : out STD_LOGIC;
           hdmi_tx_clk_p : out STD_LOGIC;
           hdmi_tx_d_n : out STD_LOGIC_VECTOR (2 downto 0);
           hdmi_tx_d_p : out STD_LOGIC_VECTOR (2 downto 0);
           hdmi_rx_clk_n : in STD_LOGIC;
           hdmi_rx_clk_p : in STD_LOGIC;
           hdmi_rx_d_n : in STD_LOGIC_VECTOR (2 downto 0);
           hdmi_rx_d_p : in STD_LOGIC_VECTOR (2 downto 0)
          );
end FPGA_Vision_arty_z7;

architecture shell of FPGA_Vision_arty_z7 is

signal clk_75           : std_logic := '0';
signal clk_200          : std_logic := '0';
signal pll_locked       : std_logic;   -- Clocking-Wizard gesperrt
signal reset, reset_n   : std_logic;
signal enable           : std_logic_vector(2 downto 0);
signal rst_pixel_sync   : std_logic_vector(3 downto 0) := (others => '1');
signal rst_pixel        : std_logic;   -- Mit Pixeltakt synchronisierter Reset
signal rbg_in           : std_logic_vector(23 downto 0);
signal de_0, de_1, hs_0, hs_1, vs_0, vs_1   : std_logic;
signal r, r_0, g, g_0,  b, b_0              : std_logic_vector(7 downto 0);

-- Lock-Status des dvi2rgb
signal rx_locked, pLocked      : std_logic;
  
begin

reset_n <= not BTN(0);
reset <= BTN(0);
enable <= sw(1 downto 0) & btn(3);
rst_pixel <= reset or not pLocked;


fpga_vision: entity work.edupow
  port map (clk       => clk_75,                      -- input clock 74.25 MHz, video 720p
            reset_n   => reset_n,                     -- reset (invoked during configuration)
            enable_in => enable,                      -- three slide switches
            -- video in
            vs_in     => vs_0,                        -- vertical sync
            hs_in     => hs_0,                        -- horizontal sync
            de_in     => de_0,                        -- data enable is '1' for valid pixel
            r_in      => rbg_in(23 downto 16),        -- red component of pixel
            g_in      => rbg_in(7 downto 0),          -- green component of pixel
            b_in      => rbg_in(15 downto 8),         -- blue component of pixel
            -- video out
            vs_out    => vs_1,                        -- corresponding to video-in
            hs_out    => hs_1,
            de_out    => de_1,
            r_out     => r,
            g_out     => g,
            b_out     => b,
            --
            clk_o     => open,                        -- output clock (do not modify)
            led       => open);                       -- not supported by remote lab


hdmi_clk_gen : entity work.clk_wiz_0
   port map ( 
  -- Clock out ports  
   clk_out1 => clk_200,
  -- Status and control signals                
   locked => pll_locked,
   -- Clock in ports
   clk_in1 => clk
 );

video_in: ENTITY work.dvi2rgb_0
  PORT map (
    TMDS_Clk_p => hdmi_rx_clk_p,
    TMDS_Clk_n => hdmi_rx_clk_n, 
    TMDS_Data_p => hdmi_rx_d_p, 
    TMDS_Data_n => hdmi_rx_d_n, 
    RefClk => clk_200,
    aRst => reset, 
    vid_pData => rbg_in, 
    vid_pVDE => de_0, 
    vid_pHSync => hs_0, 
    vid_pVSync => vs_0, 
    PixelClk => clk_75, 
    aPixelClkLckd => open,
    pLocked => pLocked,
    pRst => '0');
     
video_out: ENTITY work.rgb2dvi_0
  PORT map (
    TMDS_Clk_p => hdmi_tx_clk_p,
    TMDS_Clk_n => hdmi_tx_clk_n, 
    TMDS_Data_p => hdmi_tx_d_p, 
    TMDS_Data_n => hdmi_tx_d_n, 
    aRst => rst_pixel, 
    vid_pData => r & b & g, 
    vid_pVDE => de_1, 
    vid_pHSync => hs_1,
    vid_pVSync => vs_1,
    PixelClk => clk_75);
    
end shell;

